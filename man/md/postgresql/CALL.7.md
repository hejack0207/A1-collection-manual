# call(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CALL - invoke a procedure

<a name="synopsis"></a>

# Synopsis

```


```
    CALL name ( [ argument ] [, ...] )

<a name="description"></a>

# Description


**CALL**
executes a procedure.

If the procedure has any output parameters, then a result row will be returned, containing the values of those parameters.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of the procedure.

_argument_
An input argument for the procedure call. See
Section&nbsp;4.3
for the full details on function and procedure call syntax, including use of named parameters.

<a name="notes"></a>

# Notes


The user must have
EXECUTE
privilege on the procedure in order to be allowed to invoke it.

To call a function (not a procedure), use
**SELECT**
instead.

If
**CALL**
is executed in a transaction block, then the called procedure cannot execute transaction control statements. Transaction control statements are only allowed if
**CALL**
is executed in its own transaction.

PL/pgSQL
handles output parameters in
**CALL**
commands differently; see
Section&nbsp;42.6.3.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    CALL do_db_maintenance();
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CALL**
conforms to the SQL standard.

<a name="see-also"></a>

# See Also

CREATE PROCEDURE (**CREATE\_PROCEDURE**(7))
