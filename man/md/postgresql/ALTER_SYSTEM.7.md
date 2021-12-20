# alter system(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_SYSTEM - change a server configuration parameter

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER SYSTEM SET configuration_parameter { TO | = } { value | value*(Aq | DEFAULT }
    
    ALTER SYSTEM RESET configuration_parameter
    ALTER SYSTEM RESET ALL

<a name="description"></a>

# Description


**ALTER SYSTEM**
is used for changing server configuration parameters across the entire database cluster. It can be more convenient than the traditional method of manually editing the
postgresql.conf
file.
**ALTER SYSTEM**
writes the given parameter setting to the
postgresql.auto.conf
file, which is read in addition to
postgresql.conf. Setting a parameter to
DEFAULT, or using the
**RESET**
variant, removes that configuration entry from the
postgresql.auto.conf
file. Use
RESET ALL
to remove all such configuration entries.

Values set with
**ALTER SYSTEM**
will be effective after the next server configuration reload, or after the next server restart in the case of parameters that can only be changed at server start. A server configuration reload can be commanded by calling the SQL function
**pg\_reload\_conf()**, running
pg_ctl reload, or sending a
SIGHUP
signal to the main server process.

Only superusers can use
**ALTER SYSTEM**. Also, since this command acts directly on the file system and cannot be rolled back, it is not allowed inside a transaction block or function.

<a name="parameters"></a>

# Parameters


_configuration\_parameter_
Name of a settable configuration parameter. Available parameters are documented in
Chapter&nbsp;19.

_value_
New value of the parameter. Values can be specified as string constants, identifiers, numbers, or comma-separated lists of these, as appropriate for the particular parameter.
DEFAULT
can be written to specify removing the parameter and its value from
postgresql.auto.conf.

<a name="notes"></a>

# Notes


This command cant be used to set
data_directory, nor parameters that are not allowed in
postgresql.conf
(e.g.,
preset options).

See
Section&nbsp;19.1
for other ways to set the parameters.

<a name="examples"></a>

# Examples


Set the
wal_level:

.if n \{.RS 4
.\}
    ALTER SYSTEM SET wal_level = replica;
.if n \{.RE
.\}

Undo that, restoring whatever setting was effective in
postgresql.conf:

.if n \{.RS 4
.\}
    ALTER SYSTEM RESET wal_level;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**ALTER SYSTEM**
statement is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

**SET**(7), **SHOW**(7)
