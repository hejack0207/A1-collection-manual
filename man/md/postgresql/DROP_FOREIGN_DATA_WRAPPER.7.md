# drop foreign data wrapper(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_FOREIGN_DATA_WRAPPER - remove a foreign-data wrapper

<a name="synopsis"></a>

# Synopsis

```


```
    DROP FOREIGN DATA WRAPPER [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP FOREIGN DATA WRAPPER**
removes an existing foreign-data wrapper. To execute this command, the current user must be the owner of the foreign-data wrapper.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the foreign-data wrapper does not exist. A notice is issued in this case.

_name_
The name of an existing foreign-data wrapper.

CASCADE
Automatically drop objects that depend on the foreign-data wrapper (such as foreign tables and servers), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the foreign-data wrapper if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Drop the foreign-data wrapper
dbi:

.if n \{.RS 4
.\}
    DROP FOREIGN DATA WRAPPER dbi;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP FOREIGN DATA WRAPPER**
conforms to ISO/IEC 9075-9 (SQL/MED). The
IF EXISTS
clause is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE FOREIGN DATA WRAPPER (**CREATE\_FOREIGN\_DATA\_WRAPPER**(7)), ALTER FOREIGN DATA WRAPPER (**ALTER\_FOREIGN\_DATA\_WRAPPER**(7))
