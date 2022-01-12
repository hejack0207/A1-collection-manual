# alter group(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_GROUP - change role name or membership

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER GROUP role_specification ADD USER user_name [, ... ]
    ALTER GROUP role_specification DROP USER user_name [, ... ]
    
    where role_specification can be:
    
        role_name
      | CURRENT_USER
      | SESSION_USER
    
    ALTER GROUP group_name RENAME TO new_name

<a name="description"></a>

# Description


**ALTER GROUP**
changes the attributes of a user group. This is an obsolete command, though still accepted for backwards compatibility, because groups (and users too) have been superseded by the more general concept of roles.

The first two variants add users to a group or remove them from a group. (Any role can play the part of either a
“user”
or a
“group”
for this purpose.) These variants are effectively equivalent to granting or revoking membership in the role named as the
“group”; so the preferred way to do this is to use
**GRANT**(7)
or
**REVOKE**(7).

The third variant changes the name of the group. This is exactly equivalent to renaming the role with
ALTER ROLE (**ALTER\_ROLE**(7)).

<a name="parameters"></a>

# Parameters


_group\_name_
The name of the group (role) to modify.

_user\_name_
Users (roles) that are to be added to or removed from the group. The users must already exist;
**ALTER GROUP**
does not create or drop users.

_new\_name_
The new name of the group.

<a name="examples"></a>

# Examples


Add users to a group:

.if n \{.RS 4
.\}
    ALTER GROUP staff ADD USER karl, john;
.if n \{.RE
.\}

Remove a user from a group:

.if n \{.RS 4
.\}
    ALTER GROUP workers DROP USER beth;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER GROUP**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

**GRANT**(7), **REVOKE**(7), ALTER ROLE (**ALTER\_ROLE**(7))
