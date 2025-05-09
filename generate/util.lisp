(in-package :aw-gdextension/generate)

(defparameter *type-mapping*
  '(("void" . ":void")
    ("bool" . ":bool")
    ("int" . ":int")
    ("int8" . ":int8")
    ("int16" . ":int16")
    ("int32" . ":int32")
    ("int64" . ":int64")
    ("uint" . ":uint")
    ("uint8" . ":uint8")
    ("uint16" . ":uint16")
    ("uint32" . ":uint32")
    ("uint64" . ":uint64")
    ("float" . ":float")
    ("double" . ":double")
    ("String" . ":string")
    ("StringName" . ":string")
    ("Variant" . ":pointer")
    ("Array" . ":pointer")
    ("Dictionary" . ":pointer")
    ("Object" . ":pointer"))
  "Mapping of Godot types to CFFI types.")

(defun find-by-build-cfg (&key top-level-key target-key)
  (let ((entries (gethash top-level-key *extension-api-spec)))
    (gethash target-key (find-if (lambda (entry) (string-equal (gethash "build_configuration" entry) *build-configuration*)) entries))))

(defun get-cffi-type (godot-type)
  "Convert a Godot type to its CFFI equivalent."
  (let ((mapped-type (cdr (assoc godot-type *type-mapping* :test #'string=))))
    (if mapped-type
        mapped-type
        ":pointer")))

(defun snake-to-kebab (name)
  "Convert snake_case to kebab-case."
  (substitute #\- #\_ name))

(defun lisp-safe-name (name)
  "Convert a name to a Lisp-safe symbol name."
  (string-downcase (snake-to-kebab name)))

