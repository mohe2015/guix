;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2016 Jelle Licht <jlicht@fsfe.org>
;;; Copyright © 2019 Timothy Sample <samplet@ngyro.com>
;;; Copyright © 2021 Pierre Langlois <pierre.langlois@gmx.com>
;;; Copyright © 2021 Philip McGrath <philip@philipmcgrath.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (guix build-system node)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix derivations)
  #:use-module (guix search-paths)
  #:use-module (guix build-system)
  #:use-module (guix build-system gnu)
  #:use-module (ice-9 match)
  #:export (%node-build-system-modules
            node-build
            node-build-system))

(define %node-build-system-modules
  ;; Build-side modules imported by default.
  `((guix build node-build-system)
    (guix build json)
    ,@%gnu-build-system-modules))

(define (default-node)
  "Return the default Node package."
  ;; Lazily resolve the binding to avoid a circular dependency.
  (let ((node (resolve-interface '(gnu packages node))))
    (module-ref node 'node-lts)))

(define* (lower name
                #:key source inputs native-inputs outputs system target
                (node (default-node))
                (absent-dependencies ''())
                #:allow-other-keys
                #:rest arguments)
  "Return a bag for NAME."
  (define private-keywords
    '(#:source #:target #:node #:inputs #:native-inputs))

  (and (not target)                    ;XXX: no cross-compilation
       (bag
         (name name)
         (system system)
         (host-inputs `(,@(if source
                              `(("source" ,source))
                              '())
                        ,@inputs
                        ;; Keep the standard inputs of 'gnu-build-system'.
                        ,@(standard-packages)))
         (build-inputs `(("node" ,node)
                         ;; Many packages with native addons need
                         ;; libuv headers. The libuv version must
                         ;; be exactly the same as for the node
                         ;; package we are adding implicitly,
                         ;; so we take care of adding libuv, too.
                         ("libuv" ,@(assoc-ref (package-inputs node) "libuv"))
                         ,@native-inputs))
         (outputs outputs)
         (build node-build)
         (arguments (strip-keyword-arguments private-keywords arguments)))))

(define* (node-build store name inputs
                     #:key
                     (test-target "test")
                     (tests? #t)
                     (phases '(@ (guix build node-build-system)
                                 %standard-phases))
                     (absent-dependencies ''())
                     (outputs '("out"))
                     (search-paths '())
                     (system (%current-system))
                     (guile #f)
                     (imported-modules %node-build-system-modules)
                     (modules '((guix build node-build-system)
                                (guix build utils))))
  "Build SOURCE using NODE and INPUTS.

The builder will remove Node.js packages listed in ABSENT-DEPENCENCIES from
the 'package.json' file's 'dependencies' and 'devDependencies' tables.  This
mechanism can be used both avoid dependencies we don't want (e.g. optional
features that would increase closure size) and to work around dependencies
that haven't been packaged for Guix yet (e.g. test utilities)."
  ;; Before #:absent-dependencies existed, this scenario was often handled by
  ;; deleting the 'configure phase. Using #:absent-dependencies, instead,
  ;; retains the check that no dependencies are silently missing and other
  ;; actions performed by 'npm install', such as building native
  ;; addons. Having an explicit list of absent dependencies in the package
  ;; definition should also facilitate future maintenence: for example, if we
  ;; add a package for a test framework, it should be easy to find all the
  ;; other packages that use it and enable their tests.
  (define builder
    `(begin
       (use-modules ,@modules)
       (node-build #:name ,name
                   #:source ,(match (assoc-ref inputs "source")
                               (((? derivation? source))
                                (derivation->output-path source))
                               ((source) source)
                               (source source))
                   #:system ,system
                   #:test-target ,test-target
                   #:tests? ,tests?
                   #:phases ,phases
                   #:absent-dependencies ,absent-dependencies
                   #:outputs %outputs
                   #:search-paths ',(map search-path-specification->sexp
                                         search-paths)
                   #:inputs %build-inputs)))

  (define guile-for-build
    (match guile
      ((? package?)
       (package-derivation store guile system #:graft? #f))
      (#f
       (let* ((distro (resolve-interface '(gnu packages commencement)))
              (guile  (module-ref distro 'guile-final)))
         (package-derivation store guile system #:graft? #f)))))

  (build-expression->derivation store name builder
                                #:inputs inputs
                                #:system system
                                #:modules imported-modules
                                #:outputs outputs
                                #:guile-for-build guile-for-build))

(define node-build-system
  (build-system
    (name 'node)
    (description "The Node build system")
    (lower lower)))
