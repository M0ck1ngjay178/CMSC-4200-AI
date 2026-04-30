/*  CMSC-4200-ASSIGNMENT6
    GROUP 1:
    - MARGO BONAL
    - LUKE RUFFING
    - EVAN THOMPSON
*/

% *******CODE*******

% ----Relation Facts------------------------------------

% -------- SPOUSE --------
spouse(george,mum).
spouse(mum,george).

spouse(spencer,kydd).
spouse(kydd,spencer).

spouse(elizabeth,philip).
spouse(philip,elizabeth).

spouse(diana,charles).
spouse(charles,diana).

spouse(anne,mark).
spouse(mark,anne).

spouse(andrew,sarah).
spouse(sarah,andrew).

spouse(edward,sophie).
spouse(sophie,edward).

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

% ----END Relation Facts------------------------------------

% ----Relation Rules-----
parent(X, Y) :- child(Y, X).

mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).

sibling(X, Y) :-
    parent(P, X), parent(P, Y), X\=Y.

brother(X, Y) :- male(X), sibling(X, Y).

sister(X, Y) :- female(X), sibling(X, Y).

son(X, Y) :- male(X), parent(Y, X).

daughter(X, Y) :- female(X), parent(Y, X).

married(X) :- spouse(X, _).

grandchild(X, Y) :- parent(Y, Z), parent(Z, X).

great_grandparent(X, Y) :- parent(X, Z), parent(Z, W), parent(W, Y).

%Spouses Brother
brother_in_law(X, Y) :- spouse(Y, Z), brother(X, Z).

%Spouses Siblings Husband
brother_in_law(X, Y) :- spouse(Y, Z), sibling(Z, W), spouse(W, X), male(X).

%Siblings Spouse
brother_in_law(X, Y) :- sibling(Y, Z), spouse(Z, X), male(X).

%Spouses Sister
sister_in_law(X, Y) :- spouse(Y, Z), sister(X, Z).

%Spouses Siblings Wife
sister_in_law(X, Y) :- spouse(Y, Z), sibling(Z, W), spouse(W, X), female(X).

%Siblings Spouse
sister_in_law(X, Y) :- sibling(Y, Z), spouse(Z, X), female(X).

aunt(X, Y) :- sister(X, Z), parent(Z, Y).

uncle(X, Y) :- brother(X, Z), parent(Z, Y).

two_sisters(X, Y) :- sibling(X, Y), female(X), female(Y).

two_brothers(X, Y) :- sibling(X, Y), male(X), male(Y).

three_siblings(X, Y, Z) :- sibling(X, Y), sibling(Y, Z), sibling(X, Z), X \= Y, Y \= Z, X \= Z.

has_exactly_two_children(X, Y, Z) :- parent(X, Y), parent(X, Z), Y \= Z, \+ (parent(X, W), W \= Y, W \= Z).
