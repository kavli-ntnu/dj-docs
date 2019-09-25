%{
# Processed tracking data for one rigid body
-> tracking.Tracking
-> tracking.Tracking
-> tracking.TrackingProcessingMethod
-> tracking.TrackingProcessingMethod
-> reference.SyncMethod
-> reference.SyncMethod
---
synced_tracking_start       : decimal(6,2)                  # (s) timestamp of tracking onset with respect to the start of the session
synced_tracking_stop        : decimal(6,2)                  # (s) timestamp of tracking offset with respect to the start of the session
synced_tracking_timestamps  : longblob                      # (s) synced tracking timestamps, relative to the start of this session
fov_calibration_used        : tinyint                       # 
%}


classdef ProcessedTracking < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end