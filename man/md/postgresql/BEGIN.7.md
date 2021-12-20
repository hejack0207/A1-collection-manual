# begin(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

BEGIN - start a transaction block

<a name="synopsis"></a>

# Synopsis

```


```
    BEGIN [ WORK | TRANSACTION ] [ transaction_mode [, ...] ]
    
    where transaction_mode is one of:
    
        ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }
        READ WRITE | READ ONLY
        [ NOT ] DEFERRABLE

<a name="description"></a>

# Description


**BEGIN**
initiates a transaction block, that is, all statements after a
**BEGIN**
command will be executed in a single transaction until an explicit
**COMMIT**(7)
or
**ROLLBACK**(7)
is given. By default (without
**BEGIN**),
PostgreSQL
executes transactions in
“autocommit”
mode, that is, each statement is executed in its own transaction and a commit is implicitly performed at the end of the statement (if execution was successful, otherwise a rollback is done).

Statements are executed more quickly in a transaction block, because transaction start/commit requires significant CPU and disk activity. Execution of multiple statements inside a transaction is also useful to ensure consistency when making several related changes: other sessions will be unable to see the intermediate states wherein not all the related updates have been done.

If the isolation level, read/write mode, or deferrable mode is specified, the new transaction has those characteristics, as if
SET TRANSACTION (**SET\_TRANSACTION**(7))
was executed.

<a name="parameters"></a>

# Parameters


WORK  
TRANSACTION
Optional key words. They have no effect.

Refer to
SET TRANSACTION (**SET\_TRANSACTION**(7))
for information on the meaning of the other parameters to this statement.

<a name="notes"></a>

# Notes


START TRANSACTION (**START\_TRANSACTION**(7))
has the same functionality as
**BEGIN**.

Use
**COMMIT**(7)
or
**ROLLBACK**(7)
to terminate a transaction block.

Issuing
**BEGIN**
when already inside a transaction block will provoke a warning message. The state of the transaction is not affected. To nest transactions within a transaction block, use savepoints (see
**SAVEPOINT**(7)).

For reasons of backwards compatibility, the commas between successive
_transaction\_modes_
can be omitted.

<a name="examples"></a>

# Examples


To begin a transaction block:

.if n \{.RS 4
.\}
    BEGIN;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**BEGIN**
is a
PostgreSQL
language extension. It is equivalent to the SQL-standard command
START TRANSACTION (**START\_TRANSACTION**(7)), whose reference page contains additional compatibility information.

The
DEFERRABLE
_transaction\_mode_
is a
PostgreSQL
language extension.

Incidentally, the
BEGIN
key word is used for a different purpose in embedded SQL. You are advised to be careful about the transaction semantics when porting database applications.

<a name="see-also"></a>

# See Also

**COMMIT**(7), **ROLLBACK**(7), START TRANSACTION (**START\_TRANSACTION**(7)), **SAVEPOINT**(7)
