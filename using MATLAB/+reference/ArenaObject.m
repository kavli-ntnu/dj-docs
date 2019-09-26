%{
# 
arena_object                : varchar(32)                   # 
---
obj_geometry                : varchar(16)                   # e.g. cube, cylinder
obj_width                   : float                         # (cm)
obj_length                  : float                         # (cm)
obj_height                  : float                         # (cm)
%}


classdef ArenaObject < dj.Lookup
end