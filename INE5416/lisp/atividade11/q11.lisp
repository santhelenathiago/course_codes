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

(defun main()
    (write-line "Greater common divider:")
    (write-line (write-to-string (my_gcd (read_int "x:") (read_int "y"))))
)

(main)