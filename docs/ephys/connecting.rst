.. _Ephys connecting:

==============================
Ephys: Connecting
==============================

The Ephys pipeline is split into multiple separate schemas by theme. Each schema requires its own module, either imported from raw Python code or generated from virtual modules. The following code block will generate all the necessary virtual modules

.. code-block:: python
   :linenos:
    
    import datajoint as dj
    animal = dj.create_virtual_module('animal', 'prod_mlims_data')
    reference = dj.create_virtual_module('reference', 'group_shared_reference')
    acquisition = dj.create_virtual_module('acquisition', 'group_shared_acquisition')
    tracking = dj.create_virtual_module('tracking', 'group_shared_tracking')
    behavior = dj.create_virtual_module('behavior', 'group_shared_behavior')
    ephys = dj.create_virtual_module('ephys', 'group_shared_ephys')
    analysis = dj.create_virtual_module('analysis', 'group_shared_analysis')
    analysis_param = dj.create_virtual_module('analysis_param', 'group_shared_analysis_param')


Individual tables can then be accessed as elements of the above modules.

