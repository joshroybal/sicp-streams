(load "streams")
(defvar *n*)
(defvar *triangulars-stream*)
(setf *n* (parse-integer (second *posix-argv*)))
(setf *triangulars-stream*
      (streams:partial-sums (streams:integers-starting-from 0)))
(format t "~& ~d" (streams:stream-ref *triangulars-stream* *n*))
