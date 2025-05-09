(in-package :aw-gdextension/generate)

(defparameter *build-configuration* "float_64")

(defun set-build-configuration (cfg)
  "Adjust depending on platform you're building for. At the time of writing, for desktop it is usually float_64, but web and mobile builds are usually float_32, etc. See env.Append(CPPDEFINES=[\"BUILD_32\"]) in the docs."
  (setf *build-configuration* (case cfg
                                (:float-32 "float_32")
                                (:float-64 "float_64")
                                (:double-32 "double_32")
                                (:double-64 "double_64")
                                (t (error (format nil "Invalid build-configuration: ~A" cfg))))))

