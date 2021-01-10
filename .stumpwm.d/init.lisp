(in-package :stumpwm)

(setq *input-window-gravity* :center)
(setq *message-window-gravity* :center)

;;;; modules
(set-module-dir "~/.roswell/local-projects/stumpwm/stumpwm-contrib")
(load-module "amixer")
(load-module "battery-portable")
(load-module "hostname")
(load-module "stumptray")
(load-module "screenshot")

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

;;;; visual
(setf *screen-mode-line-format*
      "^B^3%h (%B) - %d ^B\| %n: %w")
(mode-line)
(run-commands "stumptray")

;;;; initializing
;; (run-shell-command "gksudo --description 'running xkeysnail' -- xkeysnail ~/xkeysnail.config.py --devices /dev/input/event3")
(let* ((wpdir "/home/grey/code/lisp-alien-wallpapers/03_evolution-of-lisp")
       (wpname "evolution-of-lisp-aliens_black.png")
       (wp (format nil "~a/~a" wpdir wpname)))
  (run-shell-command (format nil "feh --bg-fill '~a'" wp)))

;;;; start key remapper
;; before this, do like this:
;;
;; sudo groupadd -f uinput
;; sudo gpasswd -a $USER uinput
;;
;; cat <<EOF | sudo tee /etc/udev/rules.d/70-xkeysnail.rules
;; KERNEL=="uinput", GROUP="uinput", MODE="0660", OPTIONS+="static_node=uinput"
;; KERNEL=="event[0-9]*", GROUP="uinput", MODE="0660"
;; EOF
(run-shell-command "xkeysnail ~/xkeysnail.config.py")
