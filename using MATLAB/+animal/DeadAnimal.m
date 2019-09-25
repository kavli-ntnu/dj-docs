%{
# 
-> animal.Animal
-> animal.Animal
---
death_date=null             : date                          # 
death_type                  : enum('Dead','Sacrificed')     # TODO
death_age                   : varchar(255)                  # age at death in string format (e.g. 1yr5m10d)
death_cause                 : varchar(255)                  # succinct cause of the death (e.g. sacrificed)
death_notes                 : varchar(8192)                 # additional notes about the death
%}


classdef DeadAnimal < dj.Manual
end