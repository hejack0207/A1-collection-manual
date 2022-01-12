# vacuumdb(1)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

vacuumdb - garbage-collect and analyze a PostgreSQL database

<a name="synopsis"></a>

# Synopsis

```
.HP \w'vacuumdb&nbsp;'u vacuumdb [connection-option...] [option...] [&nbsp;-t&nbsp;|&nbsp;--table&nbsp;table&nbsp;[(&nbsp;column&nbsp;[,...]&nbsp;)]&nbsp;]...  [dbname] .HP \w'vacuumdb&nbsp;'u vacuumdb [connection-option...] [option...] -a | --all 
```

<a name="description"></a>

# Description


vacuumdb
is a utility for cleaning a
PostgreSQL
database.
vacuumdb
will also generate internal statistics used by the
PostgreSQL
query optimizer.

vacuumdb
is a wrapper around the SQL command
**VACUUM**(7). There is no effective difference between vacuuming and analyzing databases via this utility and via other methods for accessing the server.

<a name="options"></a>

# Options


vacuumdb
accepts the following command-line arguments:

**-a**  
**--all**
Vacuum all databases.

**[-d]**** ****dbname**  
**[--dbname=]****dbname**
Specifies the name of the database to be cleaned or analyzed, when
**-a**/**--all**
is not used. If this is not specified, the database name is read from the environment variable
**PGDATABASE**. If that is not set, the user name specified for the connection is used. The
_dbname_
can be a
connection string. If so, connection string parameters will override any conflicting command line options.

**--disable-page-skipping**
Disable skipping pages based on the contents of the visibility map.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option is only available for servers running
PostgreSQL
9.6 and later.


**-e**  
**--echo**
Echo the commands that
vacuumdb
generates and sends to the server.

**-f**  
**--full**
Perform
“full”
vacuuming.

**-F**  
**--freeze**
Aggressively
“freeze”
tuples.

**-j ****njobs**  
**--jobs=****njobs**
Execute the vacuum or analyze commands in parallel by running
_njobs_
commands simultaneously. This option reduces the time of the processing but it also increases the load on the database server.

vacuumdb
will open
_njobs_
connections to the database, so make sure your
max_connections
setting is high enough to accommodate all connections.

Note that using this mode together with the
**-f**
(FULL) option might cause deadlock failures if certain system catalogs are processed in parallel.

**--min-mxid-age ****mxid\_age**
Only execute the vacuum or analyze commands on tables with a multixact ID age of at least
_mxid\_age_. This setting is useful for prioritizing tables to process to prevent multixact ID wraparound (see
Section&nbsp;24.1.5.1).

For the purposes of this option, the multixact ID age of a relation is the greatest of the ages of the main relation and its associated
TOAST
table, if one exists. Since the commands issued by
vacuumdb
will also process the
TOAST
table for the relation if necessary, it does not need to be considered separately.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option is only available for servers running
PostgreSQL
9.6 and later.


**--min-xid-age ****xid\_age**
Only execute the vacuum or analyze commands on tables with a transaction ID age of at least
_xid\_age_. This setting is useful for prioritizing tables to process to prevent transaction ID wraparound (see
Section&nbsp;24.1.5).

For the purposes of this option, the transaction ID age of a relation is the greatest of the ages of the main relation and its associated
TOAST
table, if one exists. Since the commands issued by
vacuumdb
will also process the
TOAST
table for the relation if necessary, it does not need to be considered separately.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option is only available for servers running
PostgreSQL
9.6 and later.


**-q**  
**--quiet**
Do not display progress messages.

**--skip-locked**
Skip relations that cannot be immediately locked for processing.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option is only available for servers running
PostgreSQL
12 and later.


**-t ****table**** [ (****column**** [,...]) ]**  
**--table=****table**** [ (****column**** [,...]) ]**
Clean or analyze
_table_
only. Column names can be specified only in conjunction with the
**--analyze**
or
**--analyze-only**
options. Multiple tables can be vacuumed by writing multiple
**-t**
switches.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Tip**
.ps -1  
If you specify columns, you probably have to escape the parentheses from the shell. (See examples below.)


**-v**  
**--verbose**
Print detailed information during processing.

**-V**  
**--version**
Print the
vacuumdb
version and exit.

**-z**  
**--analyze**
Also calculate statistics for use by the optimizer.

**-Z**  
**--analyze-only**
Only calculate statistics for use by the optimizer (no vacuum).

**--analyze-in-stages**
Only calculate statistics for use by the optimizer (no vacuum), like
**--analyze-only**. Run several (currently three) stages of analyze with different configuration settings, to produce usable statistics faster.

This option is useful to analyze a database that was newly populated from a restored dump or by
**pg\_upgrade**. This option will try to create some statistics as fast as possible, to make the database usable, and then produce full statistics in the subsequent stages.

**-?**  
**--help**
Show help about
vacuumdb
command line arguments, and exit.

vacuumdb
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
vacuumdb
to prompt for a password before connecting to a database.

This option is never essential, since
vacuumdb
will automatically prompt for a password if the server demands password authentication. However,
vacuumdb
will waste a connection attempt finding out that the server wants a password. In some cases it is worth typing
**-W**
to avoid the extra connection attempt.

**--maintenance-db=****dbname**
Specifies the name of the database to connect to to discover which databases should be vacuumed, when
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
**VACUUM**(7)
and
**psql**(1)
for discussions of potential problems and error messages. The database server must be running at the targeted host. Also, any default connection settings and environment variables used by the
libpq
front-end library will apply.

<a name="notes"></a>

# Notes


vacuumdb
might need to connect several times to the
PostgreSQL
server, asking for a password each time. It is convenient to have a
~/.pgpass
file in such cases. See
Section&nbsp;33.15
for more information.

<a name="examples"></a>

# Examples


To clean the database
test:

.if n \{.RS 4
.\}
    $ vacuumdb test
.if n \{.RE
.\}

To clean and analyze for the optimizer a database named
bigdb:

.if n \{.RS 4
.\}
    $ vacuumdb --analyze bigdb
.if n \{.RE
.\}

To clean a single table
foo
in a database named
xyzzy, and analyze a single column
bar
of the table for the optimizer:

.if n \{.RS 4
.\}
    $ vacuumdb --analyze --verbose --table=foo(bar)*(Aq xyzzy
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also

**VACUUM**(7)
