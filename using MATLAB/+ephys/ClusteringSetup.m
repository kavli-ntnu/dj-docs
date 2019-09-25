%{
# 
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
-> acquisition.ClusterTimeWindows
-> acquisition.ClusterTimeWindows
-> reference.ClusterParam
-> reference.ClusterParam
-> reference.ElectrodeConfig
-> reference.ElectrodeConfig
-> reference.SyncMethod
-> reference.SyncMethod
---
-> reference.Repository
-> reference.Repository
clustering_output_dir       : varchar(128)                  # 
routine="trigger"           : enum('trigger','import')      # 
is_synced=1                 : tinyint                       # is the clustering output synced to master? - yes if triggered by DataJoint
%}


classdef ClusteringSetup < dj.Manual
end