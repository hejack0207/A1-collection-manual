# drop role(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_ROLE - remove a database role

<a name="synopsis"></a>

# Synopsis

```


```
    DROP ROLE [ IF EXISTS ] name [, ...]

<a name="description"></a>

# Description


**DROP ROLE**
removes the specified role(s). To drop a superuser role, you must be a superuser yourself; to drop non-superuser roles, you must have
CREATEROLE
privilege.

A role cannot be removed if it is still referenced in any database of the cluster; an error will be raised if so. Before dropping the role, you must drop all the objects it owns (or reassign their ownership) and revoke any privileges the role has been granted on other objects. The
REASSIGN OWNED (**REASSIGN\_OWNED**(7))
and
DROP OWNED (**DROP\_OWNED**(7))
commands can be useful for this purpose; see
Section&nbsp;21.4
for more discussion.

However, it is not necessary to remove role memberships involving the role;
**DROP ROLE**
automatically revokes any memberships of the target role in other roles, and of other roles in the target role. The other roles are not dropped nor otherwise affected.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the role does not exist. A notice is issued in this case.

_name_
The name of the role to remove.

<a name="notes"></a>

# Notes


PostgreSQL
includes a program
**dropuser**(1)
that has the same functionality as this command (in fact, it calls this command) but can be run from the command shell.

<a name="examples"></a>

# Examples


To drop a role:

.if n \{.RS 4
.\}
    DROP ROLE jonathan;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The SQL standard defines
**DROP ROLE**, but it allows only one role to be dropped at a time, and it specifies different privilege requirements than
PostgreSQL
uses.

<a name="see-also"></a>

# See Also

CREATE ROLE (**CREATE\_ROLE**(7)), ALTER ROLE (**ALTER\_ROLE**(7)), SET ROLE (**SET\_ROLE**(7))
