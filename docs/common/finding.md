## How to find what you need

Both pipelines are large, complex networks of schemas, tables, and columns. Here are some general suggestions to help you find what you need. There are further suggestions, specific to each pipeline, in the relevant section.

### Finding a table: the Diagram

Datajoint includes a Diagram feature, to display the pipeline as a connected network. This can operate either on a _schema_ object, or a table, or some combination of the two. You may also see the keyword "ERD" used in places - this is a more mathematically correct description ("entity relationship diagram"), but it means the same thing, and executes exactly the same Python code to give you a graphical output. 

```python
import datajoint as dj

ephys = dj.create_virtual_module("ephys", "group_shared_ephys")
dj.Diagram(ephys)
```
TODO: insert figure here

The Diagram can help you find your way to the right table, although in some cases, the resulting output can be so overwhelmingly large, that it's just not useful.

You can also search a specific area of the pipeline. If you know about a specific table, and want to know about it's "neighbours", you can use the diagram a bit like an equation, requesting a certain number of neighbours above or below the table.

```python
dj.Diagram(ephys.Spikes) +2
```

You can also add diagrams together - or subtract - to get a more complex overview that keeps or avoids certain sections of the network

```python
analysis = dj.create_virtual_module("analysis", "group_shared_analysis")
dj.Diagram(ephys) + dj.Diagram(analysis) - dj.Diagram(analysis.ShuffledScores)
```

### Finding a column

Having found a relevant table, you need to know what column name to search for. Here, there are numerous options.

One is simply to print out a representation of the table itself:
```python
ephys.CuratedClustering()
```
This prints out a nicely formatted dataframe, showing all of the columns in that table and their names. 

Alternatively, you can use the various helper methods provided by Datajoint:
```python
ephys.CuratedClustering.describe()
```
This prints out the text definition that was used to _create_ the table, including any comments that were associated with those columns. However, it can hide some of the column names, as they are implicit in the description, as references to other tables. Another alternative, that includes every column name and comment is the _heading_
```python
ephys.CuratedClustering.heading
```


### Searching for a specific column name

Some times, you need to go the other way around - you know (or suspect) a column name, but don't know what table it is in. This is... a bit harder to do, and Datajoint doesn't yet provide very good tools for it, although development work is on-going

The below function provides a fragile workaround to the problem: if you know the _precise_ name of the column you want, then it will help. It implements exact, case-sensitive matching, so it will not help with more general queries where you do not know the exact name of the column

```python
def search(col_name, *args):
    """Search for the table in which a specific secondary attribute column appears
    If the column name features in multiple tables, then all tables (in the provided
    schemas) in which that column appears will be listed
    
    Parameters
    ----------
    col_name : str
        Precise name of a column that is not a primary key attribute
    *args:
        One or more schema objects
    
    Returns
    -------
    list
        The table(s) in which that column occurs
    
    Examples
    --------
    search("grid_score", ephys, analysis, acquisition)
    >>> [ephys.analysis.GridScore, ]
    search("electrode_config_id", acquistion, ephys)
    >>> [ephys.acquisition.Recording, ephys.ephys.FinalizedClustering]
    """
    tables = []
    for schema in args:
        for key, value in schema.__dict__.items():
            if hasattr(value, "describe"):
                for attr in value.heading.secondary_attributes:
                    if col_name.lower() == attr:
                        tables.append(value)
    if len(tables) > 1:
        return tables
    else:
        raise ValueError(f"Column name {col_name} does not match precisely in any table")
```