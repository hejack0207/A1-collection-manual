# execute(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

EXECUTE - execute a prepared statement

<a name="synopsis"></a>

# Synopsis

```


```
    EXECUTE name [ ( parameter [, ...] ) ]

<a name="description"></a>

# Description


**EXECUTE**
is used to execute a previously prepared statement. Since prepared statements only exist for the duration of a session, the prepared statement must have been created by a
**PREPARE**
statement executed earlier in the current session.

If the
**PREPARE**
statement that created the statement specified some parameters, a compatible set of parameters must be passed to the
**EXECUTE**
statement, or else an error is raised. Note that (unlike functions) prepared statements are not overloaded based on the type or number of their parameters; the name of a prepared statement must be unique within a database session.

For more information on the creation and usage of prepared statements, see
**PREPARE**(7).

<a name="parameters"></a>

# Parameters


_name_
The name of the prepared statement to execute.

_parameter_
The actual value of a parameter to the prepared statement. This must be an expression yielding a value that is compatible with the data type of this parameter, as was determined when the prepared statement was created.

<a name="outputs"></a>

# Outputs


The command tag returned by
**EXECUTE**
is that of the prepared statement, and not
EXECUTE.

<a name="examples"></a>

# Examples


Examples are given in the
EXAMPLES
section of the
**PREPARE**(7)
documentation.

<a name="compatibility"></a>

# Compatibility


The SQL standard includes an
**EXECUTE**
statement, but it is only for use in embedded SQL. This version of the
**EXECUTE**
statement also uses a somewhat different syntax.

<a name="see-also"></a>

# See Also

**DEALLOCATE**(7), **PREPARE**(7)
