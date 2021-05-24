house(1..5).
adjacent(1,2).
adjacent(2,3).
adjacent(3,4).
adjacent(4,5).
adjacent(H1,H2) :- adjacent(H2,H1).
person(brit;swede;dane;norwegian;german).
color(red;white;yellow;blue;green).
beverage(tea;milk;water;coffee;beer).
brand(pallmall;dunhill;bluemaster;princess;blend).
animal(dog;birds;cats;horses;fish).

1 { has_color(H,C) : color(C) } 1 :- house(H).
1 { has_color(H,C) : house(H) } 1 :- color(C).

1 { owns_house(P,H) : house(H) } 1 :- person(P).
1 { owns_house(P,H) : person(P) } 1 :- house(H).

1 { smokes(P,B) : brand(B) } 1 :- person(P).
1 { smokes(P,B) : person(P) } 1 :- brand(B).

1 { drinks(P,D) : beverage(D) } 1 :- person(P).
1 { drinks(P,D) : person(P) } 1 :- beverage(D).

1 { has_pet(P,A) : animal(A) } 1 :- person(P).
1 { has_pet(P,A) : person(P) } 1 :- animal(A).

% If the brit owns a house, then it must be red
% (it cannot be the case that the brit owns a house that is not red)
:- house(H), owns_house(brit,H), not has_color(H,red).

% The swede must have a dog
% (it cannot be the case that the swede does not have a dog)
:- not has_pet(swede,dog).

% The dane must drink tea
% (it cannot be the case that the dane does not drink tea)
:- not drinks(dane,tea).

% etc.
:- house(H1), house(H2), has_color(H1,white), has_color(H2,green), H2 != H1 - 1.
:- house(H), owns_house(P,H), has_color(H,green), not drinks(P,coffee).
:- person(P), has_pet(P,birds), not smokes(P,pallmall).
:- house(H), has_color(H,yellow), owns_house(P,H), not smokes(P,dunhill).
:- owns_house(P,3), not drinks(P,milk).
:- not owns_house(norwegian,1).
:- smokes(P1,blend), has_pet(P2,cats), owns_house(P1,H1), owns_house(P2,H2), not adjacent(H1,H2).
:- smokes(P1,dunhill), has_pet(P2,horses), owns_house(P1,H1), owns_house(P2,H2), not adjacent(H1,H2).
:- smokes(P,bluemaster), not drinks(P,beer).
:- not smokes(german,princess).
:- owns_house(norwegian,H1), has_color(H2,blue), not adjacent(H1,H2).
:- smokes(P1,blend), owns_house(P1,H1), drinks(P2,water), owns_house(P2,H2), not adjacent(H1,H2).

#show has_color/2.
#show owns_house/2.
#show smokes/2.
#show drinks/2.
#show has_pet/2.
