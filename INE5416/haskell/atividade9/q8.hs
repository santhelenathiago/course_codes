import Data.List hiding (find)

max_value :: Int
max_value = 100

minha_matriz :: [[Int]]
minha_matriz = [[2, 7, 6], [9, 5, 1], [4, 3, 8]]

minha_matriz_permutacao :: [[Int]]
minha_matriz_permutacao = [[0, 0, 0, 1],[0, 1, 0, 0],[1, 0, 0, 0],[0, 0, 1, 0]]

minha_matriz_permutacao_ou_quase :: [[Int]]
minha_matriz_permutacao_ou_quase = [[0, 0, 0, 1],[0, 1, 0, 0],[1, 0, 0, 0],[0, 0, 0, 1]]

entrada_1 :: [[Int]]
entrada_1 = [
    [0, 12, 12],
    [16, 10, 0],
    [8, 0, 0]]

valid_sudoku_table :: [[Int]]
valid_sudoku_table = [
    [1, 3, 2, 5, 7, 9, 4, 6, 8],
    [4, 9, 8, 2, 6, 1, 3, 7, 5],
    [7, 5, 6, 3, 8, 4, 2, 1, 9],
    [6, 4, 3, 1, 5, 8, 7, 9, 2],
    [5, 2, 1, 7, 9, 3, 8, 4, 6],
    [9, 8, 7, 4, 2, 6, 5, 3, 1],
    [2, 1, 4, 9, 3, 5, 6, 8, 7],
    [3, 6, 5, 8, 1, 7, 9, 2, 4],
    [8, 7, 9, 6, 4, 2, 1, 5, 3]
    ]

invalid_sudoku_table :: [[Int]]
invalid_sudoku_table = [
    [1, 3, 2, 5, 7, 9, 4, 6, 8],
    [4, 9, 8, 2, 6, 1, 3, 7, 5],
    [7, 5, 6, 3, 8, 4, 2, 1, 9],
    [6, 4, 3, 1, 5, 8, 7, 9, 2],
    [5, 2, 1, 7, 9, 3, 8, 4, 6],
    [9, 8, 7, 4, 2, 6, 5, 3, 1],
    [2, 1, 4, 9, 3, 5, 6, 8, 7],
    [3, 6, 5, 8, 1, 7, 9, 2, 4],
    [3, 7, 9, 6, 4, 2, 1, 5, 8]]

soma_matriz_elem :: [[Int]] -> Int
soma_matriz_elem [] = 0
soma_matriz_elem (a:b) = (soma_matriz_elem_aux a) + (soma_matriz_elem b)

soma_matriz_elem_aux :: [Int] -> Int
soma_matriz_elem_aux [] = 0
soma_matriz_elem_aux (a:b) = a + (soma_matriz_elem_aux b)

soma_matrizes :: [[Int]] -> [[Int]] -> [[Int]]
soma_matrizes [] [] = []
soma_matrizes (a1:b1) (a2:b2) = [(soma_matrizes_aux a1 a2)] ++ (soma_matrizes b1 b2)

soma_matrizes_aux :: [Int] -> [Int] -> [Int]
soma_matrizes_aux [] [] = []
soma_matrizes_aux (a1:b1) (a2:b2) = [a1 + a2] ++ (soma_matrizes_aux b1 b2)

find :: [Int] -> Int -> Bool
find [] _ = False
find (a:b) n = if (a == n) then True else (find b n)

find_all :: [Int] -> [Int] -> Bool
find_all [] _ = True
find_all (a:b) v = if (find v a) then find_all b v else False

get_row :: [[a]] -> Int -> [a]
get_row mat row = mat!!row

get_col :: [[a]] -> Int -> [a]
get_col [] _ = []
get_col (a:b) col = a!!col:(get_col b col)

mat_to_vec :: [[Int]] -> [Int]
mat_to_vec [] = []
mat_to_vec (a:b) = a ++ (mat_to_vec b)

all_elements_1_n2 :: [[Int]] -> Bool
all_elements_1_n2 m = (find_all ([1..(length (mat_to_vec m))]) (mat_to_vec m)) && (find_all (mat_to_vec m) ([1..(length (mat_to_vec m))])) 

sum_row :: [Int] -> Int
sum_row [] = 0
sum_row (a:b) = a + sum_row b

same_rows_sum :: [[Int]] -> Bool
same_rows_sum [a, b] = (sum_row a) == (sum_row b)
same_rows_sum [a, b, c] = (sum_row a) == (sum_row b) &&  (sum_row a) == (sum_row c)
same_rows_sum (a:b:c) = (sum_row a) == (sum_row b) && (same_rows_sum ([b] ++ c))

same_cols_sum :: [[Int]] -> Bool
same_cols_sum mat = same_rows_sum (transpose mat)


take_element :: [Int] -> Int -> Int
take_element row index = row!!index

diagonal_sum_aux :: [[Int]] -> Int -> Int
diagonal_sum_aux [] _ = 0
diagonal_sum_aux (a:b) index = (take_element a index) + (diagonal_sum_aux b (index+1))

diagonal_sum :: [[Int]] -> Int
diagonal_sum mat = diagonal_sum_aux mat 0

same_diagonal_sum :: [[Int]] -> Bool
same_diagonal_sum mat = (diagonal_sum mat) == (diagonal_sum (reverse (transpose mat)))

magic_square :: [[Int]] -> Bool
magic_square mat = (same_diagonal_sum mat) &&
                   (same_rows_sum mat) &&
                   (same_cols_sum mat) &&
                   ((diagonal_sum mat) == (sum_row (mat!!0))) &&
                   ((diagonal_sum mat) == (sum_row ((reverse (transpose mat))!!0))) 
                   
single_one_per_row :: [[Int]] -> Bool
single_one_per_row [] = True
single_one_per_row (a:b) = search_one a && single_one_per_row b

search_one :: [Int] -> Bool
search_one [] = False
search_one (a:b) =  if (a == 1) then 
                        no_more_ones b 
                    else if (a == 0) then 
                        search_one b
                    else 
                        False


no_more_ones :: [Int] -> Bool
no_more_ones [] = True
no_more_ones (a:b) = if (a == 1 || a /= 0) then 
                        False 
                     else 
                        no_more_ones b
 
matriz_permutacao :: [[Int]] -> Bool
matriz_permutacao mat = (single_one_per_row mat) && (single_one_per_row (transpose mat))

get_sub_3x3 :: [[a]] -> Int -> Int -> [[a]]
get_sub_3x3 mat x y | (x == 0 && y == 0) = (get_sub_row (mat!!0) 0 0):(get_sub_row (mat!!1) 0 0):(get_sub_row (mat!!2) 0 0):[]
                    | (x == 0 && y == 1) = (get_sub_row (mat!!3) 0 0):(get_sub_row (mat!!4) 0 0):(get_sub_row (mat!!5) 0 0):[]
                    | (x == 0 && y == 2) = (get_sub_row (mat!!6) 0 0):(get_sub_row (mat!!7) 0 0):(get_sub_row (mat!!8) 0 0):[]
                    | (x == 1 && y == 0) = (get_sub_row (mat!!0) 0 3):(get_sub_row (mat!!1) 0 3):(get_sub_row (mat!!2) 0 3):[]
                    | (x == 1 && y == 1) = (get_sub_row (mat!!3) 0 3):(get_sub_row (mat!!4) 0 3):(get_sub_row (mat!!5) 0 3):[]
                    | (x == 1 && y == 2) = (get_sub_row (mat!!6) 0 3):(get_sub_row (mat!!7) 0 3):(get_sub_row (mat!!8) 0 3):[]
                    | (x == 2 && y == 0) = (get_sub_row (mat!!0) 0 6):(get_sub_row (mat!!1) 0 6):(get_sub_row (mat!!2) 0 6):[]
                    | (x == 2 && y == 1) = (get_sub_row (mat!!3) 0 6):(get_sub_row (mat!!4) 0 6):(get_sub_row (mat!!5) 0 6):[]
                    | (x == 2 && y == 2) = (get_sub_row (mat!!6) 0 6):(get_sub_row (mat!!7) 0 6):(get_sub_row (mat!!8) 0 6):[]
 
get_sub_row :: [a] -> Int -> Int -> [a]
get_sub_row _ 3 _ = []
get_sub_row row len init_pos = row!!(init_pos+len):(get_sub_row row (len+1) init_pos)

validate_sub_tables :: [[Int]] -> Int -> Int -> Bool
validate_sub_tables table 3 0 = True
validate_sub_tables table x 3 = (validate_sub_tables table (x+1) 0)
validate_sub_tables table x y = (all_elements_1_n2 (get_sub_3x3 table x y)) && (validate_sub_tables table x (y+1))

validate_rows :: [[Int]] -> Bool
validate_rows [] = True
validate_rows (a:b) = (all_elements_1_n2 [a]) && (validate_rows b)

validate_sudoku_table :: [[Int]] -> Bool
validate_sudoku_table table = (validate_sub_tables table 0 0) && (validate_rows table) && (validate_rows (transpose table))

get_0_positions :: [[Int]] -> [[Int]]
get_0_positions mat = get_0_positions_aux mat ((length mat) - 1) ((length mat) - 1)

get_0_positions_aux :: [[Int]] -> Int -> Int -> [[Int]]
get_0_positions_aux mat x y | (x == -1) = []
                            | (y == -1) = (get_0_positions_aux mat (x-1) ((length mat) - 1))
                            | ((mat!!x)!!y == 0) = [x, y]:(get_0_positions_aux mat x (y-1))
                            | ((mat!!x)!!y /= 0) = (get_0_positions_aux mat x (y-1))

incrementa_vetor :: [Int] -> [Int]
incrementa_vetor [] = []
incrementa_vetor (a:b) | (a < max_value) = ((a+1):b)
                       | otherwise = 1:(incrementa_vetor b)

backtrack_magic_square :: [[Int]] -> [[Int]]
backtrack_magic_square mat = do
    let positions = (get_0_positions mat)
    let values = replicate (length positions) 1
    if (magic_square (replace_positions mat values positions)) then
        (replace_positions mat values positions)
    else
        backtrack_magic_square_aux mat values positions

backtrack_magic_square_aux :: [[Int]] -> [Int] -> [[Int]] -> [[Int]] 
backtrack_magic_square_aux mat values positions | (magic_square (replace_positions mat values positions)) = (replace_positions mat values positions)
                                                | otherwise = backtrack_magic_square_aux mat (incrementa_vetor values) positions

replace_positions :: [[Int]] -> [Int] -> [[Int]] -> [[Int]]
replace_positions input [] [] = input
replace_positions input (value:rest_values) (position:rest_positions) =   replace_positions (update_matrix input value position) rest_values rest_positions


update_matrix :: [[a]] -> a -> [Int] -> [[a]]
update_matrix m x [r,c] =
    take r m ++
    [take c (m !! r) ++ [x] ++ drop (c + 1) (m !! r)] ++
    drop (r + 1) m

main = do
    let m = [[1, 2, 1], [3, 0, 3], [2, 1, 2]]
    let n = [[1, 2, 1], [3, 0, 3], [2, 1, 2]]

    print "a"
    print (soma_matriz_elem m)

    print "b"
    print (soma_matrizes m n)

    print "c"
    print minha_matriz
    print ((magic_square minha_matriz) && (all_elements_1_n2 minha_matriz))
    print m
    print ((magic_square m) && (all_elements_1_n2 m))
    print n
    print ((magic_square n) && (all_elements_1_n2 n))

    print "d"
    print minha_matriz_permutacao
    print (matriz_permutacao minha_matriz_permutacao)
    print minha_matriz_permutacao_ou_quase
    print (matriz_permutacao minha_matriz_permutacao_ou_quase)

    print "e"
    print entrada_1
    print (backtrack_magic_square entrada_1)


    print "f"
    print (valid_sudoku_table)
    print (validate_sudoku_table valid_sudoku_table)
    print (invalid_sudoku_table)
    print (validate_sudoku_table invalid_sudoku_table)
    

