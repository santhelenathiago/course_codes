(defun mediaDisciplina(p1 p2 p3 t1 t2 t3 ex)
    (setq p_sum (+ p1 p2 p3))
    (setq p_med (* 0.5 (/ p_sum 3)))
    (setq t_sum (+ t1 t2 t3))
    (setq t_med (* 0.4 (/ t_sum 3)))
    (setq ex_med (* 0.1 ex))

    (+ ex_med p_med t_med)
)

(defun main()

    (write-line (write-to-string (mediaDisciplina 10 9 8 10 10 10 7)))
)

(main)