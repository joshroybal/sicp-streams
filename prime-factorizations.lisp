(load "streams")
(load "primes")
(defvar *n*)
(defvar *prime-factorizations-stream*)

(setf *n* (parse-integer (second *posix-argv*)))

(setf *prime-factorizations-stream*
      (streams:stream-mapcar #'primes:factorize
			     (streams:stream-filter
			      (lambda (x) (not (primes:prime-p x)))
			      (streams:integers-starting-from 2))))

(do ((i 1 (1+ i))
     (stream *prime-factorizations-stream* (streams:stream-cdr stream)))
    ((> i *n*) 'done)
  (format t "~& ~d ~S"
	  (reduce #'* (streams:stream-car stream))
	  (streams:stream-car stream)))
