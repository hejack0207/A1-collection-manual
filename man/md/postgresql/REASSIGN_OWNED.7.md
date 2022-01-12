# reassign owned(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

REASSIGN_OWNED - change the ownership of database objects owned by a database role

<a name="synopsis"></a>

# Synopsis

```


```
    REASSIGN OWNED BY { old_role | CURRENT_USER | SESSION_USER } [, ...]
                   TO { new_role | CURRENT_USER | SESSION_USER }

<a name="description"></a>

# Description


**REASSIGN OWNED**
instructs the system to change the ownership of database objects owned by any of the
_old\_roles_
to
_new\_role_.

<a name="parameters"></a>

# Parameters


_old\_role_
The name of a role. The ownership of all the objects within the current database, and of all shared objects (databases, tablespaces), owned by this role will be reassigned to
_new\_role_.

_new\_role_
The name of the role that will be made the new owner of the affected objects.

<a name="notes"></a>

# Notes


**REASSIGN OWNED**
is often used to prepare for the removal of one or more roles. Because
**REASSIGN OWNED**
does not affect objects within other databases, it is usually necessary to execute this command in each database that contains objects owned by a role that is to be removed.

**REASSIGN OWNED**
requires membership on both the source role(s) and the target role.

The
DROP OWNED (**DROP\_OWNED**(7))
command is an alternative that simply drops all the database objects owned by one or more roles.

The
**REASSIGN OWNED**
command does not affect any privileges granted to the
_old\_roles_
on objects that are not owned by them. Likewise, it does not affect default privileges created with
**ALTER DEFAULT PRIVILEGES**. Use
**DROP OWNED**
to revoke such privileges.

See
Section&nbsp;21.4
for more discussion.

<a name="compatibility"></a>

# Compatibility


The
**REASSIGN OWNED**
command is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

DROP OWNED (**DROP\_OWNED**(7)), DROP ROLE (**DROP\_ROLE**(7)), ALTER DATABASE (**ALTER\_DATABASE**(7))
