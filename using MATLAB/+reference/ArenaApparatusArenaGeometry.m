%{
# 
-> reference.ArenaApparatus
-> reference.ArenaApparatus
---
arena_geometry              : enum('square','rectangle','circle') # 
arena_x_dim=null            : float                         # (cm)
arena_y_dim=null            : float                         # (cm)
wall_height=null            : float                         # (cm)
%}


classdef ArenaApparatusArenaGeometry < dj.Lookup
end