# start transaction(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

START_TRANSACTION - start a transaction block

<a name="synopsis"></a>

# Synopsis

```


```
    START TRANSACTION [ transaction_mode [, ...] ]
    
    where transaction_mode is one of:
    
        ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }
        READ WRITE | READ ONLY
        [ NOT ] DEFERRABLE

<a name="description"></a>

# Description


This command begins a new transaction block. If the isolation level, read/write mode, or deferrable mode is specified, the new transaction has those characteristics, as if
SET TRANSACTION (**SET\_TRANSACTION**(7))
was executed. This is the same as the
**BEGIN**(7)
command.

<a name="parameters"></a>

# Parameters


Refer to
SET TRANSACTION (**SET\_TRANSACTION**(7))
for information on the meaning of the parameters to this statement.

<a name="compatibility"></a>

# Compatibility


In the standard, it is not necessary to issue
**START TRANSACTION**
to start a transaction block: any SQL command implicitly begins a block.
PostgreSQLs behavior can be seen as implicitly issuing a
**COMMIT**
after each command that does not follow
**START TRANSACTION**
(or
**BEGIN**), and it is therefore often called
“autocommit”. Other relational database systems might offer an autocommit feature as a convenience.

The
DEFERRABLE
_transaction\_mode_
is a
PostgreSQL
language extension.

The SQL standard requires commas between successive
_transaction\_modes_, but for historical reasons
PostgreSQL
allows the commas to be omitted.

See also the compatibility section of
SET TRANSACTION (**SET\_TRANSACTION**(7)).

<a name="see-also"></a>

# See Also

**BEGIN**(7), **COMMIT**(7), **ROLLBACK**(7), **SAVEPOINT**(7), SET TRANSACTION (**SET\_TRANSACTION**(7))
