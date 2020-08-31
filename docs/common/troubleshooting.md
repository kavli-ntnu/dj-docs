## What to do if something goes wrong

Both the ephys and imaging pipelines are extremely complicated software systems with many moving parts. It is possible for things to go wrong. 

This page lists some of the common errors that researchers have experienced, and what you can do about it. If your problem doesn't fit into any of these categories, or the answer is not helpful, then contact Simon Ball for assistance.

When assistance is needed, we can help you faster if you provide as much precise information up-front as possible. 
* What were you doing when it went wrong? Any recent GUI actions or python commands?
* What does the error message say *exactly*? Copy/paste the text or take a screenshot
* What, if anything, have you already tried (that didn't work) to fix the problem?
* What actions can I take to reproduce the same error message?

#### I can't connect to the database or web gui

If working from home, make sure that your VPN connection to NTNU is active. Both webgui and database access require you to be part of NTNU's internal network

Make sure your username and password are spelled correctly. The pipelines deliberately reuse your NTNU username, but **NOT** your NTNU password. You have a separate password for the pipelines. 

You may have saved your password in Python using `dj.config.save_global()`. In that case, you can look up what you saved with the following:
```python
import datajoint as dj
print(dj.config["database.password"])
```

If you cannot find your password, contact Simon Ball to request a new password. There is no automated "password recovery" system at this time. 

#### The web GUI keeps sending me back to the login screenshot

This is the default behaviour if something goes wrong in the web GUI. You do not need to log in again; you can use the Back button (default shortcut Backspace) to return to where you were. A common cause is that you tried to enter an invalid value. If you are confident that all the values are valid and correct, contact SImon Ball with details

#### I ingested the wrong data

What to do about this depends on what the nature of the wrong data.
* If you entered valid, but incorrect data (e.g. a probe insertion to the wrong animal, you can contact Simon Ball directly to delete the record, or submit a deletion request via the Web gui under "Management"
* If you entered invalid data, such as a session input directory path that points to nowhere, then this will probably be caught in the ingestion system as an error. In the case of new sessions, you can delete this yourself under Ephys -> Session Status

If you inserted data directly into the pipeline via Python command, then this bypasses a lot of the validation protections in the Web GUI. If you have delete permissions on the tables, you can attempt to fix this directly, *with care*. If you do not have delete permissions, contact Simon with details of what should be deleted. 

#### I ingested my session but it's not been analysed

This suggests that a key piece of data is missing, and the database worker is waiting for it. Commonly missed data are:
* Probe Association. If you have multiple probes or tetrode arrays, you need to tell the database how the data structure matches the probe insertion records, see [Ephys: Ingesting via the web gui](../doc_ephys/ingestion_webgui.md)
* Task information. Processing the tracking data requires information about which arena the session took place in

Alternatively, the ingestion may have had an error somewhere, e.g. an invalid input directory. This should show up in Session Status

Other places to check are the `jobs` tables of the various schemas, e.g., `ephys.schema.jobs`, `tracking.schema.jobs` and `analysis.schema.jobs`. This may indicate a problem.

#### There are more analysis results than I expected

Check how you have restricted your search query, including selecting specific parameter sets if necessary. The commonest issue here is either:
* Not restricting by task (stored in `behavior.Task`)
* Not restrictied by analysis parameters

#### I get a Permission Denied error message

The most likely source of this error is attempting to insert into, or delete from, tables in the common schema. 

By default, researchers do not have write, update, or delete permissions to the common, shared schemas. This is not a hard and fast rule: permissions will generally be granted where requested and justified. 

The reason for this choice is to minimise the risk of damaging the stored data, as controls cannot be finegrained to, e.g., only allow users to delete their *own* data: if you have delete permission, you have delete permission to an entire table. 

#### I want a new feature added