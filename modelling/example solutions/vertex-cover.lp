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

% edge(U,V) :- edge(V,U).

% Select a subset of nodes
{ select(V) : node(V) }.

% Ensure that each edge has at least one selected node in it
:- edge(U,V), not select(U), not select(V).

% Select a minimum size subset
#minimize { 1,select(U) : select(U) }.

#show select/1.
