(defstruct ponto2D
    x
    y
)

(defun distancia(a b)
    (sqrt (+ (expt (- (ponto2D-x a) (ponto2D-x b)) 2) (expt (- (ponto2D-y a) (ponto2D-y b)) 2)))
)

(defun colineares(a b c)
    (setq det (det3x3 (ponto2D-x a) (ponto2D-y a) 1 (ponto2D-x b) (ponto2D-y b) 1 (ponto2D-x c) (ponto2D-y c) 1))
    (= det 0)
)

(defun det3x3 (a b c
               d e f
               g h i)
  (+ (- (* a (- (* e i) (* f h)))
        (* b (- (* d i) (* f g))))
        (* c (- (* d h) (* e g))))
)

(defun checarTriangulo(a b c)
    (and
        (and 
            (and 
                (> a (abs (- b c)))
                (< a (+ b c))
            )
            (and 
                (> b (abs (- a c)))
                (< b (+ a c))
            )
        )
        (and 
            (> c (abs (- b a)))
            (< c (+ b a))
        )
    )
)

(defun formaTriangulo(a b c)
    (setq l1 (distancia a b))
    (setq l2 (distancia a c))
    (setq l3 (distancia b c))
    (checarTriangulo l1 l2 l3)
)

(defun main()
    (setq a (make-ponto2D :x 0 :y 0))
    (setq b (make-ponto2D :x 1 :y 1))
    (setq c (make-ponto2D :x 2 :y 2))
    (setq d (make-ponto2D :x -1 :y 0))
    (write-line (write-to-string (distancia a b)))
    (write-line (write-to-string (colineares a b c)))
    (write-line (write-to-string (colineares a b d)))
    (write-line (write-to-string (formaTriangulo a b c)))
    (write-line (write-to-string (formaTriangulo a b d)))
)

(main)