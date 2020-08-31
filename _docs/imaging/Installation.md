#Imaging:  Installation
Step by step installation (some optional and windows only):

- Download [github desktop](https://desktop.github.com/) and 
- Clone this repository
- Clone [Suite2P python](https://github.com/MouseLand/suite2p) into `helpers/suite2p-python` (it is also possible to pip install, but chose this way to get most recent updates/bugfixes more directly)
- Optional: Clone [rastermap](https://github.com/MouseLand/rastermap.git) into `helpers/rastermap`
- Mount file servers and make sure entries for shares are correct in `network_drives.cfg`. **Important** Make sure **no trailing slashes** are in the drive configuration. Meaning: Do not write `F:/`, but `F:`
- In `network_drives.cfg` also edit the section [suite2yops] if you want to run suite2p python locally (it specifies a local "fast" disk for processing suite2p python jobs - see network_drives.sample)
- copy the auth.sample file and rename to `auth.cfg`. Edit section [dj_auth] and if you want slack interaction to work also [slack_auth]. If you do not have a any slack API token do not delete that section but fill it with something. 

### Windows specific
- Install git (windows): https://git-scm.com/download/win
- Install [miniconda3](https://conda.io/miniconda.html)
- `conda create -n analysis python=3.6` - will create a python3.6 environment called `analysis`
- activate environment with `activate analysis` 

### Ubuntu specific
- pip: `sudo apt-get install python3-pip`
- python3.6: `sudo apt-get install python3.6-dev`
   - find out where python3.6 was installed: `which python3.6`. This path will be inserted in the virtualenv command below. 
- virtualenv: `sudo pip3 install virtualenv `
- `virtualenv -p /usr/bin/python3.6 dj36` - will create a python3.6 environment called `dj36` (can be called `analysis` as well of course). _/usr/bin/python3.6_ refers to the path that was found above when running _which python3.6_.
- activate environment with `source dj36/bin/activate` (or whatever you called your environment)

### Common
- Change into the dj-moser-imaging folder and `pip install -r requirements.txt`
    - **> February 2020**: The following requirements text files work well on MAC and WINDOWS:
        - MacOS:     requirements_horst_11022020.txt
        - Windows10: requirements_torstl_11022020.txt

- `pip install datajoint==0.12.4` (newer versions should be safe to install but not are not tested)
- Install scanreader package `pip install git+https://github.com/atlab/scanreader.git`
- Install opexebo `pip install git+https://github.com/kavli-ntnu/opexebo.git@v0.4.2`. If this runs into an error on Windows, [follow these instructions](https://github.com/kavli-ntnu/dj-elphys/wiki/Zero-to-datajoint#install-microsoft-build-tools) to download/install Microsoft Build Tools 2019 from Microsoft 
- Create the folder `log` inside dj-moser-imaging if it does not exist

___
### For using **helper** notebooks
- `pip install tabulate`
### For using **session viewer GUI** 
- `pip install --pre "pyqtgraph>0.10"`
_Careful_: Pyqtgraph requires `PyQt5==5.14` or older. If newer versions are installed you are running the risk of not being able to click buttons.


---
Additional packages:
- To use the notebooks, install [jupyter lab](https://github.com/jupyterlab/jupyterlab)
    - `pip install jupyter_contrib_nbextensions`
    - Install jupyterlab ipywidgets as described on https://ipywidgets.readthedocs.io/en/latest/user_install.html

- Install [Graphviz](https://graphviz.gitlab.io/download/) to visualize the tree ([ERD](https://docs.datajoint.io/data-definition/ERD.html)). Be sure it is accessible from your path. For example, you can call `gvpr` and be sure you get some kind of output and not a 'program not found' notice.

