/*  CMSC-4200-ASSIGNMENT6
    GROUP 1:
    - MARGO BONAL
    - LUKE RUFFING
    - EVAN THOMPSON
*/

/*Assignment Description:

/*******CODE*******/

% ----Relation Facts-----
married(george, mum).
married(spencer, kydd).
married(elizabeth, philip).
married(diana, charles).
married(anne, mark).
married(andrew, sarah).
married(edward, sophie).








Child()
Male()
Female()


% ----Relation Rules-----
spouse(X, Y) :- married(X, Y).
spouse(X, Y) :- married(Y, X).

sibling(X,Y) :- parent(Z, X), parent(Z, Y), X \= Y.


mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).
brother(X, Y) :- male(X), sibling(X, Y).
sister(X, Y) :- female(X), sibling(X, Y).
son(X, Y) :- male(X), parent(Y, X).
daughter(X, Y) :- female(X), parent(Y, X).



two_sisters(X, Y) :- sister(X, Z), sister(Y, Z), X \= Y.
two_brothers(X, Y) :- brother(X, Z), brother(Y, Z), X \= Y.
three_siblings(X, Y, Z) :- sibling(X, Y), sibling(Y, Z), X \= Z.

married(X) :- spouse(X, _).


grandchild(X, Y) :- parent(Y, Z), parent(Z, X).
great_grandparent(X, Y) :- parent(Y, Z), parent(Z, W), parent(W, X).


brother_in_law(X, Y) :- spouse(Z, X), brother(Z, Y).
sister_in_law(X, Y) :- spouse(Z, X), sister(Z, Y).


aunt(X, Y) :- sibling(X, Z), parent(Z, Y).
uncle(X, Y) :- sibling(X, Z), parent(Z, Y).


has_exactly_two_children(X, Y, Z) :- parent(X, Y), parent(X)