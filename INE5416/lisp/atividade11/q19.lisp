(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun prime (n &optional (d (- n 1))) 
  (if (/= n 1) (or (= d 1)
      (and (/= (rem n d) 0)
           (prime  n (- d 1)))) ()))

(defun next_prime(x)
    (if (prime x)
        ; then
        x
        ; else
        (next_prime (1+ x))
    )
)

(defun goldbach(n)
    (cond
        ((= (mod n 2 ) 1) -1)
        (T (next_prime (floor (/ n 2))))
    )
)

(defun main()
    (write-line "Um número de Goldbach")
    (write-line (write-to-string (goldbach (read_int "N:"))))
)

(main)