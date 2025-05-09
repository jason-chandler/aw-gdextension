;;;; aw-gdextension.asd

(asdf:defsystem #:aw-gdextension/wrapper
  :description "generates the gdextension wrappers"
  :author "Jason Chandler <jason.chandler@pm.me>"
  :license  "BSD0/MIT/Whatever-you-want"
  :version "0.0.1"
  :serial t
  :depends-on (:cffi :claw :claw-utils :cl-resect :cl-ppcre :uiop)
  :components ((:file "claw-gdextension")
               (:module :gdextension-includes :pathname "include/")))

(asdf:defsystem #:aw-gdextension/generate
  :description "uses the gdextension wrapper functions as a base to translate gdextension json"
  :author "Jason Chandler <jason.chandler@pm.me>"
  :license  "BSD0/MIT/Whatever-you-want"
  :version "0.0.1"
  :pathname "generate/"
  :serial t
  :depends-on (:cffi :com.inuoe.jzon :cl-utilities :cl-ppcre :uiop :closer-mop)
  :components ((:file "package")
               (:file "config")
               (:file "spec")
               (:file "util")
               (:file "builtin-classes")
               (:file "system")
               (:file "generate")
               (:module :gdextension-json-path :pathname "include/")))



(asdf:defsystem #:aw-gdextension
  :description "wraps the gdextension some with some neato bindings"
  :author "Jason Chandler <jason.chandler@pm.me>"
  :license  "BSD0/MIT/Whatever-you-want"
  :version "0.0.1"
  :serial t
  :depends-on (:cffi :aw-gdextension-spec-bindings)
  :components ((:file "package")))
