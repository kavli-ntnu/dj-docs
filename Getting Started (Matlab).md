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
>> dj.version
```

### Connecting to the Electrophysiology Pipeline

* TODO

### Connecting to the Imaging Pipeline

The Imaging pipeline is not currently supported in Matlab