# alter statistics(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_STATISTICS - change the definition of an extended statistics object

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER STATISTICS name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER STATISTICS name RENAME TO new_name
    ALTER STATISTICS name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER STATISTICS**
changes the parameters of an existing extended statistics object. Any parameters not specifically set in the
**ALTER STATISTICS**
command retain their prior settings.

You must own the statistics object to use
**ALTER STATISTICS**. To change a statistics objects schema, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the statistics objects schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the statistics object. However, a superuser can alter ownership of any statistics object anyway.)

<a name="parameters"></a>

# Parameters



_name_
The name (optionally schema-qualified) of the statistics object to be altered.

_new\_owner_
The user name of the new owner of the statistics object.

_new\_name_
The new name for the statistics object.

_new\_schema_
The new schema for the statistics object.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER STATISTICS**
command in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE STATISTICS (**CREATE\_STATISTICS**(7)), DROP STATISTICS (**DROP\_STATISTICS**(7))
