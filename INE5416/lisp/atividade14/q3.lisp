(defun main()
    (write "a=")
    (setq a (float (read)))
    (write "b=")
    (setq b (float (read)))
    (write "c=")
    (setq c (float (read)))
    (write-line (write-to-string ((lambda (a b c) (list (/ (+ (* b b) (sqrt (+ (- b) (- (* 4 a c)))) (* 2 a))) (/ (- (* b b) (sqrt (+ (- b) (- (* 4 a c)))) (* 2 a))))) a b c)))
)

(main)