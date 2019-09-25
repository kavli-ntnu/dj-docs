%{
# 
-> reference.ArenaApparatus
-> reference.ArenaApparatus
-> reference.ArenaObject
-> reference.ArenaObject
obj_x_coord                 : decimal(6,2)                  # (cm) x-coordinate of this object, w.r.t the arena (0, 0) being the center of the arena
obj_y_coord                 : decimal(6,2)                  # (cm) y-coordinate of this object, w.r.t the arena (0, 0) being the center of the arena
---
obj_note                    : varchar(1000)                 # any notes about this object in this arena (e.g. purpose, hypothesis, etc.)
%}


classdef ArenaApparatusObject < dj.Lookup
end