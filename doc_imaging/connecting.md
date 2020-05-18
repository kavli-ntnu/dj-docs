## Connecting to the Imaging pipeline

The Imaging pipeline is split into two schemas: the common animal database, and . Each schema requires its own module, either imported from raw Python code or generated from virtual modules. The following code block will generate all the necessary virtual modules

```python
animal = dj.create_virtual_module('animal', 'prod_mlims_data')
imaging = dj.create_virtual_module('imaging', 'group_imaging_1b')
```