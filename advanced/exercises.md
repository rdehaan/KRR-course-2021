# Exercises for advanced modelling

This is a list of problems that you can use for practicing advanced techniques for modelling and solving a problem using ASP.

## A. 'No solution' variants of the basic modelling exercises

For the problems in the [(basic) modelling exercises](../modelling/exercises.md), you can consider 'no solution' variants. For example, for the problem of dominating set, you can consider the following variant:

*Input:* an undirected graph *G = (V,E)*, and a positive integer *k*.

*'Solution':* an answer set if and only if there is no [dominating set](https://en.wikipedia.org/wiki/Dominating_set) *D* of *G* of size at most *k*.

Solve these 'no solution' variants of the problems using the technique of saturation.

## B. Further saturation exercises

### B.1. &exist;&forall;-QBF

*Input:* a [quantified Boolean formula](https://en.wikipedia.org/wiki/True_quantified_Boolean_formula) &varphi; with an &exist;&forall; quantifier prefix.

*Solutions:* truth assignments &alpha; to the existentially quantified variables such that &varphi;[&alpha;] is true for every truth assignment to the universally quantified variables.

### B.2. Entailed clauses

*Input:* a [propositional logic CNF formula](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem) &varphi;.

*Solutions:* clauses *c* over the variables in &varphi; such that *c* is logically entailed by &varphi; (i.e., &varphi; &models; *c*).

### B.3. 3-Coloring extension

*Input:* an undirected graph *G = (V,E)*.

*Solutions:* [colorings](https://en.wikipedia.org/wiki/Graph_coloring) of the leaves of *G* (i.e., vertices in *G* that have only one neighbor) that use at most 3 colors, such that every extension of this coloring to all vertices in *G* is not a proper 3-coloring.
