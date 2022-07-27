.. _Imaging notebooks:

===================================
Imaging: Helper notebooks
===================================

This page documents the jupyter notebooks available under `/notebooks <https://github.com/kavli-ntnu/dj-imaging/tree/master/notebooks>`_.


Introductory notebooks
---------------------------

- `Starting notebook <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/Starting%20notebook.ipynb>`_:
  Boilerplate notebook - starts by loading the schema code and making a connection to the database. This can be re-used for whatever purpose. 
- `Starting notebook - follow the tree <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/Starting%20notebook-%20follow%20the%20tree.ipynb>`_:
  Follows the main branches of the schema. This is a good starting point if you haven't worked with the imaging database before and just want to get a rough overview over what is there.


Notebooks for adding information
------------------------------------

In order for downstream processes to run correctly, users have to add information after the basic processing has run through and ``Recording``, etc. entries are created.

At the moment this concerns the ``Recording.RecordingType`` and ``Recording.ArenaObject`` tables for recording type (open field, wheel, etc.) and object type and locations in open field sessions respectively.

- `Insert Recording Type <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/insert_recording_type.ipynb>`_:
  Looks for Session entries that do not yet have a matching ``Session.SessionType`` part table entry and presents user with a little notebook GUI to supplement that information. At the same time the user also fills the ``Session.Apparatus`` table. 
- `Annotate object locations in open field tracking <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/Enter%20object%20locations%20Napari.ipynb>`_:
  Loads object session tracking data and builds a little GUI (based on `Napari <https://napari.org/>`_), in which people can specify object locations.  

.. figure:: /_static/imaging/Napari_object_locations.png
   :alt: Object location adding via Napari


More specialized notebooks
-------------------------------

- `FOV unwarping <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/insert_fov_unwarping.ipynb>`_:
  2p miniscope raw recordings undergo distortions because of uncalibrated scanner responses to command voltages (and are therefore different for every scope vs. setup combination). In order to obtain undistorted cell maps and projections, we can unwarp these (raw) field of views by comparing with a calibration slide. The process of saving a calibration (=affine transformation) matrix into datajoint is shown in this notebook. For a more thorough explanation see :ref:`Imaging unwarping`

- `DLC add new Model/Processing method <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/dlc_model_insertion.ipynb>`_:
  Helper notebook to insert (register) new deep lab cut (DLC) model and associated processing method. 


Useful routines
-----------------
- `Unwarp tif files <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/Unwarp%20tiff%20files.ipynb>`_:
  Quick and easy way to obtain undistorted tif files and view those with `Napari <https://napari.org/>`_. See :ref:`Imaging unwarping`
- `Suite2p python reader <https://github.com/kavli-ntnu/dj-imaging/blob/master/notebooks/suite2py%20reader%20class.ipynb>`_:
  Notebook that shows the usage of the suite2p python reader class, which is also used when loading suite2p output into datajoint. It provides convenience functions for rapidly investigating suite2p python exports and plotting results of the imaging analysis. 
