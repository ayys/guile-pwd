;;; utils.scm --- util functions for pwd.scm  -*- scheme -*-

(define-module (libc pwd utils)
  #:use-module ((rnrs bytevectors))
  #:use-module ((scheme base))
  #:use-module ((srfi srfi-9))
  #:use-module ((system foreign))
  #:export (<passwd> pointer->passwd bytevector->passwd))

(define-record-type <passwd>
  (make-passwd name passwd uid gid gecos dir shell)
  passwd?
  (name passwd-name)
  (passwd passwd-passwd)
  (uid passwd-uid)
  (gid passwd-gid)
  (gecos passwd-gecos)
  (dir passwd-dir)
  (shell passwd-shell))

(define (bytevector->string bv index) (pointer->string (make-pointer (bytevector-s64-native-ref bv index))))

(define (bytevector->passwd bv) (make-passwd
                                 (bytevector->string bv 0)
                                 (bytevector->string bv 8)
                                 (bytevector-s32-native-ref bv 16)
                                 (bytevector-s32-native-ref bv 20)
                                 (bytevector->string bv 24)
                                 (bytevector->string bv 32)
                                 (bytevector->string bv 40)))


(define (pointer->passwd pointer) (bytevector->passwd (pointer->bytevector pointer 48)))
