(load "streams")
(load "primes")
(defvar *n*)
(setf *n* (parse-integer (second *posix-argv*)))
(format t "~&~S" (primes:prime-factorization *n*))