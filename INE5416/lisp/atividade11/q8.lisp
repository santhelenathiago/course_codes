(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun bhaskara(a b c)
    (setq delta (- (expt b 2) (* 4 (* a c))))
    (setq x1 (/ (+ (- 0 b) (sqrt delta)) (* a 2.0)))
    (setq x2 (/ (- (- 0 b) (sqrt delta)) (* a 2.0)))
    (list x1 x2)
)

(defun main()
    (write-line "Função quadrática")
    (write-line (write-to-string (bhaskara (read_int "a") (read_int "b") (read_int "c")))) 
)

(main)