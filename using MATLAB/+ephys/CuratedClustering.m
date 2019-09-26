%{
# A completed curation for a particular clustering
-> ephys.Clustering
-> ephys.Clustering
curation_timestamps         : datetime                      # ensure complete datetime here to prevent collision (in the rare case of multiple people curate at the exact same datetime)
---
 (curator) -> reference.Experimenter
 (curator) -> reference.Experimenter
curation_notes              : varchar(128)                  # 
-> reference.Repository
-> reference.Repository
curation_output_dir         : varchar(128)                  # 
%}


classdef CuratedClustering < dj.Manual
end