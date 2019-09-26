%{
# Association of ProbeInsertion and user-specified probe name (e.g. 'probe_1')
-> acquisition.Session
-> acquisition.Session
probe_channel_name          : varchar(64)                   # short name/alias for the channels this probe is mapped to e.g. 'p_0_2_4_6'
---
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
probe_channels              : longblob                      # list of all the channels this probe is mapped to
%}


classdef SessionNeurologgerProbeAssociation < dj.Manual
end