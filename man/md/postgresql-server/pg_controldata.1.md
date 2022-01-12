# pg_controldata(1)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pg_controldata - display control information of a PostgreSQL database cluster

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pg_controldata&nbsp;'u pg_controldata [option] [[-D | --pgdata]datadir]
```

<a name="description"></a>

# Description


**pg\_controldata**
prints information initialized during
**initdb**, such as the catalog version. It also shows information about write-ahead logging and checkpoint processing. This information is cluster-wide, and not specific to any one database.

This utility can only be run by the user who initialized the cluster because it requires read access to the data directory. You can specify the data directory on the command line, or use the environment variable
**PGDATA**. This utility supports the options
**-V**
and
**--version**, which print the
pg_controldata
version and exit. It also supports options
**-?**
and
**--help**, which output the supported arguments.

<a name="environment"></a>

# Environment


**PGDATA**
Default data directory location

**PG\_COLOR**
Specifies whether to use color in diagnostic messages. Possible values are
always,
auto
and
never.
