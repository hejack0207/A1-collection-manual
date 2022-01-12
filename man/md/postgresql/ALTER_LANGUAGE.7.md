# alter language(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_LANGUAGE - change the definition of a procedural language

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER [ PROCEDURAL ] LANGUAGE name RENAME TO new_name
    ALTER [ PROCEDURAL ] LANGUAGE name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }

<a name="description"></a>

# Description


**ALTER LANGUAGE**
changes the definition of a procedural language. The only functionality is to rename the language or assign a new owner. You must be superuser or owner of the language to use
**ALTER LANGUAGE**.

<a name="parameters"></a>

# Parameters


_name_
Name of a language

_new\_name_
The new name of the language

_new\_owner_
The new owner of the language

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER LANGUAGE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE LANGUAGE (**CREATE\_LANGUAGE**(7)), DROP LANGUAGE (**DROP\_LANGUAGE**(7))
