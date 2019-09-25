%{
# 
-> analysis.RateMap
-> analysis.RateMap
field_no                    : smallint                      # 
---
field_area                  : smallint                      # Area in number of bins   # fields(i).area
field_coords                : longblob                      # Field bin coordinates    # fields(i).posInd
field_peak_rate             : float                         # Field peak value (rate)   # fields(i).peak
field_mean_rate             : float                         # Field mean value (rate)   # fields(i). meanRate
field_center_x              : float                         # Center x coordinate       # fields(i).x
field_center_y              : float                         # Center y coordinate       # fields(i).y
field_map                   : longblob                      # Binary map of field       #fields(i).map
%}


classdef RateMapFiringFields < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end