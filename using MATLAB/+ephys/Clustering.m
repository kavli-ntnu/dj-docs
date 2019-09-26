%{
# A completed clustering analysis
-> ephys.ClusteringSetup
-> ephys.ClusteringSetup
%}


classdef Clustering < dj.Imported

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end