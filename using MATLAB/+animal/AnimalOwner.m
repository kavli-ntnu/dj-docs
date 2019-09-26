%{
# record of animal owners
-> animal.Animal
-> animal.Animal
owner_date                  : datetime                      # date of owner change
---
-> animal.Person
-> animal.Person
%}


classdef AnimalOwner < dj.Manual
end