# drop tablespace(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TABLESPACE - remove a tablespace

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TABLESPACE [ IF EXISTS ] name

<a name="description"></a>

# Description


**DROP TABLESPACE**
removes a tablespace from the system.

A tablespace can only be dropped by its owner or a superuser. The tablespace must be empty of all database objects before it can be dropped. It is possible that objects in other databases might still reside in the tablespace even if no objects in the current database are using the tablespace. Also, if the tablespace is listed in the
temp_tablespaces
setting of any active session, the
**DROP**
might fail due to temporary files residing in the tablespace.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the tablespace does not exist. A notice is issued in this case.

_name_
The name of a tablespace.

<a name="notes"></a>

# Notes


**DROP TABLESPACE**
cannot be executed inside a transaction block.

<a name="examples"></a>

# Examples


To remove tablespace
mystuff
from the system:

.if n \{.RS 4
.\}
    DROP TABLESPACE mystuff;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP TABLESPACE**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE TABLESPACE (**CREATE\_TABLESPACE**(7)), ALTER TABLESPACE (**ALTER\_TABLESPACE**(7))
