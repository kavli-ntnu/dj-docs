%{
# 
-> acquisition.Session
-> acquisition.Session
tracking_time               : datetime                      # start time of this tracking recording
---
-> tracking.TrackingType
-> tracking.TrackingType
tracking_name               : varchar(40)                   # user-assign name of this tracking (e.g. 27032019laserSess1)
tracking_sample_rate        : float                         # (Hz)
tracking_timestamps         : longblob                      # (s) timestamps of the frame in the tracking system clock, w.r.t the start of this tracking
%}


classdef Tracking < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end