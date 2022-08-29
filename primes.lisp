(defpackage :primes
  (:use :cl)
  (:import-from :streams
		:stream-car
		:stream-cdr
                :stream-filter
                :integers-starting-from)  
  (:export :prime-p :twin-prime-p :prime-factorization))
(in-package :primes)

;;;
(defun divides-p (x y)
  "Procedure predicate is true when x|y."
  (= (rem y x) 0))

;;; 
(defun smallest-divisor (n)
  "Procedure returns smallest non-unity divisor of n."
  (cond ((< n 2) nil)
	((evenp n) 2)
	((divides-p 3 n) 3)
	(t
	 (do ((k 5 (+ k 6)))
	     ((> k (sqrt n)) n)
	   (cond ((divides-p k n)
		  (return-from smallest-divisor k))
		 ((divides-p (+ k 2) n)
		  (return-from smallest-divisor (+ k 2))))))))

;;; primality predicate
(defun prime-p (n)
  "Procedure predicate is true when n is prime."
  (if (= (smallest-divisor n) n)
      t
      nil))

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
		    (reverse result))
		   ((prime-p k)
		    (prime-factorization-recur
		     (/ k (reduce #'* result))
		     (stream-filter
		      #'prime-p
		      (integers-starting-from (+ k 2)))
		     (cons k result)))
		   ((divides-p (stream-car primes-stream) k)
		    (prime-factorization-recur
		     (/ k (stream-car primes-stream))
		     primes-stream
		     (cons (stream-car primes-stream) result)))
		   (t
		    (prime-factorization-recur
		     k
		     (stream-cdr primes-stream)
		     result)))))
    (prime-factorization-recur
     n
     (stream-filter #'prime-p (integers-starting-from (smallest-divisor n)))
     nil)))
