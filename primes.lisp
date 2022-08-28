(defpackage :primes
  (:use :cl)
  (:import-from :streams
		:stream-car
		:stream-cdr
                :stream-filter
                :integers-starting-from)  
  (:export :prime-p :twin-prime-p :prime-factorization))
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

;;; prime-factorization procedure
(defun prime-factorization (n)
  "Procedure constructs list representing prime-factors of n."
  (labels ((prime-factorization-recur (k primes-stream result)
	     (cond ((equal (reduce #'* result) n)
		    result)
		   ((zerop (rem k (stream-car primes-stream)))
		    (prime-factorization-recur
		     (/ k (stream-car primes-stream))
		     primes-stream
		     (append result (list (stream-car primes-stream)))))
		   (t
		    (prime-factorization-recur
		     k
		     (stream-cdr primes-stream)
		     result)))))
    (if (prime-p n)
	(list n)
	(prime-factorization-recur
	 n
	 (stream-filter #'prime-p (integers-starting-from 2))
	 nil))))
