# drop sequence(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_SEQUENCE - remove a sequence

<a name="synopsis"></a>

# Synopsis

```


```
    DROP SEQUENCE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP SEQUENCE**
removes sequence number generators. A sequence can only be dropped by its owner or a superuser.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the sequence does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of a sequence.

CASCADE
Automatically drop objects that depend on the sequence, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the sequence if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To remove the sequence
serial:

.if n \{.RS 4
.\}
    DROP SEQUENCE serial;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP SEQUENCE**
conforms to the
SQL
standard, except that the standard only allows one sequence to be dropped per command, and apart from the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE SEQUENCE (**CREATE\_SEQUENCE**(7)), ALTER SEQUENCE (**ALTER\_SEQUENCE**(7))
