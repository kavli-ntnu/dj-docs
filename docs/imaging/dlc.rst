.. _Imaging dlc:

=========================
Imaging: DLC
=========================

`DeepLabCut <http://www.mackenziemathislab.org/deeplabcut>`_ is a software package for inferring motion capture information from tracking video. Whereas Optitrack makes use of infra-red reflectors attached to the parts of the subject's body that are to be tracked, DeepLabCut instead analyses a video of the subject using a deep neural network. The latter approach interferes less with the subject's natural behaviour. 



Schema
------------

The DLC implementation in the imaging pipeline is shown below

.. figure:: /_static/imaging/dlc_schema.png
   :alt: DLC in the Imaging schema
   
   DLC in the Imaging schema.

* ``DLCTrackingType``

  Determines which kinds of session (e.g. a 1D wheel session vs a 2D open field session) will be processed beyond the ``TrackingRaw`` table. At present, only `*openfield* sessions are supported. 

* ``DLCModel``

  Contains the full specification of a trained DLC model used in prediction. Due to the way DLC is designed, this data is derived from several separate files. When creating a new Method, please pay careful attention to how body parts are named (see ``TrackedBodyPart``).

* ``DLCTrackingProcessingMethod``

  DLC by itself keeps track of individual body parts, not an entire subject; while the imaging pipeline is built around the assumption that a subject can be assigned to a single state vector at any given time. This table keeps track of the method to calculate that state vector given the set of body part co-ordinates provided by DLC. Note that it has to know the *exact* name of each body part in question, and so if models use new names for the same body part, a new tracking processing method must be provided. 

* ``DLCProcessingMethod``
  
  Maps a DLCTrackingProcessingMethod to a DLCModel. This mapping is important to ensure that the expected data columns (matching specific ``TrackedBodyPart``) are available (and named correctly!).

* ``SessionDLC``

  Maps a specific Sessionto a specific Model / Processing Method.

* ``TrackedBodyPart``

  A list of the body parts that can be tracked. Please try to avoid adding to this list unnecessarily and follow the naming schemes already in use (for example, if the body part ``left_ear`` already exists, please try to avoid also creating ``leftear``, ``LEFTEAR``, and ``Left_Ear``).
  
* ``TrackingRaw.DLCPart``

  Stores the raw tracking data calculated via the method identifed in ``DLCTrackingProcessingMethod``. Raw, i.e. the position of the subject (in arbitrary units) derived from the DLC data.

* ``Tracking.DLCPart``

  Stores the processed tracking data, i.e. after conversion to real units, smoothing, and derivation of,e.g., speeds, angles etc. 

* ``DLCPrediction``

  Handles automated processing of a session



Models and Processing Methods
-----------------------------------

Models
^^^^^^^^^^

In the field of machine learning, a "model" is the outcome of the training stage, that may be used for inference. 

In the case of DLC, this model is a weighted neural network that will be used to analyse the video file and produce a table containing position and probability data of each tracked body part at each timestamp. 

The model also defines which body parts will be tracked and, importantly, what those body parts are called. 

Processing Methods
^^^^^^^^^^^^^^^^^^^^^^^^^

A Processing Method handles how to convert DLC's data output to something that the Imaging pipeline can handle. 

DLC's data output is a time-series of position data for each tracked body part. The Imaging schema is designed around the assumption of tracking a single subject, defined by a single position. 

A single TrackingProcessingMethod is an algorithm to convert the positions (and probabilities) for a specific set of body parts into the position data for a single body. If a different set of body parts are chosen (i.e. in a different model), a different TrackingProcessingMethod may be required.

For example, one Model might use a camera underneath the arena, tracking the position of four feet, while a second model might use a camera underneath, tracking the position of two ears. A TrackingProcessingMethod accepting two timeseries from ``left_ear`` and ``right_ear`` cannot cope with four timeseries named ``left-front-foot``, ``right-front-foot``, ``left-back-foot``, ``right-back-foot``.

Adding new processing methods
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Initial work with DLC within the Moser group has focused on duplicating the same tracking methods used in the past - tracking the position and angle of the head of the subject. Typically, this took the form of tracking the left and right ears, instead of LEDs mounted to the subject's head. Consequently, exactly the same calculation method could be used, with a pre-calculation stage of identifying what data corresponds to each "LED".

Future methods may be added, including potentially 3D information, but these methods must first be formulated, written, and tested. 


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
  * Format: ``DLC_`` + netname (``resnet50``) + cfg['Task'] (``mouse_openfield``) + cfg['date'] (``June30``) + shuffle + trainingsiterations
  * Note that "trainingsiterations" here is not the same as "dlc_iteration" (which is more of a model version)
  * "trainingsiterations" is inferred based on: cfg['snapshotindex']
  * This scorer name is not sufficiently unique because it misses information about the dlc_iteration
  
  (https://github.com/DeepLabCut/DeepLabCut/blob/326e6f7e48b70bee9360ba84a8ffc1772f50cbe3/deeplabcut/utils/auxiliaryfunctions.py#L524)

In summary, the combination of (dlc_task, dlc_date, dlc_iteration, dlc_shuffle, dlc_trainingsetindex, dlc_snapshotindex) is sufficient to uniquely specify one DLC model



Workflow
--------------

There are two stages to working with DLC:

  1. Registering a model. This must currently be done via code, and is currently reserved to pipeline administrators only, to handle the naming complexity of models. Please contact Simon Ball or Horst Obenhaus to `register a new model. <https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/DLC%20model%20insertion.ipynb>`_
  2. SessionDLC insertion. This can be done via the imaging web gui, to map a **Session** to  a specific DLC model and processing method (see :ref:`Imaging ingestion`).

The Imaging pipeline supports automated DLC processing, assuming that the model requested is available to one or more of the workers running the pipeline. If the model is not available, the job will never complete.

Alternatively, users may run the model themselves (just as with Suite2p), although in this case, several manual steps must also be taken. A function is provided within the Imaging pipeline to run the model and do these manual steps automatically:

.. code-block:: python
    
    from dj_schemas.jobs_dlc import do_DLC_prediction
    
    do_DLC_prediction(
        video_filepaths=(r"D:/mydata/my_video_1.mp4",),
        model_name="DLC_resnet50_mouse_openfieldJun30shuffle1_1030000",
        tif_filepaths=(r"D:/mydata/tif1.tif", r"D:/mydata/tif2.tif"),
      )

If you run DLC via the command line instead, then these manual steps are:
  
  * Open the ``.pickle`` file and add the attribute ``Start Timestamp``, indicating the date/time at which the video was recorded (formatted as iso8601). A `notebook <https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Add%20timestamp%20to%20DLC%20pickle.ipynb>`_ is provided to help with this. 
  * Name the files accordingly (see :ref:`Imaging naming dlc` for more discussion of file naming conventions)

.. code-block:: bash

    metasession_directory
    |- dlc_{basename}
        |- dlc_config_file.yml
        |- {modelname}.h5
        |- {modelname}includingmetadata.pickle
