;;; pwd.scm --- pwd.h FFI library for guile -*- scheme -*-

(define-module (libc pwd)
  #:use-module ((srfi srfi-9))
  #:use-module ((rnrs bytevectors))
  #:use-module ((system foreign))
  #:use-module ((libc pwd raw))
  #:use-module ((libc pwd utils))
  #:use-module ((srfi srfi-9 gnu))
  #:export (<passwd>))

(define-record-type <passwd>
  (define-passwd name passwd uid gid gecos dir shell)
  passwd?
  (name passwd-name)
  (passwd passwd-passwd)
  (uid passwd-uid)
  (gid passwd-gid)
  (gecos passwd-gecos)
  (dir passwd-dir)
  (shell passwd-shell))

(define (getpwuid uid) (pointer->passwd (%getpwuid% uid)))
(define (getpwnam name) (pointer->passwd (%getpwuid% (string->pointer name))))

(define (getpwent) (pointer->passwd (%getpwent%)))
(define (endpwent) (%endpwent%))
(define (setpwent) (%setpwent%))
