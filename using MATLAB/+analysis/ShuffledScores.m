%{
# 
-> analysis.TaskSpikesTracking
-> analysis.TaskSpikesTracking
-> `group_shared_analysis_param`.`#shuffle_params`
-> `group_shared_analysis_param`.`#shuffle_params`
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#smoothing_params`
-> `group_shared_analysis_param`.`#smoothing_params`
-> `group_shared_analysis_param`.`#field_detect_params`
-> `group_shared_analysis_param`.`#field_detect_params`
-> `group_shared_analysis_param`.`#occupancy_params`
-> `group_shared_analysis_param`.`#occupancy_params`
-> `group_shared_analysis_param`.`#analysis_package`
-> `group_shared_analysis_param`.`#analysis_package`
---
grid_scores                 : longblob                      # 
border_scores               : longblob                      # 
speed_scores                : longblob                      # 
hd_scores                   : longblob                      # 
%}


classdef ShuffledScores < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end