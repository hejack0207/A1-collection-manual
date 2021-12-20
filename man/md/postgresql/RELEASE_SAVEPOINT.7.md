# release savepoint(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

RELEASE_SAVEPOINT - destroy a previously defined savepoint

<a name="synopsis"></a>

# Synopsis

```


```
    RELEASE [ SAVEPOINT ] savepoint_name

<a name="description"></a>

# Description


**RELEASE SAVEPOINT**
destroys a savepoint previously defined in the current transaction.

Destroying a savepoint makes it unavailable as a rollback point, but it has no other user visible behavior. It does not undo the effects of commands executed after the savepoint was established. (To do that, see
ROLLBACK TO SAVEPOINT (**ROLLBACK\_TO\_SAVEPOINT**(7)).) Destroying a savepoint when it is no longer needed allows the system to reclaim some resources earlier than transaction end.

**RELEASE SAVEPOINT**
also destroys all savepoints that were established after the named savepoint was established.

<a name="parameters"></a>

# Parameters


_savepoint\_name_
The name of the savepoint to destroy.

<a name="notes"></a>

# Notes


Specifying a savepoint name that was not previously defined is an error.

It is not possible to release a savepoint when the transaction is in an aborted state.

If multiple savepoints have the same name, only the one that was most recently defined is released.

<a name="examples"></a>

# Examples


To establish and later destroy a savepoint:

.if n \{.RS 4
.\}
    BEGIN;
        INSERT INTO table1 VALUES (3);
        SAVEPOINT my_savepoint;
        INSERT INTO table1 VALUES (4);
        RELEASE SAVEPOINT my_savepoint;
    COMMIT;
.if n \{.RE
.\}

The above transaction will insert both 3 and 4.

<a name="compatibility"></a>

# Compatibility


This command conforms to the
SQL
standard. The standard specifies that the key word
SAVEPOINT
is mandatory, but
PostgreSQL
allows it to be omitted.

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), **ROLLBACK**(7), ROLLBACK TO SAVEPOINT (**ROLLBACK\_TO\_SAVEPOINT**(7)), **SAVEPOINT**(7)
