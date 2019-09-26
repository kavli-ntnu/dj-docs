%{
# 
spike_tracking_hash         : varchar(32)                   # hash of the SpikesTracking primary_key
---
-> ephys.SpikesTracking
-> ephys.SpikesTracking
%}


classdef SpikesTrackingProxy < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end