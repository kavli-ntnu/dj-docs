.. _Ephys naming:

======================================
Ephys Naming Conventions
======================================

The Ephys pipeline will, over time, build up numerous lists of user-entered names and labels. It is important that individual researchers give at least some thought to how they name entries in the pipeline in order to keep these lists meaningfully searchable.

- Be *systematic*: Calling your objects "ham" "spam", and "eggs" tells you nothing at all about what the object is or if it relates to you. Try to use a consistent, systematic approach to naming objects, preferable using the conventions discussed below

- Be *specific*: "my_probe" is a common *example* of a name, but is a terrible name in *practice* - who is "me"? Which of my probes is it?

- Be *relevant*: "ksyqhsghd" will almost certainly be unique and no-one else will want to use it. But you won't be able to remember it, nor figure out what it means or why it was used. 

- Be *descriptive*: "arena_1" provides no information about the size or shape of the arena

- Be *brief*: "probe_neuropixel_2_multi-shank_sn1234567890_subject_98765" is specific and relevant, but you're pretty much guaranteed to make numerous errors each time you have to type it out. Database columns often have specific character limits that you must fit within. 




When trying to come up with a name, consider the following:

- Names are often used for uniqueness, and you are not the only user of the pipeline - try not to "monopolise" common words, phrase, conventions that everyone might need

- Likewise, try not to identify specific things as yours that are not necessarily unique to you - For example, numerous people might use an identical 1m arena, and so rather than "claim" a 1m arena entry as your own, make it non-user-specific. 

- You wmay need to pick this name out of a long list of unrelated objects at some future point. Plan to make it easier on your future self. It is always a pleasant (and unusual) surprise when your past-self turns out to have, in fact, *not* been a jerk.





.. _Ephys naming probes:

Probe names
---------------------

For tetrodes, the standard probe naming convention is as follows::

  tetrode_<subject_id>

For example, that might result in::
  
  tetrode_98765

(A tetrode implanted in subject 98765)

For Neuropixel probes, it is strongly recommended to use the probe's serial number, or to include the serial number as a
component of a longer name. Use of the serial number allows the probe-association (see :ref:`Ephys web-gui ingest`) step
to happen automatically::

  <serial_number>_<subject_id>_<#>

For example::

    123456789_32859_2
  
(The second Neuropixel probe implanted in subject 34567, with serial number 123456789)




.. _Ephys naming arenas:

Arena Names
------------------

The standard arena naming convention is::

  <dimension>_<shape>_<height>

For example::

  050_square
  100/150_rectangle_50
  400_square

More unique names *can* be given if an arena is less generic, but a more informative name is preferred where possible




.. _Ephys naming multisession-clustering:

Multisession Clustering
---------------------------

In the case of multisession clustering, the user must provide a manual cluster group naming. The standard group naming in this case is, subject to a limit of 64 characters. If a very large number of sessions are grouped together, it may be sensible to specify only a first and final session date, rather than all sessions dates::

  <subject_id>_<session_time_1>_<session_time_2>_...
  
For example::

  26966_2020-12-14_2020-12-16
