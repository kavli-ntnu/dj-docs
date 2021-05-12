## Database backend

We use `mysqldb` as the backend database, as this is currently the main backend supported by Datajoint. 

The server can be found at both

* `datajoint.it.ntnu.no:3306`
* `kavli-datajoint02.it.ntnu.no:3306`

#### Default permissions

Default users have the following permissions:

* Read-only (`SELECT` and `REFERENCES`) `group_shared_%`
* Read-only (`SELECT` and `REFERENCES`) `prod_%_%`
* Read-only (`SELECT` and `REFERENCES`) `user_%_%`
* All permissions to `user_<username>_%`

This allows individual users to create, modify, and drop databases within their own area, and to read and reference other user tables. 

The following users have some degree of admin permissions:

* Simon Ball
* Haagen Wade
* Edgar Walker
* Horst Obenhaus
* Thinh Nguyen
