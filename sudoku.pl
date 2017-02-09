%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Ash Khan                                                               %
% File Name: sudoku.pl                                                         %
% Assignment: Lab 2, Sudoku Puzzle                                             %
% Date: 02/08/2016                                                             %
% Description: Sudoku is a famous puzzle which has a board containing 9 by 9   %
% grid. A solution for sudoku puzzle has to have all different number (usually %
% 0-9) in each row, column and 2 by 2 box.                                     %
% This is a Prolog code to solve a 4 X 4 sudoku puzzle. User enters a sudoku   %
% puzzle and this code will find solutions to that puzzle(if there  exists one)%
% This code is very simple and concise. We wrote some helpful predicates for   %
% our main sudoku solution predicate including perm ( different permutations), %
% alldifferent (checks if all the elements in a list are distinct) and takeout(%
% which takes out a given number from a list).                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% consult('sudoku.pl').



% member() takes two clauses as arguments, a variable and a list; It 
% recursively goes through the list and checks if the variable is a member of 
% the given list. Our base case is when head of the list is same as the given
% variable (X), if not, this predicate will recursively traverse the list and 
% return true if X is found in the list.

 member(X, [X|T]).
 member(X, [H|T]) :- member(X, T).

% alldifferent() takes only one clause as its argument which is a list. Our base
% case is when the list is empty; it returns true when list is empty. It 
% recursively traverse the list and only return false if head of the list is a
% member of the tail of the list.

 alldifferent([]).
 alldifferent([H|T]):- \+member(H, T), alldifferent(T).

% perm() takes two clauses as its argument; a list and a variable. It
% recursively traverse the given list and return another list as a variable(Z)
% a possible permutation of the given list.

 perm([],[]).
 perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).   
 
% takeout() takes three parameter as its argument; two variables and a list. 
% This predicate takes in a variable as its first argument(X) and a list as 
% second and takes out that variable (X) and provide the new list (R) as the 
% third argument. e.g takeout(a, [b, c, e, r, a, t], R) returns R = [b, c, e, r
% t].

 takeout(X,[X|R],R).
 takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

% Main sudoku predicate which returns the solution of the given puzzle (Input)
% as a list (Solved).
    
% We first saved the board by make variables.
    sudoku(Input, Solved) :-  Solved = Input, Input = [C11, C12, C13, C14, 
						       C21, C22, C23, C24,
						       C31, C32, C33, C34, 
						       C41, C42, C43, C44],
% We can only have 1-4 numbers in the puzzle so we store those numbers in a list
    Numbers = [1, 2, 3, 4],
    
% Create different variables for rows, column and 2 by 2 boxes.
    Row1 = [C11, C12, C13, C14],
    Row2 = [C21, C22, C23, C24],
    Row3 = [C31, C32, C33, C34],
    Row4 = [C41, C42, C43, C44],
    
    Col1 = [C11, C21, C31, C41],
    Col2 = [C12, C22, C32, C42],
    Col3 = [C13, C23, C33, C43],
    Col4 = [C14, C24, C34, C44],
    
    Box1 = [C11, C12, C21, C22],
    Box2 = [C31, C32, C41, C42],
    Box3 = [C13, C14, C23, C24],
    Box4 = [C33, C34, C43, C44],

% Make rules about what are the possible permutations of numbers 1-4 for the
% solution for each row, column and 2 by 2 box.

    perm(Numbers, Row1), perm(Numbers, Row2), perm(Numbers, Row3),
    perm(Numbers, Row4), perm(Numbers, Col1), perm(Numbers, Col2),
    perm(Numbers, Col3), perm(Numbers, Col4), perm(Numbers, Box1),
    perm(Numbers, Box2), perm(Numbers, Box3), perm(Numbers, Box4),

% Finally make rules. i.e all the numbers in ever row, column and 2 by 2 box
% have to be different.
    
    alldifferent(Row1), alldifferent(Row2), alldifferent(Row3),
    alldifferent(Row4), alldifferent(Col1), alldifferent(Col2),
    alldifferent(Col3), alldifferent(Col4), alldifferent(Box1),
    alldifferent(Box2), alldifferent(Box3), alldifferent(Box4).

% set_prolog_flag(toplevel_print_options, [quoted(true), portray(true),
%    					   max_depth(100), priority(699)]).

  
