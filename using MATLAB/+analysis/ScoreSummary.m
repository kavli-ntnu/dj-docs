%{
# 
-> `group_shared_analysis_param`.`#analysis_package`
-> `group_shared_analysis_param`.`#analysis_package`
-> analysis.GridScore
-> analysis.SpeedScore
-> analysis.SpeedScore
-> analysis.HDTuning
-> analysis.GridScore
-> analysis.SpeedScore
-> analysis.SpeedScore
-> analysis.HDTuning
---
grid_score                  : float                         # 
border_score                : float                         # 
speed_score                 : float                         # 
hd_tuning                   : float                         # 
%}


classdef ScoreSummary < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end