%% Graph GP(12,4), from https://en.wikipedia.org/wiki/Independent_set_%28graph_theory%29
node(1..24).

edge(1,2).
edge(2,3).
edge(3,4).
edge(4,5).
edge(5,6).
edge(6,7).
edge(7,8).
edge(8,9).
edge(9,10).
edge(10,11).
edge(11,12).
edge(12,1).

edge(1,13).
edge(2,14).
edge(3,15).
edge(4,16).
edge(5,17).
edge(6,18).
edge(7,19).
edge(8,20).
edge(9,21).
edge(10,22).
edge(11,23).
edge(12,24).

edge(13,17).
edge(13,21).
edge(17,21).
edge(14,18).
edge(14,22).
edge(18,22).
edge(15,19).
edge(15,23).
edge(19,23).
edge(16,20).
edge(16,24).
edge(20,24).

edge(U,V) :- edge(V,U).

% Select a subset of nodes
{ select(V) : node(V) }.

% Define what 'dominated' means
dominated(V) :- select(V).
dominated(V) :- select(U), edge(U,V).

% Ensure that all nodes are dominated by the selected set
:- node(V), not dominated(V).

% Select a minimum size subset
#minimize { 1,select(U) : select(U) }.

#show select/1.
