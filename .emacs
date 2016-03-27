;; highlighting
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))


(setq load-path (append load-path '("~/dotemacs/")))

;; TODO: not working in cygwin
;; (require 'git-emacs)

;; python
(if (= emacs-major-version 21)
    (progn
      (add-to-list 'load-path "~/dotemacs/")
      (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
      (autoload 'python-mode "python-mode" nil t)
      (setq interpreter-mode-alist
            (cons '("python" . python-mode) interpreter-mode-alist))))

;; nXML
(add-to-list 'load-path "~/dotemacs/nxml-mode-20041004/")
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.rng\\'" . nxml-mode))
(autoload 'nxml-mode "nxml-mode" nil t)

(ido-mode t)
(setq-default fill-column 79)

;; customize colors
(set-face-foreground 'font-lock-comment-face "green")
(set-face-foreground 'font-lock-type-face "blue")
(set-face-bold-p 'font-lock-type-face t)
(set-face-foreground 'font-lock-variable-name-face "white")
(set-face-foreground 'font-lock-function-name-face "magenta")
(set-face-foreground 'font-lock-keyword-face "blue")
(set-face-foreground 'font-lock-string-face "cyan")

;; in C mode use auto-fill-mode
(setq c-mode-common-hook '(lambda nil
         (auto-fill-mode 1)))

(defun untabify-whole-buffer ()
  (untabify (point-min) (point-max)))

;; (add-hook 'before-save-hook 'untabify-whole-buffer)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; always save before compilation
(setq compilation-ask-about-save nil)

;; no toolbar
;; TODO: not working in cygwin
;; (tool-bar-mode -1)

;; compilation utilities (F9 key)
(defun switch-and-recompile ()
  " Switch to the compilation buffer and call recompile"
  (interactive)
  (switch-to-buffer-other-window "*compilation*")
  (recompile))
(defun switch-to-compilation ()
  " Switch to the compilation buffer"
  (interactive)
  (switch-to-buffer "*compilation*"))

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; show colum number
(setq column-number-mode t)

(setq-default indent-tabs-mode nil)
(setq default-tab-width 8)

;; Make buffers with uniq name include the name of the parent directory
(toggle-uniquify-buffer-names)
(setq uniquify-buffer-name-style  'post-forward-angle-brackets)

;; Coding conventions
(defconst c-basic-offset 4)
(c-set-offset 'defun-block-intro 4)
(c-set-offset 'statement-block-intro 4)
(c-set-offset 'func-decl-cont 0)
(c-set-offset 'block-open 0)
(c-set-offset 'block-close 0)
(c-set-offset 'substatement-open 0)
(c-set-offset 'substatement 4)
(c-set-offset 'namespace-open 0)
(c-set-offset 'innamespace 0)
(c-set-offset 'namespace-close 0)
;; (setq c-offsets-alist
;;       '((substatement-open . 0) (brace-list-open . 0)))
;; (setq c-echo-syntactic-information-p t)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; query replace in open buffers
(defun query-replace-regexp-in-open-buffers (arg1 arg2)
  "query-replace-regexp in open buffer"
  (interactive "squery replace in open buffers: \nsquery with: ")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (beginning-of-buffer)
       (query-replace-regexp arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))

;; simple code folding (bound to F1)
(defun mk-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

(global-set-key [(meta g)] 'goto-line)
(global-set-key [f3]       'delete-trailing-whitespace)
(global-set-key [f4]       'untabify-whole-buffer)
(global-set-key [f5]       'mk-toggle-selective-display)
(global-set-key [f9]       'switch-and-recompile)
(global-set-key [C-f9]     'switch-to-compilation)
(global-set-key [S-f9]     'compile)

(put 'upcase-region 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(nxml-sexp-element-flag t)
 '(show-trailing-whitespace t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)
