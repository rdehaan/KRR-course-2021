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

% Select a subset of edges
{ choose(U,V) : edge(U,V) }.

% Make sure that every node has exactly one ingoing edge and one outgoing edge
1 { choose(N,M) : node(M), edge(N,M) } 1 :- node(N).
1 { choose(M,N) : node(M), edge(M,N) } 1 :- node(N).

% Make sure there is only a single cycle
reachable(1).
reachable(U) :- reachable(V), choose(U,V).
:- node(V), not reachable(V).

#show choose/2.
