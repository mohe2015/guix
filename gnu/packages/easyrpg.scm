;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2018 Sou Bunnbu <iyzsong@member.fsf.org>
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

(define-module (gnu packages easyrpg)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages mp3)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages xml))

(define-public liblcf
  (package
    (name "liblcf")
    (version "0.5.4")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://easyrpg.org/downloads/player/" version
                    "/liblcf-" version ".tar.gz"))
              (sha256
               (base32
                "1k99bcw5c23801jk3mbz5sj5h18x46w1qxrkknhwhfgqzpvxhwrs"))))
    (build-system gnu-build-system)
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (propagated-inputs
     ;; Required by 'liblcf.pc'.
     `(("expat" ,expat)
       ("icu" ,icu4c)))
    (home-page "https://easyrpg.org/")
    (synopsis "Library to handle RPG Maker 2000 and 2003 game data")
    (description
     "@code{liblcf} is a library to handle RPG Maker 2000 and 2003 game data.
It can read and write LCF and XML files.")
    ;; It includes a copy of Boost Preprocessor Cat and Stringize (boost-1.0):
    ;;   src/boost/preprocessor/config.hpp
    ;;   src/boost/preprocessor/cat.hpp
    ;;   src/boost/preprocessor/stringize.hpp
    ;; and a copy of inih (bsd-3):
    ;;   src/ini.h
    ;;   src/ini.cpp
    ;;   src/inireader.h
    ;;   src/inireader.cpp
    ;; TODO: Unbundle them.
    (license license:expat)))

(define-public easyrpg-player
  (package
    (name "easyrpg-player")
    (version "0.5.4")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://easyrpg.org/downloads/player/" version
                    "/easyrpg-player-" version ".tar.gz"))
              (sha256
               (base32
                "0w0idr61slg5828j1q31c1kh1h0ryp8psc006y06jph5pp3qgm48"))))
    (build-system gnu-build-system)
    (arguments
     '(#:configure-flags
       (list (string-append "--with-bash-completion-dir="
                            %output "/etc/bash_completion.d/"))))
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
     `(("freetype" ,freetype)
       ("harfbuzz" ,harfbuzz)
       ("liblcf" ,liblcf)
       ("libpng" ,libpng)
       ("libsndfile" ,libsndfile)
       ("libvorbis" ,libvorbis)
       ("libxmp" ,libxmp)
       ("mpg123" ,mpg123)
       ("opusfile" ,opusfile)
       ("pixman" ,pixman)
       ("sdl2-mixer" ,sdl2-mixer)
       ("sdl2" ,sdl2)
       ("speexdsp" ,speexdsp)
       ;; ("wildmidi" ,wildmidi)      ; TODO: package it
       ("zlib" ,zlib)))
    (home-page "https://easyrpg.org/")
    (synopsis "Play RPG Maker 2000 and 2003 games")
    (description
     "EasyRPG Player is a game interpreter to play RPG Maker 2000, 2003 and
EasyRPG games.  It uses the LCF parser library (liblcf) to read RPG Maker game
data.")
    ;; It bundles FMMidi YM2608 FM synthesizer emulator (bsd-3):
    ;;   src/midisynth.h
    ;;   src/midisynth.cpp
    ;; and PicoJSON JSON parser/serializer (bsd-2):
    ;;   src/picojson.h
    ;; TODO: Unbundle them.
    (license license:gpl3+)))
