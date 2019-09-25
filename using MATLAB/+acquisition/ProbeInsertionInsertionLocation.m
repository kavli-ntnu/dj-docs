%{
# 
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
---
-> reference.BrainArea
-> reference.BrainArea
hemisphere                  : enum('left','right')          # 
-> reference.SkullReference
-> reference.SkullReference
ml_location=null            : float                         # (um) relative to the skull-reference
ap_location=null            : float                         # (um) relative to the skull-reference
dv_location=null            : float                         # (um) relative to the surface of the dura at the implant location
ml_angle=null               : float                         # (degree)
ap_angle=null               : float                         # (degree)
%}


classdef ProbeInsertionInsertionLocation < dj.Manual
end