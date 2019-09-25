%{
# 
-> analysis.TaskSpikesTracking
-> analysis.TaskSpikesTracking
-> analysis.SpatialOccupancy
-> analysis.SpatialOccupancy
-> `group_shared_analysis_param`.`#field_detect_params`
-> `group_shared_analysis_param`.`#field_detect_params`
---
ratemap                     : longblob                      # Smoothed 2D ratemap     # 1     map.z
ratemap_mask                : longblob                      # Mask (where time = 0)   # 1     isnan(map.zRaw)
ratemap_raw                 : longblob                      # Unsmoothed ratemap     # 1      map.zRaw
fieldmap                    : longblob                      # 2     fieldsMap
field_quantity              : smallint                      # 2     size(fields)
peak_rate=null              : float                         # 
mean_rate=null              : float                         # 4
spatial_information_rate=null: float                        # 3     information.rate
spatial_information_content=null: float                     # 3     information.content
spatial_coherence=null      : float                         # 5     coherence
selectivity=null            : float                         # 3     selectivity
sparsity=null               : float                         # 5     sparsity
%}


classdef RateMap < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end