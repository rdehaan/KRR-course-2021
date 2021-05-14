# Some notes on changes in clingo's syntax

In the most recent version of clingo, a slightly different syntax is used from what is mentioned in the book "Answer Set Solving in Practice". Here are some notes on the differences.

## `;` instead of `,`

In choice rules, use `;` instead of `,`.
For example:

```prolog
at(grocery).

% OLD SYNTAX: { buy(pizza), buy(wine), buy(corn) } :- at(grocery).
{ buy(pizza); buy(wine); buy(corn) } :- at(grocery).
```

In cardinality rules, use `;` instead of `,`.
For example:

```prolog
pass(a1;a2).

% OLD SYNTAX: pass(c42) :- 2 { pass(a1),  pass(a2), pass(a3) }.
pass(c42) :- 2 { pass(a1);  pass(a2); pass(a3) }.
```

Generally, use `,` to separate several parts inside a single conditional literal, and use `;` to separate different elements within a set (e.g., literals, conditional literals, tuples). And if there is no possible confusion, you may replace `;` by `,`.
For example:

```prolog
vertex(42).
color(1;2;3).
good(1;2;3).
use(42,(1;2;3)).

all1(V) :- use(V, C) : color(C), good(C); vertex(V).
all2(V) :- use(V,1); use(V,2); use(V,3); vertex(V).
all3(V) :- use(V,1), use(V,2), use(V,3), vertex(V).
all4(V) :- use(V,1), use(V,2); use(V,3), vertex(V).
```

## Aggregates

In aggregates, use `:` instead of `=`, and use `;` instead of `,`.
For example:

```prolog
% OLD SYNTAX: 10 { course(db)=4, course(ai)=6, course(project)=8, course(xml)=3 } 20.
10 #sum { 4 : course(db); 6 : course(ai); 8 : course(project); 3 : course(xml) } 20.
```

## Optimization statements

In optimization statements, use `{` and `}` instead of `[` and `]`, use `:` instead of `=`.

```prolog
number(1;2;3;4).
2 { hd(X) : number(X) } 2.

% OLD SYNTAX: #minimize[ hd(1)=30@2, hd(2)=40@2, hd(3)=60@2, hd(4)=80@2 ].
#minimize { 30@2,hd(1); 40@2,hd(2); 60@2,hd(3); 80@2,hd(4) }.
```

## Disjunctions in the head

When specifying disjunction in the head of rules, use `;` instead of `|`.
(In this case, the old syntax still works as well.)

```prolog
vertex(42).

% OLD SYNTAX (STILL WORKS): color(42,red) | color(42,green) | color(42,blue) :- vertex(42).
color(42,red) ; color(42,green) ; color(42,blue) :- vertex(42).
```

## `#show`ing predicates

To selectively show only some predicates in the answer sets, you don't need to use `#hide.` anymore before selective `#show` statements (such as `#show color/1.`).

```prolog
number(1;2;3;4).
color(red;green;blue).

% OLD SYNTAX: #hide. #show color/1.
#show color/1.
```
