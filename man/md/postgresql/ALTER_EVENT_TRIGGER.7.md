# alter event trigger(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_EVENT_TRIGGER - change the definition of an event trigger

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER EVENT TRIGGER name DISABLE
    ALTER EVENT TRIGGER name ENABLE [ REPLICA | ALWAYS ]
    ALTER EVENT TRIGGER name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER EVENT TRIGGER name RENAME TO new_name

<a name="description"></a>

# Description


**ALTER EVENT TRIGGER**
changes properties of an existing event trigger.

You must be superuser to alter an event trigger.

<a name="parameters"></a>

# Parameters


_name_
The name of an existing trigger to alter.

_new\_owner_
The user name of the new owner of the event trigger.

_new\_name_
The new name of the event trigger.

DISABLE/ENABLE [ REPLICA | ALWAYS ] TRIGGER
These forms configure the firing of event triggers. A disabled trigger is still known to the system, but is not executed when its triggering event occurs. See also
session_replication_role.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER EVENT TRIGGER**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE EVENT TRIGGER (**CREATE\_EVENT\_TRIGGER**(7)), DROP EVENT TRIGGER (**DROP\_EVENT\_TRIGGER**(7))
