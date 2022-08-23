;;; Credit for packages goes to Abelson & Sussmans, Eli B., ?
;;; SICP streams like package for Common Lisp.

(defpackage :streams
  (:use :common-lisp)
  (:export :cons-stream
	   :stream-car
	   :stream-cdr
           :+the-empty-stream+
	   :stream-null-p
           :stream-ref
	   :stream-enumerate-interval
	   :integers-starting-from
	   :stream-mapcar
           :stream-map
	   :stream-filter
           :add-streams
	   :mul-streams
           :scale-stream
           :power-stream
	   :partial-sums
	   :print-stream
   ))
(in-package :streams)

;;;global define macro
(defmacro deflex (var exp)
  "Macro to define global variables."
  `(progn
     (defvar ,var)
     (setf ,var ,exp)))

(defun memo-proc (proc)
  "Procedure memoizes proc."
  (let ((already-run-p nil) (result nil))
    (lambda ()
      (if (not already-run-p)
        (progn
          (setf result (funcall proc))
          (setf already-run-p t)
          result)
        result))))

;;; Delay and force are foundational to this implementation of streams.

(defmacro delay (exp)
  "Macro returns promise to evaluate exp when forced."
  `(memo-proc (lambda () ,exp)))

;;; This is how I got it to work by trial ane error.
;; (defun force (delayed-object)
;;   "Procedure forces evaluation of promised expression."
;;   (funcall (eval (macroexpand delayed-object))))

(defun force (delayed-object)
  "Procedure to force evaluation of delayed expression."
  (funcall delayed-object))

;;; fundamental stream constructor
(defmacro cons-stream (a b)
  "Macro generates code to cons a to stream b."
  `(cons ,a (delay ,b)))

(defun stream-car (s) (car s))
(defun stream-cdr (s) (force (cdr s)))

(defconstant +the-empty-stream+ nil)

(defun stream-null-p (s) (null s))

(defun stream-ref (s n)
  "Function returns nth element of stream s."
  (if (zerop n)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(defun stream-enumerate-interval (lo hi)
  (if (> lo hi)
      +the-empty-stream+
      (cons-stream
       lo
       (stream-enumerate-interval (+ lo 1) hi))))

(defun integers-starting-from (n)
  (cons-stream n (integers-starting-from (1+ n))))

;;; non tail-recursive first sol'n
(defun stream-head (s n)
  "Function takes first n or fewer elements from stream s."
  (cond ((stream-null-p s) +the-empty-stream+)
	((zerop n) +the-empty-stream+)
	(t (cons-stream (stream-car s) (stream-head (stream-cdr s) (- n 1))))))

;;; simple one dimensional map
(defun stream-mapcar (fn s)
  "Apply function to elements of stream."
  (if (stream-null-p s)
      +the-empty-stream+
      (cons-stream
       (funcall fn (stream-car s))
       (stream-mapcar fn (stream-cdr s)))))

;;; map over arbitrary no. of streams
(defun stream-map (proc &rest argstreams)
  (if (stream-null-p (car argstreams))
      +the-empty-stream+
      (cons-stream
       (apply proc (mapcar #'stream-car argstreams))
       (apply #'stream-map
	      (cons proc (mapcar #'stream-cdr argstreams))))))

;;; simple filter
(defun stream-filter (pred s)
  "Apply filter to elements of stream."
  (cond ((stream-null-p s) +the-empty-stream+)
	((funcall pred (stream-car s))
	 (cons-stream (stream-car s)
		      (stream-filter pred (stream-cdr s))))
	(t (stream-filter pred (stream-cdr s)))))

;; (defun add-streams (s1 s2)
;;   (cons-stream (+ (stream-car s1) (stream-car s2))
;; 	       (add-streams (stream-cdr s1) (stream-cdr s2))))

(defun add-streams (s1 s2)
  (stream-map #'+ s1 s2))

(defun mul-streams (s1 s2)
  (stream-map #'* s1 s2))

(defun scale-stream (scalar s)
  "Function multiplies stream s by scalar."
  (stream-mapcar #'(lambda (x) (* scalar x)) s))

(defun print-stream (s)
  "Procedure prints stream elements. Limit 1000."
  (do ((k 0 (1+ k))
       (out-stream s (stream-cdr out-stream)))
      ((or (>= k 1000) (stream-null-p out-stream)) 'done)
    (format t "~&~S" (stream-car out-stream))))

(defun power-stream (n)
  "Function constructs stream of non-negativepowers of n."
  (let ((*ones* nil))
    (progn
      (setf *ones* (cons-stream 1 *ones*))
      (stream-map #'expt (scale-stream n *ones*) (integers-starting-from 0)))))

;; (defun partial-sums (s)
;;   "Function constructs stream of partial-sums of n."
;;   (let ((ps
;; 	 (cons-stream (stream-car s) (add-streams (stream-cdr s) (partial-sums s)))))
;;     ps))

;;; Self-reference is neccessary in order to avoid re-calculation.
(defun partial-sums (s)
  "Function constructs stream of partial-sums of n."
  (let ((*ps* nil))
    (progn
      (setf *ps* (cons-stream (stream-car s) (add-streams (stream-cdr s) *ps*)))
      *ps*)))
