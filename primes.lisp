(defpackage :primes
  (:use :cl)
  (:export :prime-p :twin-prime-p))
(in-package :primes)

;;; primality predicate
(defun prime-p (n)
  "Procedure predicate is true when n is prime."
  (cond ((< n 2) nil)
	((< n 4) t)
	((evenp n) nil)
	((zerop (rem n 3)) nil)
	(t
	 (do ((k 5 (+ k 6)))
	     ((> k (sqrt n)) t)
	   (when (or (zerop (rem n k)) (zerop (rem n (+ k 2))))
	     (return-from prime-p nil))))))

;;; twin prime predicate
(defun twin-prime-p (n)
  "Procedure predicate is true when n is a twin prime."
  (cond ((not (prime-p n)) nil)
	((or (prime-p (+ n 2)) (prime-p (- n 2))) t)
	(t nil)))
