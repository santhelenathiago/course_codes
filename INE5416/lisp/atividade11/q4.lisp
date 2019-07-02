(defun read_bool(str)
    (write str)
    (> (parse-integer (read-line)) 0)
)

(defun ex_or(x y)
    (not (or (and x y) (and (not x) (not y))))
)

(defun main()
    (write-line "Exclusive or")
    (write-line (write-to-string (ex_or (read_bool "x:") (read_bool "y:"))))
)

(main)