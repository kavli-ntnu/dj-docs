%{
# 
tracking_system_setup       : varchar(64)                   # user-readable identifier of this setup (e.g. 'room_1_setup')
---
-> reference.TrackingSystemType
-> reference.TrackingSystemType
setup_description           : varchar(1000)                 # 
%}


classdef TrackingSystemSetup < dj.Lookup
end