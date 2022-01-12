# drop user mapping(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_USER_MAPPING - remove a user mapping for a foreign server

<a name="synopsis"></a>

# Synopsis

```


```
    DROP USER MAPPING [ IF EXISTS ] FOR { user_name | USER | CURRENT_USER | PUBLIC } SERVER server_name

<a name="description"></a>

# Description


**DROP USER MAPPING**
removes an existing user mapping from foreign server.

The owner of a foreign server can drop user mappings for that server for any user. Also, a user can drop a user mapping for their own user name if
USAGE
privilege on the server has been granted to the user.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the user mapping does not exist. A notice is issued in this case.

_user\_name_
User name of the mapping.
CURRENT_USER
and
USER
match the name of the current user.
PUBLIC
is used to match all present and future user names in the system.

_server\_name_
Server name of the user mapping.

<a name="examples"></a>

# Examples


Drop a user mapping
bob, server
foo
if it exists:

.if n \{.RS 4
.\}
    DROP USER MAPPING IF EXISTS FOR bob SERVER foo;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP USER MAPPING**
conforms to ISO/IEC 9075-9 (SQL/MED). The
IF EXISTS
clause is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE USER MAPPING (**CREATE\_USER\_MAPPING**(7)), ALTER USER MAPPING (**ALTER\_USER\_MAPPING**(7))
