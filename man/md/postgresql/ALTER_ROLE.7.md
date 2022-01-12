# alter role(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_ROLE - change a database role

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER ROLE role_specification [ WITH ] option [ ... ]
    
    where option can be:
    
          SUPERUSER | NOSUPERUSER
        | CREATEDB | NOCREATEDB
        | CREATEROLE | NOCREATEROLE
        | INHERIT | NOINHERIT
        | LOGIN | NOLOGIN
        | REPLICATION | NOREPLICATION
        | BYPASSRLS | NOBYPASSRLS
        | CONNECTION LIMIT connlimit
        | [ ENCRYPTED ] PASSWORD password*(Aq | PASSWORD NULL
        | VALID UNTIL timestamp*(Aq
    
    ALTER ROLE name RENAME TO new_name
    
    ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter { TO | = } { value | DEFAULT }
    ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter FROM CURRENT
    ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] RESET configuration_parameter
    ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] RESET ALL
    
    where role_specification can be:
    
        role_name
      | CURRENT_USER
      | SESSION_USER

<a name="description"></a>

# Description


**ALTER ROLE**
changes the attributes of a
PostgreSQL
role.

The first variant of this command listed in the synopsis can change many of the role attributes that can be specified in
CREATE ROLE (**CREATE\_ROLE**(7)). (All the possible attributes are covered, except that there are no options for adding or removing memberships; use
**GRANT**(7)
and
**REVOKE**(7)
for that.) Attributes not mentioned in the command retain their previous settings. Database superusers can change any of these settings for any role. Roles having
CREATEROLE
privilege can change any of these settings except
SUPERUSER,
REPLICATION, and
BYPASSRLS; but only for non-superuser and non-replication roles. Ordinary roles can only change their own password.

The second variant changes the name of the role. Database superusers can rename any role. Roles having
CREATEROLE
privilege can rename non-superuser roles. The current session user cannot be renamed. (Connect as a different user if you need to do that.) Because
MD5-encrypted passwords use the role name as cryptographic salt, renaming a role clears its password if the password is
MD5-encrypted.

The remaining variants change a roles session default for a configuration variable, either for all databases or, when the
IN DATABASE
clause is specified, only for sessions in the named database. If
ALL
is specified instead of a role name, this changes the setting for all roles. Using
ALL
with
IN DATABASE
is effectively the same as using the command
ALTER DATABASE ... SET ....

Whenever the role subsequently starts a new session, the specified value becomes the session default, overriding whatever setting is present in
postgresql.conf
or has been received from the
**postgres**
command line. This only happens at login time; executing
SET ROLE (**SET\_ROLE**(7))
or
SET SESSION AUTHORIZATION (**SET\_SESSION\_AUTHORIZATION**(7))
does not cause new configuration values to be set. Settings set for all databases are overridden by database-specific settings attached to a role. Settings for specific databases or specific roles override settings for all roles.

Superusers can change anyones session defaults. Roles having
CREATEROLE
privilege can change defaults for non-superuser roles. Ordinary roles can only set defaults for themselves. Certain configuration variables cannot be set this way, or can only be set if a superuser issues the command. Only superusers can change a setting for all roles in all databases.

<a name="parameters"></a>

# Parameters


_name_
The name of the role whose attributes are to be altered.

CURRENT_USER
Alter the current user instead of an explicitly identified role.

SESSION_USER
Alter the current session user instead of an explicitly identified role.

SUPERUSER  
NOSUPERUSER  
CREATEDB  
NOCREATEDB  
CREATEROLE  
NOCREATEROLE  
INHERIT  
NOINHERIT  
LOGIN  
NOLOGIN  
REPLICATION  
NOREPLICATION  
BYPASSRLS  
NOBYPASSRLS  
CONNECTION LIMIT _connlimit_  
[ ENCRYPTED ] PASSWORD _password_\*(Aq  
PASSWORD NULL  
VALID UNTIL _timestamp_\*(Aq
These clauses alter attributes originally set by
CREATE ROLE (**CREATE\_ROLE**(7)). For more information, see the
**CREATE ROLE**
reference page.

_new\_name_
The new name of the role.

_database\_name_
The name of the database the configuration variable should be set in.

_configuration\_parameter_  
_value_
Set this roles session default for the specified configuration parameter to the given value. If
_value_
is
DEFAULT
or, equivalently,
RESET
is used, the role-specific variable setting is removed, so the role will inherit the system-wide default setting in new sessions. Use
RESET ALL
to clear all role-specific settings.
SET FROM CURRENT
saves the sessions current value of the parameter as the role-specific value. If
IN DATABASE
is specified, the configuration parameter is set or removed for the given role and database only.

Role-specific variable settings take effect only at login;
SET ROLE (**SET\_ROLE**(7))
and
SET SESSION AUTHORIZATION (**SET\_SESSION\_AUTHORIZATION**(7))
do not process role-specific variable settings.

See
**SET**(7)
and
Chapter&nbsp;19
for more information about allowed parameter names and values.

<a name="notes"></a>

# Notes


Use
CREATE ROLE (**CREATE\_ROLE**(7))
to add new roles, and
DROP ROLE (**DROP\_ROLE**(7))
to remove a role.

**ALTER ROLE**
cannot change a roles memberships. Use
**GRANT**(7)
and
**REVOKE**(7)
to do that.

Caution must be exercised when specifying an unencrypted password with this command. The password will be transmitted to the server in cleartext, and it might also be logged in the clients command history or the server log.
**psql**(1)
contains a command
**\epassword**
that can be used to change a roles password without exposing the cleartext password.

It is also possible to tie a session default to a specific database rather than to a role; see
ALTER DATABASE (**ALTER\_DATABASE**(7)). If there is a conflict, database-role-specific settings override role-specific ones, which in turn override database-specific ones.

<a name="examples"></a>

# Examples


Change a roles password:

.if n \{.RS 4
.\}
    ALTER ROLE davide WITH PASSWORD hu8jmn3*(Aq;
.if n \{.RE
.\}

Remove a roles password:

.if n \{.RS 4
.\}
    ALTER ROLE davide WITH PASSWORD NULL;
.if n \{.RE
.\}

Change a password expiration date, specifying that the password should expire at midday on 4th May 2015 using the time zone which is one hour ahead of
UTC:

.if n \{.RS 4
.\}
    ALTER ROLE chris VALID UNTIL May 4 12:00:00 2015 +1*(Aq;
.if n \{.RE
.\}

Make a password valid forever:

.if n \{.RS 4
.\}
    ALTER ROLE fred VALID UNTIL infinity*(Aq;
.if n \{.RE
.\}

Give a role the ability to create other roles and new databases:

.if n \{.RS 4
.\}
    ALTER ROLE miriam CREATEROLE CREATEDB;
.if n \{.RE
.\}

Give a role a non-default setting of the
maintenance_work_mem
parameter:

.if n \{.RS 4
.\}
    ALTER ROLE worker_bee SET maintenance_work_mem = 100000;
.if n \{.RE
.\}

Give a role a non-default, database-specific setting of the
client_min_messages
parameter:

.if n \{.RS 4
.\}
    ALTER ROLE fred IN DATABASE devel SET client_min_messages = DEBUG;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**ALTER ROLE**
statement is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE ROLE (**CREATE\_ROLE**(7)), DROP ROLE (**DROP\_ROLE**(7)), ALTER DATABASE (**ALTER\_DATABASE**(7)), **SET**(7)
