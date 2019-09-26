%{
# record of animal caging
-> animal.Animal
-> animal.Animal
caging_date                 : datetime                      # date of cage entry
---
-> animal.Cage
-> animal.Cage
-> animal.Person
-> animal.Person
%}


classdef AnimalCaging < dj.Manual
end