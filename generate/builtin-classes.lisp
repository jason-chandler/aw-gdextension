(in-package :aw-gdextension/generate)

(defun generate-builtin-classes ()
  (let ((builtin-class-sizes (find-by-build-cfg :top-level-key "builtin_class_sizes" :target-key "sizes"))
        (builtin-class-member-offsets (find-by-build-cfg :top-level-key "builtin_class_member_offsets" :target-key "classes"))
        (builtin-classes (gethash "builtin_classes" *extension-api-spec*)))
    (declare (ignore builtin-class-sizes builtin-class-member-offsets builtin-classes))))

