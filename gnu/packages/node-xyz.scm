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
