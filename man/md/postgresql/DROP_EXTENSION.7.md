# drop extension(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_EXTENSION - remove an extension

<a name="synopsis"></a>

# Synopsis

```


```
    DROP EXTENSION [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP EXTENSION**
removes extensions from the database. Dropping an extension causes its component objects to be dropped as well.

You must own the extension to use
**DROP EXTENSION**.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the extension does not exist. A notice is issued in this case.

_name_
The name of an installed extension.

CASCADE
Automatically drop objects that depend on the extension, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the extension if any objects depend on it (other than its own member objects and other extensions listed in the same
**DROP**
command). This is the default.

<a name="examples"></a>

# Examples


To remove the extension
hstore
from the current database:

.if n \{.RS 4
.\}
    DROP EXTENSION hstore;
.if n \{.RE
.\}

This command will fail if any of
hstores objects are in use in the database, for example if any tables have columns of the
hstore
type. Add the
CASCADE
option to forcibly remove those dependent objects as well.

<a name="compatibility"></a>

# Compatibility


**DROP EXTENSION**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE EXTENSION (**CREATE\_EXTENSION**(7)), ALTER EXTENSION (**ALTER\_EXTENSION**(7))
