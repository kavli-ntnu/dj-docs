%{
# 
-> acquisition.Recording
-> acquisition.Recording
---
lfp_sample_rate             : float                         # (Hz)
 (lfp_time_stamps) -> ephys.ExternalEphysStore
 (lfp_time_stamps) -> ephys.ExternalEphysStore
 (lfp_mean) -> ephys.ExternalEphysStore
 (lfp_mean) -> ephys.ExternalEphysStore
%}


classdef LFP < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end