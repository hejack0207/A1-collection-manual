# unlisten(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

UNLISTEN - stop listening for a notification

<a name="synopsis"></a>

# Synopsis

```


```
    UNLISTEN { channel | * }

<a name="description"></a>

# Description


**UNLISTEN**
is used to remove an existing registration for
**NOTIFY**
events.
**UNLISTEN**
cancels any existing registration of the current
PostgreSQL
session as a listener on the notification channel named
_channel_. The special wildcard
*
cancels all listener registrations for the current session.

**NOTIFY**(7)
contains a more extensive discussion of the use of
**LISTEN**
and
**NOTIFY**.

<a name="parameters"></a>

# Parameters


_channel_
Name of a notification channel (any identifier).

*
All current listen registrations for this session are cleared.

<a name="notes"></a>

# Notes


You can unlisten something you were not listening for; no warning or error will appear.

At the end of each session,
**UNLISTEN ***
is automatically executed.

A transaction that has executed
**UNLISTEN**
cannot be prepared for two-phase commit.

<a name="examples"></a>

# Examples


To make a registration:

.if n \{.RS 4
.\}
    LISTEN virtual;
    NOTIFY virtual;
    Asynchronous notification "virtual" received from server process with PID 8448.
.if n \{.RE
.\}

Once
**UNLISTEN**
has been executed, further
**NOTIFY**
messages will be ignored:

.if n \{.RS 4
.\}
    UNLISTEN virtual;
    NOTIFY virtual;
    -- no NOTIFY event is received
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**UNLISTEN**
command in the SQL standard.

<a name="see-also"></a>

# See Also

**LISTEN**(7), **NOTIFY**(7)
