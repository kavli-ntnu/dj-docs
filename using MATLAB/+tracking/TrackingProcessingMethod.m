%{
# 
tracking_processing_method  : varchar(16)                   # 
---
tracking_processing_description: varchar(1000)              # 
tracking_processing_parameters: longblob                    # 
%}


classdef TrackingProcessingMethod < dj.Lookup
end