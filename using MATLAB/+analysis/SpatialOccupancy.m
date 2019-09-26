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
spatial_occupancy           : longblob                      # Smoothed 2D occupancy map             # map.time
spatial_occupancy_mask      : longblob                      # Mask (where time = 0)                 # isnan(map.timeRaw)
spatial_occupancy_raw       : longblob                      # Raw, non-smoothed 2D occupancy map    # map.timeRaw
x_edges                     : longblob                      # Histogram edges in x                  # map.x
y_edges                     : longblob                      # Histogram edges in y                  # map.y
coverage                    : float                         # fraction of the arena the animal covered
%}


classdef SpatialOccupancy < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end