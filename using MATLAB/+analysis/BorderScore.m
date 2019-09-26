%{
# 
-> analysis.RateMap
-> analysis.RateMap
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#score_params`
---
border_score                : float                         # 
border_coverage             : float                         # 
%}


classdef BorderScore < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end