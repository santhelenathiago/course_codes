(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)
(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun media(a b c)
    (/ (+ (+ a b) c) 3.0)
)

(defun main()
    (write-line "Media")
    (write-line (cond 
        ((>= (media (read_int "nota1:") (read_int "nota2:") (read_int "nota3:")) 6) "Aprovado")
        (T "Reprovado")
    )) 
)

(main)