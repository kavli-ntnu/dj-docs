%{
# position of the pivot point, or rigid body
-> tracking.ProcessedTracking
-> tracking.ProcessedTracking
---
position_x                  : longblob                      # (cm)
position_y                  : longblob                      # (cm)
position_z=null             : longblob                      # (cm)
speed                       : longblob                      # (cm/s)
%}


classdef ProcessedTrackingPosition < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end