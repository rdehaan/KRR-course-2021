% Declare existential variables
evar(a).
% Declare universal variables
uvar(b).

% Declare terms
term(1,(a;b)).
term(2,(a;-b)).
term(C) :- term(C,_).

% Guess an assignment to the existential variables
select(V) :- evar(V), not select(-V).
select(-V) :- evar(V), not select(V).

% Generate the search space over the universal variables
select(V) ; select(-V) :- uvar(V).

% Mark incorrect and invalid solutions
invalid :- select(V), select(-V), uvar(V).
incorrect :- term(I), select(L) : term(I,L).

% Do saturation
saturate :- invalid.
saturate :- incorrect.
select(V) :- uvar(V), saturate.
select(-V) :- uvar(V), saturate.
invalid :- saturate.
incorrect :- saturate.
:- not saturate.

% Select what to show
qbf_true :- saturate.
#show.
#show qbf_true/0.
#show select(V) : select(V), evar(V).
#show select(-V) : select(-V), evar(V).
