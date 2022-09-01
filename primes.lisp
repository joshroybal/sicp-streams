(defpackage :primes
  (:use :cl)
  (:import-from :streams
		:stream-car
		:stream-cdr
		:stream-mapcar
                :stream-filter
                :integers-starting-from)  
  (:export
   :prime-p
   :twin-prime-p
   :factorize
   :*primes*
   :*composites*
   :*prime-factorizations*
   :*semiprimes*))
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
(defun factorize (n)
  "Procedure constructs list representing prime factors of n."
  (labels ((factorize-recur (k primes-stream result)
	     (cond ((prime-p k)
		    (reverse (cons k result)))
		   ((divides-p (stream-car primes-stream) k)
		    (factorize-recur
		     (/ k (stream-car primes-stream))
		     primes-stream
		     (cons (stream-car primes-stream) result)))
		   (t
		    (let ((sd (smallest-divisor k))
			  (np (stream-car (stream-cdr primes-stream))))
		      (if (<= sd np)
			  (factorize-recur k (stream-cdr primes-stream) result)
			  (factorize-recur
			   k
			   (stream-filter #'prime-p (integers-starting-from sd))
			   result)))))))
    (factorize-recur
     n
     (stream-filter #'prime-p (integers-starting-from (smallest-divisor n)))
     nil)))

(defvar *primes*)
(defvar *composites*)
(defvar *prime-factorizations*)
(defvar *semiprimes*)

(setf *primes* (stream-filter #'prime-p (integers-starting-from 2)))

(setf *composites*
      (stream-filter
       #'(lambda (x) (not (prime-p x)))
       (integers-starting-from 2)))

(setf *prime-factorizations* (stream-mapcar #'factorize *composites*))

(setf *semiprimes*
      (stream-mapcar
       #'(lambda (x) (reduce #'* x))
       (stream-filter
	#'(lambda (x) (= (length x) 2))
	*prime-factorizations*)))
