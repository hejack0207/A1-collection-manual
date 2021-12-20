# drop schema(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_SCHEMA - remove a schema

<a name="synopsis"></a>

# Synopsis

```


```
    DROP SCHEMA [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP SCHEMA**
removes schemas from the database.

A schema can only be dropped by its owner or a superuser. Note that the owner can drop the schema (and thereby all contained objects) even if they do not own some of the objects within the schema.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the schema does not exist. A notice is issued in this case.

_name_
The name of a schema.

CASCADE
Automatically drop objects (tables, functions, etc.) that are contained in the schema, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the schema if it contains any objects. This is the default.

<a name="notes"></a>

# Notes


Using the
CASCADE
option might make the command remove objects in other schemas besides the one(s) named.

<a name="examples"></a>

# Examples


To remove schema
mystuff
from the database, along with everything it contains:

.if n \{.RS 4
.\}
    DROP SCHEMA mystuff CASCADE;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP SCHEMA**
is fully conforming with the SQL standard, except that the standard only allows one schema to be dropped per command, and apart from the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER SCHEMA (**ALTER\_SCHEMA**(7)), CREATE SCHEMA (**CREATE\_SCHEMA**(7))
