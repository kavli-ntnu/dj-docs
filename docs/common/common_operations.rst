.. _Common Operations:

========================================
Common database operations
========================================
This page will discuss some of the common database operations required to use the Datajoint pipelines. It is not intended
to be exhaustive, and for deeper insights, please consult the Datajoint documentation, and the wealth of MySQL documentation
available on the internet.

* `Datajoint (Python) <https://docs.datajoint.io/python/>`_
* `Datajoint Matlab <https://docs.datajoint.io/matlab/>`_

The four operations covered on this page are:

* Joining
* Restricting
* Projecting
* Fetching

Note that, in general, there are several possible ways to construct a query to return the information you require. 

.. _Common Operations Reference:

Quick reference
-----------------

Joining: 

* ``table1 * table2``

Restricting

* AND restriction: ``table1 & restriction``
* AND NOT restriction: ``table1 - restriction``
* OR restriction: ``table1 & [restriction1, restriction2]``



Constructing restrictions

* Exact match: ``table1 & "my_column = 'my_value'"``

  - When restricting by multiple exact criteria, or by other variables, it can be useful to express restrictions as dicts or structs instead of strings

.. code-block:: python
   # Exact matches can be expressed as either strings or dictioanries
   table1 & "my_column_1 = 'my_value'" & "my_column_2 = 'my_other_value'"
   table1 & {"my_column_1": "my_value", "my_column_2": "my_other_value"}

.. code-block:: matlab
   % Exact matches can be expressed as either string/character arrays, or as structs, or as cell arrays
   table1 & "my_column_1 = 'my_value'" & "my_column_2 = 'my_other_value'";
   s = struct("my_column_1", "my_value", "my_column_2", "my_value");
   table1 & s;
   ca = {"my_column_1='my_value'", "my_column_2", "my_other_value"};
   table1 & ca;

* Greater than: ``table1 & "my_column > other_value"``
* Less than: ``table1 & "my_column < other_value"``
* Pattern matching: ``table1 & "my_column LIKE 'partial%'"``
  
  - ``%`` is a wild-card, representing any number of other characters at that location.
  
* Restrictions involving variables:
  
  - The contents of one column equal to another column: ``table1 & "column1 = column2"``
  
     + Careful! Be aware of the distinction between ``"column1 = column2"`` and ``column1 = 'column2'"``.
     + ``"column_1 = column_2"`` will return all rows which individually have the same value in both columns 1 and 2
     + ``"column_1 = 'column_2'`` will return all rows which have a value in column 1 equal to the string ``"column_2"``
    
  - Comparing time intervals (this example comparing the number of months): ``table1 & "TIMESTAMPDIFF(MONTH, date1, date2) > value``

* Restricting by multiple choice

  - You can use list comprehension to build your query: ``restriction = ["column_1 = '{}'".format(value) for value in my_list_of_values]``
  - You can use the sql syntax IN, but *only* with round brackets: ``restriction = "column_1 IN ('value_1', 'value_2')"``
  - If using IN with Python string formatting, remember to convert lists and numpy arrays to tuples first, to meet the round-brackets-only requirement: ``restriction = "column_1 IN {}".format(tuple(my_list_of_values))``

* Restricting by other tables, or other queries: ``table1 & table2``; ``table1 & (table2 & restriction)``

  


Projection

* Discard all secondary columns: ``table1.proj()``
* Keep specific columns: ``table1.proj("my_column")``
* Rename column:
.. code-block:: python
   ``table1.proj(my_new_column="my_old_column")``

.. code-block:: matlab
   ``table1.proj("my_old_column -> my_new_column");

* Keep everything else: ``table1.proj(..., my_new_column="my_old_column")``

  + Not relevant in Matlab, as everything is kept anyway
* Calculation:
  
  - Just about any SQL syntax is supported in this way
.. code-block:: python
    table1.proj(value="sql_syntax()")


Fetching

* Fetch any number of rows (zero, one, or many), from a table or constructed query, with ``fetch()``

.. code-block:: python
   # If no other arguments are provided, the entire record will be fetched
   my_data = table1.fetch()
   my_data = (table1 & restriction).fetch()

.. code-block:: matlab
   % omitting '*' will fetch the primary key, rather than the entire record
   my_data = fetch(table1, '*');
   my_data = fetch(table1 & restriction, '*');

* Fetch **exactly** one row, with ``fetch1()``

.. code-block:: python
   my_data = (table1 & restriction).fetch1()

.. code-block:: matlab
   my_data = fetch1(table1 & restriction, '*');

* Specify specific columns by name to avoid spending time transferring data you don't care about: ``table1.fetch("my_column_1", "my_column_2")``

.. code-block:: python
   my_data = table1.fetch("my_column_1", "my_column_2")

.. code-block:: matlab
   my_data = fetch(table1, "my_column_1", "my_column_2")

* Decide what format you want data returned in. The default is an array (or set of arrays)

.. code-block:: python
   list_of_tuples = table1.fetch()
   (array_1, array_2) = table1.fetch("my_column_1", "my_column_2")
   list_of_dict = table1.fetch(as_dict=True)
   pandas_dataframe = table1.fetch(format="frame")
   dict = (table1 & restriction).fetch1()

.. code-block:: matlab
   array_of_structs = fetch(table1, '*');
  
* If fetching as a series of arrays, you can assign these to multiple names in the same line via list comprehension: ``x, y = table1.fetch("thing1", "thing2")``
* Control fetching multiple rows with a maximum number (keyword ``limit``) and an order (``order_by="column_name direction"``, where "direction" is either ascending (``ASC``) or descending (``DESC``), e.g. ``order_by="timestamp DESC"``)


Queries are calculated following standard equation conventions. You can use parentheses and variable assignment to make query expressions easier to read. You can (and should) construct queries beginnning from the most general and working towards the most specific to confirm that the outcome is what you expect it to be. 




Example
------------

An example schema has been provided to demonstrate some of these concepts. You can access it as following::

   import datajoint as dj
   example = dj.create_virtual_module("example", "group_shared_datajoint_example")
   dj.Diagram(example)

The example contains three tables (contents abridged)

**Pantheon**

+--------------+----------+--------+
| **pantheon** | earliest | latest |
+--------------+----------+--------+
| greek        |-1200     | 313    |
+--------------+----------+--------+
| ...          |...       | ...    |
+--------------+----------+--------+

**Deity**

+----------+----------+--------+
| **name** | pantheon | gender |
+----------+----------+--------+
| amon     | egyptian | m      |
+----------+----------+--------+
| ...      | ...      | ...    |
+----------+----------+--------+

**Attribute**

+----------+---------------+
| **name** | **attribute** |
+----------+---------------+
| amon     | air           |
+----------+---------------+
| ...      | ...           |
+----------+---------------+



Joining
------------

Each pipeline is, fundamentally, a database schema, i.e. a set of interconnected data tables. Typically, you will need to use information spread across multiple tables to construct your queries. 

Referring to the above example, information about a god's name, and membership in one particular pantheon, is stored in the **deity** table. The aspects of life of which the god, or goddess, is nominally in charge, is stored in the **attribute** table.

Suppose that we want to identify all the attributes that are covered by one particular pantheon - what aspects of life are governed by Egyptian gods? In that case, we need to combine those two tables together some how. 

We do that with the **join** operation.

Joining identifies what (if any) column names are shared between two tables, and uses the contents of those columns to match rows together. The end result is a temporary table with the combined columns of both tables::

   print(len(example.Deity)
   print(len(example.Attribute
   example.Deity * example. Attribute

   >>> 36
   >>> 147

+----------+---------------+----------+--------+
| **name** | **attribute** | pantheon | gender |
+----------+---------------+----------+--------+
| amon     | air           | egyptian | m      |
+----------+---------------+----------+--------+
| amon     | creation      | egyptian | m      |
+----------+---------------+----------+--------+
| ...      | ...           | ...      | ...    |
+----------+---------------+----------+--------+

   Total: 147

The outcome is a table with all columns from both tables. The number of rows depends on how much data matches. Warning! Just because column names match does not guarantee that *any* data is shared between the two tables, and the join of two populated tables *may* be completely empty. 

Joining two tables with shared column names is, functionally, equivalent to considering each table as a matrix and calculating the cross-product. 


If no column names match, then the outcome is closer to the Kronecker product of two matricies::

  example.Pantheon * example.Attribute

+--------------+----------+---------------+----------+--------+
| **pantheon** | **name** | **attribute** | earliest | latest |
+--------------+----------+---------------+----------+--------+
| egyptian     | amon     | air           |-3000     | -300   |
+--------------+----------+---------------+----------+--------+
| roman        | amon     | air           |-753      | 1453   |
+--------------+----------+---------------+----------+--------+
| greek        | amon     | air           |-1200     | 313    |
+--------------+----------+---------------+----------+--------+
| ...          | ...      | ...           | ...      | ...    |
+--------------+----------+---------------+----------+--------+

   Total: 441

Essentially, a copy of the first table has been created for each entry in the second table. Observe the vastly increased size - this is a good warning sign that you may have made an error in your query. 


.. _Common Operations Restrict:

Restricting
-----------------

Joining puts entire tables together to contain all of the columns you want. But you almost never want to work with entire data tables - you want a fraction of that number of rows, that are relevant to whatever you happen to be working on at the time. That is where restriction comes in

Restricting is all about stating the criteria that define what you want, in the form of a logical equation. That equation is applied to a table (or joined object), and only rows that match your crieteria are returned. 

You can specify criteria as either:

* **AND**, using the symbol ``&``
* **AND NOT** using the symbol ``-``

In addition, you can specify **OR** criteria by giving a list of independent conditions, of which rows must satisfy at least one. 

Critera can be specified in several ways:

* Exact matching, using the ``=`` symbol (Note! This is distinct from Python, which uses ``==``)
  For example, suppose we wished to find all members of the Greek pantheon in our example, we could do this as follows::
   
    example.Deity & "pantheon = 'greek'"
  
  +-----------+----------+--------+
  | **name**  | pantheon | gender |
  +-----------+----------+--------+
  | aphrodite | greek    | f      |
  +-----------+----------+--------+
  | apollo    | greek    | m      |
  +-----------+----------+--------+
  | ...       | ...      | ...    |
  +-----------+----------+--------+
   
     Total: 14

* Numerical comparison, using the operators ``>`` and ``<``. For example, which pantheons were still known to be worshipped after the year 1 AD? ::

    example.Pantheon & "latest > 1"

  +--------------+----------+--------+
  | **pantheon** | earliest | latest |
  +--------------+----------+--------+
  | greek        |-1200     | 313    |
  +--------------+----------+--------+
  | roman        |-753      | 1453   |
  +--------------+----------+--------+

    Total: 2

* Pattern matching, using the keyword ``LIKE``. In this case, you specify part of the value, and indicate where additional characters may be located via the wild-card character ``%``. For example, look for all gods whose name *ends* with the letter ``n`` ::

    example.Deity & "name LIKE '%n'"

  +-----------+----------+--------+
  | **name**  | pantheon | gender |
  +-----------+----------+--------+
  | amon      | egyptian | m      |
  +-----------+----------+--------+
  | poseidon  | greek    | m      |
  +-----------+----------+--------+
  | vulcan    | roman    | m      |
  +-----------+----------+--------+

    Total: 3

* Multiple criteria can also be specified, i.e. an **OR** conditional. To do this, we provide a list of criteria, and we will recieve rows which match one (or more) of those crteria. For example, all gods that are Roman, or whose name begins with ``b`` (or both). Whether this is and **AND (X OR Y)** condition, or **AND NOT EITHER (X OR Y)** condition can be controlled with ``&`` or ``-``::

    example.Deity & ["name LIKE 'b%'", "pantheon = 'roman'"]

  +-----------+----------+--------+
  | **name**  | pantheon | gender |
  +-----------+----------+--------+
  | bastet    | egyptian | f      |
  +-----------+----------+--------+
  | ceres     | roman    | f      |
  +-----------+----------+--------+
  | ...       | ...      | ...    |
  +-----------+----------+--------+

    Total: 12


The above restrictions are the basic building blocks, but more complicated queries can be constructed by restricting with *tables*. The above all follow the pattern ``table & restriction``, where ``table`` might be the product of joining tables together. The restriction can *also* be the product of joining (and restricting!) tables together.

When restricting by a table, that means: "include (or exclude) rows from table1 that **also** occur in the restricting table". To demonstrate, let's combine two examples from above. Let's look for all deities with names ending in the letter ``n``, that are members of pantheons still worshipped after 1AD ::

    example.Deity & "name LIKE '%n'" & (example.Pantheon & "latest > 1")

+-----------+----------+--------+
| **name**  | pantheon | gender |
+-----------+----------+--------+
| poseidon  | greek    | m      |
+-----------+----------+--------+
| vulcan    | roman    | m      |
+-----------+----------+--------+

  Total: 2

We can also break the equation down into multiple, simpler, equations by assigning parts to variables ::

    gods_n = example.Deity & "name LIKE '%n'"
    groups = example.Pantheon & "latest > 1"
    gods_n & groups

+-----------+----------+--------+
| **name**  | pantheon | gender |
+-----------+----------+--------+
| poseidon  | greek    | m      |
+-----------+----------+--------+
| vulcan    | roman    | m      |
+-----------+----------+--------+

  Total: 2


We might also want to specify a restriction where a column can take one of several values. For example, suppose we wanted to know all of the attributes of the gods ``Bastet``, ``Ceres`` and ``Apollo``. 

Based on what's written above, we can already construct this query using ``& [...]``, i.e. AND EITHER. Writing that out can get tedious quite fast ::

    attr = example.Attribute & ["name = 'bastet'", "name='ceres'", "name='apollo'"]
    attr

+-----------+-------------+
| **name**  | **attribute |
+-----------+-------------+
| apollo    | archery     |
+-----------+-------------+
| apollo    | arts        |
+-----------+-------------+
| ...       | ...         |
+-----------+-------------+

  Total: 15

We can shortcut this in several possible ways. One way is to use Python list comprehension to construct the repetitive bits for us ::

    gods = ["bastet", "ceres", "apollo"]
    attr = example.Attribute & ["name = '{}'".format(name) for name in gods]
    attr

Alternatively, we can use another SQL term: IN. Just like the use of ``in`` in Python, it allows us to check if a value
is a member of a group of values. This one needs a little bit of care, though, because the restriction string is interpreted
by SQL standards, and not by Python standards ::

    attr = example.Attribute & "name IN ('bastet', 'ceres', 'apollo')"

The two aspects to be aware of: each string is separately quoted (just as in previous queries), and the list is constructed
here with ROUND brackets, not SQUARE - because SQL expects round brackets. If you want to construct this with Python string
formatting, that means you need to convert from a list (or numpy array) to a ``tuple`` first ::

    gods = ["bastet", "ceres", "apollo"]
    attr = example.Attribute & "name IN {}".format(gods)   # This line will cause a QuerySyntaxException
    attr = example.Attribute & "name IN {}".format(tuple(gods))  # This will work fine


.. _Common Operations Fetch:

Fetching
-----------

All of the above is about constructing a query that contains the data you want - but it doesn't *give* you the data, it just shows an abbreviated section of the data on screen. 

In order to actually work with the data, you need to **fetch** it. Data can be fetched either from existing tables on disk, or from queries that you have constructed as above. Data is fetched via either of two methods:

* ``fetch()``
* ``fetch1()``

Fetch is also the only way to work with "blob" data, as that is never displayed in the on-screen summary of query objects. 

Fetch1()
^^^^^^^^^^^

``fetch1()`` is used whenever you have **exactly one** row of data to fetch. It will throw an exception if there are either more, or fewer, rows of data. ::

  my_data = (example.Deity & "name = 'zeus'").fetch1()
  type(my_data)
  >>> dict
  example.Deity.fetch1()
  ## This will throw an error


Fetch()
^^^^^^^^^^

``fetch()`` is used with any arbitrary number of rows (or zero). ``fetch()`` will *always* return an array - even if fetching a single row. If you need to extract a single object, indexin that object is required::

  my_data = (example.Deity & "name = 'zeus'").fetch1()
  type(my_data)
  >>> numpy.ndarray
  type(my_data[0])
  >>> numpy.void

Using Fetches
^^^^^^^^^^^^^^^^^^

Both ``fetch()`` and ``fetch1()`` offer a lot of flexibility:

* With no arguments, data from all columns will be fetched: 
* Columns can be named to fetch only from those columns: ``table.fetch("my_column_1", "my_column_2")``
* Data can be ordered by any column in the table, either ascending or descending: ``table.fetch(order_by="my_column_3 asc")``
* Data can be fetched in various formats

  - List of dictionaries: ``table.fetch(as_dict=True)``
  - Pandas Dataframe: ``table.fetch(format="frame")``
  - Array of arrays (default): ``table.fetch()``
  
* A subset of data can be fetched - this is great if you're testing something and want a faster result: ``table.fetch(limit=10)``

  - Note! Even with ``limit=1``, you will *still* get an *array*, containing 1 result. 






.. _Common Operations Permission:

Permissions
-----------------

The back end infrastructure to these pipelines is a database server, which provides very fine-grained permissions on a per-user, per-table level. 

By default, these permissions are set quite restrictively:

* Read-only and reference access to the various shared databases
* read-only access to other users' personal schemas
* Full read/write/delete permissions to your own schemas (any schema prefixed by ``user_<username>_``, e.g. ``user_simoba_example``)

The default set of permissions are deliberately restrictive, and there is a good reason for this: it provides peace of mind that you can explore and experiment *without risk of causing any damage*.

With the default set of permissions, you have full read-access to any data in the database, but you cannot write (or delete) anything. At worst, you may be able to introduce corrupted data via the web gui (note: this is not a challenge!).

Additional permissions **can be granted when needed,** but with great power comes great responsibility: if you have deletion permissions, you have the power to screw things up for everybody. More (potentially) destructive permissions will not be given lightly, but they will be given if you can demonstrate why you need them, and that you know how to use them safely. 

Database permission: meaning
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The database server offers very fine-grained control compared to the file systems you may be familiar with. Several important permissions to be aware of:

* ``SELECT`` : this is, essentially "read-only" access: if you have `SELECT` permission to a table, you can see the data in that table, and fetch it back to your computer to work with.

* ``REFERENCES`` : Allows entries in this table to be used as foreign keys elsewhere, for example in building your own personal schema to contain and extend your own analyses. 

* ``INSERT`` : This is similar to "write access": this allows you to _add_ new rows to a table. It does not, however, allow the modification or deletion of existing rows

* ``UPDATE`` : Allows existing rows to be modified, but not deleted.

* ``DELETE`` : Allows the deletion of existing rows, but not their modification.
