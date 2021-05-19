.. _Ephys Terminology:

======================================
Ephys: Terminology
======================================




Due to the divergent development process, some different terminology has evolved between the imaging and ephys pipelines. This page, and it's :ref:`imaging twin<Imaging Terminology>`, will cover some of the distinctions. 



Sessions, Tasks, and Recordings
--------------------------------------

In the Ephys pipeline, the top level grouping of recording data is the **Session**, approximately equivalent to the Imaging pipeline's *MetaSession*. 

A **Session** collectively groups together some quantity of electrophysiology and/or tracking data, gathered at the same time and within the same recording room. 

A **Session** may contain one or more **Recordings**. A **Recording** is a single, contiguous, block of acquired data, within a single **session**. Multiple recordings are supported in the case of either breaking up individual epochs, or in the case of some technical malfunction causing data acquisition to end unintentionally, and then be re-started. 

A **Session** may contain one or more **Tasks**. A **Task** is a contiguous block of time in which a single activity is monitored. For example, a **Task** might consist of the subject running in an open field. A **Task** is associated with a single arena, objects in the arena, etc. 

**Tasks** may *or may not* correspond to separate **Recordings**. The two concepts are not necessarily linked, although researchers *may* find it convenient to stop and start data acquisition (starting a new **Recording**) as a way to indicate the end of one **Task** and the beginning of another. 

One **Recording** may contain multiple **Tasks**, and one **Task** may be split across multiple **Recordings**.

Both **Recordings** and **Tasks** are approximately equivalent to the concept of *session* in the Imaging Pipeline.


Task Events
-----------------

**Task Events** provide a way to label things that occur within a broader **Task**. For example, the timing of stimulation events, such as photo-stimulation or provision of rewards. 

The **TaskEvent** table can more properly be understood as a task event *stream*: a single entry in the ``TaskEvent`` table provides space to store an *array* of start and stop times - e.g. all of the on and off times of laser pulses for photo-stimulation.
