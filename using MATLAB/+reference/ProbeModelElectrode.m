%{
# 
-> reference.ProbeModel
-> reference.ProbeModel
electrode                   : int                           # electrode
---
x_coord=null                : float                         # (um) x coordinate of the electrode within the probe
y_coord=null                : float                         # (um) y coordinate of the electrode within the probe
z_coord=null                : float                         # (um) z coordinate of the electrode within the probe
%}


classdef ProbeModelElectrode < dj.Lookup
end