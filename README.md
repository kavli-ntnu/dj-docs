# Datajoint @ Kavli Documentation

[![Documentation Status](https://readthedocs.org/projects/moser-pipelines/badge/?version=latest)](https://moser-pipelines.readthedocs.io/en/latest/?badge=latest)

**The official Datajoint Documentation on the two core pipelines in use in the Moser Group at the Kavli Institute can be found [here](https://moser-pipelines.readthedocs.io/en/latest/index.html).** This repository is the source.

## Contents

* Usage
  * Getting started with Datajoint
    * [Getting Started in Python](docs/common/getting_started/python.md)
    * [Getting Started in Matlab](docs/common/getting_started/matlab.md)
    * [Where to find help](docs/common/troubleshooting.md)
    * [Nomenclature: terms used in ephys and imaging pipelines](docs/common/nomenclature.md)
  * Ephys
    * [Connecting to the pipeline](docs/ephys/connecting.md)
    * [Ingesting new data via the web GUI](docs/ephys/ingestion_webgui.md)
    * [Fetching data from the pipeline](docs/ephys/fetching.md)
  * Imaging
    * [Overview](docs/imaging/Overview.md)
    * [Installation](docs/imgaing/Installation.md)
    * [Folder logic](docs/imaging/Folder-logic.md)    
    * [Adding sessions](docs/imaging/How-to-add-sessions.md)
    * [Helper notebooks](docs/imaging/Helper-notebooks.md)
    * [Synchronisation](docs/imaging/Sync.md)
    * [FOV Unwarping](docs/imaging/FOV-unwarping.md)
    * [Desktop screening GUI](docs/imaging/Session-viwer-GUI.md)

* Technical details
  * [Pipeline architecture](docs/technical/architecture.md)
  * [Database server](docs/technical/database.md)

## Notes

Something about the `docutils` package v0.17.1 breaks bullet pointed lists. Currently pinned to 0.16, review when either 0.17.2 or 0.18 comes out
