# Example of a solution (for a different assignment)

## Exercise: Solving Exact Cover by 3-Sets

In this exercise, you will model the problem of *Exact Cover by 3-Sets* in answer set programming.
The problem is as follows.
The input consists of a finite set *U = {u<sub>1</sub>,...,u<sub>n</sub>}* of elements,
and a sequence *S<sub>1</sub>,...,S<sub>m</sub>* of subsets *S<sub>i</sub> &subseteq; U* of the set *U*, each containing exactly three elements.
The task is to find a subset *C* of *{S<sub>1</sub>,...,S<sub>m</sub>}* so that each element in *U* is contained in **exactly** one set in *C*&mdash;such a set *C* is called an *exact cover* of *U*.

#### Assignment:
Explain how you can solve this problem using answer set programming.

#### Note:
In your answer, include the following:
- Describe clearly how, for each input of the problem, you can construct an answer set program *P* such that from an answer set of *P* you can construct the right output.
- Describe what rules/constraints/statements you add to the program *P*, and (intuitively) what function each has.
- Describe why answer sets correspond to solutions for the problem, and how to construct a solution from a given answer set.

## Example solution:
The problem is already described in a precise, formal way, so we start with describing how to represent any input of the problem in ASP.

We begin by stating what the elements of *U* are, using the predicate `element/1`.
Suppose *U = {u<sub>1</sub>,...,u<sub>n</sub>}* has *n* elements.
We then begin our program *P* as follows:
```
element(1..n).
```
Then, using the predicate `given_subset/2`, we state facts that describe the given subsets *S<sub>1</sub>,...,S<sub>m</sub>*.
Suppose that the set *S<sub>8</sub>* contains the elements *u<sub>2</sub>*, *u<sub>4</sub>* and *u<sub>7</sub>*.
We then add the following facts to *P*:
```
given_subset(8,2).
given_subset(8,4).
given_subset(8,7).
```
We do this (adding to *P* the fact `given_subset(i,j).`) for all the sets *S<sub>i</sub>* and all elements *u<sub>j</sub> &in; S<sub>i</sub>*.

This concludes the representation of the input,
and next we will add some statements to *P* that serve to generate all possible (candidate) solutions.
We add the following rule, that will allow us to use the unary predicate `given_subset/1`:
```
given_subset(S) :- given_subset(S,_).
```
And we use this predicate, in the following statement, to generate all subsets of *{S<sub>1</sub>,...,S<sub>m</sub>}*:
```
{ choose(S) : given_subset(S) }.
```

All that remains is to filter out those answer sets that do not form an exact cover *C*.
To do this, we first add the following rule, that encodes (with the predicate `element_covered/1`) which elements are covered by the chosen subsets:
```
element_covered(E) :- element(E), choose(S), given_subset(S,E).
```
And we add the following constraint, which serves to ensure that all elements in *U* are covered by at least one chosen subset:
```
:- element(E), not element_covered(E).
```
Finally, we add another constraint, that expresses that an element may not be covered by two different chosen subsets:
```
:- element(E), choose(S1), choose(S2), S1 != S2,
    given_subset(S1,E), given_subset(S2,E).
```

The answer sets of the constructed program *P* then correspond exactly to the exact covers *C* of *U* (using the sets *S<sub>1</sub>,...,S<sub>m</sub>*).

Any exact cover *C* of *U* will be generated as a possible subset by the choice rule that uses `choose/1`. And because it is an exact cover, it has for each element of *U* exactly one subset *S<sub>i</sub>* that covers it, and so it will satisfy the two constraints of the program. And so *C* will be represented by some answer set of *P*.

Conversely, any answer set *A* of *P* will correspond to an exact cover of *C*. By the choice rule that uses `choose/1`, the answer set will correspond to a subset *C* of *{S<sub>1</sub>,...,S<sub>m</sub>}*. Because all the answer sets must satisfy the constraints of the program, the answer set *A* will for each element *u<sub>j</sub>* of *U* have exactly one set *S<sub>i</sub>* where `choose(i)` &in; *A*, and therefore *A* corresponds to an exact cover.

In other words, to construct an exact cover *C* from an answer set *A* of the program *P*, we take all sets *S<sub>i</sub>* such that `choose(i)` &in; *A*, and the resulting set *C &subseteq; {S<sub>1</sub>,...,S<sub>m</sub>}* is an exact cover.

#### Note:
*This example solution is worked out in a lot of detail. Because the assignment is relatively simple, this is easily doable and still well-readable. For more complicated assignments, try to find a good balance between, on the one hand, spelling out all details, and on the other hand, describing only the main/interesting/nontrivial parts of the solution.*
