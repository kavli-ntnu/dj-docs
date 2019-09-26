%{
# 
-> reference.TrackingSystemSetup
-> reference.TrackingSystemSetup
calibration_time            : datetime                      # 
---
x_conversion                : float                         # x px-to-cm conversion factor
y_conversion                : float                         # y px-to-cm conversion factor
z_conversion=null           : float                         # z px-to-cm conversion factor
%}


classdef TrackingSystemSetupFOVCalibration < dj.Lookup
end