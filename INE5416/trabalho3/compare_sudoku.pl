


tabuleiro_4x4(Tab) :- Tab = [
    [[0, 2, 2, 0], [0, 0, 1, 1], [0, 1, 1, 0], [0, 0, 2, 2]],
    [[1, 1, 0, 0], [2, 0, 0, 2], [2, 2, 0, 0], [1, 0, 0, 1]],
    [[0, 1, 1, 0], [0, 0, 1, 2], [0, 1, 2, 0], [0, 0, 2, 2]],
    [[2, 1, 0, 0], [2, 0, 0, 2], [1, 1, 0, 0], [1, 0, 0, 2]]].

tabuleiro_6x6(Tab) :- Tab = [
    [[], [], [], [], [], []],
    [[], [], [], [], [], []],
    [[], [], [], [], [], []],
    [[], [], [], [], [], []],
    [[], [], [], [], [], []],
    [[], [], [], [], [], []]].

% Define números possíveis para cada tamamanho
n4(1).
n4(2).
n4(3).
n4(4).

n6(1).
n6(2).
n6(3).
n6(4).
n6(5).
n6(6).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).


% Para 4x4
completa([X1, X2, X3, X4]) :-
    n4(X1), n4(X2), n4(X3), n4(X4),
    todosDiferentes([X1, X2, X3, X4]).

% Para 6x6
completa([X1, X2, X3, X4, X5, X6]) :-
    n6(X1), n6(X2), n6(X3), n6(X4), n6(X5), n6(X6),
    todosDiferentes([X1, X2, X3, X4, X5, X6]).

% Valida uma célula, comparando a célula com cara adjacente com o respectivo simbolo
validCell([TopSymbol, RightSymbol, BottomSymbol, LeftSymbol], [Vt, Vr, Vb, Vl], CellValue) :-
    validSymbol(TopSymbol, Vt, CellValue),
    validSymbol(RightSymbol, Vr, CellValue),
    validSymbol(BottomSymbol, Vb, CellValue),
    validSymbol(LeftSymbol, Vl, CellValue).

% Valida um símbolo, comparando o valor da célula com o valor da adjacente correspondente ao simbolo
validSymbol(Symbol, Value, CellValue) :-
    n4(Value), n4(CellValue),
    (Symbol =:= 0);                     % Sem valor
    (Symbol =:= 1, Value > CellValue) ; % Simbolo de menor que 
    (Symbol =:= 2, Value < CellValue).  % Simbolo de maior que

validSymbolsOfTable(Symbols, Tab) :-
    length(Tab, L), 
    validSymbolsOfTableAtIndexes(Symbols, Tab, 0, 0, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 0, 1, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 0, 2, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 0, 3, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 1, 0, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 1, 1, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 1, 2, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 1, 3, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 2, 0, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 2, 1, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 2, 2, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 2, 3, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 3, 0, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 3, 1, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 3, 2, L),
    validSymbolsOfTableAtIndexes(Symbols, Tab, 3, 3, L).

% Repete o mesmo elemento N vezes
repeats(_, 0, []).
repeats(Elem, N, Output) :-
    Nm1 is N-1,
    repeats(Elem, Nm1, Output1),
    Output = [Elem|Output1].


getRow(List, Index, Len, Row) :- (
    (Index >= 0, Index < Len) ->
    % then
        nth0(Index, List, Row)
    % else
    ;   repeats(0, Len, Row)
    ).

validSymbolsOfTableAtIndexes(Symbols, Tab, X, Y, Len) :-
    % Utilitaries
    XM1 is X+1,
    YM1 is Y+1,
    Xm1 is X-1,
    Ym1 is Y-1,

    % Get rows from the table to get adjacent values
    getRow(Tab, Ym1, Len, RowUp),
    getRow(Tab, YM1, Len, RowDown),
    nth0(Y, Tab, Row),

    % Get adjacents for the cell
    nth0(X, RowUp, Vt),
    nth0(X, RowDown, Vb),
    ( XM1 < Len ->
        nth0(XM1, Row, Vr)
        ; true
    ),
    (Xm1 > 0 ->
        nth0(Xm1, Row, Vl)
        ; true
    ),
    % Get symbols for the cell
    nth0(Y, Symbols, SymbolsRow),
    nth0(X, SymbolsRow, CellSymbols),
    nth0(X, Row, CellValue),
    validCell(CellSymbols, [Vt, Vr, Vb, Vl], CellValue).


solve_4x4(Solucao) :-
    Solucao = [
        [X11, X12, X13, X14],
        [X21, X22, X23, X24],
        [X31, X32, X33, X34],
        [X41, X42, X43, X44]
    ],

    % Simbolos
    tabuleiro_4x4(Symbols),
    validSymbolsOfTable(Symbols, Solucao),
    
    % Linhas
    completa([X11, X12, X13, X14]),
    completa([X21, X22, X23, X24]),
    completa([X31, X32, X33, X34]),
    completa([X41, X42, X43, X44]),
    
    % Colunas
    completa([X11, X21, X31, X41]),
    completa([X12, X22, X32, X42]),
    completa([X13, X23, X33, X43]),
    completa([X14, X24, X34, X44]),
    
    % Quadrados menores
    completa([X11, X12, X21, X22]),
    completa([X13, X14, X23, X24]),
    completa([X31, X32, X41, X42]),
    completa([X33, X34, X43, X44]). 

