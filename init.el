;;; init.el --- where all the magic begins

;;; Commentary:

;; Provides a minimal interface for developing Clojure and PHP

;;; Code:

;;Remove unessesary interface
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;;;; Package setup
(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar package-list
  '(
    cider
    clojure-mode
    expand-region
    flycheck
    flycheck-clojure
    flycheck-tip
    flyspell-lazy
    flyspell-popup
    json-mode
    less-css-mode
    magit
    multiple-cursors
    php-mode
    zenburn-theme
    ))

;; Fetch the list of packages available
(or (file-exists-p package-user-dir) (package-refresh-contents))
;(unless package-archive-contents
;  (package-refresh-contents))

;; Install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(load-theme 'zenburn t)

; show belongin parens / brackets
(show-paren-mode t)

; search case insensitive?
(setq case-fold-search t)

; Show the cursor column next to the line in the bottom status bar
(setq column-number-mode t)
(setq mouse-wheel-follow-mouse t)
(setq mouse-wheel-mode t)

; Disable the system bell in
(setq visible-bell t)

; Make sure that Emacs doesn't leave ~-files all over
(setq backup-directory-alist (list (cons ".*" (expand-file-name "~/.emacsbackup/"))))

(require 'expand-region)
(global-set-key (kbd "M-2") 'er/expand-region)

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq auto-mode-alist
      (append
       '(("tpl_[^/]*\\.php\\'" . sgml-mode)
         ("\\.phtml\\'" . sgml-mode)
         ("\\.php\\'" . php-mode)
         ("\\.js$" . js-mode)
         ("\\.json$" . js-mode)
         ("\\.clj$" . clojure-mode)
         ("\\.cljs$" . clojure-mode)
         ("\\.cljx$" . clojure-mode)
         ("\\.edn$" . clojure-mode))
       auto-mode-alist))

; Magit
(global-set-key [f2] 'magit-status)

;; Enable expand-region on key binding where it would have been
;; had it been a UK keyboard (C-=)
(global-set-key [C-dead-acute] 'er/expand-region)

; Makes it possible to tab through windows (instead of using C-x o)
(global-set-key [C-tab] 'other-window)

;; Always split side-by-side
;; http://stackoverflow.com/questions/2081577/setting-emacs-split-to-horizontal
(setq split-height-threshold nil)
(setq split-width-threshold 162)

(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)


;; Unbind Pesky Sleep Button
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

; PHP indent settings copy pasted from web
(defun php-indent-settings ()
  (setq tab-width 4
        c-basic-offset 4
        indent-tabs-mode nil
        show-paren-mode t
        )
  (c-set-offset 'substatement-open 0))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/php-extras"))
;; php-mode is already loaded at this point
;(eval-after-load 'php-mode
(require 'php-extras)
;)

(setq flycheck-phpcs-standard "PSR2")

(add-hook 'php-mode-hook (lambda ()
                           (php-indent-settings)
                           (eldoc-mode)
                           (php-enable-psr2-coding-style)
                           (flycheck-select-checker 'php)
                           ;; Draw tabs with the same color as trailing whitespace
                           (font-lock-add-keywords
                            nil
                            '(("\t" 0 'trailing-whitespace prepend)))
                           ))


(setq cider-repl-history-file "~/.cider-history")
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq nrepl-hide-special-buffers t)

(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook
          '(lambda ()
             (electric-pair-mode t)))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key [f5] 'mc/mark-all-like-this-dwim)
(global-set-key [f7] 'flyspell-buffer)
(global-set-key [S-f7] 'flyspell-prog-mode)
(put 'scroll-left 'disabled nil)

;; find aspell and hunspell automatically
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-extra-args '("-d en_US")))
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cider clojure-mode expand-region flycheck flycheck-clojure flycheck-tip flyspell-lazy flyspell-popup json-mode less-css-mode magit multiple-cursors php-mode zenburn-theme))))
