(in-package :stumpwm)

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
(mode-line)



