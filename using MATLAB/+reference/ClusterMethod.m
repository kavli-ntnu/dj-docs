%{
# 
cluster_method              : varchar(16)                   # name of clustering method
---
cluster_method_description  : varchar(1024)                 # longer description about the method
%}


classdef ClusterMethod < dj.Lookup
end