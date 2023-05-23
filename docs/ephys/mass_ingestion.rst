.. _Ephys mass-ingestion:

=====================================================
Ephys: Mass Ingestion
=====================================================

The  :ref:`web interface <Ephys web-gui>` is designed around inserting one session at a time: its workflow assumes that
the user will add each session as they record it. Since not all users adopt this workflow, it can represent a significant
point of friction when they come to the end of a recording campaign and need to ingest a large quantity of data all at
once.

To help solve this friction, an interface for mass ingestion has been developed. Instead of clicking through web forms,
or adding sessions via code in a Jupyter notebook, the user can compose an "input file" - a text document that
describes the set of data to be inserted, and processed in a single pass. As this is text based, it is easier to generate
for consistently structured data, and easier to source control. It is processed idempotently, i.e. the same document may
be processed repeatedly, and in the absence of changes to the document, no changes to the stored data will be made.


.. _Ephys mass-ingestion workflow:

----------
Workflow
----------

You, as the user, compose an input file for your subject, based on a downloaded template (see above). The input file can
describe as few or as many sessions and multi-session clusterings as are appropriate to your work. You can compose the
input file either all at once, at the end of a recording campaign, or progressively, as you go. You can compose a single
input file per subject, or as many as one per session and one per multi-session clustering, as you prefer.

At any point, you can check if the input file is valid via the validation tool built into the :ref:`web interface <Ephys web-gui>`.
This tool does not attempt to ingest anything, it simply checks if the file, as provided, meets the various validation
stages described.

When satisfied, you can upload the input file to be processed. This will run the validation tool again and, if the file
passes, processing will begin.

Processing uses the same backend logic as the web interface, and the various stages will be visible through the exact
same pages on the web interface as if you were inserting sessions one by one, including any errors that may arise from
aspects that could not be validated beforehand.

Optional components that were omitted from the input file may still be added, one by one, through the web interface, in
the same way you are already used to.

If you choose to compose your input file as you record, you may upload the same input file multiple times as new data is
added to it. Sessions and clustering that are determined to already exist will be ignored, `including changes to existing
sessions and clustering` (data already in the database is *not* updated)


---------------------------------------
Composing and validating an input file
---------------------------------------

You can of course compose an input file by hand. In addition, an automatic tool has been written that can perform some
of the composition for you.

Exact details of the input file structure are annotated below, see the section on :ref:`Input File Format <Ephys mass-ingestion format>`.
Several keywords require a value matching a valid value in the database: the file format section details these tables
exhaustively. To help you identify valid values, a web form has been provided: `auto-compose tool <https://datajoint.kavli.org.ntnu.no/ephys/mass_ingest/compose>`_

You can at any time check whether an input file is valid or not, via the `validation tool provided on the web interface <https://datajoint.kavli.org.ntnu.no/ephys/mass_ingest/validator>`_

Automatic composing
^^^^^^^^^^^^^^^^^^^

You can generate a pro-forma input file for a location by entering that location into the automatic composition tool at
(`auto-compose tool <https://datajoint.kavli.org.ntnu.no/ephys/mass_ingest/compose>`_). The tool will evaluate the location
for probable session directories and return a partial input file for manual checking and completion. The returned input
file will **not** be sufficiently complete to pass any level of validation without further manual input.

This tool is experimental and subject to several assumptions and limitations:

  * Your data is structured in a certain way (see below)
  * You are working with Neuropixels data. Support for wireless neurologger is untested; older tetrode systems are explicitly unsupported.
  * You can only generate an input file for one subject at a time.

Principally, it is assumed that your data structure will look something like:

.. code-block:: bash

    project_share
      |- recordings
           |- subject_1
                |- session_1
                |- session_2
                |- session_3
           |- subject_2
           |- <...>

You may submit any directory location to the tool, and it will check:

1) Does the location look like a session directory?

    * If yes, return an input file containing one session

2) Does the location look like a directory containing one or more session directories?

    * If yes, return an input file containing one or more sessions

3) Does the location look like it contains data for zero, two, or more, subjects?

    * Multiple subjects not supported, rocessing not possible

4) Structure not understood, processing not possible

More complex structures, or other unexpected phenomena, will cause automatic generation to fail or behave unpredictably.


.. _Ephys mass-ingestion validation:

Input file validation
^^^^^^^^^^^^^^^^^^^^^

The input file is validated at several stages through ingestion. The validation tool can be accessed either within the
code repository, or via `validation tool <https://datajoint.kavli.org.ntnu.no/ephys/mass_ingest/validator>`_ page.

The input file is validated in several stages

0) Stage 0: Can the provided file be loaded as a valid ``.json`` or ``.yaml`` file?
1) Stage 1: Are the required keywords present, and do the data they contain match the expected data types? Are any
   keywords missing or misspelt?
2) Stage 2: Where data values are required to match values already in the database, do those data values match? Can
   requested file paths be located and does the backend system have read permission to those locations?
3) Stage 3: Can the requested data be successfully ingested?

Stages 0-2 are checked by the provided validation tool.

Stage 3 is *not* checked by the provided validation tool: doing so would require functionally duplicating the entire
pipeline logic. It is therefore possible for an input file to be marked as valid via the validation tool, but still result
in errors during ingestion.

Validation is provided by the following methods:

* Stage 0: success (or failure) of loading the file through the packages ``json`` and ``pyyaml``
* Stage 1: success (or failure) of inserting the resulting dictionary into the `input file model <https://github.com/kavli-ntnu/dj-elphys/blob/master/ephys/utilities/mass_ingest/config_model.py>`_ defined with
  ``pydantic``
* Stage 2: Checking values against relevant database tables


Stage 1 implements strict keyword checking: only keywords explicitly defined in the input file schema are
permitted. Extra keywords will result in validation errors.

The primary reason for this choice is to avoid *unexpected* behaviour due to mis-spelt keywords. Without strict checking,
a mis-spelt keyword would result in the value you, as a user, specify being replaced by the default value (if there is one)
for that field. With strict checking, the mis-spelt keyword is recognised as forbidden, and highlighted to you to fix.




.. _Ephys mass-ingestion format:

------------------
Input file format
------------------

The input file may be submitted as either a ``json`` or ``yaml`` file. Where examples are given in this page, an identical
example in each format is provided.

An input file describes exactly one subject. It may describe zero, one, or many, sessions relating to that subject.
An input file may also describe multi-session clustering related to that subject. Zero, one, or many,
multi-session clusterings may be described.

Several example templates are available (see below), which include examples of the maximal and minimal set of data that
can be, or must be, included. Note that while ``json`` is supported as a first class citizen for providing input files,
the ``json`` specification does *not* support inline comments (as ``#`` is used in Python and ``%`` in Matlab), and
consequently does not contain human-readable comments detailing which fields are optional and which are mandatory.

* :download:`yaml template </_static/ephys/mass_ingest/mass_ingest_template.yml>`
* :download:`yaml example </_static/ephys/mass_ingest/mass_ingest_example.yml>`
* :download:`json example </_static/ephys/mass_ingest/mass_ingest_example.json>`

The example files as shown refer to fictional data and as such will not pass :ref:`validation <Ephys mass-ingestion validation>`.



Components
^^^^^^^^^^^^

This section summarises the components of the input file, starting at the top level and moving down width-first

The input file has three top-level components:

* ``subject``
  A short section identifying the subject

* ``sessions``, optional
  A list of dictionaries, one for each session for the subject.
  Single session clustering comes under this heading

* ``clustering``, optional
  A list of dictionaries, one for each *multi-session clustering*. This is *not* for any clustering based on only a
  single session.

Keys that are optional may be excluded from the input file, in which case it will be treated as equal to its default
value. If the keyword is explicitly included in the input file, a value must be assigned by the user.

.. tabs::

    .. code-tab:: yaml

        subject:
        sessions:
        clustering:

    .. code-tab:: json

        {
            "subject": {},
            "sessions": [],
            "clustering": []
        }

Subject
********

Identifying details for the subject for which the input file describes. This section is mandatory. Prior to ingestion,
the subject must have probes already recorded as implanted via the web interface.

    * ``name``. The common name of the subject, e.g. ``12345``
    * ``datasource_id``, optional, default 0. The source of subject information. Until/unless mlims is replaced, there are no valid values other than ``0``

.. tabs::

    .. code-tab:: yaml

        subject:
          name: 12345
          datasource_id: 0              # Optional, defaults to 0

    .. code-tab:: json

        {
            "subject": {
                "name": 12345,
                "datasource_id": 0
            }
        }


Sessions
*********

This section is optional: it is supported to upload input files that handle only multi-session clustering, rather than
sessions. If included, this section contains a list of dictionaries, one per session

A single session dictionary looks like this:

    * ``location``.
      A file path to the location on disk. Access to this path will be validated as part of upload, and if the location
      either cannot be found, or is found to be restricted access, the input file will be rejected
    * ``experimenter``.
      A string literal, or list of string literals, naming the users associated with recording the data. Values given must
      exactly match values in the table ``reference.Experimenter``
    * ``tasks``.
      A list of dictionaries, one entry per Task
    * ``clustering``, optional, default True.
      Either a boolean, or a list of dictionaries, one entry per Clustering (single-session clustering *only*, multi-session
      clustering is handled by another section). If a boolean, a value of ``True`` will indicate inheritance (see :ref:`Ephys mass-ingestion format session clustering <clustering>`).
      A value of ``False`` will result in no clustering being inserted.
    * ``probe_association``, optional, default None.
      A dictionary listing how, in the case of multiple probes, recordings on disk correspond to probes implanted to the
      subject. Not required if either:

      * only a single probe is implanted, OR
      * Multiple probes are implanted, but the probe_association can be inferred based on serial numbers
    * ``room``, optional, default None.
      String or float, the room in which the recording took place. If a value is given, it must exactly match a value in the
      table ``reference.ExperimentRoom``.
    * ``project``, optional, default None.
      String or list of strings, the project(s) with which this session is associated. If a value is given, it must exactly
      match a value in the table ``acquisition.Project``

    * ``notes``, optional, default None.
      Any notes to be attached to the session.
    * ``name``, optional, default None.
      Used for relating to-be-inserted sessions to multi-session clustering. The name is not inserted into the database, or
      used in any way beyond processing the input file.

probe_assocation
~~~~~~~~~~~~~~~~~

This is the most free-form section of the input file, since the exact keys and values must match how your data is
structured. In general, keys within this dictionary match the probe signatures *on disk*, while the values match the names
of probes in the table ``reference.Probe``.

For neuropixel probes, where a serial number is stored as part of the recording metadata, probe association is performed
automatically *if probe records in the database include that serial number as part of the probe name*. In such a case,
you can exclude the ``probe_association`` section.

Suppose you have a recording folder with two raw data folders, ``probe_1`` and ``probe_2``. Suppose also that your subject
has two probes implanted, ``npx_1_18408403232`` and ``npx_1_18408405241``, which match to ``probe_1`` and ``probe_2`` in
that order. In that case, your folder structure would look like so:

.. tabs::

    .. code-tab:: yaml

        probe_association:
          probe_1: npx_1_18408403232
          probe_2: npx_1_18408405241

    .. code-tab:: json

        {
            "probe_association": {
                "probe_1": "npx_1_18408403232",
                "probe_2": "npx_1_18408405241"
            }
        }

.. _Ephys mass-ingestion format session tasks:

tasks
~~~~~~

A list of dictionaries, one dictionary per described task. If an appropriate source of task information is already
available, e.g. the ``sessions.txt`` file produced by the acquisition software, a limited set of values may be inherited
from that file rather than manually (re-)entered by the user.

Values that may be inherited are:

    * ``task_start``
    * ``task_stop``
    * ``notes``

Inheritance is signalled by replacing the expected data type (numeric or string) with a boolean value of ``True``. A
value of ``False`` is not valid. Since the ``sessions.txt`` file does not contain all of the information required, manual
data entry of other fields is still required, even when some values are inherited.

When inheritance is used, tasks in the input file are matched to tasks in the source file by order. Take care not to
ignore any tasks, even if they are trivial, or you may find that you unintentionally corrupt your data records.

Vales for the keywords ``task_type`` and ``arena_apparatus`` are validated against the contents of ``behavior.TaskType``
and ``reference.ArenaApparatus`` respectively. If the arena you are using is not yet available in that table, you can add
it via the web interface.

For *each* task, there may optionally be supplied a list of objects, cue cards, and curtains. Each included object or
card may additionally have an optional note attached. If included, these categories are validated against:

    * ``tasks[i].light_level`` : ``behavior.TaskLightLevel``
    * ``tasks[i].objects[j].object_name`` : ``reference.ArenaObject``
    * ``tasks[i].cue_cards[j].card_name`` : ``reference.CueCard``



The below example shows three tasks. The first task includes the maximal set of allowable keywords. The second set shows
the minimal set of allowable keywords. The third task has a minial set of keywords, and demonstrates inheritance.

.. tabs::

    .. code-tab:: yaml

        tasks:
            # Maximal set of keywords
          - task_type: OpenField
            arena_apparatus: 150_square
            task_start: 27
            task_stop: 1533.5
            notes: "the subject explored an open arena with no stimulation"         # optional
            light_level: dim                                                        # optional
            objects:                                                                # optional
             - object_name: object_1
                coord_x: 27
                coord_y: 34
                note: "tower made of smooth plastic"                                # optional, even if objects included
            cue_cards:                                                              # optional
              - card_name: card_1
                coord_x: 13
                coord_y: -5
                note: "left a bit off centre"                                       # optional
            curtains:                                                               # optional
              - start_point: "bottom-left"
                direction: "clockwise"
                coverage: 25

            # minimal set of keywords
          - task_type: SleepTask
            task_start: 1587
            task_stop: 2110

            # Minimal et of keywords with inheritance
          - task_type: OpenField
            task_start: yes                         # Inherit the timestamps of the 3rd task from sessions.txt
            task_stop: yes
            notes: yes


    .. code-tab:: json

        {
            "tasks": [
                {
                    "task_type": "OpenField",
                    "arena_apparatus": "150_square",
                    "task_start": 27,
                    "task_stop": 1533.5
                    "notes": "the subject explored an open arena with no stimulation",
                     "objects": [
                        {
                            "object_name": "object_1",
                            "coord_x": 27,
                            "coord_y": 34,
                            "note": "tower made of smooth plastic"
                        }
                    ],
                    "cue_cards": [
                        {
                        "card_name": "card_1",
                        "coord_x": 13,
                        "coord_y": -5,
                        "note": "left a bit off centre"
                        }
                    ],
                    "curtains": [
                        {
                            "start_point": "bottom-left",
                            "direction": "clockwise",
                            "coverage": 25
                        }
                    ]
                },
                {
                    "task_type": "SleepTask",
                    "task_start": 1587,
                    "task_stop": 2110
                },
                {
                    "task_type": "OpenField",
                    "task_start": true,
                    "task_stop": true,
                    "notes": true
                }
            ]
        }


.. _Ephys mass-ingestion format session clustering:

clustering (single-session only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This clustering section iss given as *part of a Session*. It is intended for use only in cases when clustering (e.g.
Kilosort) is run over that single session, and not jointly with other sessions. When joint clustering is used, see the
:ref: `Ephys mass-ingestion format mscluster <multi-session clustering section>`.

``clustering`` takes the form of either a single boolean value, or a list of dictionaries. A list of mixed booleans and
dictionaries is not permitted. The example below shows two distinct sessions, one with a list of clusterings, and one with
a boolean (inherited) clustering

Where an entire clustering is inherited, the session location is searched to find clustering files. The curator is assumed
to be the uploading user.

A boolean value of ``False`` *is* permitted, and will result in associating zero clustering information with the session.
In this case, the user should fill in the appropriate clustering data after the fact, via the web interface.

In the example below:

In the first session, two clusterings are specified. The first is written out entirely. The second is mostly written out,
but excludes the optional ``notes`` field, and inherits the time of the clustering from the file modification time. In
the second session, clustering is searched within the session location.

.. tabs::

    .. code-tab:: yaml

      sessions:
        - location: /path/to/example/2
          ...
          clustering:
            - curator: my_user_name
              curation_time: 2023-04-05 12:13:14
              location: /path/to/example/2/clustering/1
              notes: some notes about this one
            - curator: my_user_name
              curation_time: yes
              location: /path/to/example/2/clustering/2

        - location: /path/to/example/3
          ...
          clustering: yes

    .. code-tab:: json

        {
            "sessions": [
                {
                    "location": "/path/to/example/2",
                    "clustering": [
                        {
                            "curator": "my_user_name",
                            "curation_time": "2023-04-05 12:13:14",
                            "location": "/path/to/example/2/clustering/1",
                            "notes": "some notes about this one"
                        },
                        {
                            "curator": "my_user_name",
                            "curation_time": "true",
                            "location": "/path/to/example/2/clustering/2"
                        }
                    ]
                },
                {
                    "location": "/path/to/example/3",
                    "clustering": "true"
                }
            ]
        }




.. _Ephys mass-ingestion format mscluster:

Clustering (Multi-session clustering only)
********************************************

This section is optional: it is supported to upload input files that handle only sessions, not multi-session clustering.
If it is included, this section contains a list of dictionaries, one dictionary per clustering.

Multi-session clustering does not directly descend from a single session, but depends on two or more sessions, which may
already exist within the database, or may be inserted by the action of processing this input file. Validation of the
latter case is self-referential and therefore suffers some limitations (see :ref:`Ephys mass-ingestion validation <Validation>`).
A multi-session clustering *cannot* depend be created without *all* of its associated sessions existing first. Therefore,
it is not possible to insert a multi-session clustering now, and fill in its sessions later.


    * ``curator``.  A string literal identifying who performed the work. Must match an entry in ``reference.Experimenter``

    * ``location``.  The path to the location where the resulting data is stored. For multi-probe clusterings via Kilosort, it may be an
      "outer" directory that contains the output locations for each of the probes.

    * ``curation_time``, optional, default True.  Either a date time, indicating when the work took place, or a boolean. In the case of a boolean, the time will be
      inferred based on the modification time of the underlying files.

    * ``group_name``.  A string literal giving a custom name for the ClusterSessioNGroup that ties the clustering back to its component sessions
      Group names must be globally unique - both within the input file, and within the Ephys database.
      One exception is permitted to support idempotency: an input file which contains a `group_name` which already exists
      *for the same subject* will be *assumed to be a duplicate of a previously inserted clustering*. In this case, it will
      be accepted, but will not be processed (dupliate input files are permitted to improve user experience).

    * ``sessions``.  List of datetimes or strings, identifying which sessions were used as the basis for the clustering.
      For sessions that already exist within the database, these values must match the column ``session_time`` from the table
      ``acquisition.Session``, *for the named subject*.
      For sessions that *do not yet exist in the database*, but *will*, as a result of this input file, you can attach them
      by means of the ``name`` parameter under ``sessions``. Forward references are not recursively validated, and consequently
      this is a weak point that may result in ingestion errors.

    * ``notes``, optional, default None. Any free form text notes you wish to attach.

The example below includes two sets of multisession clusterings. The first refers to sessions that are not yet in the
database, but will be inserted as a result of processing this input file. Consequently, they are referred to by name -
the optional ``name`` attribute assigned within the ``session`` entry. The second example refers to sessions already
in the pipeline, and they are therefore referred to by the session timestamp recorded in the database.

.. tabs::

    .. code-tab:: yaml

        subject:
        sessions:
        clustering:
          - curator: user_3
            curation_time: 2023-04-07 19:00:05
            location: N:/my_project/clustering/my_subject/msc_0001
            group_name: 12345_msc_0001
            sessions:
              - 12345_1
              - 12345_2
            notes: "first clustering for this subject, looks like some interesting results"

          - curator: user_2
            curation_time: 2023-04-07 12:41:30
            location: N:/my_project/clustering/my_subject/msc_0002
            group_name: 12345_msc_0002
            sessions:
              - 2023-05-01 10:00:00
              - 2023-05-02 10:12:50
              - 2023-05-03 09:53:47
              - 2023-05-04 09:58:25
            notes: "Another clustering for this subject"

    .. code-tab:: json

        {
            "subject": {},
            "sessions": [],
            "clustering": [
                {
                    "curator": "user_3",
                    "curation_time": "2023-04-07 19:00:05",
                    "location": "N:/my_project/clustering/my_subject/msc_0001",
                    "group_name": "12345_msc_0001",
                    "sessions": [
                        "12345_1",
                        "12345_2"
                    ],
                    "notes": "first clustering for this subject, looks like some interesting results"
                },
                {
                    "curator": "user_2",
                    "curation_time": "2023-04-07 12:41:30",
                    "location": "N:/my_project/clustering/my_subject/msc_0002",
                    "group_name": "12345_msc_0001",
                    "sessions": [
                        "2023-05-01 10:00:00",
                        "2023-05-02 10:12:50",
                        "2023-05-03 09:53:47",
                        "2023-05-04 09:58:25"
                    ],
                    "notes": "first clustering for this subject, looks like some interesting results"
                }
            ]
        }



Full example
**************

A full example is shown below. The example includes two sessions, and two multi-session clusterings. In each category,
one entry shows the maximal, and the other the minimal, set of parameters that are allowed.

.. tabs::

    .. code-tab:: yaml

        subject:
          name: 12345
          datasource_id: 0
        sessions:
          - location: N:/my_project/recordings/my_subject/date_1
            name: "12345_1"                                             # Optional, note yaml's issues ducktyping numerics with an underscore
            experimenter:
              - user_1
              - user_2
            room: 2.345
            project: my_project
            probe_association:
              probe_1: npx_1_18408403232
              probe_2: npx_1_18408405241
            tasks:
              - task_type: OpenField
                arena_apparatus: 150_square
                task_start: 27
                task_stop: 1533.5
                notes: "the subject explored an open arena with no stimulation"         # optional
                light_level: dim                                                        # optional
                objects:                                                                # optional
                 - object_name: object_1
                    coord_x: 27
                    coord_y: 34
                    note: "tower made of smooth plastic"                                # optional, even if objects included
                cue_cards:                                                              # optional
                  - card_name: card_1
                    coord_x: 13
                    coord_y: -5
                    note: "left a bit off centre"                                       # optional
                curtains:                                                               # optional
                  - start_point: "bottom-left"
                    direction: "clockwise"
                    coverage: 25
              - task_type: SleepTask
                task_start: 1587
                task_stop: 2110
            clustering:
              - curator: user_1
                curation_time: 2023-04-05 12:13:14
                location: N:/my_project/recordings/my_subject/date_1/clustering_1
                notes: some notes about this one
              - curator: user_3
                curation_time: yes
                location: N:/my_project/recordings/my_subject/date_1/clustering_2

          - location: N:/my_project/recordings/my_subject/date_2
            name: "12345_2"
            experimenter: user_1
            tasks:
              - task_type: OpenField
                task_start: yes
                task_stop: yes
                notes: yes
            clustering: yes

        clustering:
          - curator: user_3
            curation_time: 2023-04-07 19:00:05
            location: N:/my_project/clustering/my_subject/msc_0001
            group_name: 12345_msc_0001
            sessions:
              - 12345_1
              - 12345_2
            notes: "first clustering for this subject, looks like some interesting results"

    .. code-tab:: json

        {
            "subject": {
                "name": 12345,
                "datasource_id": 0
            },
            "sessions": [
                {
                    "location": "N:/my_project/recordings/my_subject/date_1",
                    "name": "12345_1"
                    "experimenter": [
                        "user_1",
                        "user_2"
                    ],
                    "room": 2.345,
                    "project": "my_project",
                    "probe_association": {
                        "probe_1": "npx_1_18408403232",
                        "probe_2": "npx_1_18408405241"
                    },
                    "tasks": [
                        {
                            "task_type": "OpenField",
                            "arena_apparatus": "150_square",
                            "task_start": 27,
                            "task_stop": 1533.5
                            "notes": "the subject explored an open arena with no stimulation",
                             "objects": [
                                {
                                    "object_name": "object_1",
                                    "coord_x": 27,
                                    "coord_y": 34,
                                    "note": "tower made of smooth plastic"
                                }
                            ],
                            "cue_cards": [
                                {
                                "card_name": "card_1",
                                "coord_x": 13,
                                "coord_y": -5,
                                "note": "left a bit off centre"
                                }
                            ],
                            "curtains": [
                                {
                                    "start_point": "bottom-left",
                                    "direction": "clockwise",
                                    "coverage": 25
                                }
                            ]
                        },
                        {
                            "task_type": "SleepTask",
                            "task_start": 1587,
                            "task_stop": 2110
                        },
                        {
                            "task_type": "OpenField",
                            "task_start": true,
                            "task_stop": true,
                            "notes": true
                        }
                    ],
                    "clustering": [
                        {
                            "curator": "my_user_name",
                            "curation_time": "2023-04-05 12:13:14",
                            "location": "/path/to/example/2/clustering/1",
                            "notes": "some notes about this one"
                        },
                        {
                            "curator": "my_user_name",
                            "curation_time": "true",
                            "location": "/path/to/example/2/clustering/2"
                        }
                    ]
                },
                {
                    "location": "N:/my_project/recordings/my_subject/date_2",
                    "name": "12345_2",
                    "experimenter": "user_1",
                    "tasks": [
                        {
                            "task_type": "OpenField",
                            "task_start": true,
                            "task_stop": true,
                            "notes": true
                    ],
                    "clustering": true
                }
            ],
            "clustering": [
                {
                    "curator": "user_3",
                    "curation_time": "2023-04-07 19:00:05",
                    "location": "N:/my_project/clustering/my_subject/date_1_date_2",
                    "group_name": "12345_msc_0001",
                    "sessions": [
                        "12345_1",
                        "12345_2"
                    ],
                    "notes": "first clustering for this subject, looks like some interesting results"
                }
            ]
        }



.. _Ephys mass-ingestion updating:


----------------------------------------
Insertion, updating, and deduplication
----------------------------------------

The reference workflow around which mass ingestion was designed assumes that the user will compose a single input file
per subject, and upload progressively longer versions of that same file repeatedly over the course of a recording
campaign.

To support this design, each stage of an input file is checked for redundancy or duplication: i.e. does it refer to
sessions or clustering that have already been processed?

As of release, the workflow performs deduplication as follows:

* For every ``session`` entry, check for duplication of the combination (``username``, ``location``). Any ``session``
  entry for which these values have already been observed in the past: treat it as a duplicate and process no further
* For every (multi-session) ``clustering`` entry, check for duplication of the ``group_name`` attribute *for the
  requested subject*. If the ``group_name`` already exists for the subject, treat it as a duplicate and process no further

Where duplicates are discovered they are **excluded from further processing**. Therefore, you cannot (directly) use a
change in an input file as a tool to correct past errors/inconsistencies. The database does not, automatically, update
itself.


In the event that you need to fix one or more mistakes, you have several options to fix the mistake:

* It may be possible to replace the offending error through the web interface. For example, if you enter ``probe_association``
  information incorrectly, you can use the standard form for inserting that information correctly
* If you missed ``clustering`` or ``task`` information from a session, likewise, you can use the web interface.
* For more serious, or widespread, issues, it may be easier to delete the sessions with incorrect information, thus
  preventing deduplication from blocking their integration in a re-inserted input file.

In the event that delete-and replace is necessary, the following tables are relevant:

* ``acquisition.Session`` and downstream : all stored data relating to the session
* ``ingestion.SessionInsertRequest`` and downstream: all stored data relating to the ingestion of the session




.. _Ephys mass-ingestion faq:


-----------------------------
Frequently Asked Questions
-----------------------------

If an input file passes validation, does that guarantee everything will work?

* No. Input file validation checks for _many_ possible errors. But there are several conditions it can't check for:

    * Valid, but wrong, data. For example, the validator can check that the subject ID points to a known subject, but it
      cannot verify that that is the subject you *intended* to reference.

    * Data that requires executing some or all of the main pipeline logic to verify. For example, it will check that a
      requested location *exists*, but not check that it is a valid Session directory.

* Due to the processing time of the pipeline, it is *possible* for a file to pass validation, but to later be invalid due
  to the state of the pipeline changing before it finishes processing. This is an unusual event, but it is possible to
  occur.

* When inheritance is used (for example, ``task_start: yes``), it assumes that a valid value will (eventually) be available
  to inherit. If that inheritance is delayed, or fails due to some error, it may wait indefinitely.


If I make a mistake in an input file, can I upload a second, corrected copy to fix that mistake?

* It depends on the nature of the mistake, but mostly, no.

* In general, mass ingestion implements "deduplication", i.e. if it recognises a session or multi-session clustering as
  already existing, it ignores it (and any changes inside). To fix an error, you need to delete the records of the old
  entry in order for it to be recognised as a new session (with your corrections in place).

* Duplication is recognised as follows:

    * For Sessions, the location of files and your username.

    * For multi-session clustering, the ``group_name``. A ``group_name`` must be globally unique. If you re-use a
      ``group_name`` for a single animal, it is assumed to be a duplicate. If you re-use a ``group_name`` that is already
      in use for another animal, the file will fail validation.



Why support both YAML and JSON? Why not pick one?

* The two languages have different strengths. ``yaml`` is easier to compose, in general, but has a set of odd or unexpected
  behaviours to watch out for. ``json`` is much more pedantic to write, but offer no ambiguity once the file is accepted
  as valid.

* ``.yaml`` is a format that implements Python-style duck typing. In certain cases, this can result in unexpected
  behaviour where common human language usage clashes with the specifications used in the language's implementation.
  Some common pitfalls are noted below:

  * Hexadecimal values, such as the hashes used as animal_ids, must be surrounded by quotation marks (``""``) to mark
    them as strings, rather than integers.

    * Example: ``f4fab316a8743038`` will be interpreted as an integer (17,652,618,599,328,919,608 in base 10), while
      ``"f4fab316a8743038"`` ill be interpreted as a string literal.

  * Underscores within otherwise numeric values will be assumed to be markers for human readability, and the result will
    be a numeric value, absent the underscores, *not* a string literal including the underscores. This remains true `even
    if the value is subsequently cast to a string`.

    * Example: ``102_1`` will be interpreted as the integer ``1021``, while ``"102_1"`` will be interpreted as a string
      ``"102_1"``.

  * The following values, if not wrapped in string quotes, are assumed to be booleans: (``yes, no, true, false, up, down``),
    regardless of capitalisation. This issue is particularly relevant in a country where the two-letter country code ``no`` is
    treated as ``False``. When wrapped in string quotes, they are treated as string literals.

* ``.json`` does not implement duck typing, and essentially only handles string and numeric types. It is much, much more
  verbose than yaml, and generally harder to compose correctly (since, as object notation for javascript, it was never
  intended to be composed by humans). However, compared to ``yaml``, it has significantly fewer opportunities for ambiguity.
