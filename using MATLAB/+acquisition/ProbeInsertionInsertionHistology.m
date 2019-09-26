%{
# histology images (if applicable) for this probe insertion
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
img_id                      : smallint                      # 
---
histology_img               : longblob                      # 
%}


classdef ProbeInsertionInsertionHistology < dj.Manual
end