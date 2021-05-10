## Guide for modelling and solving problems

This guide highlights the main steps to take when modelling and solving a problem using ASP.

*Note:* depending on the problem that you're solving (and how detailed the description of the problem already is, for example), some steps may be easy/trivial. Don't panic. This guide is intended as a checklist of subtasks that might come up when solving any given problem.

The main steps are:
1. Formalize the problem
1. Establish encoding of problem instances
1. Establish encoding of candidate solutions (*generate*)
1. Establish encoding of solution properties (*test*)
1. Optional: add optimization statements

## 1. Formalize the problem

In this step, the goal is to *precisely* describe what the problem is.
If the problem that you're solving is already described precisely and in detail,
this step is already done.

The main questions to consider and answer in this step are:
- What is the problem input?
- What kind of objects are (candidate) solutions?
- What properties do solutions need to have?
- What (if anything) are you optimizing for?

## 2. Establish encoding of problem instances

In this step, the goal is to determine how to represent the problem input in ASP.

The main questions to consider and answer in this step are:
- What predicates to use to represent the problem input? What arity do they have?
- What constants to use to represent the problem input?
- How to translate the problem input to facts that use these predicates and constants?

## 3. Establish encoding of candidate solutions (*generate*)

In this step, the goal is to determine how to encode the structure of candidate solutions.

The main questions to consider and answer in this step are:
- What predicates to use to represent candidate solutions? What arity do they have?
- What rules/constraints to add to your program so that the answer sets of the program correspond to (all) candidate solutions?
- Do you need any auxiliary predicates/rules/constraints to express some properties that candidate solutions should have?

## 4. Establish encoding of solution properties (*test*)

In this step, the goal is to determine how to encode the properties that determine which candidate solutions are actual solutions, and to filter out non-solutions.

The main questions to consider and answer in this step are:
- What rules/constraints to add to your program so that only answer sets remain that correspond to actual solutions?
- Do you need any auxiliary predicates/rules/constraints to express some properties that actual solutions should have?

## 5. Optional: add optimization statements

In this step, the goal is to determine how to encode any optimization statements that the problem may involve.

The main questions to consider and answer in this step are:
- What optimization statements to add to your program so that the optimal answer sets correspond to optimal solutions?
- Do you need any auxiliary predicates/rules to express some properties involved in the optimization statement?
