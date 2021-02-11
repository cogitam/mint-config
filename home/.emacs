;; Config file for Emacs
;; 
;; Updated: 03-12-2012

;; Encoding
(set-language-environment "UTF-8")

;; New custom file
;(setq custom-file "~/.emacs-custom.el")
;(load custom-file)

;; Appearance
(tool-bar-mode 0)
; (menu-bar-mode 0)
; (scroll-bar-mode 0)
(column-number-mode t)
(setq truncate-partial-width-windows nil)
(display-time-mode t)

;; Commands
(global-set-key (kbd "C-c s") 'replace-string)
(global-set-key (kbd "C-c x") 'replace-regexp)
(global-set-key (kbd "C-c b") 'bury-buffer)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c g") 'gdb)
(global-set-key (kbd "C-x g") 'goto-line)

;; Easy bookmarks system
;; (load "/path/to/easy-bookmarks.el")

;; Open the file I am working on and jump to a line
(setq inhibit-startup-message t)
;; (find-file "/path/to/current_file")
;; (goto-line 1049)
