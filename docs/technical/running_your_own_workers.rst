.. _dev workers:

=============================
Running your own workers
=============================

There may arise circumstances in which the common worker processes are not sufficiently fast for your work. This is probably a sign that the entire pipeline requires more compute resources, but in the short term, it is possible to run a set of works yourself, which provides the option to prioritise your own data.


Requirements
---------------

By default, you do not have the database permissions necessary to run your own workers. Contact Simon to request them. You will be provided with a specialised user account that can be used to run your own workers.

It is important that your workers are running the latest copy of the code, and that their python environment meets the version requirements, as those factors are critical to maintaining the integrity of the data.

You must clone the dj-elphys repository to recieve a local copy of the code, and keep your copy synchronised with the primary repository.

At the root of the repository you should create a datajoint config file ``dj_local_conf.json``, containing the details outlined in :ref:`Getting Started Python`. A template can be created from your saved configuration with::

  import datajoint as dj
  dj.config.save("/path/to/my/file")

This template will need to be updated with the specialised user account/password noted above. 

You must initialise a fresh Python environment from the requirements.txt file in that repository, the easiest way to do that is to install the pipeline as a python package

.. code-block:: bash
    
  [base] $ conda create -n my-workers python=3.8
  [base] $ conda activate my-workers
  [my-workers] $ cd /path/to/ephys/repository
  [my-workers] $ pip install .


Running a local worker
------------------------

The workers, by default, execute the various scripts stored in `ephys/populate`, but if running your own workers, you probably want to modify these scripts in order to prioritise your own data.

The workers all take the form of Python scripts running commands that look like this::

  acquisition.Recording.populate(**settings)

Here, ``settings`` is a dictionary specifying various keyword arguments. You may adjust them as you wish, but it is strongly recommended to keep ``suppress_errors=True`` and ``reserve_jobs=True``.

  * If ``suppress_errors=False`` (default), then the populate command will stop working as soon as it reaches an error. Setting it to ``True`` will instead log the error in the ``jobs`` table, and then proceed to the next data
  * If ``reserve_jobs=False`` (default), then other workers will not know what jobs are currently being processed. This is not a *problem*, per se, but it reduces the efficiency of parallel workers, as they will end up wasting effort by repeating work that is already in progress. 
  * if ``display_progress=False``, (default) then you will not see any activity in the Python prompt, it will simply be busy. You may display what is going on with ``display_progress=True``, which will give a progress bar. 
  
You can limit what data the worker will process by passing a restriction, or set of restrictions, to the function. That restriction will then be applied to the table's key source, to determine which jobs the worker is to work on. For example, you might restrict by the animal_id::

  acquisition.Recording.populate({"animal_id":"180c96239a3f40e7"}, **settings)

Because of the way Python evaluates these arguments, there are a few limitations that apply to restrictions given this way: in particular, the "&" operator may *not* be used in this context. However, multiple "or" restrictions may be given as usual, i.e as a list of restrictions::

  acquisition.Recording.populate([{"animal_id":"180c96239a3f40e7"}, {"animal_id":"381970b6b65ad10d"}], **settings

The very simplest way to run populate functions yourself is to import the pipeline code into a Python terminal and run the populate scripts directly

.. code-block:: bash

    [base] $ conda activate my-workers
    [my-workers] $ python
    >>> from ephys import acquisition
    >>> acquisition.Recording.populate({"animal_id":"180c96239a3f40e7"}, display_progress=True, suppress_errors=True, reserve_jobs=True)
    
However, if you want to process multiple layers of the pipeline in order - i.e. many tables - this approach does not scale well. The next level of complexity is to write scripts that will group multiple commands together (this is how the common worker servers are controlled, by the scripts in ``ephys/populate``. You are welcome to re-use those scripts, but be aware that they do not implement or support any sort of prioritisation, and so you may want to modify them, at least slightly, to support the prioritisation you want:

.. code-block:: bash
  
    [base] $ conda activate my-workers
    [my-workers] $ python ephys/populate/my_populate_script.py

If you wish to run multiple workers in parallel, you may want to set up a script that will do that for you rather than have to manually start multiple independent Python terminals. On Windows, that would be a batch script, and might look something like this:

.. code-block:: bash

    [base] $ type my-workers.bat
    start "worker-1" python ephys/populate/my_script.py
    start "worker-2" python ephys/populate/my_script.py

On Linux, that would be a shell script and might look something like this:

.. code-block:: bash

    [base] $ cat my-workers.sh
    python ephys/populate/my_script.py &
    python ephys/populate/my_script.py &

