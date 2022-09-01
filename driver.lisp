(load "streams")
(load "primes")
(load "rnd")

(setf *random-state* (make-random-state t))

(do ((lo 10 (* 10 lo))
     (hi 99 (1- (* 100 lo))))
    ((> lo (expt 10 17)) 'done)
  (format t "~& ~d digits" (1+ (floor (log lo 10))))
  (dotimes (i 20)
    (let ((rnd (random-in-range lo hi)))
      (format t "~& ~d ~S" rnd (primes:factorize rnd)))))
