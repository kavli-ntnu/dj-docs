.. _Common mass_ingestion:

======================================
Mass data ingestion
======================================



The pipeline workflow is built around the assumption that sessions are added as you go - once experimental data is moved
from the local recording computer to the main storage server, the session can be added to the pipeline. However,
occasionally, it will be necessary to add large quantites of data all at once. The web gui is not well suited to this
task, and falling back on code is recommended.



(Ephys-only) You will need to manually add information about each of the subjects, see
:ref:`Working with new subjects <Ephys web-gui>`.

Assuming that your data is stored in a standardised format and structure, it can then be added by a fairly simple
script, for assistance consult Simon Ball

At minimum, you will require the following information:

* What network share(s) are the data stored on? Check whether the workers have read access to these shares
* How are your data directories structured? For example

.. code-block:: bash

    -network_share
        -analysis
        -histology
        -recordings
            -12345
            -12346
            -12347
                -2020-01-01_10-00-30
                -2020-01-02_11-13-17
                    -logs
                    -motive
                    -probe_1
                        npx.imec.ap.bin
                        np.ximec.ap.meta
                    -probe_2
                    -probe_3
                    sessions.txt
                    sync_all.mat
            -23456
            -23457
                -20220419
                    openfield_00001_00001.tif
                    openfield_00001_00002.tif
                    openfield_00001.mp4
                    openfield_00002_00001.tif
                    openfield_00002_00002.tif
                    openfield_00002.mp4
                    -dlc23456_openfield_00001
                        dlc_config_file.yaml
                        23456_meta.pickle
                        23456.h5
                    -dlc_23456_openfield_00002
                    -suite2p
                        -combined
                        -plane0
                        -plane1


* Are there any subjects, or sessions that should be excluded, or that have an unusual structure?
* Are there any metagroupings, e.g. subjects or sessions that fall within specific projects?

Additional manual information will need to be entered after mass session ingestion:

* Details of specific tasks (timings may be inferred based on the presence of *sessions.txt* or similar, but must be confirmed by the user)
* Details of arenas
* Details of clustering output (Ephys specific; for Imaging, any existing Suite2p output will be collected automatically)
* Details of probe association (Ephys specific, can be avoided if probes are named appropriately)
