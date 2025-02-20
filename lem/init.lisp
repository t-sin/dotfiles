(defpackage :lem.init.t-sin
  (:use :cl :lem))
(in-package :lem.init.t-sin)

;; loading utilities

(defun initfile-path (filename)
  (make-pathname :name filename
                 :type "lisp"
                 :defaults *load-pathname*))

(defun load-initfile (filename)
  (let ((initfile (if (typep filename 'pathname)
                      filename
                      (initfile-path filename))))
    (log:info "loading ~s" initfile)
    (load initfile)))

(defun load-if-exists (filename)
  (let ((initfile (initfile-path filename)))
    (if (probe-file initfile)
        (load-initfile initfile)
        (log:info "don't load ~s because of not found" initfile))))

(setf *auto-format* t)

;; load files

;; TODO: load something
;; (load-initfile "aaaaaaaaaaaaaaaaa")

;; finally, load a script for editor debugging or experiments
(load-if-exists "temp")
