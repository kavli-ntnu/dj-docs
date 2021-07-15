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


THis page provides an overview of what a typical Session folder looks like for each recording system. The relevant files are listed. Other files may also be present, but aren't incorporated into the pipeline


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

A Neuropixels session is identified by the presence of one (or more) ``.ap.meta`` files underneatht eh session directory. They may be nested arbitrarily deep. There should be exactly the same number of ``.ap.meta`` files as there are probes inserted into the subject. 

Tracking data is expected to be provided via the Optitrack motion capture system. Either data output format (see :ref:`Ephys folders optitrack`) is supported. Depending on the format, either:

  * Matmot
    
    ``motive`` folder containing ``matmot.meta``, ``matmot.mtv``, ``sync.mat``. The directory and files are searched for by explicit naming
  
  * OptiCSV
  
    ``Optitrack`` folder containing a ``.csv`` file

Ephys data is stored in ``probe_x`` folders, one per probe (2 in this case). Each ``probe_x`` folder contains the raw data in the form of ``.bin`` and ``.meta`` files. The exact name of these files is less important than the suffixes (``.ap.meta``, ``.ap.bin``, ``.lf.meta``, ``.lf.bin``)

- First generation neuropixel probes have separate ``ap`` and ``lf`` files for high and low frequency data. 
- Neuropixel 2.0 probes do not have ``lf`` data files, as all data is stored in the ``ap`` file. 
- If clustered with Kilosort, it is expected that the Kilosort output for each probe is typically stored in that probe's directory, but for the case of multiple clusterings, see :ref:`Ephys folders npx multiple-clusterings`

Sync data is stored in the ``sync_all.mat`` and ``sync.mat`` files 

Information on tasks is stored in ``sessions.txt``

The Session may be ingested by providing the path ``../2020-06-17_12-35-40`` to the web gui.


.. _Ephys folders npx multiple-clusterings:

Multiple clusterings with multiple Neuropixel probes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The standard way of storing multiple clustering outputs with Neuropixel probes is to store one folder per clustering, per probe, i.e. 

.. code-block:: bash

    |- 2020-06-17_12-35-40
        |- probe_1
            |- ks2.1_01
                |- <Kilosort output here>
            |- ks2.1_02
                |- <Kilosort output here>
            |- ks2.1_03
                |- <Kilosort output here>
        |- probe_2
            |- ks2.1_01
                |- <Kilosort output here>
            |- ks2.1_02
                |- <Kilosort output here>
            |- ks2.1_03
                |- <Kilosort output here>
    
That is to say: clusterings are first separated by probe, and then by clustering ID. However this standard approach causes problems with ingestion via the web GUI (see :ref:`Ephys web-gui`). The ingestion logic requires a single "parent folder" which contains exactly one clustering output per probe inserted into that subject, while the above approach will yield many clustering outputs per probe inserted. 

The current work around is to modify this folder structure slightly instead: to separate *first* by curation ID and *then* by probe:

.. code-block:: bash

    |- 2020-06-17_12-35-40
        |- probe_1
        |- probe_2
        |- curations
            |- 01
                |- probe_1
                    |- ks2.1_01
                        |- <Kilosort output here>
                |- probe_2
                    |- ks2.1_01
                        |- <Kilosort output here>
            |- 02
                |- probe_1
                    |- ks2.1_02
                        |- <Kilosort output here>
                |- probe_2
                    |- ks2.1_02
                        |- <Kilosort output here>

In this case, you would provide the path ``../2020-06-17_12-35-40/curations/01`` as the curation output directory. 


Supported Probes
^^^^^^^^^^^^^^^^^^^^^

The ephys pipeline supports the following Neuropixel probe models:

* Phase 3A - pre v1.0 prototypes. Labelled in the piepline as "neuropixels_1.0". The supply has now expired and it is not expected that any further new subjects will be implanted with these probes
* Phase 3B - Commercial version 1.0 probes. Labelled as "neuropixels 1.0 - 3B". No more such probes will be purchased, but existing stock will be consumed with future subjects
* Neuropixel 2.0 single shank, model 21. Labelled as "neuropixels 2.0 - SS". 
* Neuropixel 2.0 multiple shank, model 24. Labelled as "neuropixels 2.0 - MS". 

The SpikeGLX wireless head stage for Neuropixel probes is currently NOT supported, unless individual users manually recreate the data structure explained above. 




.. _Ephys folders wireless:

Neurologger Recordings
------------------------------

Neurologger (or Deuteron) recording folders should look something like this:

.. code-block:: bash

    |- 2020-06-17_12-35-40
        |- Optitrack
            optitrack.csv
        |- Processed
            <kilosort output>
        |- Raw
            EVENTLOG.CSV
            EVENTLOG.NLE
            NEUR0000.DT2
            NEUR0001.DT"
            ....
        neurologger_header.mat

A Neurologger Session is primarily identified by the presence of a ``neurologger_header.mat`` file. 



.. _Ephys folders axona:

Axona Recordings
----------------------------

Standard practice is to place all Recordings for a single Session in a single folder

.. code-block:: bash

    |- 2020-06-17_12-35-40
        2020-06-17_openfield.1
        2020-06-17_openfield.2
        2020-06-17_openfield.3
        2020-06-17_openfield.4
        2020-06-17_openfield.eeg
        2020-06-17_openfield.eeg2
        2020-06-17_openfield.eeg3
        2020-06-17_openfield.eeg4
        2020-06-17_openfield.inp
        2020-06-17_openfield.pos
        2020-06-17_openfield.set
        2020-06-17_laser_1.1
        2020-06-17_laser_1.2
        <...>

Ingestion does not currently support recordings nested into individual folders. 

The Session may be ingested by providing the path ``../2020-06-17_12-35-40`` to the web gui.

An Axona Recording is identified by a single ``.set`` file. All Axona recordings in the same folder are considered to be members of the same Session. 


.. _Ephys folders neuralynx:

Neuralynx Recordings
------------------------------

Multiple recordings per Session are not supported for Neuralynx data.

A Neuralynx recording is identified by the presence of exactly 1 ``.ntt`` file. 


.. _Ephys folders sessions:

Sessions.txt
------------------------------

Thie is a standardised format for storing information about tasks, from Richard's neuropixel software. The same format can also be used for any other probe model.

Sessions.txt should be a basic text file, with columns delimited by commas

.. code-block:: bash

    #<number>,   <task_name>   start=<start_time>,     <task_type>

.. code-block:: bash

    #1,    open_field_1    start=30    <RUNNING>


.. _Ephys folders optitrack:

OptiTrack tracking data
-----------------------------

Optitrack is a commercial motion capture system. The Moser group makes use of two parallel methods of recording motion capture data.

CSV
^^^^^^^^^^^

The simplest option is to run Optitrack's own software to record and process the data, and then export the data as a CSV file. 

Timestamp synchronisation relies on TTL logic, with the OptiTrack system sending a TTL pulse to the data acquisition system (either Neurologger or Neuropixels) each time a frame is recorded. The data acquisition system records this pulse train as a set of timestamps, which are later assigned to each frame of tracking, in order. 

This method is typically used with Neurologger recordings. 

If at any time the Optitrack software crashes, then all the recording must stop, as an unknown number of frames will be missed, and no further tracking may be synchronised.


Matmot
^^^^^^^^^^

In order to solve the problem where a software crash could invalidate a large amount of recording data, an alternative synchronisation method is used, mostly with Neuropixel recordings. 

A group of infra-red LEDs are positioned around the arena where they can be observed by one or more Optitrack cameras, controlled by an Arduino. The LEDs are flashed with a pseudorandom pattern, which is also transmitted to the data acquisition system as a stream of TTL pulses. 

The Optitrack software is configured to recognise the IR LEDs as an additional rigid body; and additionally is configured to stream data into a ``.mat`` data file as each frame is recorded. If the software crashes, then it can be restarted, and continue streaming, some time period later.

Synchronisation is then performed by correlating the existence of the sync rigid body in the .mat files to the pseudorandom pulse code recorded by the data acquisition system. This method allows a long recording to continue even after the optitrack software crashes and is restarted, although in the tracking data some time periods will be absent. 