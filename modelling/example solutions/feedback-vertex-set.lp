node(1..8).
edge(1,2).
edge(1,3).
edge(2,3).
edge(3,4).
edge(4,5).
edge(5,3).
edge(6,7).
edge(7,8).
edge(6,8).

edge(U,V) :- edge(V,U).

% Select a subset of nodes
{ select(V) : node(V) }.

% Define some auxiliary predicates
different_edge(U,V,S,T) :-
    edge(U,V), edge(S,T), not same_edge(U,V,S,T).
same_edge(U,V,U,V) :- edge(U,V).
same_edge(U,V,V,U) :- edge(U,V).

% Define a predicate, that for each edge (U,V), keeps track of whether there
% is a path from S to T that is unbroken (by the selected nodes)
% and that doesn't use the edge (U,V).
reachable_without_edge(U,V,S,S) :-
    edge(U,V), node(S), not select(S).
reachable_without_edge(U,V,S,T2) :-
    edge(U,V), node(S), node(T1), node(T2), edge(T1,T2),
    different_edge(U,V,T1,T2),
    reachable_without_edge(U,V,S,T1),
    not select(S), not select(T1), not select(T2).

% Require that there may not be an unbroken path from U to V that does not use
% the edge (U,V) and also the edge (U,V) in the graph
% (If this were the case, there would be an unbroken cycle)
:- edge(U,V), reachable_without_edge(U,V,U,V), not select(U), not select(V).

% Select a minimum size subset
#minimize { 1,select(U) : select(U) }.

#show select/1.
