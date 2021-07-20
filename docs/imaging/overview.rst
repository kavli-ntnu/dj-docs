.. _Imaging overview:

======================
Imaging: Overview
======================

The Imaging schema was built to handle two-photon Calcium imaging data acquired by either fixed benchtop machines, or the newer miniscopes in use in the Moser group.

The Imaging schema is written in Python using the Datajoint database framework. 

New users may find the following pages to be useful:

* :ref:`Imaging basics`:

  General introduction to the pipeline

* :ref:`Imaging terminology`:

  Notes on how certain names and concepts differ from the Ephys pipeline

* :ref:`Imaging naming`:

  The Imaging schema relies on certain file naming and folder layouts to run efficiently. These naming and layouts are based on the default behaviour of core libraries (see below) and mostly should not require any significant changes to your usual workflow.

* :ref:`Imaging ingestion`:

  An interface for inserting freshly acquired data into the pipeline.
  
* :ref:`Imaging dlc`:

  Generating Tracking data via the DeepLabCut software package

* :ref:`Imaging session viewer`:

  An interface for evaluationg and screening data that has been successfully inserted into the pipeline.
  
The following pages cover more advanced topics, and are provided for reference:

* :ref:`Imaging sync`:

  Some background notes on how the Imaging pipeline handles synchronisation between the various independent hardware clocks present in the miniscope systems.

* :ref:`Imaging unwarping`:

  Background notes on the field-of-view unwarping process, to correct for the distortions of the microscope objective.

* :ref:`Imaging notebooks`:

  Jupyter notebooks written to provide a more powerful interface into advanced pipeline sections than is suited to the :ref:`Imaging ingestion`


.. _Imaging overview hardware:

Hardware Supported
------------------------

The primary hardware systems supported are experimental mobile laser-scanning microscope systems, developed in-house by Horst Oberhaus and Weijian Zong.

Additionally, legacy data from an older generation of fixed, benchtop, laser scanning micrscope purchased from `Femtonics <https://femtonics.eu/>`_ is supported. 



.. _Imaging overview software:

Software supported
------------------------

The Imaging pipeline makes extensive use of third party libraries to support the miniscopes. Critical components include:

* `Suite2p <https://github.com/MouseLand/suite2p>`_: both (legacy) Matlab and current (Python) versions are supported as the primary analysis package for identifying cells within an imaging stack. 

* `DeepLabCut (DLC) <https://github.com/DeepLabCut/DeepLabCut>`_: machine-learning based open-field tracking of subject behaviour from a video stream

* `ScanImage <http://scanimage.vidriotechnologies.com/display/SIH/ScanImage+Home>`_: Image acquisition for lasser scanning microscopy

* `Wavesurfer <https://wavesurfer.janelia.org/>`_: Data acquisition software written in Matlab



.. _Imaging overview contributors:

Contributors
-------------------

Main schema development:

* Horst Obenhaus

Further schema development:

* Simon Ball
* Thinh Nguyen

Documentation

* Simon Ball
* Horst Oberhaus
* Ragnhild Jacobsen
