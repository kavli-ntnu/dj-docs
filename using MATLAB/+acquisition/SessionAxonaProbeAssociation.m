%{
# Association of ProbeInsertion and user-specified probe name (e.g. 'tt_1234')
-> acquisition.Session
-> acquisition.Session
probe_tetrode_name          : varchar(64)                   # short name/alias for the tetrodes of this probe to e.g. 'tt_1234'
---
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
tetrode_numbers             : longblob                      # list of this probe's tetrode numbering in this session (e.g. [5, 6, 7, 8]
%}


classdef SessionAxonaProbeAssociation < dj.Manual
end