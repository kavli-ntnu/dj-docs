%{
# Since each computer has a different drive mapping this Repository table in conjunction with the 'drive_config' option in DJ config (under 'custom') (per computer) describe the exact location of the data directory
repository                  : varchar(100)                  # e.g. 'Local', 'Network'
%}


classdef Repository < dj.Lookup
end