%{
# 
sync_method                 : varchar(16)                   # sync method name
---
sync_method_description     : varchar(128)                  # long description
%}


classdef SyncMethod < dj.Lookup
end