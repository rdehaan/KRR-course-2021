node(1..7).
edge(1,2).
edge(2,3).
edge(3,4).
edge(1,4).
edge(2,5).
edge(3,6).
edge(5,6).
edge(5,7).
edge(6,7).

edge(U,V) :- edge(V,U).

% Select a subset of edges (and select their swapped versions too)
{ select(U,V) : edge(U,V) }.
:- select(U,V), not select(V,U).

% Make sure that every node has exactly two selected edges connected to it
2 { select(V,U) : node(U), edge(V,U) } 2 :- node(V).

% Make sure there is only a single cycle
reachable(1).
reachable(U) :- reachable(V), select(U,V).
:- node(V), not reachable(V).

#show select/2.
