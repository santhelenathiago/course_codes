(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun greater(x y z)
    (if (> x y)
        ; THEN
        (if (> x z)
            ; THEN
            x
            ; ELSE
            z)
        ; ELSE
        (if (> y z)
            y
            ;ELSE
            z)

    )
)

(defun main()
    (write-line "maior número")
    (setq x (read_int "x:"))
    (setq y (read_int "y:"))
    (setq z (read_int "z:"))
    (write-line (write-to-string (greater x y z))) 
)

(main)