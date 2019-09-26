%{
# 
cage                        : varchar(64)                   # cage identifying info
---
purpose                     : varchar(128)                  # cage purpose
%}


classdef Cage < dj.Lookup
end