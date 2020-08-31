#Imaging: Overview
The **imaging schema** is built around a table called ``Session.Data``, which is where ``Session`` information on the one hand and information from ``Dataset`` are combined. When the experimenter adds data to an existing session or when a new analysis output that is calculated in an external package (Suite2p, ...) becomes available, this output can be added to the schema.

The entry point for all session data is the ``BaseFolder`` table, which takes as input 

- User name
- Path to a **base folder** with (new) data (**Careful**: Has to be a Windows folder path!)
- Animal name (ID)
- Experiment type
- Label: Combined - yes/no
- Setup / Scope info
- Suite2P processing info
- Notes

It all starts with a *base folder*, which is a file server location that contains files that belong to one or multiple session which _could_ be analysed together as if they were one long recording. It acts as the basic organising unit.

From there, ``MakeDatasetSessions`` takes over and extracts what is needed from this basic input. Most importantly, the folder path gets abstracted to a ``repository`` and a relative path so it can be found across clients. What data is looked for is determined by the _Experiment type_ label. 

So, for example, if the experiment type is "femtonics" the first thing that happens is that the script looks for ".mesc" output files (the basic imaging format coming from the femtonics microscope). It then creates ``Session`` entries based on the metadata associated with these files and looks for other session relevant data like tracking data files. All files are entered as ``Datasets`` and ``PhysicalFiles`` into the database, where Datasets represent bundles of PhysicalFiles that belong together (for example: tif files that are split into multiple sub-files because of file size limitations). Data is ultimately combined under ``Session.Data``. 

Sessions are subdivided into ``MetaSessions`` and ``Sessions``. If things end up in one MetaSession that means that they ought to be analysed together, meaning e.g. suite2p will run over all files that belong to this MetaSession, all Sessions will be ordered by timestamp within that MetaSession. How files in a base folder are treated depends on the label ``combined``: If _yes_, whatever sessions are found in one folder will end up under one MetaSession, if _no_, each identified session will form its own MetaSession. 

Whenever a new ``BaseFolder`` entry is created, the same routine runs over the chosen folder/experiment type/animal name combination. Since the file path is abstracted this will not lead to multiples of the same Session/Dataset, but rather either lead to the creation of 
1. a new session if no associated entries are found, 
2. new data being associated with an existing session. Thus, experimenters can add their folders as many times as they want to add new data. Let's say for example that someone forgets to put the tracking files into the session folder. She/he can just add that folder again to add that data to the database. Similarly, for Suite2P parameters that are added to the BaseFolder entry, when parameters do not match, the Suite2P related output is purged from the database and a new Suite2P can run over the new set of parameters.
Once data and session information converged on `Session.Data`, the first layer of imported tables (blue tables in ERD) will sort it according to dataset type. In these tables, basic pre-processing takes place. For example, the `ImagingAnalysis` table extracts all information pertaining to the analysis of imaging data, the `Tif` table grabs all tifs belonging to one session and extracts dimensions and a preview images from them. 
Downstream computed tables can then make use of this data and process it further.

#### Basic functions of the imaging schema: 
All imported / computed table `populate` commands are organised in a set of convenience "batch populate" functions (see [folder](https://github.com/kavli-ntnu/dj-moser-imaging/tree/master/batch_populate) in this repository). These can be run on multiple workers (for example your local Windows desktop or an open stack instance). 

#### Suite 2P python implementation 
[Suite2P python](https://github.com/MouseLand/suite2p) is implemented into the schema such that sessions that do not have matching suite2p output can be run through suite2p by calling `Suite2Py.populate()`. Suite2P python works on `ops` (Options) files that store all information to run Suite2P with. Those ops files can be uploaded/managed through the GUI (see readme for link). However, both Matlab Suite2P and Python Suite2P output converges in the schema and is then processed in parallel. Filtering for either result downstream is achieved by joining with table `ImagingAnalysis.Suite2p` for matlab or `ImagingAnalysis.Suite2py` for python output.

#### Other schemas: 
The **mLIMS** schema has been created by Vathes/Datajoint and syncs mouse/rat data with mLIMS on a regular basis. 

#### The GUI: 
There is a basic website running under http://2p.neuroballs.net:5000, which allows registered users to monitor the input layer (BaseFolder) and the Jobs tables of the imaging and Suite2PJobs schema. These jobs tables collect errors from any imported/computed table `make` routine. New Sessions/Data that should be analysed can be added through the GUI. 