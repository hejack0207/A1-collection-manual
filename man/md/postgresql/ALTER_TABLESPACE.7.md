# alter tablespace(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TABLESPACE - change the definition of a tablespace

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TABLESPACE name RENAME TO new_name
    ALTER TABLESPACE name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER TABLESPACE name SET ( tablespace_option = value [, ... ] )
    ALTER TABLESPACE name RESET ( tablespace_option [, ... ] )

<a name="description"></a>

# Description


**ALTER TABLESPACE**
can be used to change the definition of a tablespace.

You must own the tablespace to change the definition of a tablespace. To alter the owner, you must also be a direct or indirect member of the new owning role. (Note that superusers have these privileges automatically.)

<a name="parameters"></a>

# Parameters


_name_
The name of an existing tablespace.

_new\_name_
The new name of the tablespace. The new name cannot begin with
pg_, as such names are reserved for system tablespaces.

_new\_owner_
The new owner of the tablespace.

_tablespace\_option_
A tablespace parameter to be set or reset. Currently, the only available parameters are
_seq\_page\_cost_,
_random\_page\_cost_
and
_effective\_io\_concurrency_. Setting either value for a particular tablespace will override the planners usual estimate of the cost of reading pages from tables in that tablespace, as established by the configuration parameters of the same name (see
seq_page_cost,
random_page_cost,
effective_io_concurrency). This may be useful if one tablespace is located on a disk which is faster or slower than the remainder of the I/O subsystem.

<a name="examples"></a>

# Examples


Rename tablespace
index_space
to
fast_raid:

.if n \{.RS 4
.\}
    ALTER TABLESPACE index_space RENAME TO fast_raid;
.if n \{.RE
.\}

Change the owner of tablespace
index_space:

.if n \{.RS 4
.\}
    ALTER TABLESPACE index_space OWNER TO mary;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER TABLESPACE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE TABLESPACE (**CREATE\_TABLESPACE**(7)), DROP TABLESPACE (**DROP\_TABLESPACE**(7))
