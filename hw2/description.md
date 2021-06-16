# Homework assignment 2

In this assignment, you will program several algorithms related to BombKnightSudoku (a variant of Sudoku) on a `(k*k)^2` size grid, for varying sizes of `k`. You will use several problem solving and search methods.

The homework assignment consists of several parts (a)&ndash;(d).
You get 1 point for free.
Assignment (a) is worth 3 points.
Assignment (b) is worth 1 bonus point.
Assignment (c) is worth 4 points.
Assignment (d) is worth 2 points (or you may opt to solve an easier variant for a maximum of 1 points).
Your grade will be the amount of points you get, with a maximum of 10.0.

## Python notebook

A Python notebook is available [on Canvas](https://canvas.uva.nl/files/4958498/download?download_frd=1) with some skeleton code.
Use this notebook to submit your solutions.
For more instructions for submission, see the [assignment on Canvas](https://canvas.uva.nl/courses/21424/assignments/247527).

## BombKnightSudoku's

Here follows a description of *inputs* and *solutions* for BombKnightSudoku's.
These notions are similar (but not exactly the same) as for the [Sudoku's](https://en.wikipedia.org/wiki/Sudoku) that you might have seen elsewhere, generalized to arbitrary values of `k` (typically, `k=3`).

An *input* consists of a `k`-by-`k` grid of blocks,
where each consisting of a `k`-by-`k` grid of cells,
forming a `k*k`-by-`k*k` grid of cells.
Each cell can (but must not) contain a value between `1` and `k*k`.

An example is the following grid, for `k=3`, written out
as `k*k` lines, each consisting of `k*k` numbers, separated by spaces.
Here the value `0` represents that a cell does not contain
a value between `1` and `k*k`.

```
0 0 0 0 0 0 0 0 0
0 3 0 0 8 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 4 0 0 0 5
0 0 0 0 0 0 0 2 7
0 0 0 0 0 0 3 0 0
0 0 0 0 0 0 9 0 0
0 0 0 0 5 6 0 0 0
0 0 0 0 0 0 0 0 0
```

Here is the same input, where now the `k`-by-`k` blocks are separated from
each other with whitespace.

```
0 0 0  0 0 0  0 0 0
0 3 0  0 8 0  0 0 0
0 0 0  0 0 0  0 0 0

0 0 0  0 4 0  0 0 5
0 0 0  0 0 0  0 2 7
0 0 0  0 0 0  3 0 0

0 0 0  0 0 0  9 0 0
0 0 0  0 5 6  0 0 0
0 0 0  0 0 0  0 0 0
```

A *solution* for a sudoku input is a `k*k`-by-`k*k` grid (for the same `k`),
where:
1. Each cell contains a value between `1` and `k*k`.
1. If a cell *(i,j)* contains a value `u` in the input,
  then the cell *(i,j)* in the solution must contain the same value `u`.
1. Each two different cells in the same row must contain different values.
1. Each two different cells in the same column must contain different values.
1. Each two different cells in the same `k*k` block must contain different values.
1. Each two different cells that are directly adjacent (horizontally, diagonally or vertically) must contain different values. In other words, a cell cannot contain the same value as any of the eight cells surrounding it.
1. Each two different cells that can be reached from each other with a single [knight's move](https://en.wikipedia.org/wiki/Knight_%28chess%29) (as in Chess) must contain different values.

(Constraints 6. and 7. are what distinguish BombKnightSudoku's from regular Sudoku's.)

For example, a solution for the input mentioned above is the following:

```
5 6 2 7 3 4 1 8 9
7 3 4 1 8 9 5 6 2
1 8 9 5 6 2 7 3 4
6 2 7 3 4 1 8 9 5
3 4 1 8 9 5 6 2 7
8 9 5 6 2 7 3 4 1
2 7 3 4 1 8 9 5 6
4 1 8 9 5 6 2 7 3
9 5 6 2 7 3 4 1 8
```

## Representation of inputs and outputs

Inputs are represented as a list of lists of numbers.
For example, the BombKnightSudoku input above is represented as:

```
input =
    [[0, 0, 0, 0, 0, 0, 0, 0, 0],
     [0, 3, 0, 0, 8, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 4, 0, 0, 0, 5],
     [0, 0, 0, 0, 0, 0, 0, 2, 7],
     [0, 0, 0, 0, 0, 0, 3, 0, 0],
     [0, 0, 0, 0, 0, 0, 9, 0, 0],
     [0, 0, 0, 0, 5, 6, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0, 0]]
```

Solutions are represented similarly, for example:

```
solution =
    [[5, 6, 2, 7, 3, 4, 1, 8, 9],
     [7, 3, 4, 1, 8, 9, 5, 6, 2],
     [1, 8, 9, 5, 6, 2, 7, 3, 4],
     [6, 2, 7, 3, 4, 1, 8, 9, 5],
     [3, 4, 1, 8, 9, 5, 6, 2, 7],
     [8, 9, 5, 6, 2, 7, 3, 4, 1],
     [2, 7, 3, 4, 1, 8, 9, 5, 6],
     [4, 1, 8, 9, 5, 6, 2, 7, 3],
     [9, 5, 6, 2, 7, 3, 4, 1, 8]]
```

## (a): solving puzzles with propagation

Implement an algorithm that takes as input a BombKnightSudoku input (for arbitrary `k`), and that outputs a generator that iterates over **all** solutions for this input.

For this assignment, your algorithm should use an *exhaustive search with propagation (inference)* approach. That is, it should traverse a search tree, and it should perform propagation at each of the nodes in the search tree.

## (b): solving puzzles using SAT

Again, implement an algorithm that takes as input a BombKnightSudoku input (for arbitrary `k`), and that outputs a generator that iterates over **all** solutions for this input.

For this assignment, your algorithm should use the approach of encoding the BombKnightSudoku input into a propositional CNF formula &varphi;, calling a SAT solver to find satisfying assignments for &varphi;, and translating these assignments to solutions for the BombKnightSudoku input.

## (c): solving puzzles using ASP

Yet again, implement an algorithm that takes as input a BombKnightSudoku input (for arbitrary `k`), and that outputs a generator that iterates over **all** solutions for this input.

For this assignment, your algorithm should use the approach of encoding the BombKnightSudoku input into an answer set program *P*, calling an ASP solver (i.e., clingo) to find answer sets for *P*, and translating these answer sets to solutions for the BombKnightSudoku input.

## (d): generating puzzles with unique solutions using ASP

Implement an algorithm that generates `9`-by-`9` BombKnightSudoku inputs (i.e., `k=3`) that:
1. have exactly 10 cells filled with a number between `1` and `9`,
1. and have a unique solution.
That is, your algorithm should output a generator that iterates over BombKnightSudoku inputs with the required properties.

Your algorithm should use the approach of translating this problem to an answer set program *P*, calling an ASP solver (i.e., clingo) to find answer sets for *P*, and translating these answer sets to BombKnightSudoku inputs with the required properties.

(To be clear: you may not 'hardcode' a list of BombKnightSudoku inputs in the answer set program *P*.)

There are two variants of this assignment: a harder variant (d.I) and an easier variant (d.II). You may choose which variant you would like to solve.
If you opt for the harder variant (d.I), you can get a maximum of 3 points for this assignment.
If you opt for the easier variant (d.II), you can get a maximum of 2 points for this assignment.


### (d.I) Harder variant:

To solve the harder variant, your answer set program *P* should be such that for **each** BombKnightSudoku input *I* with the required properties, there is an answer set of *P* that corresponds to *I*. For this, you should express in *P* the constraints 1. (that exactly 10 cells are filled) and 2. (that the input has a unique solution).

*Hint:* Use the technique of saturation to express constraint 2.

### (d.II) Easier variant:

To solve the easier variant, your answer set program *P* only needs to be such that for **a subset of** BombKnightSudoku inputs *I* with the required properties, there is an answer set of *P* that corresponds to *I*. For this, you could express in *P*, in addition to the constraint 1. (that exactly 10 cells are filled), some other property that entails constraint 2. (that the input has a unique solution).

*Hint:* If a Sudoku input can be solved using some [basic strategies](http://pi.math.cornell.edu/~mec/Summer2009/Mahmood/Solve.html), it must have a unique solution. Consider variants of these basic strategies for BombKnightSudoku.
