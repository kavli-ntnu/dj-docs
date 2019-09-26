%{
# All units that are skipped in TaskSpikesTracking due to unmet criteria in CellAnalysisMethod
-> behavior.Task
-> behavior.Task
-> ephys.SpikesTrackingProxy
-> ephys.SpikesTrackingProxy
-> `group_shared_analysis_param`.`#cell_selection_params`
-> `group_shared_analysis_param`.`#cell_selection_params`
---
-> ephys.SkipReason
-> ephys.SkipReason
description                 : varchar(1000)                 # 
%}


classdef SkippedTaskSpikesTracking < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end