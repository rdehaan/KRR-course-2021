%% CHOCOLATE OR THE TIGER 1

room(1;2).

tiger(R) :- not chocolate(R), room(R).
chocolate(R) :- not tiger(R), room(R).

true(R) :- not false(R), room(R).
false(R) :- not true(R), room(R).

1 { true(R) : room(R) } 1.

:- not chocolate(1), true(1).
:- not tiger(2), true(1).
true(1) :- chocolate(1), tiger(2).

:- chocolate(R) : room(R); true(2).
:- tiger(R) : room(R); true(2).
true(2) :- 1 { chocolate(R) : room(R) } 1.

#show true/1.
#show false/1.
#show chocolate/1.
#show tiger/1.
