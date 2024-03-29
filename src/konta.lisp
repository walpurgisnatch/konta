(in-package :cl-user)
(defpackage konta
  (:use :cl
        :konta.time
        :konta.job)
  (:import-from :pero
                :write-line-to)
  (:export :main))

(in-package :konta)

(defvar *heartbeat* t)

(defun main (&optional (sleep-time 30))
  (konta.daemon:daemonize :exit-parent t)
  (loop while *heartbeat* with now = (now) do
    (setf now (now))
    (run-jobs now)
    (when (no-more-jobs) (setf *heartbeat* nil))
    (sleep sleep-time))
  (pero:write-line-to "~/konta" (format nil "heartbeat stopped | ~a" *heartbeat*))
  (konta.daemon:exit))

