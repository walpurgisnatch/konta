(in-package :cl-user)
(defpackage konta.actions
  (:use :cl
        :konta.time)
  (:import-from :pero
                :write-line-to)
  (:export :shell))

(in-package :konta.actions)

(defun shell (&rest args)
  (uiop:run-program (format nil "~{~a~^ ~}" args)))
