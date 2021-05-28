% Take an input graph
node(a;b;c;d;e;f).
edge(a,b).
edge(b,c).
edge(a,c).
edge(d,a).
edge(e,b).
edge(f,c).

edge(U,V) :- edge(V,U).

% Define what are leaves
leaf(U) :- node(U), 1 { edge(U,V) : node(V) } 1.

% Select a 3-coloring for the leaves
color(red;green;blue).
1 { color(V,C) : color(C) } 1 :- leaf(V).

% Symmetry breaking: the first leaf should be colored red
first_leaf(U) :- U = #min { V : leaf(V) }.
:- first_leaf(U), not color(U,red).

% Generate search space: colorings of the non-leaves
non_leaf(N) :- node(N), not leaf(N).
color(N,red) ; color(N,green) ; color(N,blue) :- non_leaf(N).

% Mark invalid and incorrect solutions in the search space
invalid :- 2 { color(N,C) : color(C) }, non_leaf(N).
incorrect :- edge(U,V), color(U,C), color(V,C).

% Do saturation
saturate :- invalid.
saturate :- incorrect.
color(N,C) :- non_leaf(N), color(C), saturate.
invalid :- saturate.
incorrect :- saturate.
:- not saturate.

% Show only the coloring for the leaves
#show.
#show color(N,C) : color(N,C), leaf(N).
