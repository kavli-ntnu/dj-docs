This page documents the jupyter notebooks available under [/Helper_notebooks](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks).

# Introductory notebooks
- [Starting notebook](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Starting%20notebook.ipynb): Boilerplate notebook - starts by loading the schema code and making a connection to the database. This can be re-used for whatever purpose. 
- [Starting notebook - follow the tree](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Starting%20notebook-%20follow%20the%20tree.ipynb): Follows the main branches of the schema. This is a good starting point if you haven't worked with the imaging database before and just want to get a rough overview over what is there.
- [SpatialAnalysis plotting](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/SpatialAnalysis%20plotting.ipynb): Shows how to plot results for spatial analyses like path-spike plots, ratemaps, etc. 

# Notebooks for adding information 
In order for downstream processes to run correctly, users have to add information after the basic processing has run through and `Session`, etc. entries are created. 

At the moment this concerns the `Session.SessionType` and `Session.ArenaObject` tables for session type (open field, wheel, etc.) and object type and locations in open field sessions respectively.

- [Fill in session type and apparatus information](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Insert%20Session%20Type.ipynb): Looks for Session entries that do not yet have a matching `Session.SessionType` part table entry and presents user with a little notebook GUI to supplement that information. At the same time the user also fills the `Session.Apparatus` table. 
- [Annotate object locations in open field tracking](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Enter%20object%20locations%20Napari.ipynb): Loads object session tracking data and builds a little GUI (based on [Napari](https://napari.org/)), in which people can specify object locations.  
![Object location adding via Napari](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/wiki_files/Napari_object_locations.png)

### More specialized notebooks
- [FOV unwarping](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Insert%20FOV%20unwarping.ipynb): 2p miniscope raw recordings undergo distortions because of uncalibrated scanner responses to command voltages (and are therefore different for every scope vs. setup combination). In order to obtain undistorted cell maps and projections, we can unwarp these (raw) field of views by comparing with a calibration slide. The process of saving a calibration (=affine transformation) matrix into datajoint is shown in this notebook. For a more thorough explanation check [FOV unwarping](https://github.com/kavli-ntnu/dj-moser-imaging/wiki/FOV-unwarping).

# Useful routines 
- [Unwarp tif files](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/Unwarp%20tiff%20files.ipynb): Quick and easy way to obtain undistorted tif files and view those with [Napari](https://napari.org/). See quick explanation below ('FOV unwarping').
- [Suite2p python reader](https://github.com/kavli-ntnu/dj-moser-imaging/blob/master/Helper_notebooks/suite2py%20reader%20class.ipynb): Notebook that shows the usage of the suite2p python reader class, which is also used when loading suite2p output into datajoint. It provides convenience functions for rapidly investigating suite2p python exports and plotting results of the imaging analysis. 
