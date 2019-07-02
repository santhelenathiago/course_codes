(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun prime(x)
    (prime_aux x 2)
)

(defun prime_aux(x cont)
    (cond
        ((>= cont (sqrt x)) T)
        ((= (mod x cont) 0) NIL)
        (T (prime_aux x (1+ cont)))
    )
)

(defun main()
    (write-line "É primo?")
    (write-line (write-to-string (prime (read_int "N:"))))
)

(main)