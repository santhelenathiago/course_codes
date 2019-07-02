(defun read_int(str)
    (write str)
    (parse-integer (read-line)) 
)

(defun tem_triangulo(a b c)
    (cond 
        ((and (> a (abs (- b c))) (< a (+ b c))) T)
        ((and (> b (abs (- a c))) (< b (+ a c))) T)
        ((and (> c (abs (- a b))) (< c (+ b a))) T)
        (T NIL)
    )
)

(defun main()
    (write-line "Construir triangulo com varetas")
    (write-line (cond 
        ((tem_triangulo (read_int "vareta1:") (read_int "vareta2:") (read_int "vareta3:")) "Tem triângulo")
        (T "Não tem")
    )) 
)

(main)