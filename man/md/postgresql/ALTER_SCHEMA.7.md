# alter schema(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_SCHEMA - change the definition of a schema

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER SCHEMA name RENAME TO new_name
    ALTER SCHEMA name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }

<a name="description"></a>

# Description


**ALTER SCHEMA**
changes the definition of a schema.

You must own the schema to use
**ALTER SCHEMA**. To rename a schema you must also have the
CREATE
privilege for the database. To alter the owner, you must also be a direct or indirect member of the new owning role, and you must have the
CREATE
privilege for the database. (Note that superusers have all these privileges automatically.)

<a name="parameters"></a>

# Parameters


_name_
The name of an existing schema.

_new\_name_
The new name of the schema. The new name cannot begin with
pg_, as such names are reserved for system schemas.

_new\_owner_
The new owner of the schema.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER SCHEMA**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE SCHEMA (**CREATE\_SCHEMA**(7)), DROP SCHEMA (**DROP\_SCHEMA**(7))
