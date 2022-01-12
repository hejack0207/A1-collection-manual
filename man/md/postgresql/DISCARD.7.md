# discard(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DISCARD - discard session state

<a name="synopsis"></a>

# Synopsis

```


```
    DISCARD { ALL | PLANS | SEQUENCES | TEMPORARY | TEMP }

<a name="description"></a>

# Description


**DISCARD**
releases internal resources associated with a database session. This command is useful for partially or fully resetting the sessions state. There are several subcommands to release different types of resources; the
**DISCARD ALL**
variant subsumes all the others, and also resets additional state.

<a name="parameters"></a>

# Parameters


PLANS
Releases all cached query plans, forcing re-planning to occur the next time the associated prepared statement is used.

SEQUENCES
Discards all cached sequence-related state, including
**currval()**/**lastval()**
information and any preallocated sequence values that have not yet been returned by
**nextval()**. (See
CREATE SEQUENCE (**CREATE\_SEQUENCE**(7))
for a description of preallocated sequence values.)

TEMPORARY or TEMP
Drops all temporary tables created in the current session.

ALL
Releases all temporary resources associated with the current session and resets the session to its initial state. Currently, this has the same effect as executing the following sequence of statements:

.if n \{.RS 4
.\}
    CLOSE ALL;
    SET SESSION AUTHORIZATION DEFAULT;
    RESET ALL;
    DEALLOCATE ALL;
    UNLISTEN *;
    SELECT pg_advisory_unlock_all();
    DISCARD PLANS;
    DISCARD TEMP;
    DISCARD SEQUENCES;
.if n \{.RE
.\}

<a name="notes"></a>

# Notes


**DISCARD ALL**
cannot be executed inside a transaction block.

<a name="compatibility"></a>

# Compatibility


**DISCARD**
is a
PostgreSQL
extension.
