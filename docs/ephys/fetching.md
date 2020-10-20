## Ephys: Fetching data

This guide assumes that you understand the basics of fetching data with Datajoint (covered extensively at [the Datajoint documentation](https://docs.datajoint.io/python/queries/Queries.html)). It assumes you have created database interface objects as discussed in *Ephys: Connecting*.





### Animal

Shared between the ephys and imaging pipelines, and contains information imported from the mLims colony management systems in use at Kavli.

#### Identifying Animals

Animals are identified throughout the pipeline by two columns:
* `animal_id` : this is an alphanumeric string, e.g., `e098f50d626e0650`. This is not the same as the mlims identifier
* `datasource_id`: this is always 0 for animals from any of the mLims management systems at Kavli. Included for future expansion to additional datasources. 

These two identifiers are matched to a more human-friendly `animal_name` (shared with mLims) in the table `animal.Animal`. The human-friendly name is not used throughout as it does not guarantee uniqueness. 

The human-friendly name can be used as a restriction throughout the pipeline as follows:

`animal.Animal & {"animal_name":26230}`





### Reference

Contains lookup tables of information that is referenced throughout the pipeline

#### Arenas

Information about the arenas in which animals run, and the objects, cue-cards etc that they react to

`reference.ArenaApparatus`
`reference.ArenaApparatus.ArenaGeometry`
`reference.ArenaObject`
`reference.CueCard`


#### General

`reference.Experimenter`
`reference.ExperimentRoom`





### Acquisition

Contains information about recording sessions and surgery on animals

#### Probe Insertion

`acquisition.ProbeInsertion`

#### ProbeAssociation

Where multiple probes are inserted and recorded, Datajoint must be informed which physical probe (identified in `acquisition.ProbeInsertion`) matches which data files. 

`acquisition.Session.NeuropixelsProbeAssociation`
`acquisition.Session.NeurologgerProbeAssociation`
`acquisition.Session.TetrodeProbeAssociation`

#### Session

Groups (of 1 or more) recordings as part of a single session. See *Noemclature* for discussion of the relative meanings between the two pipelines

`acquisition.Session`
`acquisition.Recording`

#### Project

Provides a way to group multiple Sessions together as part of a longer running project. A project can contain any number of sessions, and a session may be a member of many (or none) projects. Intended to provide a simple administrative interface for grouping data together. For example, consider a project to evaluate how animals react to darkness. This could prompt one project for all sessions involved in the project at all, and a 2nd project which groups only those sessions used in publishing a paper.

`acquisition.Project`
`acquisition.ProjectSession`




### Ephys

Contains information about the electrophysiology data - LFP, waveforms, clusterings and units, spikes. 

#### LFP

Stores LFP information from the probe(s).

`ephys.LFP`
`ephys.LFP.ChannelLFP`

`ephys.LFP` contains the mean LFP across all channels. `ephys.LFP.ChannelLFP` contains the LFP for each channel. For Neuropixels probes, a ChannelLFP is stored for 1 in every 10 channels due to the high channel density. 

#### Clustering

The ephys pipeline is designed to accept multiple clustering outputs for a single session - for example, if the researcher later refines their clustering, or if a session is clustered again by another user. Optionally, a user can assign a single CuratedClustering as a FinalizedClustering, to simplify selecting a single "authoritative" clustering

`ephys.CuratedClustering`
`ephys.FinalizedClustering`
`ephys.Unit`

The logic for linking a CuratedClustering to one (or more) Sessions is quite complicated, because it is designed to allow clustering to be performed over one session, multiple sessions, *or parts of sessions*

This information is contained in four tables in the **acquisition** schema:

`acquisition.ClusterSessionGroup`
`acquisition.ClusterSessionGroup.GroupMember`
`acquisition.ClusterTimeWindows`
`acquisition.ClusterTimeWindows.TimeWindow`

`acquisition.ClusterSessionGroup` stores a unique identifier for a group of sessions for which a clustering has been performed. `acquisition.ClusterSessionGroup.GroupMember` lists all of the sessions that are included in that group. A group *can*, and often does, only include a single session.

`acquisition.ClusterTimeWindows` stores a unique identifier for the time windows over which a clustering is performed within a ClusterSessionGroup. There is a time window for each Session within the ClusterSessionGroup, and these individual time windows are stored in `acquisition.ClusterTimeWindows.TimeWindow`. By default, TimeWindows cover the entire session duration. 


#### Units

Specific units are keyed by the CuratedClustering that identifies them, and by a `unit_id`. For tetrodes, `unit_id`s are created as a 4 digit number, in the format TTCC (for example, cluster 8 from tetrode 12 would have the unit_id 1208)

`ephys.Unit`

Units are characterised by a `cluster_type` column, inspired by the qualities assigned in Kilosort 2:

* Good
* MUA - multi unit activity
* Noise
* Unknown

Manual curation methods, such as Tint and MClust automatically assign the quality "Good" to all included units. 

Note that unit_ids are created from the output of the researcher's clustering. `unit_id`s are guaranteed to be unique **only within a single clustering output**. The method for creating `unit_id` is consistent and based on the clustering output, so users can manipulate this (in advance) by modifying their clustering output if they wish

There is ongoing work to create a method to track the same physical cell across multiple clustering outputs, but as of now, researchers must manage this tracking **themselves**

#### Unit tracking across multiple clusterings

Work in progress, not yet implemented

#### Spikes

Contains the spike times, and spike tracking for each Unit. 

`ephys.UnitSpikeTimes`
`ephys.SpikesTracking`

SpikesTracking can only be populated once the **Tracking** section is completed. SpikesTracking is only populated for units that have a `cluster_type` of `good`. Tracking data for each spikes is identified by finding the nearest tracking frame by time, and using those values. Tracking values are not interpolated to assign this tracking




### Tracking

Contains information about the animal's movement - position tracking from camera(s). 






### Behavior

Contains information about the experimental protocol - what tasks animal was subjected to, and what, if any, stimulus was applied. In particular, this is where information about what arena the animal was running in is stored (referenced to the **Reference** schema)





### Analysis

Contains common analysis results, split by Task (see **Behavior**). Parameters involved in analysis methods are tracked in **Analysis Parameters**. If multiple sets of parameters apply, multiple sets of analysis outcomes will be generated





### Analysis Parameters

Stores sets of analysis parameters. 