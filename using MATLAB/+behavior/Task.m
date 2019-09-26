%{
# 
-> acquisition.Session
-> acquisition.Session
-> behavior.TaskType
-> behavior.TaskType
task_start                  : decimal(6,2)                  # (s) timestamp of task onset with respect to the start of the session
---
task_stop                   : decimal(6,2)                  # (s) timestamp of task offset with respect to the start of the session
-> reference.ArenaApparatus
-> reference.ArenaApparatus
%}


classdef Task < dj.Manual
end