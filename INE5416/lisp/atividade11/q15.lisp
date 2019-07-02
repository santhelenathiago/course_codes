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

(defun totiente(n)
    (totiente_aux n (- n 1))
)

(defun totiente_aux(n dec)
    (cond
        ((<= dec 0) 0)
        ((coprimes n dec) (1+ (totiente_aux n (1- dec))))
        (T (totiente_aux n (1- dec)))
    )
)

(defun main()
    (write-line "Função totiente")
    (write-line (write-to-string (totiente (read_int "N:"))))
)

(main)10