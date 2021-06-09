# Homework assignment 1

## Exercise 1 (3pt): Finding small FSAs

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
The input consists of a positive integer *k* and a set of tuples *(w,o)* where *w* is a (nonempty) finite word over the alphabet *&Sigma;* and *o &in; \{ 0,1 \}*.
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

## Exercise 2 (6pt): Modelling road repair scheduling

In this exercise, you will show how to model the following problem in answer set programming.
The general goal is to find a schedule of repairs for a network of roads in as little as possible time.

This exercise contains several assignments. In the first two, you will show how to model a basic variant of the problem. In the subsequent assignments, you will extend this modelling to (more complicated) variants of the problem.

#### Basic problem description

You are given a network of roads:
- A collection of intersections and a collection of roads that are each between two intersections.
- Some roads are one-way, and some roads are two-way (this is specified in the problem input).

You are also given a collection of which repair equipment is available (e.g., 2 trucks and 1 drill).

In addition, you are given a subset of roads that need to be repaired (repair requests).
For each repair request, you are given:
- Which road is to be repaired (i.e., the road segment between which two intersections).
- How long this repair takes (e.g., a number of days). The repair should happen on subsequent days. (Repairs always take a multiple of complete days&mdash;in other words, the granularity of time for this problem is days.)
- What tools are needed for this repair (e.g., 1 truck and 1 drill).

The task is to find a schedule for the repairs&mdash;i.e., which repairs should happen on which (subsequent) days&mdash;such that:
- each repair is assigned to the right amount of subsequent days,
- for each day, the total amount of tools needed (for each type of tool) for the repairs scheduled on that day is less than or equal to the total amount of tools available (of that type), and
- the overall amount of days after which all repairs are done is minimal.

#### Assignment (a; 1pt):

Give a precise specification of the problem input.
How would you model the input data? What predicates would you use to represent
this in ASP, and how do you construct the facts over these predicates?

Give an example of an instance with at least 10 roads that form a single connected graph, at least 5 repair requests of different durations that require different sets of tools, and at least 3 different tools.
Also give the ASP encoding of this example problem input.

#### Assignment (b; 2pt):

Describe how you would model and solve the basic problem (as described above) in ASP.

Explain clearly what predicates you use, what rules and constraints you add to the program, and what conceptual function these rules and constraints serve.

Also, explain clearly why (optimal) answer sets of your program correspond to solutions for the problem.

#### Assignment (c; 1pt):

In this assignment, you will show how to modify the ASP encoding that you constructed for assignments (a) and (b) to include the following additional constraint.

The additional constraint is that on each day, each intersection must be reachable from each other intersection by roads that are not being repaired on that day. So for example, all roads connected to some intersection may not all be repaired on the same day (because that intersection cannot be reached on that day from the other intersections).

Explain clearly what you will modify in and add to your previous program, and why the (optimal) answer sets for the new program correspond to the problem with this additional constraint.

#### Assignment (d; 2pt):

In this assignment, you will show how to modify the ASP encoding that you constructed for assignments (a)&ndash;(c) to include the following additional constraint.

*Note: If you didn't solve assignment (c), you may start from the program that you constructed for (a)&ndash;(b).*

The additional constraint for this assignment is the following.
In the input, you are given some additional data:
- For each road (and each direction on two-way roads), you are given a capacity: some positive integer that indicates how much traffic can pass on this road (e.g., 2 units of traffic per time unit).
- Some traffic flow requirements (one per day), consisting of:
  - A starting intersection *s*, a finish intersection *t*, and a total flow amount *a* (a nonnegative integer).
The repair schedule should be such that on each day, there must be a [network flow](https://en.wikipedia.org/wiki/Maximum_flow_problem#Definition) possible from *s* (for that day) to *t* (for that day) with a value *a* of flow, that uses only roads that are not being repaired that day.

Again, explain clearly what you will modify in and add to your previous program, and why the (optimal) answer sets for the new program correspond to the problem with this additional constraint.

<!--
#### Assignment (e):

In this assignment, you will show how to modify the ASP encoding that you constructed for assignments (a)&ndash;(d) to include the following additional constraint.

*Note: If you didn't solve assignment (c) or (d), you may start from the program that you constructed for (a)&ndash;(b).*

The additional constraint for this assignment is the following.
In the input, you are given in addition an intersection *h* (which indicates the location of the repair company headquarters), a number *i* of inspectors, and a positive integer *l* (indicating the maximum length of a roundtrip that each inspector can make on each day).

The repair schedule should be such that on each day, the *i* inspectors each can make a cycle of length at most *l* from *h* to *h* (different inspectors are allowed to make different cycles), such that on each day all roads that are being repaired are visited by at least one inspector. (An inspector visits a road under reparation by visiting one of the two intersections next to that road.)

Again, explain clearly what you will modify in and add to your previous program, and why the (optimal) answer sets for the new program correspond to the problem with this additional constraint.
-->

## Exercise 3 (bonus, 1pt): Adding #even/#odd statements to the language

In this exercise, you will show how adding (hypothetical) language constructs about the parity of sets does not increase the expressivity of the language of answer set programming.

In particular, consider the following hypothetical language constructs `#even` and `#odd`. Both are to be followed by a set of literals, and are true if and only if the number of literals in this set that is true is even or odd, respectively. For the sake of simplicity, you may assume that statements with these hypothetical constructs `#even` and `#odd` only appear in the body (i.e., the right-hand side) of rules.

For example, the following (hypothetical) answer set program would have an answer set:
```
num(1..10).
a(1..4).
#show a/1.

:- not #even { a(X) : a(X), num(X) }.
```
And the following (hypothetical) answer set program would not have an answer set:
```
num(1..10).
a(1..3).
#show a/1.

:- not #even { a(X) : a(X), num(X) }.
```

#### Assignment:
Show how to translate any answer set program *P* that uses these hypothetical statements with `#even` and `#odd` to an equivalent answer set program *P'* (that is, *P* and *P'* have exactly the same answer sets when restricted to the predicates that appear in *P*) **without** using aggregates&mdash;only using normal rules (you may use first-order variables).

#### Note:
You may show concretely how the translation can be done for the following answer set program *P<sub>0</sub>* (for different values of the constant `t`), and then explain how your solution for *P<sub>0</sub>* can be used (in modified form) to translate arbitrary answer set programs with `#even` and `#odd` (in the body of rules) to equivalent programs without these statements.
```
#const t=10.
num(1..t).
{ a(X) : num(X) }.
#show a/1.

:- not #even { a(X) : a(X), num(X) }.
```

#### Note:
When translating *P* to *P'*, you may introduce additional predicates. The equivalence between *P* and *P'* is measured only with respect to the predicates appearing in *P*. In other words, if we were to add (both to *P* and *P'*) a `#show` statement for each predicate appearing in *P*, clingo would show exactly the same answer sets.
