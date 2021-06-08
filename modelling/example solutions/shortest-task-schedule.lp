%%% Problem input

% eight tasks and we can do at most 2 per day
task(1..8).
#const k=2.

% forbid(T,D) states that task T may not be done on day D
forbid(1,3).
forbid(2,3).
forbid(4,3).
forbid(5,3).
forbid(6,3).
forbid(7,3).
forbid(1,4).
forbid(2,4).
forbid(4,4).
forbid(5,4).
forbid(6,4).
forbid(7,4).

%%% Specify what are (candidate) solutions

% Specify what are possible days---that might be needed
% (in the worst case, we cannot do any task on the forbidden days,
% and have to do it all in the days after that)
max_forbidden_day(M) :- M = #max { D : forbid(_,D) }.
num_tasks(N) :- N = #count { task(T) : task(T) }.
max_days_needed(T) :- max_forbidden_day(M), num_tasks(N), T = M + N/k + 1.
possible_day(T) :- max_days_needed(T).
possible_day(T) :- T >= 1, possible_day(T+1).

% Choose a subset of sequential possible days, starting at day 1
{ day(D) : possible_day(D) }.
:- day(D), not day(D-1), D > 1.

% Choose a schedule where each task is done exactly once,
% and each day has at most k tasks
{ do(T,D) : task(T) } k :- day(D).
1 { do(T,D) : day(D) } 1 :- task(T).

% Find out which is the last day
last_day(D) :- day(D), not day(D+1).

% Ensure that the last day must have some task
% (otherwise we could have deleted that day)
:- last_day(D), not do(T,D) : task(T).

% Make sure that we don't do any task on a forbidden day (for that task)
:- forbid(T,D), do(T,D).

%%% Minimization

% Minimize the amount of days used
#minimize { 1,day(D) : day(D) }.

%%% Show only the schedule

#show day/1.
#show do/2.
