# drop server(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_SERVER - remove a foreign server descriptor

<a name="synopsis"></a>

# Synopsis

```


```
    DROP SERVER [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP SERVER**
removes an existing foreign server descriptor. To execute this command, the current user must be the owner of the server.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the server does not exist. A notice is issued in this case.

_name_
The name of an existing server.

CASCADE
Automatically drop objects that depend on the server (such as user mappings), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the server if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Drop a server
foo
if it exists:

.if n \{.RS 4
.\}
    DROP SERVER IF EXISTS foo;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP SERVER**
conforms to ISO/IEC 9075-9 (SQL/MED). The
IF EXISTS
clause is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE SERVER (**CREATE\_SERVER**(7)), ALTER SERVER (**ALTER\_SERVER**(7))
