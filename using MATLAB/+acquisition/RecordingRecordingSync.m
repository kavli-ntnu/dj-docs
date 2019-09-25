%{
# 
-> acquisition.Recording
-> acquisition.Recording
---
sync_master_clock           : varchar(16)                   # name of the sync-master
rec_sync_signal=null        : longblob                      # actual sync data (binary)
rec_time_zero=null          : float                         # (s) the first time point of this recording
rec_sync_timestamps=null    : longblob                      # (s) timestamps of sync signal in recording clock (probably the master clock itself)
rec_sync_master_timestamps=null: longblob                   # (s) timestamps of sync data in master clock
%}


classdef RecordingRecordingSync < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end