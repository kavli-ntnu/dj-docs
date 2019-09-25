%{
# 
-> acquisition.ClusterTimeWindows
-> acquisition.ClusterTimeWindows
window_start                : decimal(6,2)                  # (s) onset of this window, with respect to session onset
---
window_stop                 : float                         # (s) offset of this window, with respect to session onset
%}


classdef ClusterTimeWindowsTimeWindow < dj.Manual
end