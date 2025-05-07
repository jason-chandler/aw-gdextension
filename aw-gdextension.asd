;;;; aw-gdextension.asd

(asdf:defsystem #:aw-gdextension/wrapper
  :description "generates the gdextension wrappers"
  :author "Your Name <your.name@example.com>"
  :license  "BSD0/MIT/Whatever-you-want"
  :version "0.0.1"
  :serial t
  :depends-on (:cffi :claw :claw-utils :cl-resect :cl-ppcre :uiop)
  :components ((:file "claw-gdextension")
               (:module :gdextension-includes :pathname "include/")))

(asdf:defsystem #:aw-gdextension
  :description "wraps the gdextension some with some neato bindings"
  :author "Jason Chandler <jason.chandler@pm.me"
  :license  "BSD0/MIT/Whatever-you-want"
  :version "0.0.1"
  :serial t
  :depends-on (:cffi :aw-gdextension-bindings)
  :components ((:file "package")))
