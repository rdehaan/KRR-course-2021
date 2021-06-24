## Practice exam

This is a practice exam that you can use to prepare for the actual exam.
The actual exam will be online and open book, meaning that you may use the literature, your notes, and you may use clingo to help you answer questions.
(What is not allowed is communicating with each other during the exam. You should do it on your own.)
Use of clingo is not required during the exam, but it will likely be useful to double check your answers.

The exam will contain roughly five questions, of roughly the same flavor/style as the questions in this practice exam, and the questions on the exam will touch on similar topics as the ones on this practice exam. Also, the number of points for the different questions/topics on this practice exam will be roughly similar to the real exam. In other words, this practice exam will tell you what type of questions to expect and how much they count towards your grade.

There are 9 points to be earned on the exam. You get 1 point for free. Your grade will be the total number of points you get&mdash;so your exam grade will be at least 1 and at most 10.

## Question 1 (1pt)

### (a), 0.5pt
Consider the following answer set program *P<sub>1</sub>*.
```
a.
b :- not c.
c :- not d.
b :- a.
d :- not b.
```
The only answer set of *P<sub>1</sub>* is `{a,b,c}`.

Explain why `{a,b,c}` is an answer set of *P<sub>1</sub>*
and why `{a,b,d}` is not an answer set of *P<sub>1</sub>*.
In your answer, use the notions of 'reduct' and 'minimal model'.

### (b), 0.5pt
Consider the following answer set program *P<sub>2</sub>*.
```
a.
b :- not c.
c :- not d.
d :- not b.
```
The program *P<sub>2</sub>* has no answer sets.
Explain why this is the case.
Again, in your answer, use the notions of 'reduct' and 'minimal model'.

## Question 2 (2pt)
Consider the following answer set program (without comments or documentation):
```
#const k=10.
possible_node(1..k).
{ node(N) : possible_node(N) }.
:- node(N), possible_node(N-1), not node(N-1).

edge(X,Y) :- node(X), node(Y), X != Y.

1 { color(X,Y,red); color(X,Y,blue) } 1 :- edge(X,Y).
color(X,Y,C) :- color(Y,X,C).

:- edge(X,Y), edge(Y,Z), edge(X,Z), color(X,Y,C), color(Y,Z,C), color(X,Z,C).

#show node/1.
#maximize { 1,node(N) : node(N) }.
```

There is one optimal answer set for this answer set program (at least, when projected to `node/1`) and it is `{node(1), node(2), node(3), node(4), node(5)}`. The claim is that this provides an answer to the following question:
- Suppose you have an undirected graph *G* with `n` nodes where each pair of nodes is connected by an edge (this is called a *complete graph*). We are assigning to each edge one of two colors (say, red or blue). What is the largest `n` for which we can do this such that there is no triangle of the same color in this graph?

Explain how this works. That is:
1. explain what the different lines in the answer set program do,
1. explain what (optimal) answer sets of the program correspond to and why, and
1. explain how this answers the question (about graphs).

## Question 3 (2pt)

For this question, you will finish an ASP encoding of the following game. The game is played on a directed graph *G*. At the beginning of the game, a subset of vertices of the graph is marked. The goal of the game is to mark all vertices of the graph. The game is played in a number of steps. In each step, you may do one of two moves: (1) reverse all edges in the graph, or (2) mark all vertices *v* for which there exists a marked vertex *u* such that there is an edge *(u,v)*. Once a vertex is marked, it will stay marked for the rest of the game. The goal is to mark all vertices in the graph in a minimum number of steps.

For example, if you play on the graph *G = (V,E)* where *V = {1,2,3,4,5}* and *E = {(1,2), (3,2), (3,4), (5,4)}*, and if the only marked vertex at the beginning is *1*, then the following strategy is a shortest way to get all vertices marked: 1. mark, 2. reverse, 3. mark, 4. reverse, 5. mark, 6. reverse, 7. mark.

(If there is a strategy to mark all vertices, then there is also a strategy with at most *2\*n* moves, where *n* is the number of vertices in the graph.)

Inputs for this game are encoded using predicates `node/1`, `edge/2` and `marked/1`, and using a constant `n` indicating the number of vertices in the graph, for example as follows:
```
% Number of nodes
#const n=5.

% Vertices
node(1..5).

% Edges
edge(1,2).
edge(3,2).
edge(3,4).
edge(5,4).

% Marked vertices
marked(1).
```

The encoding of this game into ASP that you will finish is the following:
```
% Declare possible steps
pos_step(1..2*n).

% Generate a sequence of steps 1,..,k
{ step(S) : pos_step(S) }.
:- step(S), pos_step(S-1), not step(S-1).

% Find the final step
final_step(F) :- F = #max { 0; S : step(S) }.

% Generate a strategy of moves, one for each step
1 { reverse(S) ; mark(S) } 1 :- step(S).

%%%
%%% FINISH THE PROGRAM:
%%% - express the constraint that the generated strategy
%%%   is a valid strategy to mark all vertices of the graph
%%%

% Minimize the number of steps used
#minimize { 1,S : step(S) }.

#show reverse/1.
#show mark/1.
```

Explain how this encoding can be completed in a way that optimal answer sets
correspond to strategies to mark all vertices in the graph with a minimum number
of moves. That is:
1. explain what the different lines do that you add to the answer set program, and
1. explain why this has the effect that optimal answer sets of the program
   correspond to minimum-length winning strategies.

## Question 4 (3pt)

Write an answer set program *P* that starts with declaring two constants: `n` and `k`,
and whose answer sets correspond to all undirected graphs *G* with exactly `n` vertices that have exactly `k` connected components.
A connected component of a graph is a subset of vertices that are all reachable from each other by following edges, and which is connected to no additional vertices in the rest of the graph.
(So a vertex without any edges connected to it is a connected component on its own.)

Explain how your program works. That is:
1. explain what the different lines in the answer set program do, and
1. explain how the answer sets of the program correspond to graphs with exactly `n` vertices and exactly `k` connected components, and why.

*Tip:* keep `n=4` and `k=2` (or some other suitable example) in mind when thinking about the program (and when testing it with clingo).


## Question 5 (1pt)

For this question, you will finish the following answer set program that has as answer sets all (partially) colored graphs (using 3 colors: red, green and blue) with exactly `n=4` vertices for which there is a unique way to extend the partial coloring to a full proper coloring of the graph.

To illustrate this, take the following example graph *G* with vertices *1,2,3,4,5*,
and edges *{1,2}*, *{1,3}*, *{2,3}*, *{2,4}*, *{2,5}*, and the partial coloring that colors *1* red, *4* green and *5* red (and doesn't color vertices *2* and *3*). The only way to extend this partial coloring to a full proper 3-coloring of the graph (that is, where nodes connected by an edge get a different color) is to color *2* blue and to color *3* green.

This is the program that you should finish:
```
#const n=4.
node(1..n).

% Generate a graph and a partial 3-coloring
{ edge(N,M) : node(N), node(M), N != M }.
edge(N,M) :- edge(M,N).
color(red;green;blue).
{ coloring(N,C) : color(C) } 1 :- node(N).
:- edge(N,M), coloring(N,C), coloring(M,C).

% Generate a complete proper 3-coloring that matches
1 { hidden_coloring(N,C) : color(C) } 1 :- node(N).
:- edge(N,M), hidden_coloring(N,C), hidden_coloring(M,C).
:- hidden_coloring(N,C), coloring(N,D), C != D.

%%%
%%% FINISH PROGRAM:
%%% - use saturation to express the requirement
%%%   that there is no other proper 3-coloring of the graph
%%%   extending the coloring expressed by coloring/2.
%%%

% Show the nodes, edges, and partial coloring
#show node/1.
#show edge/2.
#show coloring/2.
```

Use the technique of saturation to express the property that the partial coloring can only be completed to a proper 3-coloring in a unique way.

Explain how your program works. That is:
- explain what the different lines that you added to the answer set program, and
- explain why this ensures that the answer sets of the program correspond to all partially colored graphs with `n=4` vertices that can only be extended to a full, proper 3-coloring in a unique way.
