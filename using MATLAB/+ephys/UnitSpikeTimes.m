%{
# 
-> ephys.Unit
-> ephys.Unit
-> acquisition.Recording
-> acquisition.Recording
---
mean_firing_rate            : float                         # mean firing rate
spike_counts                : int                           # how many spikes in this recording of this unit
unit_spike_times            : longblob                      # (s) spike times of this unit, relative to the start of the session this recording belongs to
%}


classdef UnitSpikeTimes < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end