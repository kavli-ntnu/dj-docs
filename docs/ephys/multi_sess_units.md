## Ephys: following units across multiple sessions

By default, the Ephys pipeline offers zero guarantees about the consistency of unit identities across separate sessions, as this happens, if at all, on the level of clustering, independent of the pipeline. Consequently, responsibility for ensuring that the units are actually correctly mapped from one session to the next **remains with the researcher**

There are three approaches by which you can maintain this important information


### Option 1: multisession clustering

In this case, the clustering routine is applied simultaneously to multiple sessions, naturally yielding consistent, unique, cell identifiers. 

The researcher is responsible for running their preferred Clustering routine.

Afterwards, the data can either be entered into the database via Python (see the helper notebook in the Ephys repository: `kavli-ntnu/dj-elphys/notebooks/Ephys_usecase/Multiple_sessions_clustering.ipynb` ), or via the web GUI

Ephys -> Add Clustering -> Add Multi Session Clustering


### Option 2: completely manual

In the process of clustering, you the user, adjust the identities attached to each unit to maintain a unique, consistent set of identifiers. When these clusterings are inserted as individual, single-session clusterings, the consistent identifiers are maintained within the pipeline. Therefore, `session_1` `unit_1` should be exactly the same physical unit as `session_2` `unit_1`, and if `unit_1` does not appear in `session_3`, then `session_3` should not have a `unit_1` label.


### Option 3: Completely manual, spreadsheet ingestion

Option 2 functionally requires the researcher to maintain their own records to keep using consistent, unique, identifiers. This approach accepts one format of that data to be tracked in the pipeline.

This approach is currently not supported by the website interface, and requires use of a Jupyter notebook to proceed. (see the helper notebook in the Ephys repository: `kavli-ntnu/dj-elphys/notebooks/Ephys_usecase/Follow unit over sessions.ipynb`)

The data can be provided as an Excel spreadsheet, [here is an example is provided ](../_static/ephys/moser_multisess_unit.xlsx)

Please contact Simon Ball if you require any assistance getting this to work, as you may need to be given explicit database permissions. 

In this case, the clustering of each session does NOT use unique identifiers. For example, `unit_1` in `session_1` may be a completely different physical unit to `unit_1` in `session_2`. They are instead tied together by some unique identifier that indicates that `session_1` `unit_1` is the same as `session_2` `unit_7` and `session_3` `unit_4`.

These unique identifiers are stored in the table `ephys.MultiSessUnit` and `ephys.MultiSessUnit.MemberUnit`.

