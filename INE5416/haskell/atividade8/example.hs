module Examples(Test (Test), (<:), (>:), (?:)) where
    data Test = Test String deriving (Eq, Show)

    (>:) :: Test -> Test -> Test
    (Test a) >: (Test b) = Test $ "(" ++ a ++ " >: " ++ b ++ ")"

    (<:) :: Test -> Test -> Test
    (Test a) <: (Test b) = Test $ "(" ++ a ++ " <: " ++ b ++ ")"

    (?:) :: Test -> Test -> Test
    (Test a) ?: (Test b) = Test $ "(" ++ a ++ " ?: " ++ b ++ ")"

    infix 6 ?:
    infixr 6 >:
    infixl 6 <: