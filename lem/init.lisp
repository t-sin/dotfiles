(defpackage :lem.init.t-sin
  (:use :cl :lem)
  (:import-from :lem/directory-mode
                :*directory-mode-keymap*
                :directory-mode-up-directory)
  (:import-from :lem-lsp-mode
                :*lsp-mode-keymap*
                :lsp-rename))
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

;; key bindings
(define-key *directory-mode-keymap* "M-," 'lem/directory-mode)
(define-key *lsp-mode-keymap* "M-R" 'lsp-rename)

;; load files

;; load something
;; (load-initfile "hoge")
;; (load-initfile "fuga")

;; finally, load a script for editor debugging or experiments
(load-if-exists "temp")
