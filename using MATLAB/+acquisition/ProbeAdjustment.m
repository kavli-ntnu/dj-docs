%{
# 
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
adjustment_time             : datetime                      # 
---
-> acquisition.Session
-> acquisition.Session
-> reference.Experimenter
-> reference.Experimenter
estimated_depth_change=null : float                         # (um) positive: moving more dorsal (shallower), negative: moving more ventral (deeper)
adjustment                  : varchar(128)                  # new depth (ideally)
%}


classdef ProbeAdjustment < dj.Manual
end