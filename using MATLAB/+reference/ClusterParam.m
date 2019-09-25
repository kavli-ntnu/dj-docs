%{
# 
-> reference.ClusterMethod
-> reference.ClusterMethod
cluster_param_name          : varchar(36)                   # some unique name, or maybe hash of the dict of the param (ordered)
---
cluster_param_tag           : enum('experimental','final')  # tag this param set for ease of use
%}


classdef ClusterParam < dj.Lookup
end