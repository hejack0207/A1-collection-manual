# select into(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SELECT_INTO - define a new table from the results of a query

<a name="synopsis"></a>

# Synopsis

```


```
    [ WITH [ RECURSIVE ] with_query [, ...] ]
    SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
        * | expression [ [ AS ] output_name ] [, ...]
        INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table
        [ FROM from_item [, ...] ]
        [ WHERE condition ]
        [ GROUP BY expression [, ...] ]
        [ HAVING condition ]
        [ WINDOW window_name AS ( window_definition ) [, ...] ]
        [ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
        [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
        [ LIMIT { count | ALL } ]
        [ OFFSET start [ ROW | ROWS ] ]
        [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
        [ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]

<a name="description"></a>

# Description


**SELECT INTO**
creates a new table and fills it with data computed by a query. The data is not returned to the client, as it is with a normal
**SELECT**. The new tables columns have the names and data types associated with the output columns of the
**SELECT**.

<a name="parameters"></a>

# Parameters


TEMPORARY or TEMP
If specified, the table is created as a temporary table. Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

UNLOGGED
If specified, the table is created as an unlogged table. Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

_new\_table_
The name (optionally schema-qualified) of the table to be created.

All other parameters are described in detail under
**SELECT**(7).

<a name="notes"></a>

# Notes


CREATE TABLE AS (**CREATE\_TABLE\_AS**(7))
is functionally similar to
**SELECT INTO**.
**CREATE TABLE AS**
is the recommended syntax, since this form of
**SELECT INTO**
is not available in
ECPG
or
PL/pgSQL, because they interpret the
INTO
clause differently. Furthermore,
**CREATE TABLE AS**
offers a superset of the functionality provided by
**SELECT INTO**.

In contrast to
**CREATE TABLE AS**,
**SELECT INTO**
does not allow to specify properties like a tables access method with
USING _method_
or the tables tablespace with
TABLESPACE _tablespace\_name_. Use
CREATE TABLE AS (**CREATE\_TABLE\_AS**(7))
if necessary. Therefore, the default table access method is chosen for the new table. See
default_table_access_method
for more information.

<a name="examples"></a>

# Examples


Create a new table
films_recent
consisting of only recent entries from the table
films:

.if n \{.RS 4
.\}
    SELECT * INTO films_recent FROM films WHERE date_prod >= 2002-01-01*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The SQL standard uses
**SELECT INTO**
to represent selecting values into scalar variables of a host program, rather than creating a new table. This indeed is the usage found in
ECPG
(see
Chapter&nbsp;35) and
PL/pgSQL
(see
Chapter&nbsp;42). The
PostgreSQL
usage of
**SELECT INTO**
to represent table creation is historical. It is best to use
**CREATE TABLE AS**
for this purpose in new code.

<a name="see-also"></a>

# See Also

CREATE TABLE AS (**CREATE\_TABLE\_AS**(7))
