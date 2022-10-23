(in-package :cl-user)
(defpackage konta
  (:use :cl)
  (:import-from :pero
                :write-line-to)
  (:export :main))

(in-package :konta)

(defvar heartbeat nil)

(defstruct time-obj
  day
  day-of-week
  hour
  minute)

(defparameter *test-time* (make-time-obj :hour 6 :minute 50))

(defmacro get-time (type obj)
  `(,(intern (format nil "TIME-OBJ-~a" type)) ,obj))

(defmacro time= (obj type val)
  `(or (null (get-time ,type ,obj)) (<= (get-time ,type ,obj) ,val)))

(defun main ()
  (konta.daemon:daemonize)
  (loop until heartbeat do
    (progn (evaluate-when *test-time* #'write-line-to "~/konta-was-here"
                   (format nil "i was here at ~a:~a" (time-obj-hour *test-time*) (time-obj-minute *test-time*)))
           (setf heartbeat t))
    (sleep 45))
  (konta.daemon:exit))

(defun evaluate-when (time job &rest args)
  (when (now? time)
    (apply job args)))

(defun now? (time)
  (multiple-value-bind (sec m h d month year dow dst-p tz)
      (get-decoded-time)
    (and (time= time minute m)
         (time= time hour h)
         (time= time day d)
         (time= time day-of-week dow))))
