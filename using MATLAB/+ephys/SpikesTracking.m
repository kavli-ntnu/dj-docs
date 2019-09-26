%{
# Synced spike times and tracking for each unit (all time relative to the session this recording belongs to)
-> ephys.UnitSpikeTimes
-> ephys.UnitSpikeTimes
-> tracking.ProcessedTracking
-> tracking.ProcessedTracking
---
spike_times                 : longblob                      # (s) repeat of SyncedSpikeTimes (for convenient queries)
speed                       : longblob                      # (cm/s) tracked speed at each spike times (time with respect to the start of session)
x_pos                       : longblob                      # (cm) tracked x-pos at each spike times (time with respect to the start of session)
y_pos                       : longblob                      # (cm) tracked y-pos at each spike times (time with respect to the start of session)
z_pos=null                  : longblob                      # (cm) tracked z-pos at each spike times (time with respect to the start of session)
head_yaw                    : longblob                      # (degree) tracked head yaw at each spike times (time with respect to the start of session)
head_pitch=null             : longblob                      # (degree) tracked head pitch at each spike times (time with respect to the start of session)
head_roll=null              : longblob                      # (degree) tracked head roll at each spike times (time with respect to the start of session)
angular_speed=null          : longblob                      # (degree/s) tracked head angular speed at each spike times (time with respect to the start of session)
%}


classdef SpikesTracking < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end