%{
# 
-> behavior.Task
-> behavior.Task
-> tracking.ProcessedTracking
-> tracking.ProcessedTracking
-> `group_shared_analysis_param`.`#occupancy_params`
-> `group_shared_analysis_param`.`#occupancy_params`
-> `group_shared_analysis_param`.`#smoothing_params`
-> `group_shared_analysis_param`.`#smoothing_params`
-> `group_shared_analysis_param`.`#analysis_package`
-> `group_shared_analysis_param`.`#analysis_package`
---
angular_occupancy           : longblob                      # Smoothed 1D occupancy                        # tc(:,3)
angular_occupancy_raw       : longblob                      # Raw, non-smoothed 1D occupancy               # Not explicitly output
angular_occupancy_mask      : longblob                      # Mask (where count for that bin is 0) - ie animal never there # Not explicitly output
angle_coverage              : float                         # Fraction of angles that the animal covered   # Not explicitly output
angle_edges                 : longblob                      # Histogram edges in radians                   # Not explicitly outouyt
angle_centers               : longblob                      # Histogram bin centers in radians             # tc(:, 1)
%}


classdef AngularOccupancy < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end