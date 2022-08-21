(load "streams")
(load "primes")
(defvar *primes-stream*)
(defvar *twin-primes-stream*)
(defvar *n*)
(defvar *p*)
(setf *n* (parse-integer (second *posix-argv*)))
(setf *primes-stream*
      (streams:stream-filter
       #'primes:prime-p
       (streams:integers-starting-from 2)))
(setf *twin-primes-stream*
      (streams:stream-filter
       #'(lambda (x) (primes:prime-p (+ x 2)))
       (streams:stream-filter #'primes:twin-prime-p *primes-stream*)))
(setf *p* (streams:stream-ref *twin-primes-stream* (1- *n*)))
(format t "~&~S" (cons *p* (+ *p* 2)))
