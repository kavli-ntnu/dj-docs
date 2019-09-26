%{
# represent a probe model
probe_model                 : varchar(32)                   # nick name, or other user-friendly model name of this probe
---
-> reference.ProbeType
-> reference.ProbeType
%}


classdef ProbeModel < dj.Lookup
end