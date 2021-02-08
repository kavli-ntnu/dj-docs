======================================
Building your own pipeline
======================================


The common pipelines are not designed or intended to represent all possible analyses that you require for your own research. Eventually, your own requirements will diverge from what the pipeline supports. 

At that point, you can continue your own analysis in one of two ways:
- make use of the pipeline as a data source only: fetch what you need from the database, but conduct all further analysis with local scripts and files
- define your own, private, database tables to which data can be written back.


Your own schema namespace
-------------------------

The database server is configured such that every user can define their own schemas (groups of tables), to which they have unrestricted read/write/delete access. Other users can _see_ the data in these tables, but cannot reference or modify it.

Access is determined via a prefix to the schema name: `user_<USERNAME>_*`. For example: `user_simoba_imaging_dev`. By declaring a schema object, this schema can be initialised

```python
import datajoint as dj
schema = dj.schema("user_USERNAME_SCHEMANAME")
```


Defining your own tables
-------------------------

Each table is defined in a specific way, in Python (or Matlab) code. A table must:
* be wrapped by a Schema object
* follow CamelCaps naming
* inherit from one of the five Datajoint table types
* include a class attribute called `definition`

The full Datajoint documentation is [here](https://docs.datajoint.io/python/definition/Definition.html)

```python
@schema
class MyTable(dj.Computed):
    definition = """
    -> ephys.UnitSpikeTimes
    ---
    my_first_column : int               # comment
    my_second_column: blob@ephys_store  # 2nd comment
    """
```



Defining your choice of source data
------------------------------------

The table definition includes primary key columns and secondary key columns. Typically, the primary key columns will include at least one foreign key: a reference to another table (denoted by `->` in the definition)

By default, if the table will be auto-populated, the table will consider _every single key-combination from all foreign references_ to be valid input data.

For the main pipeline, this may be true. For your own personal analysis pipeline, it probably is not true - most likely, you only care about analysing your own data, not other people's.

You can apply more complicated filtering rules via the `key_source` class attribute. This is a query like any other, and you can use all of the normal methods for restricting or expanding a selection that any other database operation would.

```python
    key_source = ephys.UnitSpikeTmes & (animal.Animal & "animal_name IN (26230, 95391, 72544)"
```

If the the key source calculation is quite complex, you can replace with with a "property" function. This is a common Python trick where someting that you want to access as an attribute needs a bit more manipulation than you can conveniently fit on one line.

(Note that the following example is more about demonstrating how a complex key source _might_ work than being a particularly useful key source to try and duplicate)

```python
    @property
    def key_source(self):
        ks = (
                ephys.UnitSpikeTimes
                * ephys.CuratedClustering
                * acquisition.ClusterSessionGroup.GroupMember
                & (
                    animal.Animal
                    & [
                        {"animal_name": 26230},
                        {"animal_name": 26231},
                       ]
                   )
                & (
                    behavior.Task
                    * reference.ArenaApparatus.ArenaGeometry
                    & {"look_outside":False}
                   )
             )
        return ks
```

Defining your own Populate logic
---------------------------------

Imported and Computed tables support population logic: they define a fixed method of transforming szome input data to some output data, and isnerting that output data back into themselves. 

That logic is defined by the "make" function, which must have the following signature:

```python
class MyTable(dj.Computed):
    definition = """
    ...
    """
    
    def make(self, key):
        spk_data = (ephys.UnitSpikeTimes & key).fetch1()
        look_outside = (reference.ArenaApparatus.ArenaGeometry & key).fetch1("look_outside")
        new_row = calculate_data(spk_data, look_outside)
        self.insert1(new_row)
```

Typically, this function will have two distinct components:
* fetching the source data
* transforming the source data (which I conveniently hid as a call to come other function, `calculate_data`)

If you call `MyTabl.populate()`, this logic will be executed for every key that _should_ exist in the table (as defined in `MyTable.key_source`, see above), and does not yet already. 

You can see what proportion of keys that should be there are there already with `MyTable.progress()`, but be aware that this _can_ be misleading if, e.g., precursor tables are not yet fully populated




Populating your own tables
----------------------------

The main pipeline is populated by a set of dedicated "worker" servers - virtual machines running on NTNU's openstack. These dedicated servers do not have access to the populate logic for your personal tables, and so cannot populate them for you. 

In general, you will need to run the population logic yourself, on your own office or lab computer, by importing the schema and table definition code and running `MyTable.populate()`

If you require computational resources exceeding the computer(s) you have available, NTNU does have various compute resources that are available to researchers that can be requested. 


Full Example
--------------

For further examples, consult the source code for the two main pipelines on github. 

```python
import datajoint as dj

schema = dj.schema("user_USERNAME_SCHEMANAME")

@schema
class MyTable(dj.Computed):
    definition = """
    -> ephys.UnitSpikeTimes
    ---
    my_first_column : int               # comment
    my_second_column: blob@ephys_store  # 2nd comment
    """
    
    @property
    def key_source(self):
        ks = (
                ephys.UnitSpikeTimes
                * ephys.CuratedClustering
                * acquisition.ClusterSessionGroup.GroupMember
                & (
                    animal.Animal
                    & [
                        {"animal_name": 26230},
                        {"animal_name": 26231},
                       ]
                   )
                & (
                    behavior.Task
                    * reference.ArenaApparatus.ArenaGeometry
                    & {"look_outside":False}
                   )
             )
        return ks
    
    def make(self, key):
        spk_data = (ephys.UnitSpikeTimes & key).fetch1()
        look_outside = (reference.ArenaApparatus.ArenaGeometry & key).fetch1("look_outside")
        new_row = calculate_data(spk_data, look_outside)
        self.insert1(new_row)


if __name__ == "__main__":
    MyTable.populate()
```
