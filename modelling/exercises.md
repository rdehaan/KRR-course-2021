# Exercises for modelling and solving problems

This is a list of problems that you can use for practicing how to model and solve a problem using ASP. When practicing, keep in mind the [guide](guide.md) of steps to take in the modelling process.

The problems in this list originate in a variety of areas. Some are already defined formally, and others less so. The problems are grouped into several categories, based on their type or flavor.

For each problem, the difficulty of modelling it using ASP is indicated using one to four stars (&star;'s)&mdash;one start being the easiest, and four stars being the hardest.

The problem descriptions below both indicate what is the input for the problem, what kind of object the solutions are and what kind of properties the solutions should have. The goal, for each exercise, is to construct an answer set program *P* such that the (optimal) answer sets of *P* correspond to the solutions of the problem&mdash;and to describe how one can extract solutions from the (optimal) answer sets.

*Tip:* To check your solution, construct an example input, and check if the (optimal) answer sets for your program correspond to correct solutions for this input.

## A. Graph problems

### A.1. Dominating set (&star;)

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*Solutions:* [dominating sets](https://en.wikipedia.org/wiki/Dominating_set) *D* of *G* of size at most *k*. (Or alternatively: dominating sets of *G* of minimum size.)

### A.2. Independent set (&star;)

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*Solutions:* [independent sets](https://en.wikipedia.org/wiki/Independent_set_%28graph_theory%29) *I* of *G* of size at least *k*. (Or alternatively: independent sets of *G* of maximum size.)

### A.3. Clique (&star;)

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*Solutions:* [cliques](https://en.wikipedia.org/wiki/Clique_%28graph_theory%29) *C* of *G* of size at least *k*. (Or alternatively: cliques of *G* of maximum size.)

### A.4. 3-Coloring (&star;)

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* [colorings](https://en.wikipedia.org/wiki/Graph_coloring) of *G* that use at most 3 colors.

### A.5. Graph coloring (&star;)

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* [colorings](https://en.wikipedia.org/wiki/Graph_coloring) of *G* that use a minimum number of colors.

### A.6. Vertex cover (&star;)

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*Solutions:* [vertex covers](https://en.wikipedia.org/wiki/Vertex_cover) *C* of *G* of size at most *k*. (Or alternatively: vertex covers of *G* of minimum size.)

### A.7. Domatic partition (&star;&star;)

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*Solutions:* [domatic partitions](https://en.wikipedia.org/wiki/Domatic_number) of *G* that partition *G* into at least *k* sets. (Or alternatively: domatic partitions of *G* that partition *G* into a maximum number of sets.)

### A.8. Feedback vertex set (&star;&star;&star;)

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*Solutions:* [feedback vertex sets](https://en.wikipedia.org/wiki/Feedback_vertex_set) *F* of *G* of size at most *k*. (Or alternatively: feedback vertex sets of *G* of minimum size.)

### A.9. Hamiltonian path (&star;&star;)

*Input:* an undirected graph *G = (V,E)*, and two vertices *s* and *t* in *V*.

*Solutions:* [Hamiltonian paths](https://en.wikipedia.org/wiki/Hamiltonian_path) in *G* from *s* to *t*.

### A.10. Hamiltonian cycle (&star;&star;)

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* [Hamiltonian cycles](https://en.wiktionary.org/wiki/Hamiltonian_cycle) in *G*.

### A.11. Maximum cut (&star;)

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* [Maximum cuts](https://en.wikipedia.org/wiki/Maximum_cut) of *G*.

### A.12. Triangle cover (&star;)

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* [Maximum cuts](https://en.wikipedia.org/wiki/Maximum_cut) of *G*.

### A.13. Partition into Hamiltonian graphs (&star;&star;)

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* partitions of *V* into sets *S<sub>1</sub>,...,S<sub>m</sub>* such that the subgraph of *G* induced by each *S<sub>i</sub>* is a [Hamiltonian graph](https://en.wikipedia.org/wiki/Hamiltonian_path#Definitions).

## B. Logic problems

### B.1. Satisfiability of propositional logic formulas (&star;&star;)

*Input:* a propositional logic formula &varphi;.

*Solutions:* satisfying truth assignments for &varphi;.

### B.2. Satisfiability of Boolean circuits (&star;&star;)

*Input:* a [Boolean circuit](https://en.wikipedia.org/wiki/Boolean_circuit) *C*.

*Solutions:* satisfying truth assignments for *C*.

### B.3. Bounded-size satisfiability of modal logic (&star;&star;&star;&star;)

*Input:* a [basic modal logic](https://en.wikipedia.org/wiki/Modal_logic) formula &varphi;,
and a positive integer *k*.

*Solutions:* a [Kripke structure](https://en.wikipedia.org/wiki/Modal_logic#Relational_semantics) *M* containing at most *k* states and a state *w* in *M* such that *M,w* &models; &varphi;.

## C. Scheduling problems

### C.1. Job shop scheduling (&star;&star;)

Take a variant of the [job shop scheduling](https://en.wikipedia.org/wiki/Job_shop_scheduling) problem (e.g., with or without precedence constraints), and find solutions of minimum [makespan](https://en.wikipedia.org/wiki/Makespan).

### C.2. Open shop scheduling (&star;&star;)

Take a variant of the [open shop scheduling](https://en.wikipedia.org/wiki/Open-shop_scheduling) problem, and find solutions of minimum [makespan](https://en.wikipedia.org/wiki/Makespan).

## D.

### D.1. Selecting a subgraph while maintaining reachability

*Input:* an undirect graph *G = (V,E)*, several pairs *(v<sub>1</sub>,u<sub>1</sub>),...,(v<sub>n</sub>,u<sub>n</sub>)* of vertices, and a positive integer *k*.

*Solutions:* subgraphs *G'* consisting of *V* and exactly *k* edges of *E* such that for each pair *(v<sub>i</sub>,u<sub>i</sub>)* it holds that *u<sub>i</sub>* is reachable from *v<sub>i</sub>* in *G'*.

*Note:* this exercise involves using a (recursively defined) predicate to keep track of reachability in the subgraph *G'*.

### D.2. Combinatorial auctions

*Input:* a set *I* of items, and a set of bids, each consisting of a subset *J &subseteq; I* of items and a profit *p* (a positive integer). (The bids are offers for selling the items in *J* together for profit *p*.)

*Solutions:* a subset of bids that are mutually consistent (that is, bids involving separate subsets of items) that lead to a maximum combined profit.

*Note:* this exercise involves using the aggregate `#sum` as well as an optimization statement.

<!--
## Problems related to games
- chess position legal after k moves
- Slitherlink

## Social choice problems
- Kemeny voting *
- minimax approval voting **

## Problems related to formal languages
- bounded-size DFA consistent with pos. and neg. words
- bounded-size NFA consistent with pos. and neg. words
- DFA intersection (restricted to works of length k) nonempty
- NFA intersection (restricted to works of length k) nonempty
- bounded-size CFG consistent with pos. and neg. words

## Other problems
- Rural postman / Chinese postman
- X3C
- Set cover
- Abstract argumentation: conflict-free, admissible, complete, stable -- https://en.wikipedia.org/wiki/Argumentation_framework
-->
