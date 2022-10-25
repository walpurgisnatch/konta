(in-package :cl-user)
(defpackage konta.utils
  (:use :cl)
  (:export :sethash))

(in-package :konta.utils)

(defun sethash (table key value)
  (setf (gethash key table) value))

(defun defword ()
  (make-array 0
              :element-type 'character
              :fill-pointer 0
              :adjustable t))

(defun string-starts-with (string x)
  (string-equal string x :end1 (length x)))

(defmacro concat (string &rest words)
  `(setf ,string (concatenate 'string ,string ,@words)))
