# rollback prepared(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ROLLBACK_PREPARED - cancel a transaction that was earlier prepared for two-phase commit

<a name="synopsis"></a>

# Synopsis

```


```
    ROLLBACK PREPARED transaction_id

<a name="description"></a>

# Description


**ROLLBACK PREPARED**
rolls back a transaction that is in prepared state.

<a name="parameters"></a>

# Parameters


_transaction\_id_
The transaction identifier of the transaction that is to be rolled back.

<a name="notes"></a>

# Notes


To roll back a prepared transaction, you must be either the same user that executed the transaction originally, or a superuser. But you do not have to be in the same session that executed the transaction.

This command cannot be executed inside a transaction block. The prepared transaction is rolled back immediately.

All currently available prepared transactions are listed in the
pg_prepared_xacts
system view.

<a name="examples"></a>

# Examples


Roll back the transaction identified by the transaction identifier
foobar:

.if n \{.RS 4
.\}
    ROLLBACK PREPARED foobar*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ROLLBACK PREPARED**
is a
PostgreSQL
extension. It is intended for use by external transaction management systems, some of which are covered by standards (such as X/Open XA), but the SQL side of those systems is not standardized.

<a name="see-also"></a>

# See Also

PREPARE TRANSACTION (**PREPARE\_TRANSACTION**(7)), COMMIT PREPARED (**COMMIT\_PREPARED**(7))
