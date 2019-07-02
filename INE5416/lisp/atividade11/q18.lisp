(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun read_int()
    (parse-integer (read-line)) 
)

(defun operate(x op y)
    (cond
        ((string-equal op "+") (+ x y))
        ((string-equal op "-") (- x y))
        ((string-equal op "*") (* x y))
        ((string-equal op "/") (/ x y))
    )
)

(defun main()
    (write-line "X OPERADOR Y")
    (write "X:")
    (setq x (read_int))
    (write "Operador:")
    (setq operator (read))
    (write "Y:")
    (setq y (read_int))

    (write-line (write-to-string (operate x operator y)))
)

(main)