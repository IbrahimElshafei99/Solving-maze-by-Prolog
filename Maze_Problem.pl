parent(gateA,gateB).
parent(gateA,gateG).
parent(gateG,gateF).
parent(gateG,gateL).
parent(gateL,gateS).
parent(gateB,gateH).
parent(gateB,gateC).
parent(gateH,gateO).
parent(gateC,gateD).
parent(gateD,gateI).
parent(gateD,gateJ).
parent(gateI,gateP).
parent(gateP,gateQ).
parent(gateJ,gateR).
parent(gateR,home).

:-use_module(library(lists)).

goSolveTheMaze(Start,Goal):-
    path([[Start,null]],[],Goal).

path([],_,_):-
    write('No solution'),nl,!.

path([[Goal,Parent] | _], Closed, Goal):-
    write('A solution is found'), nl ,
    printsolution([Goal,Parent],Closed),!.

path(Open, Closed, Goal):-
    removeFromOpen(Open, [State, Parent], RestOfOpen),
    getchildren(State, Open, Closed, Children),
    append(Children , RestOfOpen, NewOpen),
    path(NewOpen, [[State, Parent] | Closed], Goal).

getchildren(State, Open ,Closed , Children):-
    bagof(X, moves( State, Open, Closed, X), Children), ! .
getchildren(_,_,_, []).


removeFromOpen([State|RestOpen], State, RestOpen).
moves( State, Open, Closed,[Next,State]):-
    parent(State,Next),
    \+ member([Next,_],Open),
    \+ member([Next,_],Closed).

printsolution([State, null],_):-
    write(State).

printsolution([State, Parent], Closed):-
    member([Parent, GrandParent], Closed),
    printsolution([Parent, GrandParent], Closed),
    write(->),write(State).






















