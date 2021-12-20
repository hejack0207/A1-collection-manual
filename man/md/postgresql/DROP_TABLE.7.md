# drop table(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TABLE - remove a table

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TABLE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TABLE**
removes tables from the database. Only the table owner, the schema owner, and superuser can drop a table. To empty a table of rows without destroying the table, use
**DELETE**(7)
or
**TRUNCATE**(7).

**DROP TABLE**
always removes any indexes, rules, triggers, and constraints that exist for the target table. However, to drop a table that is referenced by a view or a foreign-key constraint of another table,
CASCADE
must be specified. (CASCADE
will remove a dependent view entirely, but in the foreign-key case it will only remove the foreign-key constraint, not the other table entirely.)

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the table does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of the table to drop.

CASCADE
Automatically drop objects that depend on the table (such as views), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the table if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To destroy two tables,
films
and
distributors:

.if n \{.RS 4
.\}
    DROP TABLE films, distributors;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command conforms to the SQL standard, except that the standard only allows one table to be dropped per command, and apart from the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER TABLE (**ALTER\_TABLE**(7)), CREATE TABLE (**CREATE\_TABLE**(7))
