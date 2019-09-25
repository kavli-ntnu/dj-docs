%{
# 
-> analysis.RateMap
-> analysis.RateMap
-> `group_shared_analysis_param`.`#score_params`
-> `group_shared_analysis_param`.`#score_params`
---
auto_corr                   : longblob                      # 1
grid_score=null             : float                         # 2     score
grid_spacings               : longblob                      # 2     stats.spacing
grid_orientations           : longblob                      # 2     stats.orientations
grid_ellipse                : longblob                      # 2     stats.ellipse
grid_ellipse_theta=null     : float                         # 2     stats.ellipseTheta
grid_ellipse_aspect_ratio=null: float                       # Not explicitly calculated in BNT
%}


classdef GridScore < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end