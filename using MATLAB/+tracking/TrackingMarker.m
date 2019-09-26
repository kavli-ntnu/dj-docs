%{
# 
-> tracking.Tracking
-> tracking.Tracking
marker_name                 : varchar(32)                   # 
---
position_x                  : longblob                      # (px)
position_y                  : longblob                      # (px)
position_z=null             : longblob                      # (px)
%}


classdef TrackingMarker < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end