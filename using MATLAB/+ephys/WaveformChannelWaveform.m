%{
# 
-> ephys.Waveform
-> ephys.Waveform
-> reference.ProbeModelElectrode
-> reference.ProbeModelElectrode
---
waveform_mean               : longblob                      # mean over all spikes
 (waveforms) -> ephys.ExternalEphysStore
 (waveforms) -> ephys.ExternalEphysStore
waveform_std=null           : longblob                      # std over all spikes
waveform_maxima=null        : longblob                      # max over all spikes
%}


classdef WaveformChannelWaveform < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end