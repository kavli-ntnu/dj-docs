%{
# 
-> acquisition.Session
-> acquisition.Session
-> acquisition.ProbeInsertion
-> acquisition.ProbeInsertion
recording_time              : datetime                      # start time of this recording
---
-> reference.RecordingSystem
-> reference.RecordingSystem
-> reference.ElectrodeConfig
-> reference.ElectrodeConfig
recording_order             : smallint                      # the ordering of this recording in this session
recording_duration          : float                         # (s) duration of this recording
recording_name              : varchar(40)                   # name of this recording (e.g. 27032019laserSess1)
%}


classdef Recording < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end