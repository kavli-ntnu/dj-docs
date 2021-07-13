.. _Ephys processing

======================================================
How is data in the Ephys pipeline processed?
======================================================

Part of the purpose of the pipeline is to perform, and standardise, the post-processing that is applied to all data in our lab.



Analysis Parameters
-------------------------

Users can create and work with as many analysis parameter sets as they would like.


Species specific analysis parameter groups
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


The ``analysis`` schema supports specieis specific parameter sets. Any parameter set appended either ``_rat`` or ``_mouse`` will *only* apply to animals of that species. Any parameter set _not_ so appended will apply to both species, subject to any other restrictions on that parameter set


Analysis and Screening section
----------------------------------------

The analysis and screening section is intended to provide researchers with an overview of their data. It is not intended, nor capable, of entirely replacing your own, specialist, analysis.




Tracking data
------------------------

Short tracking data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Where there is "missing" tracking data, e.g., where the spike recording began before, or ended after, the position recording, the tracking data is padded to at least the same length via prepended/appended NaN values, in the ``processed.Tracking`` table and subtables. Consequently, the length of timestamps in ``tracking.Tracking`` and ``tracking.ProcessedTracking`` is *not* guaranteed to be the same length. 


Speed smoothing
^^^^^^^^^^^^^^^^^^^^^^

Raw position data is extracted from whatever tracking data format is used (e.g. Optitrack, or the Axona or Neuralynx trackers).

Speed data is calculated frame-by-frame by the distance moved divided by the frame rate. Speed data is then smoothed by a `LOESS prediction <https://en.wikipedia.org/wiki/Local_regression>`_.

Speed data is saved after smoothing with a tricubic window determined by the larger of either (0.8s, 32 frames).

The smoothing is extremely computationally intensive for long recordings. 

Speed and the Walk Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Data presented in the ``analysis`` schema and later (e.g. in ``analysis.TaskTracking``, ``analysis.TaskSpikesTracking`` and then used in screening tools such as ratemaps) have a walk filter applied. The walk filter excludes *all* data, both positional and spike, for all times at which the animal is moving below a specified speed (specified in the ``analysis_param.CellSelectionParams`` table in column ``speed_cutoff``. By default, this is 2.5cm/s for mice, and 5cm/s for rats. 

The walk filter is calculated using the same LOESS prediction method, but with a longer window: 2.5s. The walk filter is determined as:
.. code-block:: python
   :linenos:
    speed = smooth(raw_speed, 0.8)
    extra_smooth_speed = smooth(raw_speed, 2.5)
    to_include = extra_smooth_speed >= SPEED_CUTOFF
    speed = speed[to_include]
    x_pos = x_pos[to_include]
    ...


An unfiltered set of data is available via the ``CellSelectionParams`` method ``default_unfiltered``. 

If writing your own analysis, you can:

* access the filtered data via the ``analysis.TaskTracking``, analysis.TaskSpikesTracking` and later tables

* access the unfiltered data via the ``tracking.ProcessedTracking`` and ``ephys.SpikesTracking`` tables, **or** via the ``analysis.TaskTracking``, ``analysis.TaskSpikesTracking`` via the ``default_unfiltered`` CellSelectionParams method

* Reproduce the walk filter criteria via the ``tracking.ProcessedTracking.SmoothedSpeedForFiltering`` table. 




Spike data
-------------------
