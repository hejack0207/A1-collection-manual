# set session authorization(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SET_SESSION_AUTHORIZATION - set the session user identifier and the current user identifier of the current session

<a name="synopsis"></a>

# Synopsis

```


```
    SET [ SESSION | LOCAL ] SESSION AUTHORIZATION user_name
    SET [ SESSION | LOCAL ] SESSION AUTHORIZATION DEFAULT
    RESET SESSION AUTHORIZATION

<a name="description"></a>

# Description


This command sets the session user identifier and the current user identifier of the current SQL session to be
_user\_name_. The user name can be written as either an identifier or a string literal. Using this command, it is possible, for example, to temporarily become an unprivileged user and later switch back to being a superuser.

The session user identifier is initially set to be the (possibly authenticated) user name provided by the client. The current user identifier is normally equal to the session user identifier, but might change temporarily in the context of
SECURITY DEFINER
functions and similar mechanisms; it can also be changed by
SET ROLE (**SET\_ROLE**(7)). The current user identifier is relevant for permission checking.

The session user identifier can be changed only if the initial session user (the
authenticated user) had the superuser privilege. Otherwise, the command is accepted only if it specifies the authenticated user name.

The
SESSION
and
LOCAL
modifiers act the same as for the regular
**SET**(7)
command.

The
DEFAULT
and
RESET
forms reset the session and current user identifiers to be the originally authenticated user name. These forms can be executed by any user.

<a name="notes"></a>

# Notes


**SET SESSION AUTHORIZATION**
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
    
    SET SESSION AUTHORIZATION paul*(Aq;
    
    SELECT SESSION_USER, CURRENT_USER;
    
     session_user | current_user 
    --------------+--------------
     paul         | paul
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The SQL standard allows some other expressions to appear in place of the literal
_user\_name_, but these options are not important in practice.
PostgreSQL
allows identifier syntax ("_username_"), which SQL does not. SQL does not allow this command during a transaction;
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

The privileges necessary to execute this command are left implementation-defined by the standard.

<a name="see-also"></a>

# See Also

SET ROLE (**SET\_ROLE**(7))
