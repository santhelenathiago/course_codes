(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun area(base altura)
    (/ (* base altura) 2.0)
)

(defun main()
    (write-line "Calcular área do triângulo:")
    (write-line (write-to-string (area (read_int "Base:") (read_int "Altura"))))
)

(main)