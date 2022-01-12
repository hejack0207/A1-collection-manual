# drop collation(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_COLLATION - remove a collation

<a name="synopsis"></a>

# Synopsis

```


```
    DROP COLLATION [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP COLLATION**
removes a previously defined collation. To be able to drop a collation, you must own the collation.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the collation does not exist. A notice is issued in this case.

_name_
The name of the collation. The collation name can be schema-qualified.

CASCADE
Automatically drop objects that depend on the collation, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the collation if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To drop the collation named
german:

.if n \{.RS 4
.\}
    DROP COLLATION german;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**DROP COLLATION**
command conforms to the
SQL
standard, apart from the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER COLLATION (**ALTER\_COLLATION**(7)), CREATE COLLATION (**CREATE\_COLLATION**(7))
