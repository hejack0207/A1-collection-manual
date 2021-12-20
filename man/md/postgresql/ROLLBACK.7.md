# rollback(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ROLLBACK - abort the current transaction

<a name="synopsis"></a>

# Synopsis

```


```
    ROLLBACK [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]

<a name="description"></a>

# Description


**ROLLBACK**
rolls back the current transaction and causes all the updates made by the transaction to be discarded.

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
**COMMIT**(7)
to successfully terminate a transaction.

Issuing
**ROLLBACK**
outside of a transaction block emits a warning and otherwise has no effect.
**ROLLBACK AND CHAIN**
outside of a transaction block is an error.

<a name="examples"></a>

# Examples


To abort all changes:

.if n \{.RS 4
.\}
    ROLLBACK;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The command
**ROLLBACK**
conforms to the SQL standard. The form
ROLLBACK TRANSACTION
is a PostgreSQL extension.

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), ROLLBACK TO SAVEPOINT (**ROLLBACK\_TO\_SAVEPOINT**(7))
