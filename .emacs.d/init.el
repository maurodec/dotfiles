;;;;;;;;;;;;;;;;;;;;;;
;; General Settings ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Hide scrollbars
(scroll-bar-mode -1)
;; Hide toolbar
(tool-bar-mode -1)

;; Don't show startup screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Bar cursor
(setq-default cursor-type 'bar)
(setq mouse-wheel-progressive-speed nil)

;; Show column number
(setq column-number-mode  t)

;; No backup files
(setq make-backup-files nil)
;; Don't autosave
(setq auto-save-default nil)

;; Fonts
(set-face-attribute 'default nil :height 130)
(set-face-attribute 'default nil :font "Menlo")

;; Highlight matching parentheses, or whole expr if not visible.
(show-paren-mode 1)
(setq show-paren-style 'mixed)

;; Always use spaces when indenting (unless overridden for buffer)
(setq-default indent-tabs-mode nil)

;; Remove trailing Whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Ensure newline at end of file.
(setq require-final-newline t)

;; Highlight current line
(global-hl-line-mode)
;; Show line numbers
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ")

;; Keybindings
(global-set-key (kbd "<f11>")
                (lambda()(interactive)(find-file "~/.emacs.d/init.el")))

(global-set-key (kbd "<s-right>") 'move-end-of-line)
(global-set-key (kbd "<s-left>") 'move-beginning-of-line)
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
(global-set-key (kbd "<s-a>") 'mark-whole-buffer)
(global-set-key (kbd "RET") 'newline-and-indent)

;; Overwrite selection when typing
(delete-selection-mode t)


;;;;;;;;;;;;;;;;;;;;;;
;; Package settings ;;
;;;;;;;;;;;;;;;;;;;;;;

(defvar my-emacs-bin-directory
  (convert-standard-filename (concat user-emacs-directory "bin/")))

(defvar my-modules-directory
  (convert-standard-filename (concat user-emacs-directory "modules")))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(markdown-mode
		      rainbow-mode
		      yaml-mode
                      web-mode
                      nyan-mode
		      ido-ubiquitous
                      ido-vertical-mode
		      smex
		      magit
		      fill-column-indicator
                      yasnippet
                      auto-highlight-symbol
                      monokai-theme
                      go-mode))

;; Check if packages in my-packages are installed; if not, install.
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 my-packages)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings for extra packages ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; magit
(setq magit-default-tracking-name-function
      'magit-default-tracking-name-branch-only)

;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; ido-mode
(ido-mode t)
(ido-ubiquitous t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)
(ido-vertical-mode t)
(global-set-key (kbd "C-b") 'ido-switch-buffer)

;; nyan-mode
(nyan-mode)
(nyan-start-animation)
(setq nyan-wavy-trail t)

;; projectile
(projectile-global-mode)

;; Yasnipper
(yas-global-mode t)

;; Auto-highlight-symbol
(global-auto-highlight-symbol-mode t)


;;;;;;;;;;;;;;;
;; Automodes ;;
;;;;;;;;;;;;;;;

;; Markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; Jinja2
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))

;; Ruby
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; Go
(require 'go-mode-load)


;;;;;;;;;;;
;; Theme ;;
;;;;;;;;;;;

(load-theme 'monokai t)
