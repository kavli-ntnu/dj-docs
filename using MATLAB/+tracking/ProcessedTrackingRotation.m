%{
# rotation of the pivot point, or rigid body
-> tracking.ProcessedTracking
-> tracking.ProcessedTracking
---
q_x                         : longblob                      # 
q_y                         : longblob                      # 
q_z                         : longblob                      # 
q_w                         : longblob                      # 
%}


classdef ProcessedTrackingRotation < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end