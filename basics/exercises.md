# Exercises for modelling and solving problems

This is a list of problems that you can use for getting familiar with the framework of answer set programming and SAT solving. You can use [clingo](https://potassco.org/clingo/) to check your solutions.

## A. Playing with answer sets

For each of the following answer set programs, determine what their answer sets are.
Then check your answer with [clingo](https://potassco.org/clingo/) (e.g., [online](https://potassco.org/clingo/run/)).
If you missed some answer sets in your original analysis, make sure you understand why these are answer sets.
If you had some incorrect answer sets in your original analysis, make sure you understand why these are not answer sets.

### A.1.

```
a :- not b.
b :- not a.
c :- not d.
d :- not c.
```

### A.2.

```
a :- b.
b :- c.
c :- a.
a :- not d.
d :- not b.
```

### A.3.

```
num(1..3).
a(X) :- num(X), not b(X).
b(X) :- num(X), not a(X).
```

### A.4.

```
num(1..3).
a(X) :- num(X), not b(X).
b(X) :- num(X), not a(X).

:- a(1), b(2).
:- not a(3).
```

### A.5.

```
item(a;b;c;d).
2 { choose(I) : item(I) } 2.
```

### A.6.

```
item(a;b;c).
{ choose(I) : item(I) }.

:- choose(a), not choose(b).
```

### A.7.

```
item(1;2;3).
good(1;2).
perfect :- good(I) : item(I).
```

### A.8.

```
item(a;b;c).
number(1;2;3).

1 { assign(I,N) : number(N) } 1 :- item(I).
1 { assign(I,N) : item(I) } 1 :- number(N).
```

### A.9.

```
item(a;b;c).
number(1;2;3).

1 { assign(I,N) : item(I) } 1 :- number(N).
```

### A.10.

```
item(a;b;c).
number(1;2;3).

1 { assign(I,N) : number(N) } 1 :- item(I).
```

## B. Some puzzles

Solve the following puzzles.

### B.1. Dreadsbury Mansion Murder Mystery

*Someone in Dreadsbury Mansion killed Aunt Agatha. Agatha, the butler, and Charles live in Dreadsbury Mansion, and are the only ones to live there. A killer always hates, and is no richer than his victim. Charles hates noone that Agatha hates. Agatha hates everybody except the butler. The butler hates everyone not richer than Aunt Agatha. The butler hates everyone whom Agatha hates. Noone hates everyone. Who killed Agatha?*

(From the paper [Seventy-Five Problems for Testing Automatic Theorem Provers](https://link.springer.com/content/pdf/10.1007/BF02432151.pdf) by Pelletier (1986).)

### B.2. The Smith Family

The Smith family and their three children want to pay a visit but they
do not all have the time to do so. Following are few hints who will go
and who will not:
 - If Mr Smith goes, his wife will go too.
 - At least one of their two sons Matt and John will go.
 - Either Mrs Smith or Tim will go, but not both.
 - Either Tim and John will go, or neither will go.
 - If Matt goes, then John and his father will also go.

Who will go and who will not?

### B.3. Marathon

Dominique, Ignace, Naren, Olivier, Philippe, and Pascal
have arrived as the first six at the Paris marathon.
Reconstruct their arrival order from the following
information:
- Olivier has not arrived last
- Dominique, Pascal and Ignace have arrived before Naren and Olivier
- Dominique who was third last year has improved this year.
- Philippe is among the first four.
- Ignace has arrived neither in second nor third position.
- Pascal has beaten Naren by three positions.
- Neither Ignace nor Dominique are on the fourth position.

### B.4. Safe Cracking

The code of Professor Smart's safe is a sequence of 9 distinct nonzero
digits *C1* to *C9* such that the following equations and
inequations are satisfied:

*C4 - C6 = C7*

*C1 * C2 * C3 = C8 + C9*

*C2 + C3 + C6 < C8*

*C9 < C8*

and *C1 != 1*, *C2 != 2*, ..., *C9 != 9*.

Can you find the correct combination?

(From [here](https://www.comp.nus.edu.sg/~henz/projects/puzzles/digits/index.html), where there are more similar puzzles.)

## C. Knights and knaves

This set of exercises is based on some puzzles from Raymond Smullyan's book [Forever Undecided: A Puzzle Guide To Gödel](https://www.goodreads.com/book/show/493575.Forever_Undecided). Solve these exercises both using SAT solving and answer set programming.

The puzzles take place on the Island of Knights and Knaves, where knights always make true statements, knaves always make false statements, and every inhabitant is either a knight or a knave.

### C.1.
The census taker McGregor once did some fieldwork on the Island of Knights and Knaves. McGregor decided on this visit to interview couples only.

McGregor knocked on one door. One person opened it, and asked McGregor their business. "I am a census taker," replied McGregor, "and I need information about you and your partner. Which, if either, is a knight, and which, if either, is a knave?"

"We are both knaves!" said the person angrily, as he slammed the door.

Which type is the person that opened the door, and which type is their partner?

### C.2.

At the next house, McGregor asked the person opening the door: "Are both of you knaves?" The person replied: "At least one of us is."

Which type is the person that opened the door, and which type is their partner?

### C.3.

The next house visited by McGregor proved more of a puzzler. The door was opened timidly by a rather shy person. After McGregor asked them to say something about themself and their partner, all the person said was: "If I am a knight, then so is my partner."

Which type is the person that opened the door, and which type is their partner?

### C.4.

When McGregor interviewed the fourth couple, the person opening the door said: "My partner and I are of the same type. We are either both knights or both knaves."

What can be deduced about the person opening the door and what can be deduced about the partner?

## D. Chocolate or the tiger

This set of exercises is based on some puzzles from Raymond Smullyan's book [The Lady or the Tiger? And Other Logic Puzzles](https://www.goodreads.com/book/show/678521.The_Lady_or_the_Tiger_And_Other_Logic_Puzzles). Solve these exercises both using SAT solving and answer set programming.

The story starts out as follows.

*Many of you are familiar with Frank Stockton's story "The Lady or the Tiger?," in which the prisoner must choose between two rooms, one of which contains a lady and the other a tiger. If he chooses the former, he marries the lady; if he chooses the latter, he (probably) get eaten by the tiger.*

*The king of a certain land had also read the story, and it gave him an idea. "Just the perfect way to try my prisoners!" he said one day to his minister. "Only, I won't leave it to chance; I'll have signs on the doors of the rooms, and in each case I'll tell the prisoner certain facts about the signs. If the prisoner is clever and can reason logically, he'll save his life&mdash; and win a nice bride to boot!" "Excellent idea!" said the minister.*

(Since not everyone is interested in marrying a lady, we'll replace the lady by some chocolate in these exercises.)

### D.1. The first three trials

*On the first day, there were three trials. In all three, the king explained to the prisoner that each of the two rooms contained either [chocolate] or a tiger, but it could be that there were tigers in both rooms, or [chocolate] in both rooms, or then again, maybe one room contained [chocolate] and the other room a tiger.*

#### First trial
There were two signs on the doors of the rooms:
- I: In this room there is chocolate, and in the other room there is a tiger.
- II: In one of these rooms there is chocolate, and in one of these rooms there is a tiger.

The king moreover said that one of these statements was true, and the other false.

If you were the prisoner, which door would you open?

#### Second trial
Again, there were two signs on the doors of the rooms:
- I: At least one of these rooms contains chocolate.
- II: A tiger is in the other room.

The king moreover said that these statements were either both true or both false.

If you were the prisoner, which door would you open?

#### Third trial
Again, there were two signs on the doors of the rooms:
- I: Either a tiger is in this room or chocolate is in the other room.
- II: Chocolate is in the other room.

The king moreover said that these statements were either both true or both false.

If you were the prisoner, which door would you open?

### D.2. The final trial

*Instead of having [two] rooms for the prisoner to choose from, the king gave him nine! As he explained, only one room contained [chocolate]; each of the other eight contained a tiger or was empty. And, the king added, the sign on the door containing the [chocolate] is true; the signs on doors of all rooms containing tigers are false; and the signs on doors of empty rooms can be either true or false.*

*Here are the signs:*
- *I: The [chocolate] is in an odd-numbered room.*
- *II: This room is empty.*
- *III: Either Sign V is right or Sign VII is wrong.*
- *IV: Sign I is wrong.*
- *V: Either sign II or Sign IV is right.*
- *VI: Sign III is wrong.*
- *VII: The [chocolate] is not in Room I.*
- *VIII: This room contains a tiger and Room IX is empty.*
- *IX: This room contains a tiger and Sign VI is wrong.*

*The prisoner studied the situation for a long while. "The problem is unsolvable!" he exclaimed angrily. "That's not fair!" "I know," laughed the king. "Very funny!" replied the prisoner. "Come on, now, at least give me a decent clue: is Room Eight empty or not?" The king was decent enough to tell him whether Room VIII was empty or not, and the prisoner was then able to deduce where the [chocolate] was.*

Which room contained the chocolate?

## E. River crossing puzzles

[River crossing](https://en.wikipedia.org/wiki/River_crossing_puzzle) puzzles are logic puzzles, where the goal is to get a set of people/items across a river with a minimum number of crossings (or in a minimum amount of time), subject to some constraints on the allowed (combinations of) crossings.

Model the following river crossing puzzles in ASP, and find the optimal solution(s).

### E.1. The wolf, the goat and the cabbage

Solve the [wolf, goat and cabbage problem](https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem).

### E.2. Missionaries and cannibals

Solve the [Missionaries and cannibals problem](https://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem).

### E.3. Bridge and torch

Solve the [Bridge and torch problem](https://en.wikipedia.org/wiki/Bridge_and_torch_problem).

## F.

This set of exercises is taken from Vladimir Lifschitz' book [Answer Set Programming](https://www.cs.utexas.edu/users/vl/teaching/378/ASP.pdf) (Section 3.11).

Solve the following exercises both using SAT solving and using answer set programming.

### F.1. Who owns the fish?

There are five houses of five different colors. In each house lives a person of a different nationality. Each of these five people drinks a certain beverage, smokes a certain brand of cigarettes, and keeps a certain pet. No two people have the same pet, drink the same drink or smoke the same brand. We also know the following:
- The British person lives in the red house.
- The Swedish person keeps a dog.
- The Danish person drinks tea.
- The green house is (directly) on the left of the white house.
- The owner of the green house drinks coffee.
- The person who smokes Pall Mall rears birds.
- The owner of the yellow house smokes Dunhill.
- The person living in the house right in the center drinks milk.
- The Norwegian person lives in the first house.
- The person who smokes Blend lives next to the one who has cats.
- The person who has horses lives next to the Dunhill smoker.
- The person who smokes Bluemaster drinks beer.
- The German smokes Princess.
- The Norwegian lives next to the blue house.
- The person who smokes Blend has a neighbor who drinks water.

Who owns the fish?

### F.2. Bishops on a Chessboard

How many bishops can be placed on a chessboard so that they do not attack each other?

### F.3. Filling a Grid with Letters

You are given a 5 x 5 grid partially filled with letters A, B, C, D, E and with a question mark in one of the squares.
For instance:

| | **?** | | | |
| --- | --- | --- | --- | --- |
| | | | | **A** |
| | | **B** | | |
| **D** | | **C** | | |
| | | | **E** | |

What letter can replace the question mark if we fill the grid so that each letter is used once in each row, each column, and each of the two diagonals?

### F.4. Packing Squares into a Rectangle

Pack a given set of squares into a given rectangular area without overlaps.

For instance, if we want to pack the squares A of size 4, B of size 3, C and D of size 2, E of size 1 into an area of 5 x 8, then one of the solutions is:

| **A** | **A** | **A** | **A** | **B** | **B** | **B** | |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **A** | **A** | **A** | **A** | **B** | **B** | **B** | |
| **A** | **A** | **A** | **A** | **B** | **B** | **B** | **E** |
| **A** | **A** | **A** | **A** | **C** | **C** | **D** | **D** |
| | | | | **C** | **C** | **D** | **D** |

### F.5. Hitori

In a Hitori puzzle, you are given a square grid with integers appearing in all squares.
The object is to darken some of the squares so that:
- in undarkened squares, no number appears in any row or column more than once,
- darkened squares do not touch each other vertically or horizontally, and
- all undarkened squares are connected to each other.

Write a program that solves Hitori puzzles.
To test your program, run it on the example from
[the Wikipedia article on Hitori](https://en.wikipedia.org/wiki/Hitori).

<!--
Other ideas:

Knight's Tour: https://ibmathsresources.com/2013/11/19/knights-tour/

http://www.hakank.org/answer_set_programming/who_killed_agatha.lp
http://www.hakank.org/answer_set_programming/mr_smith.lp
http://www.hakank.org/answer_set_programming/marathon2.lp
http://www.hakank.org/answer_set_programming/safe_cracking.lp
http://www.amagicclassroom.com/uploads/3/4/5/2/34528828/alphametics.pdf

-->
