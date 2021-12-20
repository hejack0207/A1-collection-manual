# listen(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

LISTEN - listen for a notification

<a name="synopsis"></a>

# Synopsis

```


```
    LISTEN channel

<a name="description"></a>

# Description


**LISTEN**
registers the current session as a listener on the notification channel named
_channel_. If the current session is already registered as a listener for this notification channel, nothing is done.

Whenever the command
**NOTIFY ****channel**
is invoked, either by this session or another one connected to the same database, all the sessions currently listening on that notification channel are notified, and each will in turn notify its connected client application.

A session can be unregistered for a given notification channel with the
**UNLISTEN**
command. A sessions listen registrations are automatically cleared when the session ends.

The method a client application must use to detect notification events depends on which
PostgreSQL
application programming interface it uses. With the
libpq
library, the application issues
**LISTEN**
as an ordinary SQL command, and then must periodically call the function
**PQnotifies**
to find out whether any notification events have been received. Other interfaces such as
libpgtcl
provide higher-level methods for handling notify events; indeed, with
libpgtcl
the application programmer should not even issue
**LISTEN**
or
**UNLISTEN**
directly. See the documentation for the interface you are using for more details.

**NOTIFY**(7)
contains a more extensive discussion of the use of
**LISTEN**
and
**NOTIFY**.

<a name="parameters"></a>

# Parameters


_channel_
Name of a notification channel (any identifier).

<a name="notes"></a>

# Notes


**LISTEN**
takes effect at transaction commit. If
**LISTEN**
or
**UNLISTEN**
is executed within a transaction that later rolls back, the set of notification channels being listened to is unchanged.

A transaction that has executed
**LISTEN**
cannot be prepared for two-phase commit.

<a name="examples"></a>

# Examples


Configure and execute a listen/notify sequence from
psql:

.if n \{.RS 4
.\}
    LISTEN virtual;
    NOTIFY virtual;
    Asynchronous notification "virtual" received from server process with PID 8448.
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**LISTEN**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

**NOTIFY**(7), **UNLISTEN**(7)
