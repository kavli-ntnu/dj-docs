%{
# 
-> reference.ProbeModel
-> reference.ProbeModel
electrode_config_id         : varchar(36)                   # hash of the group and group_member (ensure uniqueness)
---
electrode_config_name       : varchar(16)                   # user friendly name
%}


classdef ElectrodeConfig < dj.Lookup
end