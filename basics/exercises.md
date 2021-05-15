# Exercises for modelling and solving problems

This is a list of problems that you can use for getting familiar with the framework of answer set programming and SAT solving. You can use [clingo](https://potassco.org/clingo/) to check your solutions.

## A.

This set of exercises is taken from Vladimir Lifschitz' book [Answer Set Programming](https://www.cs.utexas.edu/users/vl/teaching/378/ASP.pdf) (Section 3.11).

Solve the following exercises both using SAT solving and using answer set programming.

### A.1. Who owns the fish?

There are five houses of five different colors. In each house lives a person of a different nationality. Each of these five people drinks a certain beverage, smokes a certain brand of cigarettes, and keeps a certain pet. No two people have the same pet, drink the same drink or smoke the same brand. We also know the following:
- The British person lives in the red house.
- The Swedish person keeps a dog.
- The Danish person drinks tea.
- The green house is on the left of the white house.
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

### A.2. Bishops on a Chessboard

How many bishops can be placed on a chessboard so that they do not attack each other?

### A.3. Filling a Grid with Letters

You are given a 5 x 5 grid partially filled with letters A, B, C, D, E and with a question mark in one of the squares.
For instance:

| | **?** | | | |
| --- | --- | --- | --- | --- |
| | | | | **A** |
| | | **B** | | |
| **D** | | **C** | | |
| | | | **E** | |

What letter can replace the question mark if we fill the grid so that each letter is used once in each row, each column, and each of the two diagonals?

### A.4. Packing Squares into a Rectangle

Pack a given set of squares into a given rectangular area without overlaps.

For instance, if we want to pack the squares A of size 4, B of size 3, C and D of size 2, E of size 1 into an area of 5 x 8, then one of the solutions is:

| **A** | **A** | **A** | **A** | **B** | **B** | **B** | |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **A** | **A** | **A** | **A** | **B** | **B** | **B** | |
| **A** | **A** | **A** | **A** | **B** | **B** | **B** | **E** |
| **A** | **A** | **A** | **A** | **C** | **C** | **D** | **D** |
| | | | | **C** | **C** | **D** | **D** |

### A.5. Hitori

In a Hitori puzzle, you are given a square grid with integers appearing in all squares.
The object is to darken some of the squares so that:
- in undarkened squares, no number appears in any row or column more than once,
- darkened squares do not touch each other vertically or horizontally, and
- all undarkened squares are connected to each other.

Write a program that solves Hitori puzzles.
To test your program, run it on the example from
[the Wikipedia article on Hitori](https://en.wikipedia.org/wiki/Hitori).

## B. Knights and knaves

This set of exercises is based on some puzzles from Raymond Smullyan's book [Forever Undecided: A Puzzle Guide To Gödel](https://www.goodreads.com/book/show/493575.Forever_Undecided). Solve these exercises both using SAT solving and answer set programming.

The puzzles take place on the Island of Knights and Knaves, where knights always make true statements, knaves always make false statements, and every inhabitant is either a knight or a knave.

### B.1.
The census taker McGregor once did some fieldwork on the Island of Knights and Knaves. McGregor decided on this visit to interview couples only.

McGregor knocked on one door. One person opened it, and asked McGregor their business. "I am a census taker," replied McGregor, "and I need information about you and your partner. Which, if either, is a knight, and which, if either, is a knave?"

"We are both knaves!" said the person angrily, as he slammed the door.

Which type is the person that opened the door, and which type is their partner?

### B.2.

At the next house, McGregor asked the person opening the door: "Are both of you knaves?" The person replied: "At least one of us is."

Which type is the person that opened the door, and which type is their partner?

### B.3.

The next house visited by McGregor proved more of a puzzler. The door was opened timidly by a rather shy person. After McGregor asked them to say something about themself and their partner, all the person said was: "If I am a knight, then so is my partner."

Which type is the person that opened the door, and which type is their partner?

### B.4.

When McGregor interviewed the fourth couple, the person opening the door said: "My partner and I are of the same type. We are either both knights or both knaves."

What can be deduced about the person opening the door and what can be deduced about the partner?

## C. Chocolate or the tiger

This set of exercises is based on some puzzles from Raymond Smullyan's book [The Lady or the Tiger? And Other Logic Puzzles](https://www.goodreads.com/book/show/678521.The_Lady_or_the_Tiger_And_Other_Logic_Puzzles). Solve these exercises both using SAT solving and answer set programming.

The story starts out as follows.

*Many of you are familiar with Frank Stockton's story "The Lady or the Tiger?," in which the prisoner must choose between two rooms, one of which contains a lady and the other a tiger. If he chooses the former, he marries the lady; if he chooses the latter, he (probably) get eaten by the tiger.*

*The king of a certain land had also read the story, and it gave him an idea. "Just the perfect way to try my prisoners!" he said one day to his minister. "Only, I won't leave it to chance; I'll have signs on the doors of the rooms, and in each case I'll tell the prisoner certain facts about the signs. If the prisoner is clever and can reason logically, he'll save his life&mdash; and win a nice bride to boot!" "Excellent idea!" said the minister.*

(Since not everyone is interested in marrying a lady, we'll replace the lady by some chocolate in these exercises.)

### C.1. The first three trials

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

### C.2. The final trial

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
