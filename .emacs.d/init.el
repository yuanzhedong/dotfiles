;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
;;(add-to-list 'load-path "~/.emacs.d")
(package-initialize)

(when (>= emacs-major-version 24)
(require 'package)
(add-to-list
 'package-archives
 ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
 '("melpa" . "http://melpa.milkbox.net/packages/")
 t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gofmt-command "gofmt"))
(setenv "GOPATH" "/home/ubuntu/gocode")
(add-to-list 'exec-path "/home/ubuntu/gocode/bin")

(defun my-go-mode-hook ()
					; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
					; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
					; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
	   "go build -v && go test -v && go vet"))
					; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
