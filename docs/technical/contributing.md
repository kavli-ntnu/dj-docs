## How to contribute

The pipeline infrastructure at Kavli is a large and complex software undertaking, with numerous moving parts, stored in numerous code repositories. 

Have you found a bug, or just something that could be improved? Contributions are welcome

* The simplest option is to tell one of the maintainers (see below)
* Better: open an issue in the relevent code repository
* Best: Fork the repository, make your changes, and make a Pull Request to have your changes reviewed and merged back into the main code base. 

## Components of the pipeline

### User interfaces

#### Documentation

The documentation is written in a mixture of MarkDown and ReStructured Text. New pages should be written in ReStructured Text, and where substantial modifications are made to MarkDown formatted pages, they should be converted.

Problems can be reported to Simon Ball, and fixes are welcomed as Pull Requests to the [documentation repository](https://github.com/kavli-ntnu/dj-docs).

Documentation is hosted on [ReadTheDocs](https://moser-pipelines.readthedocs.io/en/latest/).

#### Web GUI

The web gui is written in Python using the `Flask` microservices framework and served via `nginx`. The code base and static and template objects are stored in the `dj-GUI` repository

#### Imaging: Session Viewer

The session viewer is written in Python using the PyQT5 framework, and stored in the `dj-imaging-user` repository. Originally written by Horst Obenhaus, now maintained by Simon Ball.

#### Ephys: Kavli Gui

The Kavli Gui is written in Python using the PyQT5 framework, and stored in the `kavli-gui` repository. Written and maintained by Simon Ball

### Backend code

#### Pipeline population logic

The pipelines are defined by a large amount of "business logic": this defines what happens to populate each table, and any other assistant logic needed to support those population functions. The code is separated by pipeline:

* The Ephys pipeline code is stored in the `dj-elphys` repository, and includes loader functions for reading each of the raw data file types currently in use. Written and maintained by Thinh Nguyen and Simon Ball

* The Imaging pipeline code is stored in the `dj-moser-imaging` repository. Originally written by Horst Obenhaus, and maintained by Horst Obenhaus, Thinh Nguyen and Simon Ball

#### Analysis code

Code to perform the various screening analyses (essentially, everything after combining position and spike data to produce SignalTracking) are stored in two separate repositories. Unlike most of the pipeline code, these libraries are open source. 

* [Behavoural Neurology Toolbox](https://bitbucket.org/cnc-ntnu/bnt/src/master/): the original Matlab toolbox in use at Kavli. Originally written by Vadim Frolov, and now maintained by Simon Ball

* [Opexebo](https://github.com/kavli-ntnu/opexebo): the Python translation of much of the Matlab toolbox. Written and maintained by Simon Ball. Documentation is available on [ReadTheDocs](https://opexebo.readthedocs.io/en/latest/)

#### Assistant tools and helpers

Various assistant tools have been written to help administer the pipeline. Where that code is pipeline-specific, it is stored with the population logic. Additionally, the `dj-utils` repository stores assorted tools:

* Database user management

* Ephemeral server deployment configuration (written with Ansible)

* Database server configuration details

* Pipeline initialisation code. 

### External components

The pipelines also depend on several external components, over which the pipeline maintainers have reduced or no control:

* mlims: Kavli institute colony management system

* File storage: raw data is typically stored on the `forskning` redundant network storage drive. 

* Object storage: intermediate processed data is stored on an s3-compatible storage system run by NTNU (`ceph` based)

* Openstack: Worker servers are virtual machines run in NTNU's Openstack infrastructure. VMs are configured by the configuration code in `dj-utils`. 
