% You are responsible for scheduling computer science classes that meet on Tuesday and Thursday.
% There are 8 classes that meet on these days and 4 professors who will be teaching these classes in which each professor will teach two classes.
% The classes are CMSC1200, CMSC1240, CMSC2040, CMSC3040, CMSC3100, CMSC3140, CMSC4000, CMSC4200.
% Classes meeting times are during 4 time slots:  TU8:00-9:15AM, TU9:30-10:45AM, TU12:30-1:45PM, TU2:00-3:15PM.
% The professors are:
%	Professor 1 who is qualified to teach classes CMSC1200, CMSC3040, CMSC4000, and CMSC4200. He cannot teach at 8:00-9:15am.
%	Professor 2 who is qualified to teach classes CMSC1200, CMSC1240, CMSC3040, CMSC3140, and CMSC4000. He cannot teach at 2:00-3:15pm.
%	Professor 3 who is qualified to teach classes CMSC1200 and CMSC3100.
%	Professor 4 who is qualified to teach classes CMSC1240, CMSC2040, and CMSC4200.

%   Possible Classes, Times, and Professors
enum CLASS = {CMSC1200, CMSC1240, CMSC2040, CMSC3040, CMSC3100, CMSC3140, CMSC4000, CMSC4200};
enum TIME = {t_8to915, t_930to1045, t_1230to145, t_2to315};
enum PROFESSOR = {P1, P2, P3, P4};

%   Each class will get a time
array[CLASS] of var TIME: class_time;

%   Each class will get a professor
array[CLASS] of var PROFESSOR: teaches;

%   Each professor teaches 2 classes
constraint forall(p in PROFESSOR)(
    count(teaches, p) == 2
);

%   No professor teaches two classes at same time
constraint forall(c1, c2 in CLASS where c1 < c2)(
  (teaches[c1] == teaches[c2]) ->
  (class_time[c1] != class_time[c2])
);

%	Professor 1 who is qualified to teach classes CMSC1200, CMSC3040, CMSC4000, and CMSC4200. He cannot teach at 8:00-9:15am.
constraint teaches[CMSC1240] != P1;
constraint teaches[CMSC2040] != P1;
constraint teaches[CMSC3100] != P1;
constraint teaches[CMSC3140] != P1;
constraint forall(c in CLASS)(
    (teaches[c] == P1) -> (class_time[c] != t_8to915)
);

%	Professor 2 who is qualified to teach classes CMSC1200, CMSC1240, CMSC3040, CMSC3140, and CMSC4000. He cannot teach at 2:00-3:15pm.
constraint teaches[CMSC2040] != P2;
constraint teaches[CMSC3100] != P2;
constraint teaches[CMSC4200] != P2;
constraint forall(c in CLASS)(
    (teaches[c] == P2) -> (class_time[c] != t_2to315)
);

%	Professor 3 who is qualified to teach classes CMSC1200 and CMSC3100.
constraint teaches[CMSC1240] != P3;
constraint teaches[CMSC2040] != P3;
constraint teaches[CMSC3040] != P3;
constraint teaches[CMSC3140] != P3;
constraint teaches[CMSC4000] != P3;
constraint teaches[CMSC4200] != P3;

%	Professor 4 who is qualified to teach classes CMSC1240, CMSC2040, and CMSC4200.
constraint teaches[CMSC1200] != P4;
constraint teaches[CMSC3040] != P4;
constraint teaches[CMSC3100] != P4;
constraint teaches[CMSC3140] != P4;
constraint teaches[CMSC4000] != P4;

%   Solve the problem
solve satisfy;

%   Map times to more readble strings
array[TIME] of string: time_names = [
  "8:00-9:15AM",
  "9:30-10:45AM",
  "12:30-1:45PM",
  "2:00-3:15PM"
];

%   Output
output [
  "Professor 1 Schedule: " ++ show([ (c, time_names[fix(class_time[c])]) | c in CLASS where fix(teaches[c]) == P1 ]) ++ "\n" ++
  "Professor 2 Schedule: " ++ show([ (c, time_names[fix(class_time[c])]) | c in CLASS where fix(teaches[c]) == P2 ]) ++ "\n" ++
  "Professor 3 Schedule: " ++ show([ (c, time_names[fix(class_time[c])]) | c in CLASS where fix(teaches[c]) == P3 ]) ++ "\n" ++
  "Professor 4 Schedule: " ++ show([ (c, time_names[fix(class_time[c])]) | c in CLASS where fix(teaches[c]) == P4 ])
];
