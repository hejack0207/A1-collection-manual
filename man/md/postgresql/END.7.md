# end(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

END - commit the current transaction

<a name="synopsis"></a>

# Synopsis

```


```
    END [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]

<a name="description"></a>

# Description


**END**
commits the current transaction. All changes made by the transaction become visible to others and are guaranteed to be durable if a crash occurs. This command is a
PostgreSQL
extension that is equivalent to
**COMMIT**(7).

<a name="parameters"></a>

# Parameters


WORK  
TRANSACTION
Optional key words. They have no effect.

AND CHAIN
If
AND CHAIN
is specified, a new transaction is immediately started with the same transaction characteristics (see
SET TRANSACTION (**SET\_TRANSACTION**(7))) as the just finished one. Otherwise, no new transaction is started.

<a name="notes"></a>

# Notes


Use
**ROLLBACK**(7)
to abort a transaction.

Issuing
**END**
when not inside a transaction does no harm, but it will provoke a warning message.

<a name="examples"></a>

# Examples


To commit the current transaction and make all changes permanent:

.if n \{.RS 4
.\}
    END;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**END**
is a
PostgreSQL
extension that provides functionality equivalent to
**COMMIT**(7), which is specified in the SQL standard.

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), **ROLLBACK**(7)
