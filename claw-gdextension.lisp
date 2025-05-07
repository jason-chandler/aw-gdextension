;;;; claw-gdextension.lisp

(defpackage #:aw-gdextension/wrapper
  (:use #:cl))

(in-package #:aw-gdextension/wrapper)

#+ecl
(ffi:load-foreign-library "libresect.dylib")

(uiop:define-package :%aw-gdextension)

(claw:defwrapper (:aw-gdextension-spec
                  (:system :aw-gdextension/wrapper)
                  (:headers "gdextension_interface.h")
                  (:includes :gdextension-includes)
                  (:targets 
                   ((:and :x86-64 :linux) "x86_64-pc-linux-gnu")
                   ((:and :x86-64 :windows) "x86_64-w64-mingw32")
                   ((:and :arm64 :darwin) "arm64-apple-darwin-gnu"))
                  (:persistent t)
                  (:language :c)
                  (:include-definitions "^.*GD.*" "^p_.*" "^r_.*"))
  :in-package :%gdextension
  :trim-enum-prefix t
  :recognize-bitfields t
  :recognize-strings t
  :recognize-arrays t
  :symbolicate-names (:in-pipeline
                      (:by-removing-prefixes "GDEXTENSION_" "GDExtension")))

(pushnew :claw-regen-adapter *features*)

(defun generate-and-fixup ()
  (claw:generate-wrapper :aw-gdextension-spec)
  (setf cl-ppcre:*allow-named-registers* t)
  (loop :for binding-file :in (uiop:directory-files (asdf:system-relative-pathname "aw-gdextension" "bindings"))
        :do (with-open-file (file-in binding-file :direction :input)
              (let ((file-text (uiop:read-file-string file-in)))
                (loop :for trash-name :in '("\\|C:@SA@GD-EXTENSION-(?<name>[^\\|]*)\\|" "\\|C:@EA@GD-EXTENSION-(?<name>[^\\|]*)\\|")
                      :for type-suffix :in '("-struct" "-enum")
                      :do (setf file-text (cl-ppcre:regex-replace-all trash-name file-text 
                                                                      (lambda (match &rest reg-names)
                                                                        (concatenate 'string (format nil "~A" (string-downcase (car reg-names))) type-suffix)) :simple-calls t :preserve-case nil)))
                (setf file-text (cl-ppcre:regex-replace-all "\\%gdextension\\:\\:error" file-text "%gdextension::error-arg"))
                (with-open-file (file-out binding-file :direction :output :if-exists :supersede)
                  (uiop/cl:write-string file-text file-out))))))

#+ecl
(generate-and-fixup)


