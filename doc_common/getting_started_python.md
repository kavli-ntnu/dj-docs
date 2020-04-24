## Getting Started with Datajoint (Python)

This guide will cover what you need to do to begin working with the Electrophysiology and Imaging pipelines in user in the Moser Group at the Kavli Institute for Systems Neuroscience. 

### Programming Language

Datajoint is available as a library in both Python and Matlab, and the database can be accessed from either language. Main development and support takes place primarily in Python, and if you are new to programming, we recommend that you use Python. Experienced Matlab or Python developers should continue using their language of choice. This guide covers the process for getting started with Datajoint in **Python**.

#### Installing Python

The pipelines require at least Python 3.6. We recommend using one of the *conda distributions of Python, and this guide will focus on installing Miniconda. These distributions include the Conda tool, which allows you to set up and manage separate Python environments for different projects to help avoid dependency conflicts. 

More information on working with Conda environments is available in the [Conda official documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

If you will only work with one pipeline or the other, skip the step that is not relevant to you

* Install [Miniconda Python 3.7](https://docs.conda.io/en/latest/miniconda.html).
  * Install in a directory that has no spaces in its path. 
  * [If on WIndows] Select the option to add Python to the Windows PATH
* Install the Jupyter tool in your base environment
  * We recommend using the Anaconda command prompt for command-line work
    * In Windows 10, search for `anaconda` and select the Anaconda Command Prompt
  * Ensure you are in the `base` environment
    * `conda activate base`
    * `conda install jupyter nb_conda_kernels` 

In general, we recommend using the `conda` package manager in preference to `pip` wherever possible, as `Conda` does a better job to maintaining a consistent and reproducible state. Mixing both package managers should be done with care, as it can produce environment states which are hard to reproduce.

The Ephys and Imaging pipelines have subtly different requirements. Therefore, we recommend creating separate environments if you need to work with both. If you only work with one, skip the irrelevant section. 

##### Creating an environment for Electrophysiology

* Create a new Conda environment for the **Ephys** pipeline
  * Create an environment with the following:
    * `conda create --name ephys python=3.6`
    * Confirm creation by pressing `Y`
    * This creates an environment with the name `ephys` 
  * Activate the newly created environment to begin using it
    * `activate ephys
  * Install the necessary packages
    * `conda install datajoint graphviz python-graphviz pydotplus ipykernel`

##### Creating an environment for Imaging 

* Create a new Conda environment for the **Imaging** pipeline
  * Create an environment with the following:
    * `conda create --name imaging pythong=3.6`
  * Activate the environment
    * `activate imaging`
  * Install the necessary packages
    * `conda install graphviz python-graphviz pydotplus ipykernel`
    * `pip install datajoint==0.12.dev4`

##### Working with Conda environments in Jupyter

Jupyter is a popular interactive tool for working with Python. You can install Jupyter in your base Conda environment and use it with other environments that you have created on your computer given these steps:

* In the environment _you wish to make available_ (e.g. `ephys`):
  * `activate ephys`
  * `conda install ipykernel`
* In the environment *from which you run Jupyter* (e.g. `base`):
  * `activate base`
  * `conda install juypter nb_conda_kernels`
* When you run Jupyter, you can select the Python Kernel matching the `conda env` name you wish to operate on

##### Working with Conda Environments in Spyder

`Spyder` is a popular Python development environment. It is natively installed with any *conda Python distribution. If you do not have it installed, you can install it with either `conda` or `pip` (it is a Python package like any other)

```python
conda install spyder
```



Spyder does not directly support either `conda` environments, or the older styles `venv` virtual environments. However, you can work with them anyway in one of two ways:

* Install `spyder` into the environment you wish to use, and use the resulting binary to run `spyder`
* Install `spyder-kernels` into the environment you wish to use, and use `spyder` installed from the base environment.

In the latter case, you must change `spyder` Preferences to use the appropriate Python interpreter. You can find the correct path by running the following code _inside the environment you wish to use_:

```python
python -c "import sys; print(sys.executable)"
```

And then copying this path to the provided textbox in `Preferences >Python Interpreted > Use the following interpreter`




### Connecting to the pipeline database

The fundamental building block of the pipeline is the database server that stores processed data. Each pipeline is made up of several _schemas_, each of which contains many _tables_. 

To connect to and interrogate the pipeline, you require two things:

* Access credentials and configuration for the database
* Interface classes to the schemas and tables

Access credentials are shared between both pipelines. Configuration is somewhat different, and interface classes are completely different 

#### Connecting to the Electrophysiology Pipeline

The following code block will generate the appropriate access configuration, and save it to your computer for future use. You will need to fill in the four variables at the top before executing this code in the appropriate Python environment.

You will use your NTNU username, but the password is separate - contact Simon Ball or Haagen Wade for a password. The `ACCESS_KEY` and `SECRET_KEY` values are available on the [Kavli Wiki](https://www.ntnu.no/wiki/display/kavli/DataJoint%3A+Electrophysiology+Pipeline).

##### Once-off configuration

You should only need to execute this code block once, and the computer on which it was executed will remember your configuration. The code defining `drive_config` is platform and computer specific: the example provided here is for a Windows computer that has mounted the `\\forskning.it.ntnu.no\ntnu\mh-kin\moser` shared network drive at `N:\`. Users on Linux or Mac, or users on Windows with a non-standard mounting, must adjust the settings below to match their local system. 

```python
ACCES_KEY = ""
SECRET_KEY = ""
USERNAME = ""
PASSWORD = ""
import datajoint as dj
dj.config['database.host'] = 'datajoint.it.ntnu.no'
dj.config['database.user'] = USERNAME
dj.config['database.password'] = PASSWORD
dj.config["enable_python_native_blobs"] = True
dj.config["stores"] = {
    'ephys_store': {   
        'access_key': ACCESS_KEY,
        'bucket': 'ephys-store-computed',
        'endpoint': 's3.stack.it.ntnu.no:443',
        'secure': True,
        'location': '',
        'protocol': 's3',
        'secret_key': SECRET_KEY},
    'ephys_store_manual': {   
        'access_key': ACCESS_KEY,
        'bucket': 'ephys-store-manual',
        'endpoint': 's3.stack.it.ntnu.no:443',
        'secure': True,
        'location': '',
        'protocol': 's3',
        'secret_key': SECRET_KEY}}
dj.config['custom'] = {
		'database.prefix': 'group_shared_',
		'mlims.database': 'prod_mlims_data',
        'flask.database': 'group_shared_flask',
        'drive_config': {
          'local': 'C:/',
          'network': 'N:/'}}
dj.config.save_global()
```



##### Each script configuration

The following code block will produce the interface classes you need to interrogate the pipeline. This code block needs to be repeated in each script or notebook you use

```python
animal = dj.create_virtual_module('animal', 'prod_mlims_data')
reference = dj.create_virtual_module('reference', 'group_shared_reference')
acquisition = dj.create_virtual_module('acquisition', 'group_shared_acquisition')
tracking = dj.create_virtual_module('tracking', 'group_shared_tracking')
behavior = dj.create_virtual_module('behavior', 'group_shared_behavior')
ephys = dj.create_virtual_module('ephys', 'group_shared_ephys')
analysis = dj.create_virtual_module('analysis', 'group_shared_analysis')
ingestion = dj.create_virtual_module('ingestion', 'group_shared_ingestion')
analysis_param = dj.create_virtual_module('analysis_param', 'group_shared_analysis_param')
```

Tables can then be accessed as object descendents of the above 9 Classes. For example:

```python
analysis.RateMap()
```





#### Connecting to the Imaging Pipeline

* TODO