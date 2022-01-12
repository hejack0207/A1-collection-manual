# abort(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ABORT - abort the current transaction

<a name="synopsis"></a>

# Synopsis

```


```
    ABORT [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]

<a name="description"></a>

# Description


**ABORT**
rolls back the current transaction and causes all the updates made by the transaction to be discarded. This command is identical in behavior to the standard
SQL
command
**ROLLBACK**(7), and is present only for historical reasons.

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
**ABORT**
outside of a transaction block emits a warning and otherwise has no effect.

<a name="examples"></a>

# Examples


To abort all changes:

.if n \{.RS 4
.\}
    ABORT;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command is a
PostgreSQL
extension present for historical reasons.
**ROLLBACK**
is the equivalent standard SQL command.

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), **ROLLBACK**(7)
