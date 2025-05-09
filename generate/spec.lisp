(in-package :aw-gdextension/generate)

(let* ((system (asdf/find-system:find-system :aw-gdextension/generate))
       (generator-system-path (namestring (uiop:pathname-directory-pathname (slot-value (car (asdf:module-components system)) 'asdf/component:absolute-pathname))))
       (json-module (find-if (lambda (component) (string-equal "gdextension-json-path" (slot-value component 'asdf/component:name)))
                                    (asdf:module-components system)))
       (json-path (uiop:merge-pathnames* (slot-value json-module 'asdf/component:absolute-pathname)
                                         "extension_api.json")))
    (defun from-generator-system-path (relative-path) (concatenate 'string generator-system-path relative-path))
    (defparameter *extension-api-spec* (with-open-file (extension-api json-path)
                                         (jzon:parse extension-api))))

