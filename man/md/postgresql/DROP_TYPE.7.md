# drop type(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TYPE - remove a data type

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TYPE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TYPE**
removes a user-defined data type. Only the owner of a type can remove it.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the type does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of the data type to remove.

CASCADE
Automatically drop objects that depend on the type (such as table columns, functions, and operators), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the type if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To remove the data type
box:

.if n \{.RS 4
.\}
    DROP TYPE box;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command is similar to the corresponding command in the SQL standard, apart from the
IF EXISTS
option, which is a
PostgreSQL
extension. But note that much of the
**CREATE TYPE**
command and the data type extension mechanisms in
PostgreSQL
differ from the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TYPE (**ALTER\_TYPE**(7)), CREATE TYPE (**CREATE\_TYPE**(7))
