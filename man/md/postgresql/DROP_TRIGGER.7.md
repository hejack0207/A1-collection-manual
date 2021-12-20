# drop trigger(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TRIGGER - remove a trigger

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TRIGGER [ IF EXISTS ] name ON table_name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TRIGGER**
removes an existing trigger definition. To execute this command, the current user must be the owner of the table for which the trigger is defined.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the trigger does not exist. A notice is issued in this case.

_name_
The name of the trigger to remove.

_table\_name_
The name (optionally schema-qualified) of the table for which the trigger is defined.

CASCADE
Automatically drop objects that depend on the trigger, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the trigger if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Destroy the trigger
if_dist_exists
on the table
films:

.if n \{.RS 4
.\}
    DROP TRIGGER if_dist_exists ON films;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**DROP TRIGGER**
statement in
PostgreSQL
is incompatible with the SQL standard. In the SQL standard, trigger names are not local to tables, so the command is simply
DROP TRIGGER _name_.

<a name="see-also"></a>

# See Also

CREATE TRIGGER (**CREATE\_TRIGGER**(7))
