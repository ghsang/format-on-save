;;; format-on-save.el --- Auto-format on save

;;; Commentary:

;;; Code:


(defgroup format-on-save nil
  "Autoformat on save."
  :prefix "format-on-save"
  :group 'format-on-save)


(defconst format-on-save-formatters '((typescript-mode . ("eslint --fix"))))


(defun format-on-save--run-all ()
  "Run all formatters for 'major-mode'."
  (let ((formatters (cdr (assoc major-mode format-on-save-formatters))))
    (mapc 'format-on-save--run formatters)))


(defun format-on-save--run (formatter)
  "Run FORMATTER."
  (let ((command (concat formatter " " (buffer-file-name))))
    (call-process-shell-command command nil 0)))


;;;###autoload
(define-minor-mode format-on-save-mode
  "Toggle auto format on save."
  :lighter " FmtOnSave"
  :global nil
  (if format-on-save-mode
    (add-hook    'after-save-hook
                 'format-on-save--run-all
                  nil 'local)
    (remove-hook 'after-save-hook
                 'format-on-save--run-all
                 'local)))


(provide 'format-on-save)


;;; format-on-save.el ends here
