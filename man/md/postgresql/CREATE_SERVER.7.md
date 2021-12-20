# create server(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_SERVER - define a new foreign server

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE SERVER [ IF NOT EXISTS ] server_name [ TYPE server_type*(Aq ] [ VERSION *(Aqserver_version*(Aq ]
        FOREIGN DATA WRAPPER fdw_name
        [ OPTIONS ( option value*(Aq [, ... ] ) ]

<a name="description"></a>

# Description


**CREATE SERVER**
defines a new foreign server. The user who defines the server becomes its owner.

A foreign server typically encapsulates connection information that a foreign-data wrapper uses to access an external data resource. Additional user-specific connection information may be specified by means of user mappings.

The server name must be unique within the database.

Creating a server requires
USAGE
privilege on the foreign-data wrapper being used.

<a name="parameters"></a>

# Parameters


IF NOT EXISTS
Do not throw an error if a server with the same name already exists. A notice is issued in this case. Note that there is no guarantee that the existing server is anything like the one that would have been created.

_server\_name_
The name of the foreign server to be created.

_server\_type_
Optional server type, potentially useful to foreign-data wrappers.

_server\_version_
Optional server version, potentially useful to foreign-data wrappers.

_fdw\_name_
The name of the foreign-data wrapper that manages the server.

OPTIONS ( _option_ _value_\*(Aq [, ... ] )
This clause specifies the options for the server. The options typically define the connection details of the server, but the actual names and values are dependent on the servers foreign-data wrapper.

<a name="notes"></a>

# Notes


When using the
dblink
module, a foreign servers name can be used as an argument of the
**dblink\_connect**(3)
function to indicate the connection parameters. It is necessary to have the
USAGE
privilege on the foreign server to be able to use it in this way.

<a name="examples"></a>

# Examples


Create a server
myserver
that uses the foreign-data wrapper
postgres_fdw:

.if n \{.RS 4
.\}
    CREATE SERVER myserver FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host foo*(Aq, dbname *(Aqfoodb*(Aq, port *(Aq5432*(Aq);
.if n \{.RE
.\}

See
postgres_fdw
for more details.

<a name="compatibility"></a>

# Compatibility


**CREATE SERVER**
conforms to ISO/IEC 9075-9 (SQL/MED).

<a name="see-also"></a>

# See Also

ALTER SERVER (**ALTER\_SERVER**(7)), DROP SERVER (**DROP\_SERVER**(7)), CREATE FOREIGN DATA WRAPPER (**CREATE\_FOREIGN\_DATA\_WRAPPER**(7)), CREATE FOREIGN TABLE (**CREATE\_FOREIGN\_TABLE**(7)), CREATE USER MAPPING (**CREATE\_USER\_MAPPING**(7))
