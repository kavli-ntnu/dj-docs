%{
# Spike times and tracking for a particular behavior.Task, relative to the start of task (i.e. task start at t=0)
-> behavior.Task
-> behavior.Task
-> ephys.SpikesTrackingProxy
-> ephys.SpikesTrackingProxy
-> `group_shared_analysis_param`.`#cell_selection_params`
-> `group_shared_analysis_param`.`#cell_selection_params`
---
spike_times                 : longblob                      # (s) task-related spike times (time with respect to the start of the task)
speed                       : longblob                      # (cm/s) task-related speed at each spike times
x_pos                       : longblob                      # (cm) task-related x-pos at each spike times
y_pos                       : longblob                      # (cm) task-related y-pos at each spike times
z_pos=null                  : longblob                      # (cm) task-related z-pos at each spike times
head_yaw                    : longblob                      # (degree) task-related head yaw (left/right angle) at each spike times
head_pitch=null             : longblob                      # (degree) task-related head pitch (up/down) at each spike times
head_roll=null              : longblob                      # (degree) task-related head roll (clockwise/anticlockwise) at each spike times
angular_speed=null          : longblob                      # (degree/s) task-related head angular speed at each spike times
%}


classdef TaskSpikesTracking < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end