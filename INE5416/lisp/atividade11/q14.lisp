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

(defun coprimes(x y)
     (= (my_gcd x y) 1)
)

(defun main()
    (write-line "coprimos:")
    (write-line (write-to-string (coprimes (read_int "x:") (read_int "y"))))
)

(main)