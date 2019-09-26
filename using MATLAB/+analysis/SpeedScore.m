%{
# 
-> analysis.TaskSpikesTracking
-> analysis.TaskSpikesTracking
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#analysis_package`
-> `group_shared_analysis_param`.`#analysis_package`
---
speed_score                 : float                         # 
%}


classdef SpeedScore < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end