.. _Imaging dlc:

=========================
Imaging: DLC
=========================

`DeepLabCut <http://www.mackenziemathislab.org/deeplabcut>`_ is a software package for inferring motion capture information from tracking video. Whereas Optitrack makes use of one infra-red reflectors attached to the subject(s), DeepLabCut instead uses a deep neural network trained on human-labelled data of the subject(s), allowing for less interference with subject behaviour. 


Schema
------------

The DLC implementation in the imaging pipeline is shown below

.. figure:: /_static/imaging/dlc_schema.png
   :alt: DLC in the Imaging schema
   
   DLC in the Imaging schema

* ``DLCTrackingType``
  Keeps track of the kinds of tracking to which DLC can be assigned. At present, DLC data is only supported for *openfield* tasks

* ``DLCModel``
  Contains the full specification of a trained DLC model used in prediction. Due to the way DLC is designed, this data is derived from several separate files.
  When creating a new Method, please pay careful attention to how body parts are named (see ``TrackedBodyPart``)

* ``DLCTrackingProcessingMethod``
  DLC by itself keeps track of individual body parts, not an entire subject; while the imaging pipeline is built around the assumption that a subject can be assigned to a single state vector at any given time. This table keeps track of the method to calculate that state vector given the set of body part co-ordinates provided by DLC. Note that it has to know the *exact* name of each body part in question, and so if models use new names for the same body part, a new tracking processing method must be provided. 

* ``SessionDLC``
  Maps a specific Sessionto a specific Processing Method

* ``TrackedBodyPart``
  A list of the body parts that can be tracked. Please try to avoid adding to this list unnecessarily and follow the naming schems already in use
  
* ``TrackingRaw.DLCPart``
  Stores the raw state vector calculated via the method identifed in ``DLCTrackingProcessingMethod``

* ``Tracking.DLCPart``
  Stores the processed state vector, i.e. after conversion to real units, smoothing, and derivation of,e.g., speeds, angles etc. 


Processing Methods
-----------------------

Initial work with DLC within the Moser group has focused on duplicating the same tracking methods used in the past - tracking the position and angle of the head of the subject. Typically, this took the form of tracking the left and right ears, instead of LEDs mounted to the subject's head. Consequently, exactly the same calculation method could be used, with a pre-calculation stage of identifying what data corresponds to each "LED".

Future methods may be added, including potentially 3D information, but these methods must first be written.


DLC Models
--------------

1. In DeepLabCut model directory hierarchy, accessing the model file requires:

  * cfg (fields: Task | date | iteration)
  * shuffle (not in config)
  * trainingset_fraction - not in config, compute as: cfg['TrainingFraction'][trainingsetindex]
  
  (https://github.com/DeepLabCut/DeepLabCut/blob/326e6f7e48b70bee9360ba84a8ffc1772f50cbe3/deeplabcut/utils/auxiliaryfunctions.py#L451)

2. Minimal setting for triggering DLC analysis is as follows:

      ``deeplabcut.analyze_videos(cfg, video_paths, shuffle, trainingsetindex)``
      
  (https://github.com/DeepLabCut/DeepLabCut/blob/master/deeplabcut/pose_estimation_tensorflow/predict_videos.py)

3. Generated Scorer/network name

  * Take an example: "DLC_resnet50_mouse_openfieldJun30shuffle1_1030000"
  * Format: "DLC_" + netname (resnet50) + cfg['Task'] (mouse_openfield) + cfg['date'] (June30) + shuffle + trainingsiterations
  * Note that "trainingsiterations" here is not the same as "dlc_iteration" (which is more of a model version)
  * "trainingsiterations" is inferred based on: cfg['snapshotindex']
  * This scorer name is not sufficiently unique because it misses information about the dlc_iteration
  
  (https://github.com/DeepLabCut/DeepLabCut/blob/326e6f7e48b70bee9360ba84a8ffc1772f50cbe3/deeplabcut/utils/auxiliaryfunctions.py#L524)

In summary, the combination of (dlc_task, dlc_date, dlc_iteration, dlc_shuffle, dlc_trainingsetindex, dlc_snapshotindex) is sufficient to uniquely specify one DLC model


Workflow
--------------

DLC is not currently supported via the web gui, and requires handling via code. Sample notebooks for model ingestion are provided:
  
  1. `DLC model insertion <https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/DLC%20model%20insertion.ipynb>`_
  2. `SessionDLC insertion <https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Insert%20Session%20DLC.ipynb>`_

When a new model, or a new iteration of a model, is to be used, it must be registered in the Datajoint pipeline (see notebook 1 above). When a Session will be processed via DLC, it should be added to the ``SessionDLC`` table, (see notebook 2 above).

The Imaging pipeline supports automated DLC processing, assuming that the model requested is available to one or more of the workers running the pipeline. If the model is not available, the job will never complete.

Alternatively, users may run the model themselves (just as with Suite2p), although in this case, several manual steps must also be taken

  * TODO