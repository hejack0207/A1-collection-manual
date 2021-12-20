# drop index(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_INDEX - remove an index

<a name="synopsis"></a>

# Synopsis

```


```
    DROP INDEX [ CONCURRENTLY ] [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP INDEX**
drops an existing index from the database system. To execute this command you must be the owner of the index.

<a name="parameters"></a>

# Parameters


CONCURRENTLY
Drop the index without locking out concurrent selects, inserts, updates, and deletes on the indexs table. A normal
**DROP INDEX**
acquires an
ACCESS EXCLUSIVE
lock on the table, blocking other accesses until the index drop can be completed. With this option, the command instead waits until conflicting transactions have completed.

There are several caveats to be aware of when using this option. Only one index name can be specified, and the
CASCADE
option is not supported. (Thus, an index that supports a
UNIQUE
or
PRIMARY KEY
constraint cannot be dropped this way.) Also, regular
**DROP INDEX**
commands can be performed within a transaction block, but
**DROP INDEX CONCURRENTLY**
cannot. Lastly, indexes on partitioned tables cannot be dropped using this option.

For temporary tables,
**DROP INDEX**
is always non-concurrent, as no other session can access them, and non-concurrent index drop is cheaper.

IF EXISTS
Do not throw an error if the index does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an index to remove.

CASCADE
Automatically drop objects that depend on the index, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the index if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


This command will remove the index
title_idx:

.if n \{.RS 4
.\}
    DROP INDEX title_idx;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP INDEX**
is a
PostgreSQL
language extension. There are no provisions for indexes in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE INDEX (**CREATE\_INDEX**(7))
