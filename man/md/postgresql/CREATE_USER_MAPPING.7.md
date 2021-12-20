# create user mapping(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_USER_MAPPING - define a new mapping of a user to a foreign server

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE USER MAPPING [ IF NOT EXISTS ] FOR { user_name | USER | CURRENT_USER | PUBLIC }
        SERVER server_name
        [ OPTIONS ( option value*(Aq [ , ... ] ) ]

<a name="description"></a>

# Description


**CREATE USER MAPPING**
defines a mapping of a user to a foreign server. A user mapping typically encapsulates connection information that a foreign-data wrapper uses together with the information encapsulated by a foreign server to access an external data resource.

The owner of a foreign server can create user mappings for that server for any user. Also, a user can create a user mapping for their own user name if
USAGE
privilege on the server has been granted to the user.

<a name="parameters"></a>

# Parameters


IF NOT EXISTS
Do not throw an error if a mapping of the given user to the given foreign server already exists. A notice is issued in this case. Note that there is no guarantee that the existing user mapping is anything like the one that would have been created.

_user\_name_
The name of an existing user that is mapped to foreign server.
CURRENT_USER
and
USER
match the name of the current user. When
PUBLIC
is specified, a so-called public mapping is created that is used when no user-specific mapping is applicable.

_server\_name_
The name of an existing server for which the user mapping is to be created.

OPTIONS ( _option_ _value_\*(Aq [, ... ] )
This clause specifies the options of the user mapping. The options typically define the actual user name and password of the mapping. Option names must be unique. The allowed option names and values are specific to the servers foreign-data wrapper.

<a name="examples"></a>

# Examples


Create a user mapping for user
bob, server
foo:

.if n \{.RS 4
.\}
    CREATE USER MAPPING FOR bob SERVER foo OPTIONS (user bob*(Aq, password *(Aqsecret*(Aq);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE USER MAPPING**
conforms to ISO/IEC 9075-9 (SQL/MED).

<a name="see-also"></a>

# See Also

ALTER USER MAPPING (**ALTER\_USER\_MAPPING**(7)), DROP USER MAPPING (**DROP\_USER\_MAPPING**(7)), CREATE FOREIGN DATA WRAPPER (**CREATE\_FOREIGN\_DATA\_WRAPPER**(7)), CREATE SERVER (**CREATE\_SERVER**(7))
