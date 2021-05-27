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

% Select an ordering over the vertices
#const k=7.
number(1..k).
1 { assign(U,N) : node(U) } 1 :- number(N).
1 { assign(U,N) : number(N) } 1 :- node(U).

% Start at the first vertex
:- not assign(1,1).

% Ensure that subsequently numbered vertices have an edge
:- number(N), N < k, assign(U,N), assign(V,N+1), not edge(U,V).

% Ensure that there is an edge from the last vertex to the first
:- assign(U,k), assign(V,1), not edge(U,V).

#show assign/2.
