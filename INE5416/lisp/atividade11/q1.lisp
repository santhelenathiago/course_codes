(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun main()
    (write-line "Calcular potência:")
    (write-line (write-to-string (expt (read_int "Base:") (read_int "Expoente"))))
)

(main)