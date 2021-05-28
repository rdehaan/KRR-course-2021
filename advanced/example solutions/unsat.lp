% Declare variables
var(a;b).

% Declare terms
clause(1,(a;b)).
clause(2,(-a;b)).
clause(3,(a;-b)).
clause(4,(-a;-b)).
clause(C) :- clause(C,_).

% Generate the search space over the universal variables
select(V) ; select(-V) :- var(V).

% Mark incorrect and invalid solutions
invalid :- select(V), select(-V), var(V).
incorrect :- clause(I), select(-L) : clause(I,L).

% Do saturation
saturate :- invalid.
saturate :- incorrect.
select(V) :- var(V), saturate.
select(-V) :- var(V), saturate.
invalid :- saturate.
incorrect :- saturate.
:- not saturate.

% Select what to show
formula_unsatisfiable :- saturate.
#show formula_unsatisfiable/0.
