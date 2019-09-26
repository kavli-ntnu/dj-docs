%{
# 
-> reference.ArenaApparatus
-> reference.ArenaApparatus
-> reference.CueCard
-> reference.CueCard
card_x_coord                : decimal(6,2)                  # (cm) x-coordinate of this card, w.r.t the arena (0, 0) being the center of the arena
card_y_coord                : decimal(6,2)                  # (cm) y-coordinate of this card, w.r.t the arena (0, 0) being the center of the arena
---
card_note                   : varchar(1000)                 # any notes about this card in this arena (e.g. purpose, hypothesis, etc.)
%}


classdef ArenaApparatusCueCard < dj.Lookup
end