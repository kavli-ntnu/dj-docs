%{
# 
animal_id                   : char(16)                      # 
datasource_id=0             : int                           # 
---
animal_species              : varchar(16)                   # 
animal_name                 : varchar(128)                  # 
animal_sex                  : enum('M','F','U')             # 
animal_dob=null             : date                          # 
-> animal.AnimalColor
-> animal.AnimalColor
%}


classdef Animal < dj.Manual
end