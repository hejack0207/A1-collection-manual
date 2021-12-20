# drop owned(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_OWNED - remove database objects owned by a database role

<a name="synopsis"></a>

# Synopsis

```


```
    DROP OWNED BY { name | CURRENT_USER | SESSION_USER } [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP OWNED**
drops all the objects within the current database that are owned by one of the specified roles. Any privileges granted to the given roles on objects in the current database or on shared objects (databases, tablespaces) will also be revoked.

<a name="parameters"></a>

# Parameters


_name_
The name of a role whose objects will be dropped, and whose privileges will be revoked.

CASCADE
Automatically drop objects that depend on the affected objects, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the objects owned by a role if any other database objects depend on one of the affected objects. This is the default.

<a name="notes"></a>

# Notes


**DROP OWNED**
is often used to prepare for the removal of one or more roles. Because
**DROP OWNED**
only affects the objects in the current database, it is usually necessary to execute this command in each database that contains objects owned by a role that is to be removed.

Using the
CASCADE
option might make the command recurse to objects owned by other users.

The
REASSIGN OWNED (**REASSIGN\_OWNED**(7))
command is an alternative that reassigns the ownership of all the database objects owned by one or more roles. However,
**REASSIGN OWNED**
does not deal with privileges for other objects.

Databases and tablespaces owned by the role(s) will not be removed.

See
Section&nbsp;21.4
for more discussion.

<a name="compatibility"></a>

# Compatibility


The
**DROP OWNED**
command is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

REASSIGN OWNED (**REASSIGN\_OWNED**(7)), DROP ROLE (**DROP\_ROLE**(7))
