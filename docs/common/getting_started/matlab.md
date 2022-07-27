## Getting Started with Datajoint (Matlab)

This guide will cover what you need to do to begin working with the Electrophysiology and Imaging pipelines in user in the Moser Group at the Kavli Institute for Systems Neuroscience. 

### Programming Language

Datajoint is available as a library in both Python and Matlab, and the database can be accessed from either language. Main development and support takes place primarily in Python, and if you are new to programming, we recommend that you use Python. Experienced Matlab or Python developers should continue using their language of choice. This guide covers the process for getting started with Datajoint in **Matlab**.

#### Installing Matlab

Matlab can be installed from [NTNU's Software centre ](https://software.ntnu.no/matlab). Follow the instructions at the software page to install. We recommend using R2019b, and you **must** use a version no older than R2015b.

#### Installing Datajoint 

Datajoint is made available as a custom toolbox from the [Matlab File Exchange ](https://www.mathworks.com/matlabcentral/fileexchange/63218-datajoint):

On older version (e.g. R1027)
* Navigate to the [Datajoint Toolbox](https://www.mathworks.com/matlabcentral/fileexchange/63218-datajoint) on Matlab file exchange
* Click on "Download" and select "Toolbox"
* After the download completes, open the downloaded `DataJoint.mltbox"
* CLick on "Install" and follow the on-screen instructions

On newer versions (R2018 onwards):
* Open the Add-Ons manager and search for `DataJoint`
* Select "Install"

You can verify correct installation by calling the following in the Matlab command prompt:
```matlab
>> dj.version;
```

Full access to the pipelines in use at Kavli requires **version 3.4.1 or higher**.

### Getting connected

After installing the Datajoint toolbox, there are two further steps
* Getting a local copy of the table definitions
* Setting up your credentials to access the pipeline and the external storage location

#### A local copy of code

[Clone](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository) the ephys repository from [Github](www.github.com/kavli-ntnu/dj-elphys). 

We recommend using the [Github Desktop application](https://desktop.github.com/) app for this, as it is much more user friendly than the command-line interface. 

#### Credentials

An example configuration file is provided in the repository's base directory, `dj_local_conf_ntnu.json`. You will need to
first **rename** this file to `dj_local_conf.json`, and then edit it to insert your credentials, e.g. with Notepad. Renaming 
the file is to ensure that you do not accidentally commit your credentials back to the Git repository.

You need to edit 4 values in total:
* your username
* your password
* the external storage access key
* and the external storage secret key

Your username is the same as your NTNU username
```json
"database.user": "simoba",
```
Your password is NOT the same as your NTNU password. If you have lost your password, or have not been given one, contact Simon Ball to request a new password
```json
"database.password": "omg-a-secret-password",
```
The external storage credentials are available on the [Kavli Wiki](https://www.ntnu.no/wiki/display/kavli/DataJoint%3A+Electrophysiology+Pipeline)



#### Working with code

Finally, code initialisation is taken care of by the file `/MATLAB/ephys_pipeline/init.m`. Running this script will import the credentials from the file `dj_local_conf.json` at the base of the `dj-elphys` directory, and initialise objects representing the various parts of the pipeline. These objects are prefixed with `v_`, to indicate that they are _virtual_ objects, and do not have the "business logic" code that defines how tables are populated (equivalent to the "virtual modules" created in Python)

#### Fetching data

The MatLab-Datajoint client is similar, but not identical to, the Python client, and some operations are processed a little differently. The main one to be aware of is how to fetch data. 

In Matlab, you fetch data with the top-level commands `fetch` and `fetch1`:
```matlab
init;
keys = fetch(v_analysis.RateMap);
data = fetch(v_analysis.RateMap & keys(1:10), '*', 'ORDER BY unit');
imshow(data(2).ratemap, [0,1]);
```

The main Matlab-Datajoint documentation [can be found here](https://docs.datajoint.io/matlab/)