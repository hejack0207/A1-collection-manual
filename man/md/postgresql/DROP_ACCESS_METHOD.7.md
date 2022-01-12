# drop access method(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_ACCESS_METHOD - remove an access method

<a name="synopsis"></a>

# Synopsis

```


```
    DROP ACCESS METHOD [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP ACCESS METHOD**
removes an existing access method. Only superusers can drop access methods.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the access method does not exist. A notice is issued in this case.

_name_
The name of an existing access method.

CASCADE
Automatically drop objects that depend on the access method (such as operator classes, operator families, and indexes), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the access method if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Drop the access method
heptree:

.if n \{.RS 4
.\}
    DROP ACCESS METHOD heptree;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP ACCESS METHOD**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE ACCESS METHOD (**CREATE\_ACCESS\_METHOD**(7))
