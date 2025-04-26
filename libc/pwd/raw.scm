;;; raw.scm --- raw ffi functions for pwd.h -*- scheme -*-

(define-module (libc pwd raw)
  #:use-module ((srfi srfi-9))
  #:use-module ((rnrs bytevectors))
  #:use-module ((system foreign))
  #:use-module ((srfi srfi-9 gnu))
  #:export (%getpwnam% %getpwent% %getpwuid% %endpwent% %setpwent%))

;;; This is the interface for pwd.h (source: POSIX Programmer's Manual)
;;; 
;;; /* A record in the user database.  */
;;; struct passwd
;;; {
;;;   char *pw_name;		/* Username.  */
;;;   char *pw_passwd;		/* Hashed passphrase, if shadow database
;;;                                    not in use (see shadow.h).  */
;;;   __uid_t pw_uid;		/* User ID.  */
;;;   __gid_t pw_gid;		/* Group ID.  */
;;;   char *pw_gecos;		/* Real name.  */
;;;   char *pw_dir;			/* Home directory.  */
;;;   char *pw_shell;		/* Shell program.  */
;;; };
;;; 
;;;            void           endpwent(void);
;;;            struct passwd *getpwent(void);
;;;            struct passwd *getpwnam(const char *);
;;;            int            getpwnam_r(const char *, struct passwd *, char *,
;;;                               size_t, struct passwd **);
;;;            struct passwd *getpwuid(uid_t);
;;;            int            getpwuid_r(uid_t, struct passwd *, char *,
;;;                               size_t, struct passwd **);
;;;            void           setpwent(void);
;;; 

;; link to libc; no arguments to dynamic-link will return the global
;; symbol handle
(define libc (dynamic-link #f))

(define %getpwnam%
  (pointer->procedure
   '*
   (dynamic-func "getpwnam" libc)
   (list '*)))

(define %getpwuid%
  (pointer->procedure
   '*
   (dynamic-func "getpwuid" libc)
   (list uint64)))

;; (%getpwuid% (getuid))
(define %endpwent%
  (pointer->procedure
   void
   (dynamic-func "getpwuid" libc)
   '()))

(define %setpwent%
  (pointer->procedure
   void
   (dynamic-func "setpwent" libc)
   '()))


(define %getpwent%
  (pointer->procedure
   '*
   (dynamic-func "getpwent" libc)
   '()))



