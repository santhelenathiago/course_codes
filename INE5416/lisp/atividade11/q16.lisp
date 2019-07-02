(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)


(defun divisivel(x y)
     (= (mod x y) 0)
)

(defun main()
    (write-line "x divisível por y")
    (write-line (write-to-string (divisivel (read_int "x:") (read_int "y"))))
)

(main)