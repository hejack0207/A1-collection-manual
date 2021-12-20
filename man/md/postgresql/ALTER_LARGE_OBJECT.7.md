# alter large object(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_LARGE_OBJECT - change the definition of a large object

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER LARGE OBJECT large_object_oid OWNER TO { new_owner | CURRENT_USER | SESSION_USER }

<a name="description"></a>

# Description


**ALTER LARGE OBJECT**
changes the definition of a large object.

You must own the large object to use
**ALTER LARGE OBJECT**. To alter the owner, you must also be a direct or indirect member of the new owning role. (However, a superuser can alter any large object anyway.) Currently, the only functionality is to assign a new owner, so both restrictions always apply.

<a name="parameters"></a>

# Parameters


_large\_object\_oid_
OID of the large object to be altered

_new\_owner_
The new owner of the large object

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER LARGE OBJECT**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

Chapter&nbsp;34
