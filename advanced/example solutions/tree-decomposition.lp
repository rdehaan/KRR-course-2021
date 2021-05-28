% Take an input graph -- in this case, the graph from https://en.wikipedia.org/wiki/Tree_decomposition
node(a;b;c;d;e;f;g;h).
edge(a,b).
edge(b,c).
edge(a,c).
edge(b,f).
edge(f,g).
edge(b,g).
edge(c,d).
edge(d,e).
edge(c,e).
edge(e,g).
edge(g,h).
edge(e,h).
edge(b,e).

% Define some upper bound on the size of the decomposition (tree)
#const k=6.

% Select up to k nodes to use in the tree (with some symmetry breaking)
pos_node(1..k).
{ tree_node(N) : pos_node(N) }.
:- tree_node(N), pos_node(N-1), not tree_node(N-1).
tree_root(1).
tree_node(1).

% Guess edges in the tree
{ tree_edge(N,M) : tree_node(N), tree_node(M), N < M }.
% Every node in the tree has ingoing degree one (except for the root)
:- tree_node(N), not tree_root(N), not 1 { tree_edge(M,N) : tree_node(M) } 1.

% Define 'betweenness' relation in the tree
tree_edge_sym(N,M) :- tree_edge(N,M).
tree_edge_sym(N,M) :- tree_edge(M,N).
between(N,B,M) :-
    tree_edge_sym(N,B), tree_edge_sym(B,M),
    N != B, B != M, N != M.
between(N,B,M2) :-
    between(N,B,M1), tree_edge_sym(M1,M2),
    N != B, B != M2, N != M2.
between(N1,B,M) :-
    between(N2,B,M), tree_edge_sym(N1,N2),
    N1 != B, B != M, N1 != M.

% Guess the bags for the nodes in the tree
{ in_bag(N,V) : node(V) } :- tree_node(N).

% Ensure that for each graph node, the bags containing it are connected
:- in_bag(N,V), in_bag(M,V), tree_node(N), tree_node(M), tree_node(B),
    between(N,B,M), not in_bag(B,V).

% Ensure that for each edge in the graph, both endpoints are in some single bag
edge_in_some_bag(U,V) :- tree_node(N), edge(U,V), in_bag(N,U), in_bag(N,V).
:- edge(U,V), not edge_in_some_bag(U,V).

% Minimize the size of the largest bag
size_bag(N,S) :- tree_node(N), S = #count { in_bag(N,V) : in_bag(N,V) }.
max_size_bag(S) :- S = #max { T : size_bag(N,T), tree_node(N) }.
#minimize { S : max_size_bag(S) }.

% Output the decomposition and the treewidth
treewidth(T) :- max_size_bag(T+1).
#show tree_edge/2.
#show in_bag/2.
#show treewidth/1.
