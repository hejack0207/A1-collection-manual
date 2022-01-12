# drop event trigger(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_EVENT_TRIGGER - remove an event trigger

<a name="synopsis"></a>

# Synopsis

```


```
    DROP EVENT TRIGGER [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP EVENT TRIGGER**
removes an existing event trigger. To execute this command, the current user must be the owner of the event trigger.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the event trigger does not exist. A notice is issued in this case.

_name_
The name of the event trigger to remove.

CASCADE
Automatically drop objects that depend on the trigger, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the trigger if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Destroy the trigger
snitch:

.if n \{.RS 4
.\}
    DROP EVENT TRIGGER snitch;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DROP EVENT TRIGGER**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE EVENT TRIGGER (**CREATE\_EVENT\_TRIGGER**(7)), ALTER EVENT TRIGGER (**ALTER\_EVENT\_TRIGGER**(7))
