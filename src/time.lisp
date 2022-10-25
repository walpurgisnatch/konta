(in-package :cl-user)
(defpackage konta.time
  (:use :cl)
  (:export :time-point
           :time-point-day
           :time-point-day-of-week
           :time-point-hour
           :time-point-minute
           :now
           :now?
           :compare-times))

(in-package :konta.time)

(defstruct time-point
  day
  day-of-week
  hour
  minute)

(defmacro get-time (type obj)
  `(,(intern (format nil "TIME-POINT-~a" type)) ,obj))

(defmacro time= (type p1 p2)
  `(or (= (get-time ,type ,p1) (get-time ,type ,p2))
       (null (get-time ,type ,p1))
       (null (get-time ,type ,p2))))

(defun now ()
   (multiple-value-bind (sec m h d month year dow dst-p tz)
       (get-decoded-time)
     (make-time-point :minute m :hour h :day d :day-of-week dow)))

(defun compare-times (first second)
  (and (time= minute first second)
       (time= hour first second)
       (time= day first second)
       (time= day-of-week first second)))

(defun now? (time)
  (let ((now (now)))
    (compare-times time now)))
