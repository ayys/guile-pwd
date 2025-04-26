(define-module (guile-pwd)
  #:use-module (guix packages)
  #:use-module (guix build-system guile)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build utils)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages base)
  #:use-module ((guix licenses) #:prefix license:))



(define-public guile-pwd
  (package
   (name "guile-pwd")
   (version "0.1.0")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/ayys/guile-pwd.git")
                  (commit version)))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "1xg6dhcnd6m5z9d7yzsa2vzdhzgifyk92gkfb6md8rbc8dilp2rh"))
            (snippet #~(for-each delete-file '("guix.scm")))
            ))
   (build-system guile-build-system)
   (native-inputs (list guile-3.0))
   (home-page "http://github.com/ayys/guile-pwd")
   (synopsis "POSIX password database access for Guile")
   (description
    "Guile-PWD provides access to the system password database (such as /etc/passwd) 
in Guile programs. It offers bindings to functions like getpwuid, getpwnam, 
and provides APIs to query user account information by UID or username. 
Useful for system utilities, login shells, and administrative scripts.")
   (license license:lgpl3+)))


guile-pwd
