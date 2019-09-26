%{
# 
-> ephys.CuratedClustering
-> ephys.CuratedClustering
unit                        : smallint                      # 
---
-> reference.ElectrodeConfigElectrode
-> reference.ElectrodeConfigElectrode
-> reference.ClusterType
-> reference.ClusterType
%}


classdef Unit < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end