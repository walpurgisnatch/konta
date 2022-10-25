(in-package :cl-user)
(defpackage konta.job
  (:use :cl
        :konta.time)
  (:export :*jobs*
           :evaluate-when
           :evaluate-at))

(in-package :konta.job)

(defstruct job
  condition
  at-time
  action)

(defvar *jobs* (make-hash-table :test 'equalp))

(defun create-job (name type action &key (condition t) (at-time nil))
  (sethash *jobs* name (make-job :type type :action action :condition condition
                                 :at-time at-time)))

(defun run-jobs (now)
  (maphash #'(lambda (name job)
                 (cond ((job-condition job) (evaluate-when job)
                       ((job-at-time job) (evaluate-at now job)))))))

(defun evaluate-when (job &rest args)
  (when (job-condition)
    (apply (job-action) args)))

(defun evaluate-at (now job &rest args)
  (when (compare-times now (job-at-time job))
    (apply (job-action) args)))
