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

% Select a 3-coloring
color(red;green;blue).
1 { color(V,C) : color(C) } 1 :- node(V).

% Ensure that each edge has different colors
:- edge(U,V), color(U,C), color(V,C).

#show color/2.
