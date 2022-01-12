# savepoint(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SAVEPOINT - define a new savepoint within the current transaction

<a name="synopsis"></a>

# Synopsis

```


```
    SAVEPOINT savepoint_name

<a name="description"></a>

# Description


**SAVEPOINT**
establishes a new savepoint within the current transaction.

A savepoint is a special mark inside a transaction that allows all commands that are executed after it was established to be rolled back, restoring the transaction state to what it was at the time of the savepoint.

<a name="parameters"></a>

# Parameters


_savepoint\_name_
The name to give to the new savepoint.

<a name="notes"></a>

# Notes


Use
ROLLBACK TO SAVEPOINT (**ROLLBACK\_TO\_SAVEPOINT**(7))
to rollback to a savepoint. Use
RELEASE SAVEPOINT (**RELEASE\_SAVEPOINT**(7))
to destroy a savepoint, keeping the effects of commands executed after it was established.

Savepoints can only be established when inside a transaction block. There can be multiple savepoints defined within a transaction.

<a name="examples"></a>

# Examples


To establish a savepoint and later undo the effects of all commands executed after it was established:

.if n \{.RS 4
.\}
    BEGIN;
        INSERT INTO table1 VALUES (1);
        SAVEPOINT my_savepoint;
        INSERT INTO table1 VALUES (2);
        ROLLBACK TO SAVEPOINT my_savepoint;
        INSERT INTO table1 VALUES (3);
    COMMIT;
.if n \{.RE
.\}

The above transaction will insert the values 1 and 3, but not 2.

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


SQL requires a savepoint to be destroyed automatically when another savepoint with the same name is established. In
PostgreSQL, the old savepoint is kept, though only the more recent one will be used when rolling back or releasing. (Releasing the newer savepoint with
**RELEASE SAVEPOINT**
will cause the older one to again become accessible to
**ROLLBACK TO SAVEPOINT**
and
**RELEASE SAVEPOINT**.) Otherwise,
**SAVEPOINT**
is fully SQL conforming.

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), RELEASE SAVEPOINT (**RELEASE\_SAVEPOINT**(7)), **ROLLBACK**(7), ROLLBACK TO SAVEPOINT (**ROLLBACK\_TO\_SAVEPOINT**(7))
