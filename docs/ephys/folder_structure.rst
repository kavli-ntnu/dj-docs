.. _Ephys folders:

=========================
Ephys Folder Structure
=========================

Ingesting data to the ephys pipeline requires some consistency in the structure and naming conventions of your recordings. The location of your data will be recorded so that, if necessary, data can be reingested in future. 

As a general rule, it is recommended to have a single data folder, with recordings split first by subject id, and then by session date/time. For example:

.. code-block:: bash

    network_share
    |- simoba
        |- data
            |- 26232
                |- 2020-12-13_12-14-15
                |- 2020-12-14_09-32-30
                |- 2020-12-15_13-19-00
            |- 26233
                |- 2021-01-05_09-00-00
                |- 2021-01-05_12-00-00
                |- 2021-01-07_09-00-13






.. _Ephys folders npx:

Neuropixels Recordings
---------------------------

Neuropixel Folder Structure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Neuropixel folder structure is based on Richard's models. The below example is for a single, multiple-probe, npx1.0, session from June 2020

.. code-block:: bash

    |- 2020-06-17_12-35-40
        |- motive
            |- matmot.meta
            |- matmot.mtv
            |- sync.mat
        |- probe_1
            |- npx.imec.ap.meta
            |- npx.imec.ap.bin
            |- npx.imec.lf.meta
            |- npx.imec.lf.bin
            |- sync.mat
            |- ks2.1_01
                |- <Kilosort output here>
        |- probe_2
        |- sessions.txt
        |- sync_all.mat

The relevant files are listed. Other files may also be present, but aren't incorporated into the pipeline

Tracking data is stored in the ``motive`` folder, and may either be in the `matmot` format, streamed via Matlab during acquisition, or in the `optitrack.csv` format output by Optitrack's software. 

Ephys data is stored in ``probe_x`` folders, one per probe (2 in this case). Each ``probe_x`` folder contains the raw data in the form of ``.bin`` and ``.meta`` files. The exact name of these files is less important than the suffixes (``.ap.meta``, ``.ap.bin``, ``.lf.meta``, ``.lf.bin``)
- First generation neuropixel probes have separate ``ap`` and `lf` files for high and low frequency data. 
- Neuropixel 2.0 probes do not have ``lf`` data files, as all data is stored in the ``ap`` file. 
- If clustered with Kilosort, it is expected that the Kilosort output for each probe will be stored inside that probe's directory.

Sync data is stored in the ``sync_all.mat`` and ``sync.mat`` files 

Information on tasks is stored in ``sessions.txt``

Supported Probes
^^^^^^^^^^^^^^^^^^^^^

The ephys pipeline supports the following Neuropixel probe models:

* Phase 3A - pre v1.0 prototypes. Labelled in the piepline as "neuropixels_1.0". The supply has now expired and it is not expected that any further new subjects will be implanted with these probes
* Phase 3B - Commercial version 1.0 probes. Labelled as "neuropixels 1.0 - 3B". No more such probes will be purchased, but existing stock will be consumed with future subjects
* Neuropixel 2.0 single shank, model 21. Labelled as "neuropixels 2.0 - SS". 
* Neuropixel 2.0 multiple shank, model 24. Labelled as "neuropixels 2.0 - MS". 

The SpikeGLX wireless head stage for Neuropixel probes is currently NOT supported.




.. _Ephys folders wireless:

Neuologger Recordings
------------------------------

TODO




.. _Ephys folders axona:

Axona Recordings
----------------------------

TODO




.._ Ephys folders neuralynx:

Neuralynx Recordings
------------------------------

TODO





.. _Ephys folders sessions:

Sessions.txt
------------------------------

Thie is s standardised format for storing information about tasks, from Richard's neuropixel software. The same format can also be used for any other probe model.

Sessions.txt should be a basic text file, with columns delimited by commas

.. code-block:: bash

    #<number>,   <task_name>   start=<start_time>,     <task_type>

.. code-block:: bash

    #1,    open_field_1    start=30    <RUNNING>

