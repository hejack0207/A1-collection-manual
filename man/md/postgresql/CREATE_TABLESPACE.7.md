# create tablespace(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_TABLESPACE - define a new tablespace

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE TABLESPACE tablespace_name
        [ OWNER { new_owner | CURRENT_USER | SESSION_USER } ]
        LOCATION directory*(Aq
        [ WITH ( tablespace_option = value [, ... ] ) ]

<a name="description"></a>

# Description


**CREATE TABLESPACE**
registers a new cluster-wide tablespace. The tablespace name must be distinct from the name of any existing tablespace in the database cluster.

A tablespace allows superusers to define an alternative location on the file system where the data files containing database objects (such as tables and indexes) can reside.

A user with appropriate privileges can pass
_tablespace\_name_
to
**CREATE DATABASE**,
**CREATE TABLE**,
**CREATE INDEX**
or
**ADD CONSTRAINT**
to have the data files for these objects stored within the specified tablespace.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

A tablespace cannot be used independently of the cluster in which it is defined; see
Section&nbsp;22.6.


<a name="parameters"></a>

# Parameters


_tablespace\_name_
The name of a tablespace to be created. The name cannot begin with
pg_, as such names are reserved for system tablespaces.

_user\_name_
The name of the user who will own the tablespace. If omitted, defaults to the user executing the command. Only superusers can create tablespaces, but they can assign ownership of tablespaces to non-superusers.

_directory_
The directory that will be used for the tablespace. The directory must exist (**CREATE TABLESPACE**
will not create it), should be empty, and must be owned by the
PostgreSQL
system user. The directory must be specified by an absolute path name.

_tablespace\_option_
A tablespace parameter to be set or reset. Currently, the only available parameters are
_seq\_page\_cost_,
_random\_page\_cost_
and
_effective\_io\_concurrency_. Setting either value for a particular tablespace will override the planners usual estimate of the cost of reading pages from tables in that tablespace, as established by the configuration parameters of the same name (see
seq_page_cost,
random_page_cost,
effective_io_concurrency). This may be useful if one tablespace is located on a disk which is faster or slower than the remainder of the I/O subsystem.

<a name="notes"></a>

# Notes


Tablespaces are only supported on systems that support symbolic links.

**CREATE TABLESPACE**
cannot be executed inside a transaction block.

<a name="examples"></a>

# Examples


To create a tablespace
dbspace
at file system location
/data/dbs, first create the directory using operating system facilities and set the correct ownership:

.if n \{.RS 4
.\}
    mkdir /data/dbs
    chown postgres:postgres /data/dbs
.if n \{.RE
.\}

Then issue the tablespace creation command inside
PostgreSQL:

.if n \{.RS 4
.\}
    CREATE TABLESPACE dbspace LOCATION /data/dbs*(Aq;
.if n \{.RE
.\}

To create a tablespace owned by a different database user, use a command like this:

.if n \{.RS 4
.\}
    CREATE TABLESPACE indexspace OWNER genevieve LOCATION /data/indexes*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE TABLESPACE**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE DATABASE (**CREATE\_DATABASE**(7)), CREATE TABLE (**CREATE\_TABLE**(7)), CREATE INDEX (**CREATE\_INDEX**(7)), DROP TABLESPACE (**DROP\_TABLESPACE**(7)), ALTER TABLESPACE (**ALTER\_TABLESPACE**(7))
