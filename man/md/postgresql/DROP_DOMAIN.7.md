# drop domain(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_DOMAIN - remove a domain

<a name="synopsis"></a>

# Synopsis

```


```
    DROP DOMAIN [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP DOMAIN**
removes a domain. Only the owner of a domain can remove it.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the domain does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing domain.

CASCADE
Automatically drop objects that depend on the domain (such as table columns), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the domain if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To remove the domain
box:

.if n \{.RS 4
.\}
    DROP DOMAIN box;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command conforms to the SQL standard, except for the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE DOMAIN (**CREATE\_DOMAIN**(7)), ALTER DOMAIN (**ALTER\_DOMAIN**(7))
