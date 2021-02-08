## Database permissions

The back end infrastructure to these pipelines is a database server, which provides very fine-grained permissions on a per-user, per-table level. 

By default, these permissions are set quite restrictively:
* Read-only and reference access to the various shared databases
* read-only access to other users' personal schemas
* Full read/write permissions to your own schemas. 

**If you require additional permissions than are granted by default, please contact Simon Ball**

### Database permissions: reasoning

The default set of permissions are very restrictive, and there is a sound reason behind this: providing peace of mind that you can explore and experiment without risk of causing catastrophic damage.

With the default set of permissions, you have full read-access to any data in the database, but you cannot write (or delete) anything back. At worst, you may be able to introduce corrupted data via the web gui (note: this is not a challenge!).

Any user who needs a higher level of permissions should contact Simon Ball. I cannot promise to grant any permission you ask for, but the intention is not to get in the way of your research. In particular, if you wish to replace the webbased GUI with your own scripted ingestion, that can be accommodated


### Database permission: meaning

The database server offers very fine-grained control compared to the file systems you may be familiar with. Several important permissions to be aware of:

* `SELECT` : this is, essentially "read-only" access: if you have `SELECT` permission to a table, you can see the data in that table, and fetch it back to your computer to work with

* `INSERT` : This is similar to "write access": this allows you to _add_ new rows to a table. It does not, however, allow the modification or deletion of existing rows

* `UPDATE` : Allows existing rows to be modified, but not deleted.

* `DELETE` : Allows the deletion of existing rows, but not their modification.

* `REFERENCES` : Allows entries in this table to be used as foreign keys elsewhere, for example in building your own personal schema to contain and extend your own analyses. 
