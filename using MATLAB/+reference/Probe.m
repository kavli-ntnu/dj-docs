%{
# represent a physical probe
probe                       : varchar(32)                   # unique identifier of this probe (e.g. serial number)
---
-> reference.ProbeModel
-> reference.ProbeModel
%}


classdef Probe < dj.Lookup
end