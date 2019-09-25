%{
# Association of ProbeInsertion and user-specified probe name (e.g. 'probe_1')
-> acquisition.Session
-> acquisition.Session
probe_output_dir_name       : varchar(64)                   # e.g. 'probe_1'
---
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
%}


classdef SessionNeuropixelsProbeAssociation < dj.Manual
end