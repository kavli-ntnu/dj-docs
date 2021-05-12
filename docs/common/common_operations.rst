========================================
Common database operations
========================================
This page will discuss some of the common database operations required to use the Datajoint pipelines. It is not intended to be exhaustive, and for deeper insights, please consult the `Datajoint documentation <https://docs.datajoint.io/python/>`_, and the wealth of MySQL documentation available on the internet.

The three operations covered on this page are:

* Joining
* Restricting
* Projecting

Note that, in general, there are several possible ways to construct a query to return the information you require. 

Quick reference
-----------------

Joining: ``table1 * table2``

Restricting

* AND restriction: ``table1 & restriction``
* AND NOT restriction: ``table1 - restriction``
* OR restriction: ``table1 & [restriction1, restriction2]``



Constructing restrictions

* Exact match: ``table1 & "value = 'my_value'"``
* Greater than: ``table1 & value > other_value"``
* Less than: ``table1 & value < other_value"``
* Pattern matching: ``table1 & value LIKE 'partial%'"``
  - ``%`` is a wild-card, representing any number of other characters at that location.
* Restrictions involving variables:
  - The contents of one column equal to another column: ``table1 & "column1 = column2"``
    + Careful! Be aware of the distinction between ``"column1 = column2"`` and ``column1 = 'column2'"``.
  - Comparing time intervals: ``table1 & "TIMESTAMPDIFF(MONTH, date1, date2) > value``
  


Projection

* Discard all secondary columns: ``table1.proj()``
* Keep specific columns: ``table1.proj("my_column")``
* Rename column: ``table1.proj(my_new_column="my_old_column")``
* Keep everything else: ``table1.proj(..., my_new_column="my_old_column")``
* Calculation: ``table1.proj(value="sql_syntax()")``
  - Just about any SQL syntax is supported in this way



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

**Deity**

+----------+----------+--------+
| **name** | pantheon | gender |
+----------+----------+--------+
| amon     | egyptian | m      |
+----------+----------+--------+

**Attribute**

+----------+---------------+
| **name** | **attribute** |
+----------+---------------+
| amon     | air           |
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
| amon     | air           | eqyptian | m      |
+----------+---------------+----------+--------+
| amon     | creation      | eqyptian | m      |
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

   Total: 441

Essentially, a copy of the first table has been created for each entry in the second table. Observe the vastly increased size - this is a good warning sign that you may have made an error in your query. 


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

* Multiple criteria can also be specified, i.e.e an **OR** conditional. To do this, we provide a list of criteria, and we will recieve rows which match one (or more) of those crteria. For example, all gods that are Roman, or whose name begins with ``b`` (or both) ::

    example.Deity & ["name LIKE 'b%'", "pantheon = 'roman'"]

  +-----------+----------+--------+
  | **name**  | pantheon | gender |
  +-----------+----------+--------+
  | bastet    | egyptian | f      |
  +-----------+----------+--------+
  | ceres     | roman    | f      |
  +-----------+----------+--------+

    Total: 12


