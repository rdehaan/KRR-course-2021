%% WOLF, GOAT AND CABBAGE

#const t=8.
time(1..t).
side(left;right).
otherside(left,right).
otherside(right,left).
item(wolf;goat;cabbage).

at(1,I,left) :- item(I).

at(T,boat,left) :- time(T), T \ 2 = 1.
at(T,boat,right) :- time(T), T \ 2 = 0.

{ carry(T,I) : item(I) } 1 :- time(T), T < t.

:- carry(T,I), side(S), at(T,boat,S), not at(T,I,S).

goal_reached(T) :- time(T), at(T,boat,right), at(T,I,right) : item(I).

at(T2,I,S) :-
    time(T1), time(T2), item(I), T2 = T1+1,
    at(T1,I,S), not carry(T1,I).
at(T2,I,S2) :-
    time(T1), time(T2), item(I), T2 = T1+1,
    at(T1,I,S1), carry(T1,I), otherside(S1,S2).

:- time(T), at(T,boat,S1), otherside(S1,S2), at(T,wolf,S2), at(T,goat,S2).
:- time(T), at(T,boat,S1), otherside(S1,S2), at(T,cabbage,S2), at(T,goat,S2).

:- not goal_reached(t).

#show carry/2.
