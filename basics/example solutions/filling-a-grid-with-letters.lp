%% FILLING A GRID WITH LETTERS

num(1..5).
cell(I,J) :- num(I), num(J).
letter(a;b;c;d;e).

% One letter per cell
1 { fill(I,J,L) : letter(L) } 1 :- num(I), num(J).

% Row and column constraints
1 { fill(I,J,L) : num(J) } 1 :- letter(L), num(I).
1 { fill(I,J,L) : num(I) } 1 :- letter(L), num(J).

% Diagonal constraints
1 { fill(I,I,L) : num(I) } 1 :- letter(L).
1 { fill(I,6-I,L) : num(I) } 1 :- letter(L).

% Given filled in cells
fill(2,5,a).
fill(3,3,b).
fill(4,1,d).
fill(4,3,c).
fill(5,4,e).

% Extract the question mark
question(L) :- fill(1,2,L).
#show question/1.
