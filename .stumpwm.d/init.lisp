(in-package :stumpwm)

;;;; modules
(set-module-dir "~/.stumpwm.d/contrib")
(load-module "amixer")
(load-module "battery-portable")
(load-module "hostname")
(load-module "stumptray")

;;;; definition
(defcommand run-gterm ()
  nil
  (run-shell-command "gnome-terminal"))

;;;; key bindings
(set-prefix-key (kbd "C-["))

(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Master-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Master-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle pulse")

(define-key *root-map* (kbd "t") "run-gterm")
(undefine-key *root-map* (kbd "c"))
(define-key *root-map* (kbd "c") "exec")

;;;; initializing
(run-shell-command "gksudo --description 'running xkeysnail' -- xkeysnail ~/.xkeysnail.config.py --devices /dev/input/event3")

;;;; visual
(setf *screen-mode-line-format*
      "^B^3%h (%B) - %d ^B\| %n: %w")
(mode-line)
(run-commands "stumptray")
