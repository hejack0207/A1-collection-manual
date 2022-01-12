# create table as(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_TABLE_AS - define a new table from the results of a query

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
        [ (column_name [, ...] ) ]
        [ USING method ]
        [ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
        [ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
        [ TABLESPACE tablespace_name ]
        AS query
        [ WITH [ NO ] DATA ]

<a name="description"></a>

# Description


**CREATE TABLE AS**
creates a table and fills it with data computed by a
**SELECT**
command. The table columns have the names and data types associated with the output columns of the
**SELECT**
(except that you can override the column names by giving an explicit list of new column names).

**CREATE TABLE AS**
bears some resemblance to creating a view, but it is really quite different: it creates a new table and evaluates the query just once to fill the new table initially. The new table will not track subsequent changes to the source tables of the query. In contrast, a view re-evaluates its defining
**SELECT**
statement whenever it is queried.

<a name="parameters"></a>

# Parameters


GLOBAL or LOCAL
Ignored for compatibility. Use of these keywords is deprecated; refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

TEMPORARY or TEMP
If specified, the table is created as a temporary table. Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

UNLOGGED
If specified, the table is created as an unlogged table. Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

IF NOT EXISTS
Do not throw an error if a relation with the same name already exists. A notice is issued in this case. Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

_table\_name_
The name (optionally schema-qualified) of the table to be created.

_column\_name_
The name of a column in the new table. If column names are not provided, they are taken from the output column names of the query.

USING _method_
This optional clause specifies the table access method to use to store the contents for the new table; the method needs be an access method of type
TABLE. See
Chapter&nbsp;60
for more information. If this option is not specified, the default table access method is chosen for the new table. See
default_table_access_method
for more information.

WITH ( _storage\_parameter_ [= _value_] [, ... ] )
This clause specifies optional storage parameters for the new table; see
Storage Parameters
for more information. For backward-compatibility the
WITH
clause for a table can also include
OIDS=FALSE
to specify that rows of the new table should contain no OIDs (object identifiers),
OIDS=TRUE
is not supported anymore.

WITHOUT OIDS
This is backward-compatible syntax for declaring a table
WITHOUT OIDS, creating a table
WITH OIDS
is not supported anymore.

ON COMMIT
The behavior of temporary tables at the end of a transaction block can be controlled using
ON COMMIT. The three options are:

PRESERVE ROWS
No special action is taken at the ends of transactions. This is the default behavior.

DELETE ROWS
All rows in the temporary table will be deleted at the end of each transaction block. Essentially, an automatic
**TRUNCATE**(7)
is done at each commit.

DROP
The temporary table will be dropped at the end of the current transaction block.

TABLESPACE _tablespace\_name_
The
_tablespace\_name_
is the name of the tablespace in which the new table is to be created. If not specified,
default_tablespace
is consulted, or
temp_tablespaces
if the table is temporary.

_query_
A
**SELECT**(7),
TABLE, or
**VALUES**(7)
command, or an
**EXECUTE**(7)
command that runs a prepared
**SELECT**,
**TABLE**, or
**VALUES**
query.

WITH [ NO ] DATA
This clause specifies whether or not the data produced by the query should be copied into the new table. If not, only the table structure is copied. The default is to copy the data.

<a name="notes"></a>

# Notes


This command is functionally similar to
SELECT INTO (**SELECT\_INTO**(7)), but it is preferred since it is less likely to be confused with other uses of the
**SELECT INTO**
syntax. Furthermore,
**CREATE TABLE AS**
offers a superset of the functionality offered by
**SELECT INTO**.

<a name="examples"></a>

# Examples


Create a new table
films_recent
consisting of only recent entries from the table
films:

.if n \{.RS 4
.\}
    CREATE TABLE films_recent AS
      SELECT * FROM films WHERE date_prod >= 2002-01-01*(Aq;
.if n \{.RE
.\}

To copy a table completely, the short form using the
TABLE
command can also be used:

.if n \{.RS 4
.\}
    CREATE TABLE films2 AS
      TABLE films;
.if n \{.RE
.\}

Create a new temporary table
films_recent, consisting of only recent entries from the table
films, using a prepared statement. The new table will be dropped at commit:

.if n \{.RS 4
.\}
    PREPARE recentfilms(date) AS
      SELECT * FROM films WHERE date_prod > $1;
    CREATE TEMP TABLE films_recent ON COMMIT DROP AS
      EXECUTE recentfilms(2002-01-01*(Aq);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE TABLE AS**
conforms to the
SQL
standard. The following are nonstandard extensions:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The standard requires parentheses around the subquery clause; in
  PostgreSQL, these parentheses are optional.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  In the standard, the
  WITH [ NO ] DATA
  clause is required; in PostgreSQL it is optional.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  PostgreSQL
  handles temporary tables in a way rather different from the standard; see
  CREATE TABLE (**CREATE\_TABLE**(7))
  for details.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The
  WITH
  clause is a
  PostgreSQL
  extension; storage parameters are not in the standard.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The
  PostgreSQL
  concept of tablespaces is not part of the standard. Hence, the clause
  TABLESPACE
  is an extension.

<a name="see-also"></a>

# See Also

CREATE MATERIALIZED VIEW (**CREATE\_MATERIALIZED\_VIEW**(7)), CREATE TABLE (**CREATE\_TABLE**(7)), **EXECUTE**(7), **SELECT**(7), SELECT INTO (**SELECT\_INTO**(7)), **VALUES**(7)
