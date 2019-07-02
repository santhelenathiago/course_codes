(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun my_gcd(x y)
    (cond 
        ((= y 0) x)
        (T (my_gcd y (mod x y)))
    )
)

(defun my_lcm(x y)
    (/ (* x y) (my_gcd x y))
)

(defun main()
    (write-line "Mínimo múltiplo comum:")
    (write-line (write-to-string (my_lcm (read_int "x:") (read_int "y"))))
)

(main)