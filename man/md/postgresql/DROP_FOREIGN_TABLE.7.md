# drop foreign table(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_FOREIGN_TABLE - remove a foreign table

<a name="synopsis"></a>

# Synopsis

```


```
    DROP FOREIGN TABLE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP FOREIGN TABLE**
removes a foreign table. Only the owner of a foreign table can remove it.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the foreign table does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of the foreign table to drop.

CASCADE
Automatically drop objects that depend on the foreign table (such as views), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the foreign table if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To destroy two foreign tables,
films
and
distributors:

.if n \{.RS 4
.\}
    DROP FOREIGN TABLE films, distributors;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command conforms to the ISO/IEC 9075-9 (SQL/MED), except that the standard only allows one foreign table to be dropped per command, and apart from the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER FOREIGN TABLE (**ALTER\_FOREIGN\_TABLE**(7)), CREATE FOREIGN TABLE (**CREATE\_FOREIGN\_TABLE**(7))
