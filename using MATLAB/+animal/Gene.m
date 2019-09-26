%{
# 
gene                        : varchar(64)                   # gene name
---
gene_description            : varchar(4096)                 # 
%}


classdef Gene < dj.Lookup
end