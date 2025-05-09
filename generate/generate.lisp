(in-package :aw-gdextension/generate)

(loop :for x :being :the :hash-keys :of *extension-api-spec*
      :do (format t "~S~%" x))

"builtin_class_sizes"
"builtin_class_member_offsets"
"global_constants"
"global_enums"
"utility_functions"
"builtin_classes"
"classes"
"singletons"
"native_structures"


