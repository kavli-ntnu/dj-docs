%{
# 
-> ephys.LFP
-> ephys.LFP
-> reference.ElectrodeConfigElectrode
-> reference.ElectrodeConfigElectrode
---
 (lfp) -> ephys.ExternalEphysStore
 (lfp) -> ephys.ExternalEphysStore
%}


classdef LFPChannelLFP < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end