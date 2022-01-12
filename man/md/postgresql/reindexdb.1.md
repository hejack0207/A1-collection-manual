# reindexdb(1)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

reindexdb - reindex a PostgreSQL database

<a name="synopsis"></a>

# Synopsis

```
.HP \w'reindexdb&nbsp;'u reindexdb [connection-option...] [option...] [&nbsp;-S&nbsp;|&nbsp;--schema&nbsp;schema&nbsp;]...  [&nbsp;-t&nbsp;|&nbsp;--table&nbsp;table&nbsp;]...  [&nbsp;-i&nbsp;|&nbsp;--index&nbsp;index&nbsp;]...  [dbname] .HP \w'reindexdb&nbsp;'u reindexdb [connection-option...] [option...] -a | --all  .HP \w'reindexdb&nbsp;'u reindexdb [connection-option...] [option...] -s | --system  [dbname]
```

<a name="description"></a>

# Description


reindexdb
is a utility for rebuilding indexes in a
PostgreSQL
database.

reindexdb
is a wrapper around the SQL command
**REINDEX**(7). There is no effective difference between reindexing databases via this utility and via other methods for accessing the server.

<a name="options"></a>

# Options


reindexdb
accepts the following command-line arguments:

**-a**  
**--all**
Reindex all databases.

**--concurrently**
Use the
CONCURRENTLY
option. See
**REINDEX**(7), where all the caveats of this option are explained in detail.

**[-d]**** ****dbname**  
**[--dbname=]****dbname**
Specifies the name of the database to be reindexed, when
**-a**/**--all**
is not used. If this is not specified, the database name is read from the environment variable
**PGDATABASE**. If that is not set, the user name specified for the connection is used. The
_dbname_
can be a
connection string. If so, connection string parameters will override any conflicting command line options.

**-e**  
**--echo**
Echo the commands that
reindexdb
generates and sends to the server.

**-i ****index**  
**--index=****index**
Recreate
_index_
only. Multiple indexes can be recreated by writing multiple
**-i**
switches.

**-q**  
**--quiet**
Do not display progress messages.

**-s**  
**--system**
Reindex databases system catalogs.

**-S ****schema**  
**--schema=****schema**
Reindex
_schema_
only. Multiple schemas can be reindexed by writing multiple
**-S**
switches.

**-t ****table**  
**--table=****table**
Reindex
_table_
only. Multiple tables can be reindexed by writing multiple
**-t**
switches.

**-v**  
**--verbose**
Print detailed information during processing.

**-V**  
**--version**
Print the
reindexdb
version and exit.

**-?**  
**--help**
Show help about
reindexdb
command line arguments, and exit.

reindexdb
also accepts the following command-line arguments for connection parameters:

**-h ****host**  
**--host=****host**
Specifies the host name of the machine on which the server is running. If the value begins with a slash, it is used as the directory for the Unix domain socket.

**-p ****port**  
**--port=****port**
Specifies the TCP port or local Unix domain socket file extension on which the server is listening for connections.

**-U ****username**  
**--username=****username**
User name to connect as.

**-w**  
**--no-password**
Never issue a password prompt. If the server requires password authentication and a password is not available by other means such as a
.pgpass
file, the connection attempt will fail. This option can be useful in batch jobs and scripts where no user is present to enter a password.

**-W**  
**--password**
Force
reindexdb
to prompt for a password before connecting to a database.

This option is never essential, since
reindexdb
will automatically prompt for a password if the server demands password authentication. However,
reindexdb
will waste a connection attempt finding out that the server wants a password. In some cases it is worth typing
**-W**
to avoid the extra connection attempt.

**--maintenance-db=****dbname**
Specifies the name of the database to connect to to discover which databases should be reindexed, when
**-a**/**--all**
is used. If not specified, the
postgres
database will be used, or if that does not exist,
template1
will be used. This can be a
connection string. If so, connection string parameters will override any conflicting command line options. Also, connection string parameters other than the database name itself will be re-used when connecting to other databases.

<a name="environment"></a>

# Environment


**PGDATABASE**  
**PGHOST**  
**PGPORT**  
**PGUSER**
Default connection parameters

**PG\_COLOR**
Specifies whether to use color in diagnostic messages. Possible values are
always,
auto
and
never.

This utility, like most other
PostgreSQL
utilities, also uses the environment variables supported by
libpq
(see
Section&nbsp;33.14).

<a name="diagnostics"></a>

# Diagnostics


In case of difficulty, see
**REINDEX**(7)
and
**psql**(1)
for discussions of potential problems and error messages. The database server must be running at the targeted host. Also, any default connection settings and environment variables used by the
libpq
front-end library will apply.

<a name="notes"></a>

# Notes


reindexdb
might need to connect several times to the
PostgreSQL
server, asking for a password each time. It is convenient to have a
~/.pgpass
file in such cases. See
Section&nbsp;33.15
for more information.

<a name="examples"></a>

# Examples


To reindex the database
test:

.if n \{.RS 4
.\}
    $ reindexdb test
.if n \{.RE
.\}

To reindex the table
foo
and the index
bar
in a database named
abcd:

.if n \{.RS 4
.\}
    $ reindexdb --table=foo --index=bar abcd
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also

**REINDEX**(7)
