.. dj-docs documentation master file, created by
   sphinx-quickstart on Mon Aug 31 10:04:37 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to the Moser Group neuroscience pipelines
==================================================

These web pages provide documentation for the two data management pipelines in use in the Moser Group at NTNU. 

Found a problem, a correction, or a humourous cat picture? Contact Simon Ball.

.. toctree::
   :maxdepth: 1
   :caption: Common:

   common/getting_started/index.rst
   common/common_operations
   common/finding
   common/conventions
   common/building_your_own
   common/troubleshooting

.. toctree::
   :maxdepth: 1
   :caption: Electrophysiology:
   
   ephys/overview
   ephys/terminology
   ephys/fetching
   ephys/naming_conventions
   ephys/folder_structure
   ephys/ephys_processing
   ephys/ingestion_webgui
   ephys/multi_sess_units

.. toctree::
   :maxdepth: 1
   :caption: Imaging:
   
   imaging/overview
   imaging/terminology
   imaging/basics
   imaging/folder-logic
   imaging/how-to-add-sessions
   imaging/dlc
   imaging/session-viewer-gui
   imaging/sync
   imaging/fov-unwarping
   imaging/helper-notebooks


.. toctree::
    :maxdepth: 1
    :caption: Developer Documentation:
    
    technical/contributing
    technical/install_imaging



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
