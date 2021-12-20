# rollback to savepoint(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ROLLBACK_TO_SAVEPOINT - roll back to a savepoint

<a name="synopsis"></a>

# Synopsis

```


```
    ROLLBACK [ WORK | TRANSACTION ] TO [ SAVEPOINT ] savepoint_name

<a name="description"></a>

# Description


Roll back all commands that were executed after the savepoint was established. The savepoint remains valid and can be rolled back to again later, if needed.

**ROLLBACK TO SAVEPOINT**
implicitly destroys all savepoints that were established after the named savepoint.

<a name="parameters"></a>

# Parameters


_savepoint\_name_
The savepoint to roll back to.

<a name="notes"></a>

# Notes


Use
RELEASE SAVEPOINT (**RELEASE\_SAVEPOINT**(7))
to destroy a savepoint without discarding the effects of commands executed after it was established.

Specifying a savepoint name that has not been established is an error.

Cursors have somewhat non-transactional behavior with respect to savepoints. Any cursor that is opened inside a savepoint will be closed when the savepoint is rolled back. If a previously opened cursor is affected by a
**FETCH**
or
**MOVE**
command inside a savepoint that is later rolled back, the cursor remains at the position that
**FETCH**
left it pointing to (that is, the cursor motion caused by
**FETCH**
is not rolled back). Closing a cursor is not undone by rolling back, either. However, other side-effects caused by the cursors query (such as side-effects of volatile functions called by the query)
_are_
rolled back if they occur during a savepoint that is later rolled back. A cursor whose execution causes a transaction to abort is put in a cannot-execute state, so while the transaction can be restored using
**ROLLBACK TO SAVEPOINT**, the cursor can no longer be used.

<a name="examples"></a>

# Examples


To undo the effects of the commands executed after
my_savepoint
was established:

.if n \{.RS 4
.\}
    ROLLBACK TO SAVEPOINT my_savepoint;
.if n \{.RE
.\}

Cursor positions are not affected by savepoint rollback:

.if n \{.RS 4
.\}
    BEGIN;
    
    DECLARE foo CURSOR FOR SELECT 1 UNION SELECT 2;
    
    SAVEPOINT foo;
    
    FETCH 1 FROM foo;
     ?column? 
    ----------
            1
    
    ROLLBACK TO SAVEPOINT foo;
    
    FETCH 1 FROM foo;
     ?column? 
    ----------
            2
    
    COMMIT;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
SQL
standard specifies that the key word
SAVEPOINT
is mandatory, but
PostgreSQL
and
Oracle
allow it to be omitted. SQL allows only
WORK, not
TRANSACTION, as a noise word after
ROLLBACK. Also, SQL has an optional clause
AND [ NO ] CHAIN
which is not currently supported by
PostgreSQL. Otherwise, this command conforms to the SQL standard.

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), RELEASE SAVEPOINT (**RELEASE\_SAVEPOINT**(7)), **ROLLBACK**(7), **SAVEPOINT**(7)
