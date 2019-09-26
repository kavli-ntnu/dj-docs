%{
# 
-> tracking.ProcessedTracking
-> tracking.ProcessedTracking
---
head_yaw                    : longblob                      # (radian)
head_pitch=null             : longblob                      # (radian)
head_roll=null              : longblob                      # (radian)
angular_speed               : longblob                      # (radian/s)
%}


classdef ProcessedTrackingHeadAngle < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end