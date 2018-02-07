(in-package :stumpwm)

;;;; modules
(set-module-dir "~/.stumpwm.d/contrib")
(load-module "amixer")
(load-module "hostname")
(load-module "stumptray")

;;;; definition
(defcommand run-gterm ()
  nil
  (run-shell-command "gnome-terminal"))

;;;; key bindings
(set-prefix-key (kbd "C-["))

(undefine-key *root-map* (kbd "t"))
(define-key *root-map* (kbd "t") "run-gterm")

;;;; initializing
(run-shell-command "gksudo --description 'running xkeysnail' -- xkeysnail ~/.xkeysnail.config.py --devices /dev/input/event3")

;;;; visual
(setf *screen-mode-line-format*
      "^[^B^7*%h^]")
(mode-line)
(run-commands "stumptray")
