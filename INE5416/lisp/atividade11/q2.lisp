(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun absolute(val)
    (cond
        ((< val 0) (* -1 val))
        (T val)
    ) 
)

(defun main()
    (write-line "Achar módulo:")
    (write-line (write-to-string (absolute (read_int "Valor:"))))
)

(main)