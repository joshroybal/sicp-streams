(load "streams")
(load "primes")

(defvar *n*)
(defvar *stream*)

(setf *n* (parse-integer (second *posix-argv*)))

(do ((i 0 (1+ i))
     (stream primes:*semiprimes* (streams:stream-cdr stream)))
    ((= i *n*) 'done)
  (let ((x (streams:stream-car stream)))
    (format t "~& ~d ~S" x (primes:prime-factorization x))))
