# close(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CLOSE - close a cursor

<a name="synopsis"></a>

# Synopsis

```


```
    CLOSE { name | ALL }

<a name="description"></a>

# Description


**CLOSE**
frees the resources associated with an open cursor. After the cursor is closed, no subsequent operations are allowed on it. A cursor should be closed when it is no longer needed.

Every non-holdable open cursor is implicitly closed when a transaction is terminated by
**COMMIT**
or
**ROLLBACK**. A holdable cursor is implicitly closed if the transaction that created it aborts via
**ROLLBACK**. If the creating transaction successfully commits, the holdable cursor remains open until an explicit
**CLOSE**
is executed, or the client disconnects.

<a name="parameters"></a>

# Parameters


_name_
The name of an open cursor to close.

ALL
Close all open cursors.

<a name="notes"></a>

# Notes


PostgreSQL
does not have an explicit
**OPEN**
cursor statement; a cursor is considered open when it is declared. Use the
**DECLARE**(7)
statement to declare a cursor.

You can see all available cursors by querying the
pg_cursors
system view.

If a cursor is closed after a savepoint which is later rolled back, the
**CLOSE**
is not rolled back; that is, the cursor remains closed.

<a name="examples"></a>

# Examples


Close the cursor
liahona:

.if n \{.RS 4
.\}
    CLOSE liahona;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CLOSE**
is fully conforming with the SQL standard.
**CLOSE ALL**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

**DECLARE**(7), **FETCH**(7), **MOVE**(7)
