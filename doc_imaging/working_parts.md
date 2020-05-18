## Scopes and Setups: representations of the hardware in the database

Part of the metadata for a recording session is the details of the hardware used to record that session. In the Imaging pipeline, that means the various micoscopes in use, and their associated controllers.

The Imaging pipeline tracks these in two primary tables:

* `imaging.Scope` describes the objective and scanner combination. A different `Scope` has a different field of view, and different abberations (warping). This is only relevant for the miniscopes, as it is not possible to change this on the Femtonics system

* `imaging.Setup` describes the rest of the hardware. For the Miniscopes, this covers the laser, detectors, and the electronics that control them. For the Femtonics system, this is functionally equivalent to `imaging.Scope`. 

`Setup` is the main element that ties together the raw data, and the description of how to read and pre-process that raw data to get to a standardised intermediate format that can be fed to Suite2p.