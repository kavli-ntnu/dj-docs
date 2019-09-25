%{
# All units that are skipped in SpikesTracking due to time mismatched of Recording and Tracking
-> ephys.UnitSpikeTimes
-> ephys.UnitSpikeTimes
-> tracking.ProcessedTracking
-> tracking.ProcessedTracking
---
-> ephys.SkipReason
-> ephys.SkipReason
description                 : varchar(1000)                 # 
%}


classdef SkippedSpikesTracking < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end