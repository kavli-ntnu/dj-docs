.. dj-docs documentation master file, created by
   sphinx-quickstart on Mon Aug 31 10:04:37 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to dj-docs's documentation!
===================================

Herein lies the book of Datajoint, the last and most sacred documentation of the Moser Group. 

Found a problem, a correction, or a humourous cat picture? Contact Simon Ball.

.. toctree::
   :maxdepth: 2
   :caption: Common:

   common/getting_started/index.rst
   common/finding
   common/conventions
   common/nomenclature
   common/building_your_own
   common/troubleshooting

.. toctree::
   :maxdepth: 2
   :caption: Electrophysiology:
   
   ephys/connecting
   ephys/fetching
   ephys/folder_structure
   ephys/ephys_processing
   ephys/ingestion_webgui
   ephys/multi_sess_units

.. toctree::
   :maxdepth: 2
   :caption: Imaging:
   
   imaging/Overview
   imaging/Folder-logic
   imaging/How-to-add-sessions
   imaging/Helper-notebooks
   imaging/Sync
   imaging/FOV-unwarping
   imaging/Session-viewer-GUI


.. toctree::
    :maxdepth: 2
    :caption: Developer Documentation:
    
    technical/architecture
    technical/database
    technical/working_parts
    technical/install_imaging



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
