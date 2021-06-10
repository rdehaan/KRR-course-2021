%%% Encode input (example)

% Nodes and colored edges
node(1..14).
edge(1,3,blue).
edge(3,6,red).
edge(3,5,green).
edge(5,6,red).
edge(6,7,green).
edge(7,8,blue).
edge(2,4,red).
edge(4,7,blue).
edge(4,8,green).
edge(5,9,red).
edge(6,9,green).
edge(7,9,red).
edge(9,10,blue).
edge(9,11,blue).
edge(9,12,green).
edge(10,11,red).
edge(11,12,red).
edge(10,13,green).
edge(11,13,blue).
edge(12,13,red).
edge(13,14,green).

% Edges are also reversed
edge(X,Y,C) :- edge(Y,X,C).

% Tower
tower(9).

% Spawn points
spawn(1).
spawn(2).
spawn(14).

% Waves
% wave_on_day(W,D) indicates that wave W happens on day D
% wave(W,I,C) indicates that the I'th step in wave W has color C
wave_on_day(1,1).
wave(1,1,blue).
wave(1,2,red).
wave(1,3,green).
wave(1,4,red).
wave_on_day(2,1).
wave(2,1,red).
wave(2,2,green).
wave(2,3,blue).
wave(2,4,red).
wave_on_day(3,2).
wave(3,1,green).
wave(3,2,blue).
wave(3,3,red).
wave(3,4,blue).
wave_on_day(4,3).
wave(4,1,red).
wave(4,2,blue).
wave(4,3,red).
wave_on_day(5,3).
wave(5,1,blue).
wave(5,2,red).
wave(5,3,green).
% wave(W) :- wave_on_day(W,_).

% Guard types
guard_type(a;b;c).
guard_type_degree(a,2).
guard_type_degree(b,3).
guard_type_degree(c,4).
guard_type_cost(a,1).
guard_type_cost(b,2).
guard_type_cost(c,5).
guard_type_limit_per_day(a,1).
guard_type_limit_per_day(b,1).
guard_type_limit_per_day(c,2).

% Budget
budget(12).

%%% Encode candidate solutions

% Choose a sequence of days day(1), ..., day(j) to survive
max_day(D) :- D = #max { E : wave_on_day(_,E) }.
possible_day(D) :- max_day(D).
possible_day(D-1) :- possible_day(D), D > 1.
{ day(D) : possible_day(D) }.
:- day(D), possible_day(D-1), not day(D-1). % symmetry breaking

% Choose a strategy for placing guard on nodes on different days
% place(D,G,N) indicates that on day D, a guard of type G is placed on node N
{ place(D,G,N) : day(D), guard_type(G), node(N) }.

% Guards cannot be placed on spawn points or on the tower
:- place(D,G,N), spawn(N).
:- place(D,G,N), tower(N).

%%% Encode solution properties

% Ensure that total budget is respected
total_cost(T) :-
    T = #sum { C,G,D,N : day(D), place(D,G,N), guard_type_cost(G,C) }.
:- total_cost(T), budget(B), T > B.

% Compute the degree of nodes
degree(N,D) :- node(N), D = #count { M : edge(N,M,C) }.

% Ensure that guard types are only placed on nodes with the allowed degree
:- place(D,G,N), day(D), guard_type(G), guard_type_degree(G,E), not degree(N,E).

% Ensure that on each day, the limits on the different guard types are respected
guard_type_used_per_day(G,D,M) :- guard_type(G), day(D),
    M = #count { place(D,G,N) : place(D,G,N) }.
:- guard_type_used_per_day(G,D,M), guard_type(G), day(D),
    guard_type_limit_per_day(G,L), M > L.

% Derive what nodes the different waves can reach
% reachable(W,D,N,I) indicates that wave W (up to index I) can reach node N on day D
reachable(W,D,N,0) :- wave_on_day(W,D), spawn(N).
reachable(W,D,N,I) :- wave_on_day(W,D), I > 0,
    reachable(W,D,M,I-1), edge(M,N,C), wave(W,I,C),
    not place(D,G,N) : guard_type(G).

% Ensure that the tower is never reached (after any part of a wave)
:- day(D), tower(N), reachable(_,D,N,_).

%%% Optimization

% Maximize the number of days survived
#maximize { 1,day(D) : day(D) }.

% Show only the strategy and how which days survived
#show day/1.
#show place/3.
