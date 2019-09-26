%{
# 
-> analysis.TaskSpikesTracking
-> analysis.TaskSpikesTracking
-> analysis.AngularOccupancy
-> analysis.AngularOccupancy
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#score_params`
---
hd_tuning                   : longblob                      # Smoothed 1D ratemap              # 1 tc(:, 2)
hd_tuning_mask              : longblob                      # 1 isnan(tc(:,2))
hd_tuning_raw               : longblob                      # Raw, binned spikes               # Not explicitly calculated
hd_score=null               : float                         # head direction score     # 2 tcStat.score
hd_mvl=null                 : float                         # mean vector length       # 2 tcStat.r
hd_mean_direction=null      : float                         # in degrees               # 2 tcStat.mean
hd_peak_direction=null      : float                         # Angle with peak rate      # 2 tcStat.peakDirection
hd_peak_rate=null           : float                         # Rate at peak angle        # 2 tcStat.peakRate
hd_stdev=null               : float                         # Angular standard deviation# Not explicitly calculated
%}


classdef HDTuning < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end