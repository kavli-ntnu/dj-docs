.. _Imaging Terminology:

======================================
Imaging: Terminology
======================================

Due to the divergent development process, some different terminology has evolved between the imaging and ephys pipelines, although attempts have been made to unify the terminology wherever possible. This page, and it's :ref:`Ephys twin<Ephys Terminology>`, will cover some of the distinctions. 


Session and Recordings
-------------------------------

In the Imaging pipeline, the top level object for grouping data together is the **Session**, approximately equal to the *Session* in the Ephys pipeline. It is *not* completely identical.

A **Session** collectively labels one or more sets of imaging and tracking data together. All imaging data in a **Session** is analysed as a single group within **Suite2P**, and unit IDs are consistent within that **Session**.

A **Recording** is a single group of data (tiff stacks, tracking etc) generated by a microscope. A **Recording** is associated with a single arena, a single tracking system, and so on. 

A **BaseFolder** is the *physical location on disk* where your data is stored, created by ScanImage, and is the key to ingesting data via the :ref:`Imaging Web GUI<Imaging ingestion>`. Data in a single **BaseFolder** does *not* necessarily correspond to a single **Recording** (see the discussion of the *combined* in the :ref:`Imaging Web GUI<Imaging ingestion>` page).



Data Sets
---------------

The Imaging pipeline keeps track of data files stored in the **BaseFolder**. If changes are made to the data in the **BaseFolder** (e.g. curating units identified by **Suite2P**), you should re-ingest the **BaseFolder** via the :ref:`Web GUI<Imaging ingestion>`. Only files that have changed will be re-ingested. 

A Data Set may consist of one or more physical files relating to a specific kind of data. For example, "Tif" or "Tracking" or "DLC".



.. _Imaging Terminology Setup:

Systems and Scopes
--------------------

As part of the metadata stored about acquired data, the imaging pipeline keeps track of the physical hardware used, and its most recent calibration data. This "hardware tracking" (mostly) occurs under the ``Scope`` and ``SystemConfig`` tables. 

- A **Scope** describes the microscope objective and scanner, corresponding to specific fields of view, warping/dewarping proceedures etc. This is relevant only for the experimental miniscopes, as the Femontics system, the **Scope** cannot be changed.

- A **System** describes the majority of the experimental hardware, photodetectors, lasers, calibrations, etc. In general, it describes everything else in the recording room *except* the **Scope**, the **arena** and the **subject**.

Entries in these tables describe and refer to a single, unique, physical object. Multiple copies of the same design of hardware should have one (or more) entries *each*. Multiple entries per single physical object are used to keep track of the date of calibration data.

Both Systems and Scopes are given nicknames for easier discussion. These nicknames do not encode full information about every part of themselves, they are just pointers to the group documentation where that information can be found. Scopes are named as synonyms of either "fast" (for high speed scanners), or "large" (for wide field of view scanners). Systems are named after shades of green. 