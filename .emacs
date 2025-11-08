(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((sensible-defaults :url "https://github.com/hrs/sensible-defaults.el.git"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-bar ((t (:background "#1e1e1e" :foreground "#b0b0b0" :height 0.9))))
 '(tab-bar-tab ((t (:background "#3a3a3a" :foreground "#ffffff" :weight bold :box (:line-width 1 :color "#5a5a5a")))))
 '(tab-bar-tab-inactive ((t (:background "#2a2a2a" :foreground "#888888" :box (:line-width 1 :color "#3a3a3a"))))))

;;
;; Melpa
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;
;; Required packages
;;
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(use-package auto-compile
  :demand t
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)

(setq byte-compile-warnings '(cl-functions))

(setq byte-compile-warnings
      '(not free-vars unresolved noruntime lexical make-local))

(use-package system-packages :ensure t)

;;
;; Flycheck
;;
(add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; Ranger
;;
(use-package ranger
  :ensure t
  :config
  (setq ranger-show-hidden t))

(with-eval-after-load 'evil
(evil-define-key 'normal 'global (kbd "M-f M-f") #'ranger))

;;
;; Forge
;;
(use-package forge
  :after magit)

;;
;; Line Reminder
;;
(use-package line-reminder
  :ensure t
  :config
  (setq line-reminder-show-changes t)
  (global-line-reminder-mode t))

;;
;; Golden Ratio
;;
(golden-ratio-mode 1)
(setq golden-ratio-adjust-factor 1.2)

;;
;; Helm
;;
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (setq helm-boring-file-regexp-list '("\\.o$" "~$" "\\.bin$" "\\.elc$")))

;;
;; Ivy
;;
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "))

;;
;; Counsel
;;
(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode 1))

;;
;; Projectile
;;
(use-package projectile
  :demand t
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/projects/" "~/work/"))
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;;
;; Flycheck
;;
(global-flycheck-mode t)
(setq flycheck-display-errors-delay 0.3)

;;
;; Evil
;;
(setq evil-want-keybinding nil)

(use-package evil
  :demand t
  :after undo-tree
  :init
  (setq evil-respect-visual-line-mode t
        evil-undo-system 'undo-tree
        evil-want-abbrev-expand-on-insert-exit nil
        evil-want-keybinding nil)
  :config
  (evil-mode 1)

  (with-eval-after-load 'projectile
    (evil-define-key '(normal insert) 'global (kbd "C-p") 'project-find-file))

  (with-eval-after-load 'org
    (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
    (evil-define-key 'insert org-mode-map (kbd "S-<right>") 'org-shiftright)
    (evil-define-key 'insert org-mode-map (kbd "S-<left>") 'org-shiftleft))
    (fset 'evil-visual-update-x-selection 'ignore))


(use-package evil-collection
  :after evil
  :demand t

  :config
  (setq evil-collection-mode-list
        '(comint
          deadgrep
          dired
          ediff
          elfeed
          eww
          ibuffer
          info
          magit
          mu4e
          package-menu
          pdf-view
          proced
          replace
          vterm
          which-key))

  (evil-collection-init))

(use-package evil-surround
  :after evil
  :demand t
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :after (evil org)
  :demand t

  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(with-eval-after-load 'evil
  (evil-define-key 'normal 'global
    (kbd "gt") 'tab-next
    (kbd "gT") 'tab-previous))

(dotimes (i 9)
  (let ((n (1+ i)))
    (global-set-key (kbd (format "M-%d" n))
                    `(lambda ()
                       (interactive)
                       (tab-select ,n)))))

(global-set-key (kbd "M-t") 'tab-new)
(global-set-key (kbd "M-w") 'tab-close)


;;
;; Sensible Defaults
;;
(use-package sensible-defaults
  :vc (:url "https://github.com/hrs/sensible-defaults.el.git"
            :rev :newest)
  :demand t

  :config
  (sensible-defaults/use-all-settings)
  (sensible-defaults/use-all-keybindings)
  (sensible-defaults/backup-to-temp-directory))

;;
;; UI
;;
(setq-default tab-width 2)

(setq scroll-conservatively 100)

(setq frame-inhibit-implied-resize t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

(setq visible-bell nil)

;;
;; Modeline
;;
(pixel-scroll-precision-mode 1)

(defvar +scroll-delta 180)

(defun +scroll-up-some ()
  (interactive)
  (pixel-scroll-precision-scroll-up +scroll-delta))

(defun +scroll-down-some ()
  (interactive)
  (pixel-scroll-precision-scroll-down +scroll-delta))

(defun +bind-scroll-keys (mode-map)
  (evil-define-key '(motion normal) mode-map (kbd "K") '+scroll-up-some)
  (evil-define-key '(motion normal) mode-map (kbd "J") '+scroll-down-some))

;;
;; Modeline
;;
(use-package moody
  :demand t

  :custom
  (x-underline-at-descent-line t)

  :config
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))

;;
;; Time
;;
(setq display-time-format "[%H:%M on %A, %b %-d]"
      display-time-default-load-average nil
      display-time-mail-file 0)

;; Always show time in the mode line
(display-time-mode 1)

;;
;; Minions
;;
(use-package minions
  :demand t

  :custom
  (minions-mode-line-delimiters (cons "" ""))

  :config
  (defun +set-minions-mode-line-lighter ()
    (setq minions-mode-line-lighter
          (if (display-graphic-p) "⚙" "#")))

  (add-hook 'server-after-make-frame-hook #'+set-minions-mode-line-lighter)

  (minions-mode 1))

;;
;; Font
;;
(defvar +font-size-fixed 80)
(defvar +font-size-variable 130)

(set-face-attribute 'default nil
                    :family "DM Mono"
                    :height +font-size-fixed)

(set-face-attribute 'fixed-pitch nil
                    :family "DM Mono"
                    :height +font-size-fixed)

(set-face-attribute 'variable-pitch nil
                    :family "Minion Pro"
                    :height +font-size-variable)

(use-package default-text-scale
  :bind
  (("C-)" . default-text-scale-reset)
   ("C-=" . default-text-scale-increase)
   ("C--" . default-text-scale-decrease)))

;;
;; Highlight Diff
;;
(use-package diff-hl
  :config
  :hook ((text-mode prog-mode vc-dir-mode) . turn-on-diff-hl-mode))

;;
;; Ripgrep
;;
(use-package deadgrep
  :ensure-system-package (rg . ripgrep)
  :commands (deadgrep deadgrep--read-search-term)

  :config
  (evil-define-key 'motion deadgrep-mode-map (kbd "C-p") 'project-find-file)

  (defun deadgrep--include-args (rg-args)
    (push "--hidden" rg-args)
    (push "--glob=!.git/" rg-args))
  (advice-add 'deadgrep--arguments
              :filter-return #'deadgrep--include-args))

;;
;; Corfu
;;
(use-package corfu
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :custom
  (tab-always-indent 'complete)
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect 'prompt)

  :init
  (global-corfu-mode))

;;
;; Ediff
;;
(use-package ediff
  :ensure nil

  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally))

;;
;; Magit
;;
(use-package magit
  :ensure-system-package (git git-absorb)
  :hook (with-editor-mode . evil-insert-state)
  :bind ("C-x g" . magit-status)

  :config
  (use-package magit-section)
  (use-package with-editor)

  (require 'git-rebase)

  (defun +get-author-parse-line (key value domain)
    (let* ((values (mapcar #'s-trim (s-split ";" value)))
           (name (car values))
           (email (or (cadr values) key)))
      (format "%s <%s@%s>" name email domain)))

  (defun +git-authors ()
    (let* ((config (yaml-parse-string (f-read-text "~/.git-authors")))
           (domain (gethash 'domain (gethash 'email config)))
           (authors '()))
      (+maphash (lambda (k v) (+git-author-parse-line k v domain))
                (gethash 'authors config))))

  (defun +insert-git-coauthor ()
    "Prompt for co-author and insert a co-authored-by block."
    (interactive)
    (insert (format "Co-authored-by: %s\n"
                    (completing-read "Co-authored by:" (+git-authors)))))

  (defun +changed-files-on-branch (&optional directory)
    "Return a list of files that have changed on this branch (relative to main) relative to DIRECTORY."
    (let ((default-directory (or directory (project-root (project-current)))))
      (seq-remove #'string-empty-p
                  (split-string (shell-command-to-string "git diff --name-only main")
                                "\n"))))

  (transient-replace-suffix 'magit-commit 'magit-commit-autofixup
    '("x" "Absorb changes" magit-commit-absorb))

  (setq git-commit-summary-max-length 50
        magit-bury-buffer-function 'magit-restore-window-configuration
        magit-display-buffer-function 'magit-display-buffer-fullframe-status-topleft-v1
        magit-push-always-verify nil))

;;
;; Git Time Machine
;;
(use-package git-timemachine)

;;
;; Occur
;;
(use-package occur
  :ensure nil

  :config
  (evil-define-key 'normal occur-mode-map (kbd "g r") 'revert-buffer)
  (evil-define-key 'normal occur-mode-map (kbd "q") '+quit-window-and-kill))

;;
;; Undo Tree
;;
(use-package undo-tree
  :demand t

  :config
  (setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "undo-tree"))))
  (global-undo-tree-mode)

  (defun +undo-tree-suppress-undo-history-saved-message (undo-tree-save-history &rest args)
    "Suppress the message saying that the undo history file was saved (because this happens every single time you save a file)."
    (let ((inhibit-message t))
      (apply undo-tree-save-history args)))

  (defun +undo-tree-suppress-buffer-modified-message (undo-tree-load-history &rest args)
    "Suppress the message saying that the undo history could not be loaded because the file changed outside of Emacs."
    (let ((inhibit-message t))
      (apply undo-tree-load-history args)))

  (advice-add #'undo-tree-load-history :around
              #'+undo-tree-suppress-undo-history-saved-message)

  (advice-add #'undo-tree-load-history :around
              #'+undo-tree-suppress-buffer-modified-message))

;;
;; Subword
;;
(use-package subword
  :config (global-subword-mode 1))

;;
;; Eglot
;;
(use-package eglot
  :ensure t
  :hook ((c-mode c++-mode) . eglot-ensure)
  :config
  (defun +eglot-format-buffer-on-save ()
    "Add formatting before save for the current buffer."
    (add-hook 'before-save-hook #'eglot-format-buffer nil t))

  (add-hook 'c-mode-hook #'+eglot-format-buffer-on-save)
  (add-hook 'c++-mode-hook #'+eglot-format-buffer-on-save))

;;
;; Code Folding
;;
(use-package hs-minor-mode
  :ensure nil
  :hook prog-mode

  :init
  (defvar-local +maybe-hidden-blocks nil)
  (add-hook 'hs-hide-hook (lambda () (setq-local +maybe-hidden-blocks t)))

  (defun +toggle-all-folds ()
    "If any block are hidden, show them all. Otherwise, hide all top-level blocks."
    (interactive)
    (if +maybe-hidden-blocks
        (progn
          (setq-local +maybe-hidden-blocks nil)
          (hs-show-all))
      (hs-hide-all)))

  (evil-define-key 'normal prog-mode-map (kbd "<tab>") 'hs-toggle-hiding)
  (evil-define-key 'normal prog-mode-map (kbd "<backtab>") '+toggle-all-folds))

;;
;; Proof General
;;
(use-package proof-general
  :ensure-system-package (coqc . coq)
  :hook (coq-mode . (lambda ()
                      (undo-tree-mode 1)
                      (abbrev-mode 0)))
  :bind ("C-c v" . deadgrep)

  :custom
  (proof-splash-enable nil)
  (proof-three-window-mode-policy 'hybrid)
  (proof-follow-mode 'follow)
  (proof-script-fly-past-comments t)

  :config
  (evil-define-key 'normal coq-mode-map (kbd "<down>") 'proof-assert-next-command-interactive)
  (evil-define-key 'insert coq-mode-map (kbd "<down>") 'proof-assert-next-command-interactive)

  (evil-define-key 'normal coq-mode-map (kbd "<up>") 'proof-undo-last-successful-command)
  (evil-define-key 'insert coq-mode-map (kbd "<up>") 'proof-undo-last-successful-command))

;;
;; Engine Mode
;;
(use-package engine-mode
  :config
  (engine-mode t)

  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "/")

  (defengine wikipedia
    "http://www.wikipedia.org/search-redirect.php?search=%s&language=en&go=Go"
    :keybinding "w"))

;;
;; Spaces > Tabs
;;
(setq-default indent-tabs-mode nil)

;;
;; Which Key
;;
(use-package which-key
  :demand t
  :config (which-key-mode))

;;
;; Elcord
;;

(use-package elcord
  :ensure t
  :config
  (when (display-graphic-p)
    (elcord-mode)))

(setq elcord-editor-icon "emacs")
(setq elcord-display-buffer-details t)
(setq elcord-display-major-mode t)

;;
;; Mass Grep Editing
;;
(use-package wgrep)

(eval-after-load 'grep
  '(define-key grep-mode-map
    (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(eval-after-load 'wgrep
  '(define-key grep-mode-map
    (kbd "C-c C-c") 'wgrep-finish-edit))

(setq wgrep-auto-save-buffer t)

;;
;; Keybinds
;;
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;
;; Helpful
;;
(use-package helpful
  :ensure t
  :commands (helpful-callable helpful-variable helpful-key)
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key))
  :config
  (setq help-window-select t)
  (evil-define-key 'normal helpful-mode-map (kbd "q") 'quit-window))

;;
;; Save Place
;;
(setq save-place-forget-unreadable-files nil)
(save-place-mode 1)

;;
;; Winum
;;
(use-package winum
  :ensure t
  :config
  (winum-mode 1)

  (dotimes (i 9)
    (let ((n (1+ i)))
      (global-set-key (kbd (format "M-%d" n))
                      `(lambda ()
                         (interactive)
                         (winum-select-window ,n))))))

(global-set-key (kbd "M-0") 'winum-select-window-0)

(evil-define-key 'normal 'global
  (kbd "SPC 1") '(lambda () (interactive) (winum-select-window 1))
  (kbd "SPC 2") '(lambda () (interactive) (winum-select-window 2))
  (kbd "SPC 3") '(lambda () (interactive) (winum-select-window 3))
  (kbd "SPC 4") '(lambda () (interactive) (winum-select-window 4)))

;;
;; Auto Format Recursively
;;
(defun eglot-format-all-files (dir)
  "Recursively format all files under DIR using Eglot."
  (interactive "DDirectory: ")
  (dolist (file (directory-files-recursively dir ".*\\.\\(c\\|cpp\\|h\\|py\\|rs\\|go\\|js\\|ts\\|el\\)$"))
    (with-current-buffer (find-file-noselect file)
      (when (eglot-managed-p)
        (eglot-format-buffer)
        (save-buffer))
      (kill-buffer))))
