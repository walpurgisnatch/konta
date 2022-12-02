(in-package :cl-user)
(defpackage konta.job
  (:use :cl
        :konta.utils
        :konta.time
        :konta.actions)
  (:export :*jobs*
           :run-jobs
           :create-job
           :evaluate-when
           :job
           :job-conditions
           :job-actions
           :no-more-jobs))

(in-package :konta.job)

(defstruct job
  conditions
  actions
  repeatable)

(defvar *jobs* (make-hash-table :test 'equalp))

(defun create-job (name actions &key (conditions t))
  (sethash *jobs* name (make-job :actions actions :conditions conditions)))

(print (create-job "test"
                   '((pero:write-line-to "~/konta" (format nil "I was here at ~a" (now)))
                     (pero:write-line-to "~/konta" "kek"))
                   :conditions '((now-or-earlier? (make-time-point :minute 57 :hour 12)))))

(defun run-jobs (now)
  (maphash #'(lambda (name job)
               (execute-when name job))
           *jobs*))

(defun execute-when (name job)
  (when (every #'achieve (job-conditions job))
    (execute-all (job-actions job))
    (remove-job name job)))

(defun remove-job (name job)
  (unless (job-repeatable job)
    (remhash name *jobs*)))

(defun achieve (preconds)
  (eval preconds))

(defun execute-all (actions)
  (loop for action in actions
        do (eval action)))

(defun no-more-jobs ()
  (= 0 (hash-table-count *jobs*)))
