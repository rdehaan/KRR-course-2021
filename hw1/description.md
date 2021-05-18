# Homework assignment 1

## Exercise 1: Finding small FSAs

In this exercise, you will model the following problem in answer set programming.
The goal is to find a small finite-state automaton that matches some data points.

A *[(nondeterministic) finite state automaton (NFA)](https://en.wikipedia.org/wiki/Finite-state_machine)* consists of:
- An alphabet *&Sigma;* (a finite, non-empty set).
- A finite, non-empty set *Q* of states.
- An initial state *q<sub>0</sub> &in; Q*.
- A set of labelled edges *(q,q',&sigma;) &in; Q &times; Q &times; &Sigma;*.
- A finite set *F &subseteq; Q* of final states.

A (finite) word *w* over the alphabet *&Sigma;*, consisting of the symbols *&sigma;<sub>1</sub>,...,&sigma;<sub>n</sub>*, is accepted by the automaton *A* if there is a (labelled) path from *q<sub>0</sub>* to some *q &in; F* that has the symbols *&sigma;<sub>1</sub>,...,&sigma;<sub>n</sub>* (in that order) as labels for the edges in the path. (The path may visit states *q &in; Q* an arbitrary number of times).
If a word *w* is not accepted by *A*, we say that it is rejected by *A*.

The problem is now as follows.
The input consists of a positive integer *k* and a set of tuples *(w,o)* where *w* is a finite word over the alphabet *&Sigma;* and *o &in; \{ 0,1 \}*.
Each tuple *(w,o)* in this set is a data point.
The task is to find an NFA *A* with at most *k* states (i.e., *|Q| &leq; k*) such that for each tuple *(w,o)* in the data set, it holds that *A* accepts the word *w* if *o = 1* and *A* rejects the word *w* if *o = 0*.
If such an automaton *A* of size at most *k* exists, output such an automaton *A* **of minimum size**. If no such automaton *A* of size at most *k* exists, output "None."

#### Assignment:
Explain how you can solve this problem using answer set programming.

#### Note:
In your answer, include the following:
- Describe clearly how, for each input of the problem, you can construct an answer set program *P* such that from an (optimal) answer set of *P* you can construct the right output.
- Describe what rules/constraints/statements you add to the program *P*, and (intuitively) what function each has.
- Describe why (optimal) answer sets correspond to solutions for the problem, and how to construct a solution from a given (optimal) answer set.

## Exercise 2: Adding #even/#odd statements to the language

In this exercise, you will show how adding (hypothetical) language constructs about the parity of sets does not increase the expressivity of the language of answer set programming.

In particular, consider the following hypothetical language constructs `#even` and `#odd`. Both are to be followed by a set of literals, and are true if and only if the number of literals in this set that is true is even or odd, respectively.

For example, the following (hypothetical) answer set program would have an answer set:
```
vertex(1;2).
color(red;green;blue).
use(1,red).
use(2,red).

#even { use(V,red) : vertex(V) }.
```
And the following (hypothetical) answer set program would not have an answer set:
```
vertex(1;2).
color(red;green;blue).
use(1,red).
use(2,green).

#even { use(V,red) : vertex(V) }.
```

#### Assignment (a):
Show how to translate any answer set program *P* that uses these hypothetical statements with `#even` and `#odd` to an equivalent answer set program *P'* (that is, *P* and *P'* have exactly the same answer sets when restricted to the predicates that appear in *P*) **with** aggregates.

#### Assignment (b):
Show how to translate any answer set program *P* that uses these hypothetical statements with `#even` and `#odd` to an equivalent answer set program *P'* (that is, *P* and *P'* have exactly the same answer sets when restricted to the predicates that appear in *P*) **without** using aggregates&mdash;only using normal rules (you may use first-order variables).

#### Note:
When translating *P* to *P'*, you may introduce additional predicates. The equivalence between *P* and *P'* is measured only with respect to the predicates appearing in *P*. In other words, if we were to add (both to *P* and *P'*) a `#show` statement for each predicate appearing in *P*, clingo would show exactly the same answer sets.

<!--
assign points for considering all different situations: statements like this in the head and in the body of rules.
-->

## Exercise 3: Modelling road repair scheduling

- Description of general problem
- (a): specify formal problem (directed, weighted, labelled graph); and give example of instance (strongly connected map with at least 10 roads, at least 5 repair request of different durations, and at least 3 different tools)
- (b): model basic variant of the problem (do all repairs in minimal amount of time, with durations of repairs and available tools)
- (c): add constraint that at each point, each location must be reachable from each other location
- (d): add minimum flow from s to t constraints for each timepoint (with multiple s-t flow constraints possible per timestep)
- (e): add constraint some number of supervisors must each day inspect each repair site from HQ (and they can all only traverse a fixed length cycle each day)
