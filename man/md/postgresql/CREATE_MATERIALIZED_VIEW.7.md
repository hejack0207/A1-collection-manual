# create materialized view(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_MATERIALIZED_VIEW - define a new materialized view

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE MATERIALIZED VIEW [ IF NOT EXISTS ] table_name
        [ (column_name [, ...] ) ]
        [ USING method ]
        [ WITH ( storage_parameter [= value] [, ... ] ) ]
        [ TABLESPACE tablespace_name ]
        AS query
        [ WITH [ NO ] DATA ]

<a name="description"></a>

# Description


**CREATE MATERIALIZED VIEW**
defines a materialized view of a query. The query is executed and used to populate the view at the time the command is issued (unless
**WITH NO DATA**
is used) and may be refreshed later using
**REFRESH MATERIALIZED VIEW**.

**CREATE MATERIALIZED VIEW**
is similar to
**CREATE TABLE AS**, except that it also remembers the query used to initialize the view, so that it can be refreshed later upon demand. A materialized view has many of the same properties as a table, but there is no support for temporary materialized views.

<a name="parameters"></a>

# Parameters


IF NOT EXISTS
Do not throw an error if a materialized view with the same name already exists. A notice is issued in this case. Note that there is no guarantee that the existing materialized view is anything like the one that would have been created.

_table\_name_
The name (optionally schema-qualified) of the materialized view to be created.

_column\_name_
The name of a column in the new materialized view. If column names are not provided, they are taken from the output column names of the query.

USING _method_
This optional clause specifies the table access method to use to store the contents for the new materialized view; the method needs be an access method of type
TABLE. See
Chapter&nbsp;60
for more information. If this option is not specified, the default table access method is chosen for the new materialized view. See
default_table_access_method
for more information.

WITH ( _storage\_parameter_ [= _value_] [, ... ] )
This clause specifies optional storage parameters for the new materialized view; see
Storage Parameters
for more information. All parameters supported for
CREATE TABLE
are also supported for
CREATE MATERIALIZED VIEW. See
CREATE TABLE (**CREATE\_TABLE**(7))
for more information.

TABLESPACE _tablespace\_name_
The
_tablespace\_name_
is the name of the tablespace in which the new materialized view is to be created. If not specified,
default_tablespace
is consulted.

_query_
A
**SELECT**(7),
TABLE, or
**VALUES**(7)
command. This query will run within a security-restricted operation; in particular, calls to functions that themselves create temporary tables will fail.

WITH [ NO ] DATA
This clause specifies whether or not the materialized view should be populated at creation time. If not, the materialized view will be flagged as unscannable and cannot be queried until
**REFRESH MATERIALIZED VIEW**
is used.

<a name="compatibility"></a>

# Compatibility


**CREATE MATERIALIZED VIEW**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER MATERIALIZED VIEW (**ALTER\_MATERIALIZED\_VIEW**(7)), CREATE TABLE AS (**CREATE\_TABLE\_AS**(7)), CREATE VIEW (**CREATE\_VIEW**(7)), DROP MATERIALIZED VIEW (**DROP\_MATERIALIZED\_VIEW**(7)), REFRESH MATERIALIZED VIEW (**REFRESH\_MATERIALIZED\_VIEW**(7))
