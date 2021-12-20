# alter server(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_SERVER - change the definition of a foreign server

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER SERVER name [ VERSION new_version*(Aq ]
        [ OPTIONS ( [ ADD | SET | DROP ] option [value*(Aq] [, ... ] ) ]
    ALTER SERVER name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER SERVER name RENAME TO new_name

<a name="description"></a>

# Description


**ALTER SERVER**
changes the definition of a foreign server. The first form changes the server version string or the generic options of the server (at least one clause is required). The second form changes the owner of the server.

To alter the server you must be the owner of the server. Additionally to alter the owner, you must own the server and also be a direct or indirect member of the new owning role, and you must have
USAGE
privilege on the servers foreign-data wrapper. (Note that superusers satisfy all these criteria automatically.)

<a name="parameters"></a>

# Parameters


_name_
The name of an existing server.

_new\_version_
New server version.

OPTIONS ( [ ADD | SET | DROP ] _option_ [_value_\*(Aq] [, ... ] )
Change options for the server.
ADD,
SET, and
DROP
specify the action to be performed.
ADD
is assumed if no operation is explicitly specified. Option names must be unique; names and values are also validated using the servers foreign-data wrapper library.

_new\_owner_
The user name of the new owner of the foreign server.

_new\_name_
The new name for the foreign server.

<a name="examples"></a>

# Examples


Alter server
foo, add connection options:

.if n \{.RS 4
.\}
    ALTER SERVER foo OPTIONS (host foo*(Aq, dbname *(Aqfoodb*(Aq);
.if n \{.RE
.\}

Alter server
foo, change version, change
host
option:

.if n \{.RS 4
.\}
    ALTER SERVER foo VERSION 8.4*(Aq OPTIONS (SET host *(Aqbaz*(Aq);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER SERVER**
conforms to ISO/IEC 9075-9 (SQL/MED). The
OWNER TO
and
RENAME
forms are PostgreSQL extensions.

<a name="see-also"></a>

# See Also

CREATE SERVER (**CREATE\_SERVER**(7)), DROP SERVER (**DROP\_SERVER**(7))
