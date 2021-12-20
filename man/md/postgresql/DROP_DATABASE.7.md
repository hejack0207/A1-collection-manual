# drop database(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_DATABASE - remove a database

<a name="synopsis"></a>

# Synopsis

```


```
    DROP DATABASE [ IF EXISTS ] name

<a name="description"></a>

# Description


**DROP DATABASE**
drops a database. It removes the catalog entries for the database and deletes the directory containing the data. It can only be executed by the database owner. Also, it cannot be executed while you or anyone else are connected to the target database. (Connect to
postgres
or any other database to issue this command.)

**DROP DATABASE**
cannot be undone. Use it with care!

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the database does not exist. A notice is issued in this case.

_name_
The name of the database to remove.

<a name="notes"></a>

# Notes


**DROP DATABASE**
cannot be executed inside a transaction block.

This command cannot be executed while connected to the target database. Thus, it might be more convenient to use the program
**dropdb**(1)
instead, which is a wrapper around this command.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP DATABASE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE DATABASE (**CREATE\_DATABASE**(7))
