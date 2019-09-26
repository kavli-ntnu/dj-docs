%{
# 
-> `prod_mlims_data`.`animal`
-> `prod_mlims_data`.`animal`
insertion_time              : datetime                      # When this probe was inserted
---
-> reference.Probe
-> reference.Probe
insertion_note              : varchar(1000)                 # some notes
%}


classdef ProbeInsertion < dj.Manual
end