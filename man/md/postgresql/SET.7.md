# set(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SET - change a run-time parameter

<a name="synopsis"></a>

# Synopsis

```


```
    SET [ SESSION | LOCAL ] configuration_parameter { TO | = } { value | value*(Aq | DEFAULT }
    SET [ SESSION | LOCAL ] TIME ZONE { timezone | LOCAL | DEFAULT }

<a name="description"></a>

# Description


The
**SET**
command changes run-time configuration parameters. Many of the run-time parameters listed in
Chapter&nbsp;19
can be changed on-the-fly with
**SET**. (But some require superuser privileges to change, and others cannot be changed after server or session start.)
**SET**
only affects the value used by the current session.

If
**SET**
(or equivalently
**SET SESSION**) is issued within a transaction that is later aborted, the effects of the
**SET**
command disappear when the transaction is rolled back. Once the surrounding transaction is committed, the effects will persist until the end of the session, unless overridden by another
**SET**.

The effects of
**SET LOCAL**
last only till the end of the current transaction, whether committed or not. A special case is
**SET**
followed by
**SET LOCAL**
within a single transaction: the
**SET LOCAL**
value will be seen until the end of the transaction, but afterwards (if the transaction is committed) the
**SET**
value will take effect.

The effects of
**SET**
or
**SET LOCAL**
are also canceled by rolling back to a savepoint that is earlier than the command.

If
**SET LOCAL**
is used within a function that has a
SET
option for the same variable (see
CREATE FUNCTION (**CREATE\_FUNCTION**(7))), the effects of the
**SET LOCAL**
command disappear at function exit; that is, the value in effect when the function was called is restored anyway. This allows
**SET LOCAL**
to be used for dynamic or repeated changes of a parameter within a function, while still having the convenience of using the
SET
option to save and restore the callers value. However, a regular
**SET**
command overrides any surrounding functions
SET
option; its effects will persist unless rolled back.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

In
PostgreSQL
versions 8.0 through 8.2, the effects of a
**SET LOCAL**
would be canceled by releasing an earlier savepoint, or by successful exit from a
PL/pgSQL
exception block. This behavior has been changed because it was deemed unintuitive.


<a name="parameters"></a>

# Parameters


SESSION
Specifies that the command takes effect for the current session. (This is the default if neither
SESSION
nor
LOCAL
appears.)

LOCAL
Specifies that the command takes effect for only the current transaction. After
**COMMIT**
or
**ROLLBACK**, the session-level setting takes effect again. Issuing this outside of a transaction block emits a warning and otherwise has no effect.

_configuration\_parameter_
Name of a settable run-time parameter. Available parameters are documented in
Chapter&nbsp;19
and below.

_value_
New value of parameter. Values can be specified as string constants, identifiers, numbers, or comma-separated lists of these, as appropriate for the particular parameter.
DEFAULT
can be written to specify resetting the parameter to its default value (that is, whatever value it would have had if no
**SET**
had been executed in the current session).

Besides the configuration parameters documented in
Chapter&nbsp;19, there are a few that can only be adjusted using the
**SET**
command or that have a special syntax:

SCHEMA
SET SCHEMA _value_\*(Aq
is an alias for
SET search_path TO _value_. Only one schema can be specified using this syntax.

NAMES
SET NAMES _value_
is an alias for
SET client_encoding TO _value_.

SEED
Sets the internal seed for the random number generator (the function
**random**). Allowed values are floating-point numbers between -1 and 1, which are then multiplied by 2^31-1.

The seed can also be set by invoking the function
**setseed**:

.if n \{.RS 4
.\}
    SELECT setseed(value);
.if n \{.RE
.\}

TIME ZONE
SET TIME ZONE _value_
is an alias for
SET timezone TO _value_. The syntax
SET TIME ZONE
allows special syntax for the time zone specification. Here are examples of valid values:

PST8PDT\*(Aq
The time zone for Berkeley, California.

Europe/Rome\*(Aq
The time zone for Italy.

-7
The time zone 7 hours west from UTC (equivalent to PDT). Positive values are east from UTC.

INTERVAL -08:00\*(Aq HOUR TO MINUTE
The time zone 8 hours west from UTC (equivalent to PST).

LOCAL  
DEFAULT
Set the time zone to your local time zone (that is, the servers default value of
_timezone_).

Timezone settings given as numbers or intervals are internally translated to POSIX timezone syntax. For example, after
SET TIME ZONE -7,
**SHOW TIME ZONE**
would report
&lt;-07&gt;+07.

See
Section&nbsp;8.5.3
for more information about time zones.

<a name="notes"></a>

# Notes


The function
**set\_config**
provides equivalent functionality; see
Section&nbsp;9.26. Also, it is possible to UPDATE the
pg_settings
system view to perform the equivalent of
**SET**.

<a name="examples"></a>

# Examples


Set the schema search path:

.if n \{.RS 4
.\}
    SET search_path TO my_schema, public;
.if n \{.RE
.\}

Set the style of date to traditional
POSTGRES
with
“day before month”
input convention:

.if n \{.RS 4
.\}
    SET datestyle TO postgres, dmy;
.if n \{.RE
.\}

Set the time zone for Berkeley, California:

.if n \{.RS 4
.\}
    SET TIME ZONE PST8PDT*(Aq;
.if n \{.RE
.\}

Set the time zone for Italy:

.if n \{.RS 4
.\}
    SET TIME ZONE Europe/Rome*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


SET TIME ZONE
extends syntax defined in the SQL standard. The standard allows only numeric time zone offsets while
PostgreSQL
allows more flexible time-zone specifications. All other
SET
features are
PostgreSQL
extensions.

<a name="see-also"></a>

# See Also

**RESET**(7), **SHOW**(7)
