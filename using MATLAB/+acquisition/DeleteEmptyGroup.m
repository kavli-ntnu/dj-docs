%{
# A processing-purpose table to remove ClusterSessionGroup whose sessions have been deleted
-> acquisition.ClusterSessionGroup
-> acquisition.ClusterSessionGroup
%}


classdef DeleteEmptyGroup < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
		%!!! compute missing fields for key here
			 self.insert(key)
		end
	end

end