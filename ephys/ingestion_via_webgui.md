# Ingesting electrophysiology via the Web GUI

Data can be ingested into the ephys pipeline in two different ways. All users are encouraged to use the web GUI. Advanced users may insert directly into the pipeline via Python or Matlab scripts. 



### Web GUI

The Electrophysiology web GUI is available at https://datajoint.kavli.org.ntnu.no. You must be connected to NTNU's internal network to access it: if working from home, you will require a VPN connection active first.



### Authenticating

You must log in to the web GUI to interact with it. You use the same username and password as you do to access the pipeline in Python or Matlab. 

![](..\images\ephys_pipeline\webgui\login.PNG)



### Ingestion

There are multiple stages to ingesting new data, matching to different researcher actions.



#### Surgery on an animal

Records of implanting a tetrode into an animal (or multiple probes). The database is designed to track each *instance* of a probe or tetrode array (for example, matching to a specific Neuropixels probe with a unique serial number), in case of future reuse of unique probes. Therefore, start by creating a new probe instance: 

##### Create instance of probe

Reference -> Probe -> Add Probe

![](..\images\ephys_pipeline\webgui\add_probe_1.png)
![](..\images\ephys_pipeline\webgui\add_probe_2.png)

Select the correct kind of probe model (4-tetrode array, 8-tetrode array, Neuropixels) and give the probe a name

##### Probe naming convention

In general, we encourage using a systematic naming scheme - for neuropixels, we recommend using the serial number. For tetrodes, we suggest something like `tetrode_<animal_name>` (for example `tetrode_74956`)



##### Record the probe surgery

Ephys -> Probe Insertion

##### ![](..\images\ephys_pipeline\webgui\add_probe_3.png)
##### ![](..\images\ephys_pipeline\webgui\add_probe_4.png)

The Select Animal and Select Probe drop-down menus will search automatically as you type, so you don't have to scroll endlessly to find the entry you need. 

Insertion Time is entered in ISO8601 format: YYYY-MM-DD HH:MM:SS. You do not need to specify an exact time, for example, you can just specify the day, in which case internally, it will be tracked as occurring at midnight that day.

Mandatory fields:

* Animal
* Probe
* Insertion time
* Brain area (This is the area of the brain you *intended* to implant into)
* Brain hemisphere. 

All other fields are optional, but we encourage you to enter as much information as possible, for future reference. 



#### Electrophysiology Session

See section (TODO TODO) that discusses notation within the ephys pipeline for what we mean by "session".

Ephys -> Add Session

![](..\images\ephys_pipeline\webgui\add_session_1.png)

Mandatory fields:

* Animal
* Experimenter (More than 1 experimenter may be specified)
* Input directory path

Other fields are optional.

##### Input Directory Path

Your data must be in a directory that the database worker can access and read. In general, this means that the data must be on the Moser network share (`\\forskning.it.ntnu.no\ntnu\mh-kin\moser`). The database worker recognises this as "N-drive", and accepts input paths given in either Windows format (`N:\...`) or Unix format (`/mnt/N/...`)

##### Project

Project is an **optional** field allowing you to group multiple sessions together under one title. A session may be a member of one, many, or no, projects. This was introduced to allow, e.g., grouping together all sessions that are included in a single publication. 

##### Tracking System Setup

This is an **optional** field to identify a specific tracking calibration - for example, characterising the distortion and mapping of a single camera in a single room. 

If no such calibration is available (and it usually isn't), calibration will be calculated automatically for you based on the details you provide about the arena in which the animal ran. 

