# deallocate(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DEALLOCATE - deallocate a prepared statement

<a name="synopsis"></a>

# Synopsis

```


```
    DEALLOCATE [ PREPARE ] { name | ALL }

<a name="description"></a>

# Description


**DEALLOCATE**
is used to deallocate a previously prepared SQL statement. If you do not explicitly deallocate a prepared statement, it is deallocated when the session ends.

For more information on prepared statements, see
**PREPARE**(7).

<a name="parameters"></a>

# Parameters


PREPARE
This key word is ignored.

_name_
The name of the prepared statement to deallocate.

ALL
Deallocate all prepared statements.

<a name="compatibility"></a>

# Compatibility


The SQL standard includes a
**DEALLOCATE**
statement, but it is only for use in embedded SQL.

<a name="see-also"></a>

# See Also

**EXECUTE**(7), **PREPARE**(7)
