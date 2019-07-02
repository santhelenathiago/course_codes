(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun fib(n)
    (cond
        ((or (= n 0) (= n 1)) 1)
        (T (+ (fib (- n 1)) (fib (- n 2))))
    )
)

(defun main()
    (write-line "Fibonacci")
    (write-line (write-to-string (fib (read_int "N:"))))
)

(main)