(defun random-in-range (lo hi)
  (+ lo (random (1+ (- hi lo)))))
