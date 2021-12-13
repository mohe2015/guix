;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2020 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2020 Giacomo Leidi <goodoldpaul@autistici.org>
;;; Copyright © 2021 Noisytoot <noisytoot@disroot.org>
;;; Copyright © 2021 Charles <charles.b.jackson@protonmail.com>
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

(define-module (gnu packages node-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages python)
  #:use-module (gnu packages web)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system node))

(define-public node-acorn
  (package
    (name "node-acorn")
    (version "8.4.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/acornjs/acorn")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "068h5gysz8bbslq31dva8f223rdf8l7w6nxcxjnv4zdprwkzkhaa"))))
    (build-system node-build-system)
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'change-directory
           (lambda _
             (chdir "acorn"))))))
    (home-page "https://github.com/acornjs/acorn/tree/master/acorn")
    (synopsis "Javascript-based Javascript parser")
    (description "Acornjs is a Javascript parser with many options and an
architecture supporting plugins.")
    (license license:expat)))

(define-public node-color-name
  (package
    (name "node-color-name")
    (version "1.1.3")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/colorjs/color-name")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "09rbmj16nfwcwkhrybqxyy66bkrs50vpw6hkdqqb14l3gsyxpr74"))))
    (build-system node-build-system)
    (home-page "https://github.com/colorjs/color-name")
    (synopsis "JSON with CSS color names")
    (description
     "This package provides a JSON list with color names and their values.")
    (license license:expat)))

(define-public node-env-variable
  (package
    (name "node-env-variable")
    (version "0.0.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/bigpipe/env-variable")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "0nnpxjxfhy4na7fixb7p3ww6ard5xgggfm83b78i333867r4gmsq"))))
    (build-system node-build-system)
    (arguments '(#:tests? #f)) ; No tests.
    (home-page "https://github.com/bigpipe/env-variable")
    (synopsis "Environment variables for Node with fallbacks")
    (description "This package provides environment variables with
@code{process.env}, @code{window.name}, @code{location.hash} and
@code{localStorage} fallbacks.")
    (license license:expat)))

(define-public node-far
  (package
    (name "node-far")
    (version "0.0.7")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/felixge/node-far")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "083rv1rszjn0i91zcpaghlid0kwhk0angmpj4hiflrlyhd6cmjzw"))))
    (build-system node-build-system)
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda _
             ;; We skip the two tests which are supposed to fail.
             (invoke "bin/node-far" "-v" "test/" "-e" "test.*fail.js"))))))
    (inputs
     `(("node-oop" ,node-oop)))
    (home-page "https://github.com/felixge/node-far")
    (synopsis "Node.js test runner")
    (description "This package provides a simple test runner that finds and runs
multiple node.js files, while providing useful information about output and exit
codes.")
    (license license:expat)))

(define-public node-long-stack-traces
  (package
    (name "node-long-stack-traces")
    (version "0.1.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/tlrobinson/long-stack-traces")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "0famwsyc6xawi30v25zi65d8fhbvlvh976bqydf1dqn5gz200cl3"))))
    (build-system node-build-system)
    (arguments '(#:tests? #f)) ; No tests.
    (home-page "https://github.com/tlrobinson/long-stack-traces")
    (synopsis "Long stacktraces implemented in user-land JavaScript")
    (description "This package provides long stacktraces for V8 implemented in
user-land JavaScript.")
    (license license:expat))) ; in README

(define-public node-mersenne
  (package
    (name "node-mersenne")
    (version "0.0.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/jwatte/node-mersenne")
               ;; The actual release lacks a git tag.
               (commit "f9fa01694ee49d6ae6ff9d90cfda594bddd3ccef")))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "034iaiq2pdqn342p2404cpz364g282d2hkp9375hysnh9i968wbb"))))
    (build-system node-build-system)
    (arguments '(#:tests? #f)) ; No tests.
    (home-page "http://www.enchantedage.com/node-mersenne")
    (synopsis "Node.js module for generating Mersenne Twister random numbers")
    (description "Thix package provides a node.js port of the Mersenne Twister
random number generator.")
    (license license:bsd-3)))

(define-public node-oop
  ;; No releases, last commit was February 2013.
  (let ((commit "f9d87cda0958886955c14a0a716e57021ed295dc")
        (revision "1"))
    (package
      (name "node-oop")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/felixge/node-oop")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
           (base32
            "0mqrcf0xi2jbwffwkk00cljpqfsri1jk8s6kz8jny45apn7zjds1"))))
      (build-system node-build-system)
      (arguments '(#:tests? #f)) ; Tests run during build phase.
      (home-page "https://github.com/felixge/node-oop")
      (synopsis "Simple, light-weight oop module for Node")
      (description "This library tries to bring basic oop features to JavaScript
while being as light-weight and simple as possible.")
      (license license:expat))))

(define-public node-stack-trace
  ;; There have been improvements since the last release.
  (let ((commit "4fd379ee78965ce7ce8820b436f1b1b590d5dbcf")
        (revision "1"))
    (package
      (name "node-stack-trace")
      (version (git-version "0.0.10" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/felixge/node-stack-trace")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
           (base32
            "1pk19wcpy8i95z5jr77fybd57qj7xmzmniap4dy47vjlmpkqia4i"))))
      (build-system node-build-system)
      (arguments
       '(#:phases
         (modify-phases %standard-phases
         (add-before 'check 'skip-intentionally-failing-test
           (lambda _
             (substitute* "test/run.js"
               (("far.include") "far.exclude(/test-parse.js/)\nfar.include"))
             #t)))))
      (native-inputs
       `(("node-far" ,node-far)
         ("node-long-stack-traces" ,node-long-stack-traces)))
      (home-page "https://github.com/felixge/node-stack-trace")
      (synopsis "Get v8 stack traces as an array of CallSite objects")
      (description "Get v8 stack traces as an array of CallSite objects.")
      (license license:expat))))

(define-public node-statsd-parser
  (package
    (name "node-statsd-parser")
    (version "0.0.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/dscape/statsd-parser")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "049rnczsd6pv6bk282q4w72bhqc5cs562djgr7yncy7lk0wzq5j3"))))
    (build-system node-build-system)
    (arguments '(#:tests? #f)) ; No tests.
    (home-page "https://github.com/dscape/statsd-parser")
    (synopsis "Streaming parser for the statsd protocol")
    (description "This package provides a streaming parser for the statsd
protocol used in @code{node-lynx}.")
    (license license:asl2.0)))

(define-public node-util-deprecate
  (package
    (name "node-util-deprecate")
    (version "1.0.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/TooTallNate/util-deprecate")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
         (base32
          "1rk94nl3qc7znsk8400bnga30v0m7j2mmvz9ldwjinxv1d3n11xc"))))
    (build-system node-build-system)
    (arguments '(#:tests? #f)) ; No test suite.
    (home-page "https://github.com/TooTallNate/util-deprecate")
    (synopsis "Node.js `util.deprecate()` function with browser support")
    (description "This package provides the Node.js @code{util.deprecate()}
function with browser support.")
    (license license:expat)))

(define-public node-semver
  (package
    (name "node-semver")
    (version "7.2.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/npm/node-semver")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "06biknqb05r9xsmcflm3ygh50pjvdk84x6r79w43kmck4fn3qn5p"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       '("tap")
       ;; FIXME: Tests depend on node-tap
       #:tests? #f))
    (home-page "https://github.com/npm/node-semver")
    (synopsis "Parses semantic versions strings")
    (description
     "@code{node-semver} is a JavaScript implementation of the
@uref{https://semver.org/, SemVer.org} specification.")
    (license license:isc)))

(define-public node-wrappy
  (package
    (name "node-wrappy")
    (version "1.0.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/npm/wrappy")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1ymlc61cja6v5438vwb04gq8wg2b784lj39zf0g4i36fvgcw9783"))))
    (build-system node-build-system)
    (arguments
     '(#:tests? #f ; FIXME: Tests depend on node-tap
       #:absent-dependencies
       '("tap")))
    (home-page "https://github.com/npm/wrappy")
    (synopsis "Callback wrapping utility")
    (description "@code{wrappy} is a utility for Node.js to wrap callbacks.")
    (license license:isc)))

(define-public node-once
  (package
    (name "node-once")
    (version "1.4.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/isaacs/once")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1z8dcbf28dqdcp4wb0c53wrs90a07nkrax2c9kk26dsk1dhrnxav"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       '("tap")
       ;; FIXME: Tests depend on node-tap
       #:tests? #f))
    (inputs
     `(("node-wrappy" ,node-wrappy)))
    (home-page "https://github.com/isaacs/once")
    (synopsis "Node.js module to call a function only once")
    (description
     "@code{once} is a Node.js module to call a function exactly one time.
Subsequent calls will either return the cached previous value or throw an error
if desired.")
    (license license:isc)))

(define-public node-inherits
  (package
    (name "node-inherits")
    (version "2.0.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/isaacs/inherits")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0cpsr5yqwkxpbbbbl0rwk4mcby6zbx841k2zb4c3gb1579i5wq9p"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       '("tap")
       ;; FIXME: Tests depend on node-tap
       #:tests? #f))
    (home-page
     "https://github.com/isaacs/inherits")
    (synopsis
     "Browser-friendly inheritance Node.js")
    (description
     "Browser-friendly inheritance fully compatible with standard Node.js
@code{inherits()}.")
    (license license:isc)))

(define-public node-safe-buffer
  (package
    (name "node-safe-buffer")
    (version "5.2.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/feross/safe-buffer")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0r26m0nl41h90ihnl2xf0cqs6z9z7jb87dl5j8yqb7887r9jlbpi"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       '("tape"
         "standard")
       #:tests? #f))
    (home-page
     "https://github.com/feross/safe-buffer")
    (synopsis "Safer Node.js Buffer API")
    (description "A safe drop-in replacement the Node.js @code{Buffer} API
that works in all versions of Node.js, using the built-in implementation when
available.")
    (license license:expat)))

(define-public node-string-decoder
  (package
    (name "node-string-decoder")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nodejs/string_decoder")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0xxvyya9fl9rlkqwmxzqzbz4rdr3jgw4vf37hff7cgscxkhg266k"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       '("tap"
         "core-util-is"
         "babel-polyfill")
       ;; FIXME: Tests depend on node-tap
       #:tests? #f))
    (inputs
     `(("node-safe-buffer" ,node-safe-buffer)
       ("node-inherits" ,node-inherits)))
    (home-page
     "https://github.com/nodejs/string_decoder")
    (synopsis
     "Node.js core @code{string_decoder} for userland")
    (description
     "This package is a mirror of the @code{string_decoder} implementation in
Node-core.")
    (license license:expat)))

(define-public node-readable-stream
  (package
    (name "node-readable-stream")
    (version "3.6.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nodejs/readable-stream")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0ybl4cdgsm9c5jq3xq8s01201jk8w0yakh63hlclsfbcdfqhd9ri"))))
    (build-system node-build-system)
    (arguments
     `(#:absent-dependencies
       `("@babel/cli"
         "@babel/core"
         "@babel/polyfill"
         "@babel/preset-env"
         "airtap"
         "assert"
         "bl"
         "deep-strict-equal"
         "events.once"
         "glob"
         "gunzip-maybe"
         "hyperquest"
         "lolex"
         "nyc"
         "pump"
         "rimraf"
         "tap"
         "tape"
         "tar-fs"
         "util-promisify")
       #:tests? #f))
    (inputs
     `(("node-util-deprecate" ,node-util-deprecate)
       ("node-string-decoder" ,node-string-decoder)
       ("node-inherits" ,node-inherits)))
    (home-page
     "https://github.com/nodejs/readable-stream")
    (synopsis
     "Node.js core streams for userland")
    (description
     "This package is a mirror of the streams implementations in Node.js.

If you want to guarantee a stable streams base, regardless of what version of
Node you (or the users of your libraries) are using, use
@code{readable-stream} only and avoid the @code{stream} module in Node-core.")
    (license license:expat)))

(define-public node-irc-colors
  (package
    (name "node-irc-colors")
    (version "1.5.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/fent/irc-colors.js")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0q3y34rbnlc55jcakmdxkicwazyvyph9r6gaf6hi8k7wj2nfwfli"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       `("istanbul"
         "vows")
       #:tests? #f))
    (home-page "https://github.com/fent/irc-colors.js")
    (synopsis "Node.js module providing color and formatting for IRC")
    (description "@code{node-irc-colors} is a Node.js module that
allows you to easily use colored output and formatting in IRC bots.
It contains functions for colours as well as more complex formatting
such as rainbows.")
    (license license:expat)))

(define-public node-irc
  (package
    (name "node-irc")
    (version "0.5.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/martynsmith/node-irc")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1ln4qfx20jbwg4cp8lp0vf27m5281z2sz16d15xd6150n26cbi4x"))))
    (build-system node-build-system)
    (arguments
     '(#:absent-dependencies
       `("ansi-color"
         "faucet"
         "jscs"
         "tape")
       #:tests? #f))
    (inputs
     `(("node-irc-colors" ,node-irc-colors)))
    (home-page "https://github.com/martynsmith/node-irc")
    (synopsis "IRC client library for Node.js")
    (description "@code{node-irc} is an IRC client library for Node.js.
It has functions for joining, parting, talking, and many other IRC commands.")
    (license license:gpl3+)))

(define-public node-nan
  (package
    (name "node-nan")
    (version "2.15.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nodejs/nan")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "18xslh9va5ld872scrp5y4251ax9s3c6qh0lnl1200lpzbsxy7yd"))))
    (build-system node-build-system)
    (arguments
     `(#:absent-dependencies
       '("bindings"
         "commander"
         "glob"
         "request"
         "node-gyp" ;; would be needed for tests
         "tap"
         "xtend")
       ;; tests need tap and other dependencies
       #:tests? #f))
    (inputs
     `(("readable-stream" ,node-readable-stream)))
    (home-page "https://github.com/nodejs/nan")
    (synopsis "Native Abstractions for Node.js")
    (description "Native Abstractions for Node.js (``NaN'') provides a header
file filled with macro and utility goodness for making add-on development for
Node.js easier across versions. The goal of this project is to store all logic
necessary to develop native Node.js addons without having to inspect
@code{NODE_MODULE_VERSION} and get yourself into a macro-tangle.

This project also contains some helper utilities that make addon development a
bit more pleasant.")
    (license license:expat)))

(define-public node-addon-api
  (package
    (name "node-addon-api")
    (version "4.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nodejs/node-addon-api")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bhvfi2m9nxfz418s619914vmidcnrzbjv6l9nid476c3zlpazch"))))
    (inputs
     `(("python" ,python)
       ("node-safe-buffer" ,node-safe-buffer)))
    (build-system node-build-system)
    (arguments
     `(#:absent-dependencies
       `("benchmark"
         "bindings"
         "clang-format"
         "eslint"
         "eslint-config-semistandard"
         "eslint-config-standard"
         "eslint-plugin-import"
         "eslint-plugin-node"
         "eslint-plugin-promise"
         "fs-extra"
         "path"
         "pre-commit")
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'skip-js-tests
           ;; We can't run the js-based tests,
           ;; but we can still do the C++ parts
           (lambda args
             (substitute* "package.json"
               (("\"test\": \"node test\"")
                "\"test\": \"echo stopping after pretest on Guix\"")))))))
    (home-page "https://github.com/nodejs/node-addon-api")
    (synopsis "Node.js API (Node-API) header-only C++ wrappers")
    (description "This module contains header-only C++ wrapper classes which
simplify the use of the C based Node-API provided by Node.js when using C++.
It provides a C++ object model and exception handling semantics with low
overhead.

Node-API is an ABI stable C interface provided by Node.js for building native
addons.  It is intended to insulate native addons from changes in the
underlying JavaScript engine and allow modules compiled for one version to run
on later versions of Node.js without recompilation.  The @code{node-addon-api}
module, which is not part of Node.js, preserves the benefits of the Node-API
as it consists only of inline code that depends only on the stable API
provided by Node-API.

It is important to remember that @emph{other} Node.js interfaces such as
@code{libuv} (included in a project via @code{#include <uv.h>}) are not
ABI-stable across Node.js major versions.")
    (license license:expat)))

(define-public node-sqlite3
  (package
    (name "node-sqlite3")
    (version "5.0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mapbox/node-sqlite3")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0sbbzzli282nxyfha10zx0k5m8hdp0sf3ipl59khjb7wm449j86h"))
       (snippet
        (with-imported-modules '((guix build utils))
          #~(begin
              (use-modules (guix build utils))
              ;; unbundle sqlite
              (for-each delete-file-recursively
                        (find-files "deps"
                                    (lambda (pth stat)
                                      (gzip-file? pth)))))))))
    (inputs
     `(("node-addon-api" ,node-addon-api)
       ("python" ,python)
       ("sqlite" ,sqlite)))
    (build-system node-build-system)
    (arguments
     `(#:tests?
       #f ; FIXME: tests depend on node-mocha
       #:modules
       ((guix build node-build-system)
        (guix build json)
        (srfi srfi-1)
        (ice-9 match)
        (guix build utils))
       #:absent-dependencies
       `(;; Normally, this is "built" using @mapbox/node-pre-gyp,
         ;; which publishes or downloads pre-built binaries
         ;; or falls back to building from source.
         ;; Here, we patch out all of that and just build directly.
         ;; It would be better to patch a version of @mapbox/node-pre-gyp
         ;; that always builds from source, as Debian does,
         ;; but there are a number of dependencies that need
         ;; to be packaged or removed.
         "@mapbox/node-pre-gyp"
         "node-pre-gyp" ;; deprecated name still used in some places
         "aws-sdk"
         "@mapbox/cloudfriend"
         ;; Confusingly, this is only a dependency because of
         ;; @mapbox/node-pre-gyp: with that removed,
         ;; npm will use its own copy:
         "node-gyp"
         ;; These we'd like, we just don't have them yet:
         "eslint"
         "mocha")
       #:phases
       (modify-phases %standard-phases
         (add-before 'configure 'npm-config-sqlite
           ;; We need this step even if we do replace @mapbox/node-pre-gyp
           ;; because the package expects to build its bundled sqlite
           (lambda* (#:key inputs #:allow-other-keys)
             (setenv "npm_config_sqlite" (assoc-ref inputs "sqlite"))))
         (add-after 'install 'patch-binding-path
           ;; We replace a file that dynamic searches for the addon using
           ;; node-pre-gyp (which we don't have) with a version that
           ;; simply uses the path to the addon we built directly.
           ;; The exact path is supposed to depend on things like the
           ;; architecture and napi_build_version, so, to avoid having
           ;; hard-code the details accurately, we do this after the addon
           ;; has been built so we can just find where it ended up.
           (lambda* (#:key outputs #:allow-other-keys)
             (with-directory-excursion
                 (string-append (assoc-ref outputs "out")
                                "/lib/node_modules/sqlite3/lib")
               (match (find-files "binding" "\\.node$")
                 ((rel-path)
                  (with-atomic-file-replacement "sqlite3-binding.js"
                    (lambda (in out)
                      (format out "var binding = require('./~a');\n" rel-path)
                      (display "module.exports = exports = binding;\n" out))))))))
         (add-after 'patch-dependencies 'avoid-node-pre-gyp
           (lambda args
             ;; We need to patch .npmignore before the 'repack phase
             ;; so that the built addon is installed with in the package.
             ;; (Upstream assumes node-pre-gyp will download a pre-built
             ;; version when this package is installed.)
             (substitute* ".npmignore"
               (("lib/binding")
                "#lib/binding # <- patched for Guix"))
             ;; We need to remove the install script from "package.json",
             ;; as it would try to use node-pre-gyp and would block the
             ;; automatic building performed by `npm install`.
             (with-atomic-file-replacement "package.json"
               (lambda (in out)
                 (let* ((js (read-json in))
                        (alist (match js
                                 (('@ . alist) alist)))
                        (scripts-alist (match (assoc-ref alist "scripts")
                                         (('@ . alist) alist)))
                        (scripts-alist
                         ;; install script would use node-pre-gyp
                         (assoc-remove! scripts-alist "install"))
                        (alist
                         (assoc-set! alist "scripts" (cons '@ scripts-alist)))
                        (binary-alist (match (assoc-ref alist "binary")
                                        (('@ . alist) alist)))
                        (js (cons '@ alist)))
                   ;; When it builds from source, node-pre-gyp supplies
                   ;; module_name and module_path based on the entries under
                   ;; "binary" from "package.json", so this package's
                   ;; "binding.gyp" doesn't define them. Thus, we also need
                   ;; to supply them. The GYP_DEFINES environment variable
                   ;; turns out to be the easiest way to make sure they are
                   ;; propagated from npm to node-gyp to gyp.
                   (setenv "GYP_DEFINES"
                           (string-append
                            "module_name="
                            (assoc-ref binary-alist "module_name")
                            " "
                            "module_path="
                            (assoc-ref binary-alist "module_path")))
                   (write-json js
                               out)))))))))
    (home-page "https://github.com/mapbox/node-sqlite3")
    (synopsis "Asynchronous, non-blocking SQLite3 bindings for Node.js")
    (description
     "The Node.js add-on @code{node-sqlite3} provides a set of a asynchronous,
non-blocking bindings for SQLite3, written in modern C++ and tested for memory
leaks.")
     (license license:bsd-3)))

(define-public node-file-uri-to-path
  (package
    (name "node-file-uri-to-path")
    (version "2.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/TooTallNate/file-uri-to-path")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "08l779az44czm12xdhgcrnzpqw34s59hbrlfphs7g9y2k26drqav"))))
    (native-inputs
     `(("esbuild" ,esbuild)))
    (build-system node-build-system)
    (arguments
     `(#:absent-dependencies
       `("@types/mocha"
         "@types/node"
         "@typescript-eslint/eslint-plugin"
         "@typescript-eslint/parser"
         "cpy-cli"
         "eslint"
         "eslint-config-airbnb"
         "eslint-config-prettier"
         "eslint-import-resolver-typescript"
         "eslint-plugin-import"
         "eslint-plugin-jsx-a11y"
         "eslint-plugin-react"
         "mocha"
         "rimraf"
         "typescript")
       #:phases
       (modify-phases %standard-phases
         (replace 'build
           (lambda* (#:key inputs native-inputs #:allow-other-keys)
             (copy-recursively "src" "dist")
             (invoke (string-append
                      (assoc-ref (or native-inputs inputs) "esbuild")
                      "/bin/esbuild")
                     "dist/index.ts"
                     "--outfile=dist/src/index.js"
                     "--format=cjs"
                     "--sourcemap"
                     "--platform=node"))))
       #:tests? #f))
    (home-page "https://github.com/TooTallNate/file-uri-to-path")
    (synopsis "Convert a @code{file:} URI to a file path")
    (description "This package provides a function to convert a @code{file:}
URI to a file path.  It accepts a @code{file:} URI and returns a file path
suitable for use with the @code{fs} module functions.")
    (license license:expat)))

(define-public node-bindings
  (package
    (name "node-bindings")
    (version "1.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/TooTallNate/node-bindings")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "100gp6kpjvd4j1dqnp0sbjr1hqx5mz7r61q9qy527jyhk9mj47wk"))))
    (inputs
     `(("node-file-uri-to-path" ,node-file-uri-to-path)))
    (build-system node-build-system)
    (arguments
     ;; there are no tests
     `(#:tests? #f))
    (home-page "https://github.com/TooTallNate/node-bindings")
    (synopsis "Help for loading your native module's @code{.node} file")
    (description "This is a helper module for authors of Node.js native addon
modules.  It is basically the ``swiss army knife'' of @code{require()}ing your
native module's @code{.node} file.")
    (license license:expat)))

(define-public node-segfault-handler
  (package
    (name "node-segfault-handler")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ddopson/node-segfault-handler")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "07nbw35wvrr18kmh8f388v4k5mpjgyy0260bx0xzjdv795i3xvfv"))))
    (native-inputs
     `(("python" ,python)))
    (inputs
     `(("node-bindings" ,node-bindings)
       ("node-nan" ,node-nan)))
    (build-system node-build-system)
    (arguments
     ;; there are no tests
     `(#:tests? #f))
    (home-page "https://github.com/ddopson/node-segfault-handler")
    (synopsis "Catches @code{SIGSEGV} and prints diagnostic information")
    (description "This package is a tool for debugging Node.js C/C++ native
code modules and getting stack traces when things go wrong.  If a
@code{SIGSEGV} signal is raised, the module will print a native stack trace to
both @code{STDERR} and to a timestamped file.")
    (license license:bsd-3)))
