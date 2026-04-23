/*  CMSC-4200-ASSIGNMENT6
    GROUP 1:
    - MARGO BONAL
    - LUKE RUFFING
    - EVAN THOMPSON
*/

/*Assignment Description:

/*******CODE*******/

% ----Relation Facts-----
% -------- SPOUSE --------
spouse(george, mum).
spouse(spencer, kydd).
spouse(elizabeth, philip).
spouse(diana, charles).
spouse(anne, mark).
spouse(andrew, sarah).
spouse(edward, sophie).

% -------- CHILD --------
child(elizabeth, george).
child(elizabeth, mum).
child(margaret, george).
child(margaret, mum).

child(diana, spencer).
child(diana, kydd).

child(charles, elizabeth).
child(charles, philip).
child(anne, elizabeth).
child(anne, philip).
child(andrew, elizabeth).
child(andrew, philip).
child(edward, elizabeth).
child(edward, philip).

child(william, diana).
child(william, charles).
child(harry, diana).
child(harry, charles).

child(peter, anne).
child(peter, mark).
child(zara, anne).
child(zara, mark).

child(beatrice, andrew).
child(beatrice, sarah).
child(eugenie, andrew).
child(eugenie, sarah).

child(louise, edward).
child(louise, sophie).
child(james, edward).
child(james, sophie).

% -------- MALE --------
male(george).
male(spencer).
male(philip).
male(charles).
male(mark).
male(andrew).
male(edward).
male(william).
male(harry).
male(peter).
male(james).

% -------- FEMALE --------
female(mum).
female(kydd).
female(elizabeth).
female(margaret).
female(diana).
female(anne).
female(sarah).
female(sophie).
female(zara).
female(beatrice).
female(eugenie).
female(louise).


% ----Relation Rules-----
parent(X, Y) :- child(Y, X).
spouse(X, Y) :- spouse(Y, X).


sibling(X,Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).

brother(X, Y) :- male(X), sibling(X, Y).
sister(X, Y) :- female(X), sibling(X, Y).

son(X, Y) :- male(X), parent(Y, X).
daughter(X, Y) :- female(X), parent(Y, X).


two_sisters(X, Y) :-
    sister(X, Z),
    sister(Y, Z),
    X \= Y.

two_brothers(X, Y) :-
    brother(X, Z),
    brother(Y, Z),
    X \= Y.

three_siblings(X, Y, Z) :-
    sibling(X, Y),
    sibling(Y, Z),
    sibling(X, Z),
    X \= Y, Y \= Z, X \= Z.




married(X) :- spouse(X, _).

grandchild(X, Y) :-
    parent(Y, Z),
    parent(Z, X).

great_grandparent(X, Y) :-
    parent(Y, Z),
    parent(Z, W),
    parent(W, X).


brother_in_law(X, Y) :-
    spouse(X, Z),
    brother(Z, Y).

sister_in_law(X, Y) :-
    spouse(X, Z),
    sister(Z, Y).



aunt(X, Y) :-
    sister(X, Z),
    parent(Z, Y).

uncle(X, Y) :-
    brother(X, Z),
    parent(Z, Y).



has_exactly_two_children(X, Y, Z) :-
    parent(X, Y),
    parent(X, Z),
    Y \= Z,
    \+ (parent(X, W), W \= Y, W \= Z).