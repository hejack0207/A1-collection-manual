# import foreign schema(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

IMPORT_FOREIGN_SCHEMA - import table definitions from a foreign server

<a name="synopsis"></a>

# Synopsis

```


```
    IMPORT FOREIGN SCHEMA remote_schema
        [ { LIMIT TO | EXCEPT } ( table_name [, ...] ) ]
        FROM SERVER server_name
        INTO local_schema
        [ OPTIONS ( option value*(Aq [, ... ] ) ]

<a name="description"></a>

# Description


**IMPORT FOREIGN SCHEMA**
creates foreign tables that represent tables existing on a foreign server. The new foreign tables will be owned by the user issuing the command and are created with the correct column definitions and options to match the remote tables.

By default, all tables and views existing in a particular schema on the foreign server are imported. Optionally, the list of tables can be limited to a specified subset, or specific tables can be excluded. The new foreign tables are all created in the target schema, which must already exist.

To use
**IMPORT FOREIGN SCHEMA**, the user must have
USAGE
privilege on the foreign server, as well as
CREATE
privilege on the target schema.

<a name="parameters"></a>

# Parameters


_remote\_schema_
The remote schema to import from. The specific meaning of a remote schema depends on the foreign data wrapper in use.

LIMIT TO ( _table\_name_ [, ...] )
Import only foreign tables matching one of the given table names. Other tables existing in the foreign schema will be ignored.

EXCEPT ( _table\_name_ [, ...] )
Exclude specified foreign tables from the import. All tables existing in the foreign schema will be imported except the ones listed here.

_server\_name_
The foreign server to import from.

_local\_schema_
The schema in which the imported foreign tables will be created.

OPTIONS ( _option_ _value_\*(Aq [, ...] )
Options to be used during the import. The allowed option names and values are specific to each foreign data wrapper.

<a name="examples"></a>

# Examples


Import table definitions from a remote schema
foreign_films
on server
film_server, creating the foreign tables in local schema
films:

.if n \{.RS 4
.\}
    IMPORT FOREIGN SCHEMA foreign_films
        FROM SERVER film_server INTO films;
.if n \{.RE
.\}

As above, but import only the two tables
actors
and
directors
(if they exist):

.if n \{.RS 4
.\}
    IMPORT FOREIGN SCHEMA foreign_films LIMIT TO (actors, directors)
        FROM SERVER film_server INTO films;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**IMPORT FOREIGN SCHEMA**
command conforms to the
SQL
standard, except that the
OPTIONS
clause is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE FOREIGN TABLE (**CREATE\_FOREIGN\_TABLE**(7)), CREATE SERVER (**CREATE\_SERVER**(7))
