%{
# 
-> tracking.Tracking
-> tracking.Tracking
---
sync_master_clock           : varchar(16)                   # name of the sync-master
track_sync_data=null        : longblob                      # sync data (binary)
track_time_zero=null        : float                         # (s) the first time point of this tracking
track_sync_timestamps=null  : longblob                      # (s) timestamps of sync data in tracking clock
track_sync_master_timestamps=null: longblob                 # (s) timestamps of sync data in master clock
%}


classdef TrackingTrackingSync < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end