%{
# 
-> behavior.Task
-> behavior.Task
-> behavior.Event
-> behavior.Event
---
event_onset_timestamps      : longblob                      # (s) timestamps with respect to the start of this Task
event_offset_timestamps=null: longblob                      # (s) timestamps with respect to the start of this Task
%}


classdef TaskTaskEvent < dj.Manual
end