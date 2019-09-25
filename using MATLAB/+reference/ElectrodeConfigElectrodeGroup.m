%{
# grouping of electrodes to be clustered together (e.g. a single tetrode, or a neuropixels electrode config)
-> reference.ElectrodeConfig
-> reference.ElectrodeConfig
electrode_group             : int                           # electrode group
%}


classdef ElectrodeConfigElectrodeGroup < dj.Lookup
end