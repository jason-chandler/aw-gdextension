(in-package :aw-gdextension/generate)

(defun from-generated-system-path (relative-file)
  (ensure-directories-exist (concatenate 'string (from-generator-system-path "cl-gdextension/") relative-file))
  (from-generator-system-path (concatenate 'string "cl-gdextension/" relative-file)))

(let ((system-text (format nil ";; cl-gdextension.asd ~%(asdf:defsystem #:cl-gdextension~% :description \"generated system to interact with Godot\"~% :author \"aw-gdextension\"~% :license  \"Public Domain\"~% :version \"0.0.1\"~% :serial t~% :depends-on (:cffi)~% :components ((:file \"package\")~% (:file \"cl-gdextension\")))")))
  (defun generate-system ()
    (with-open-file (new-system-dir (from-generated-system-path "cl-gdextension.asd") :direction :output :if-does-not-exist :create :if-exists :supersede)
      (write-string system-text new-system-dir))))



    