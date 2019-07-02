(defun alunos()
    '((1 "Bob" (5.6 8 9.3))
      (2 "Ana" (8.2 9 7 6.5))
      (3 "Tom" (3.2 7 5.7 8.3))
      (4 "Bin" (7.5 5.3 8.5 6.2 3.1))
      (5 "Bia" (6.7 4.1 5.5)))
)

(defun getNome (aluno)
    (car (cdr aluno))
)

(defun getNotas (aluno)
    (car (last aluno))
)

(defun medias(alunos)
    (if (null alunos)
        ()
        (cons (list (getNome (car alunos)) (media (getNotas (car alunos)))) (medias (cdr alunos)))
    )
)

(defun soma(lista)
    (if (null lista)
        0
        (+ (car lista)  (soma (cdr lista)))
    )
)

(defun media(lista)
    (if (null lista)
        0
        (/ (soma lista) (comprimento lista))
    )
)

(defun mediaTurma(alunos)
    (media (getMedias alunos))
)

(defun getMedias(alunos)
    (setq lista (medias alunos))
    (setq output ())
    (loop for x in lista
        do (setq output (append output (list (car (last x)))))
    )
    output
)

(defun comprimento(lista)
    (if (null lista)
        0
        (1+ (comprimento (cdr lista)))
    )
)

(defun getNomes (lista)
    (if (null lista)
        ()
        (cons (getNome (car lista)) (getNomes (cdr lista)))
    )
)

(defun acimaMedia(alunos)
    (setq lista (medias alunos))
    (setq media (mediaTurma (alunos)))
    (setq output ())
    (loop for x in lista
        do (if (> (car (last x)) media)
            (setq output (cons x output))
            NIL
        )
    )
    output
)

(defun aprovados(alunos)
    (setq lista (medias alunos))
    (setq media (mediaTurma (alunos)))
    (setq output ())
    (loop for x in lista
        do (if (>= (car (last x)) 6)
            (setq output (cons x output))
            NIL
        )
    )
    output
)

(defun duplas(alunos)
    (setq output ())
    (setq curr (car alunos))
    (loop for x in (cdr alunos)
        do (setq output (cons (list (car (cdr curr)) (car (cdr x))) output))
    )
    (if (null alunos)
        output
        (append output (duplas (cdr alunos)))
    )
)


(defun ordenaAlunos(alunos)
    (setq lista (medias alunos))
    (sort lista #'> :key #'getNotas)
)

(defun main ()
    (write-line (write-to-string (getNomes (alunos))))
    (write-line (write-to-string (medias (alunos))))
    (write-line (write-to-string (mediaTurma (alunos))))
    (write-line (write-to-string (acimaMedia (alunos))))
    (write-line (write-to-string (aprovados (alunos))))
    (write-line (write-to-string (duplas (alunos))))
    (write-line (write-to-string (ordenaAlunos (alunos))))
)

(main)