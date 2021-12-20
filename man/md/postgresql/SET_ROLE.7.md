# set role(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SET_ROLE - set the current user identifier of the current session

<a name="synopsis"></a>

# Synopsis

```


```
    SET [ SESSION | LOCAL ] ROLE role_name
    SET [ SESSION | LOCAL ] ROLE NONE
    RESET ROLE

<a name="description"></a>

# Description


This command sets the current user identifier of the current SQL session to be
_role\_name_. The role name can be written as either an identifier or a string literal. After
**SET ROLE**, permissions checking for SQL commands is carried out as though the named role were the one that had logged in originally.

The specified
_role\_name_
must be a role that the current session user is a member of. (If the session user is a superuser, any role can be selected.)

The
SESSION
and
LOCAL
modifiers act the same as for the regular
**SET**(7)
command.

SET ROLE NONE
sets the current user identifier to the current session user identifier, as returned by
**session\_user**.
RESET ROLE
sets the current user identifier to the connection-time setting specified by the
command-line options,
**ALTER ROLE**, or
**ALTER DATABASE**, if any such settings exist. Otherwise,
RESET ROLE
sets the current user identifier to the current session user identifier. These forms can be executed by any user.

<a name="notes"></a>

# Notes


Using this command, it is possible to either add privileges or restrict ones privileges. If the session user role has the
INHERIT
attribute, then it automatically has all the privileges of every role that it could
**SET ROLE**
to; in this case
**SET ROLE**
effectively drops all the privileges assigned directly to the session user and to the other roles it is a member of, leaving only the privileges available to the named role. On the other hand, if the session user role has the
NOINHERIT
attribute,
**SET ROLE**
drops the privileges assigned directly to the session user and instead acquires the privileges available to the named role.

In particular, when a superuser chooses to
**SET ROLE**
to a non-superuser role, they lose their superuser privileges.

**SET ROLE**
has effects comparable to
SET SESSION AUTHORIZATION (**SET\_SESSION\_AUTHORIZATION**(7)), but the privilege checks involved are quite different. Also,
**SET SESSION AUTHORIZATION**
determines which roles are allowable for later
**SET ROLE**
commands, whereas changing roles with
**SET ROLE**
does not change the set of roles allowed to a later
**SET ROLE**.

**SET ROLE**
does not process session variables as specified by the roles
ALTER ROLE (**ALTER\_ROLE**(7))
settings; this only happens during login.

**SET ROLE**
cannot be used within a
SECURITY DEFINER
function.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    SELECT SESSION_USER, CURRENT_USER;
    
     session_user | current_user 
    --------------+--------------
     peter        | peter
    
    SET ROLE paul*(Aq;
    
    SELECT SESSION_USER, CURRENT_USER;
    
     session_user | current_user 
    --------------+--------------
     peter        | paul
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


PostgreSQL
allows identifier syntax ("_rolename_"), while the SQL standard requires the role name to be written as a string literal. SQL does not allow this command during a transaction;
PostgreSQL
does not make this restriction because there is no reason to. The
SESSION
and
LOCAL
modifiers are a
PostgreSQL
extension, as is the
RESET
syntax.

<a name="see-also"></a>

# See Also

SET SESSION AUTHORIZATION (**SET\_SESSION\_AUTHORIZATION**(7))
