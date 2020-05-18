## Ingesting data into the Imaging Pipeline

### Base Folder

The Base Folder is the main entry point for ingesting data into the imaging pipeline. 

The input directory is only recognised as a Windows-style path (Example: `N:/path/to/file`), Unix style paths are not currently recognised. 

Paths to data must match the expectations of the worker server: these are configured as best I understand general lab conventions, *but they may not be the same as you use in your lab/office computers.*

The Imaging worker server understands the following locations:

* Moser network share as `N:/`. This is the location that exists at `\\forskning.it.ntnu.no\ntnu\mh-kin\moser`. Internally, the Imaging pipeline refers to this repository as `Lager`

* 2P as `F:/`. This is one of two main directories on the **Dirk** storage server in use at Kavli. It physically exists as `\\129.241.172.30\2p`. Internally, the Imaging Pipeline refers to this repository as `Moser_imaging`

* 2Pmini as `G:/`. The is the other main directory on the **Dirk** storage server in use at Kavli. It physically exists as `\\129.241.172.30\2pmini`. Internally, the Imaging Pipeline refers to this repository as `2Pmini`.

