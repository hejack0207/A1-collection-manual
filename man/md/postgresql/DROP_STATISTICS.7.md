# drop statistics(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_STATISTICS - remove extended statistics

<a name="synopsis"></a>

# Synopsis

```


```
    DROP STATISTICS [ IF EXISTS ] name [, ...]

<a name="description"></a>

# Description


**DROP STATISTICS**
removes statistics object(s) from the database. Only the statistics objects owner, the schema owner, or a superuser can drop a statistics object.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the statistics object does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of the statistics object to drop.

<a name="examples"></a>

# Examples


To destroy two statistics objects in different schemas, without failing if they dont exist:

.if n \{.RS 4
.\}
    DROP STATISTICS IF EXISTS
        accounting.users_uid_creation,
        public.grants_user_role;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DROP STATISTICS**
command in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER STATISTICS (**ALTER\_STATISTICS**(7)), CREATE STATISTICS (**CREATE\_STATISTICS**(7))
