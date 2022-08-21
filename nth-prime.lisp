(load "streams")
(load "primes")
(defvar *primes-stream*)
(defvar *n*)
(setf *n* (parse-integer (second *posix-argv*)))
(setf *primes-stream*
      (streams:stream-filter
       #'primes:prime-p
       (streams:integers-starting-from 2)))
(format t "~&~d" (streams:stream-ref *primes-stream* (1- *n*)))
