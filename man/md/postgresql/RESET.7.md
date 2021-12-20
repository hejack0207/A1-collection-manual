# reset(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

RESET - restore the value of a run-time parameter to the default value

<a name="synopsis"></a>

# Synopsis

```


```
    RESET configuration_parameter
    RESET ALL

<a name="description"></a>

# Description


**RESET**
restores run-time parameters to their default values.
**RESET**
is an alternative spelling for

.if n \{.RS 4
.\}
    SET configuration_parameter TO DEFAULT
.if n \{.RE
.\}

Refer to
**SET**(7)
for details.

The default value is defined as the value that the parameter would have had, if no
**SET**
had ever been issued for it in the current session. The actual source of this value might be a compiled-in default, the configuration file, command-line options, or per-database or per-user default settings. This is subtly different from defining it as
“the value that the parameter had at session start”, because if the value came from the configuration file, it will be reset to whatever is specified by the configuration file now. See
Chapter&nbsp;19
for details.

The transactional behavior of
**RESET**
is the same as
**SET**: its effects will be undone by transaction rollback.

<a name="parameters"></a>

# Parameters


_configuration\_parameter_
Name of a settable run-time parameter. Available parameters are documented in
Chapter&nbsp;19
and on the
**SET**(7)
reference page.

ALL
Resets all settable run-time parameters to default values.

<a name="examples"></a>

# Examples


Set the
_timezone_
configuration variable to its default value:

.if n \{.RS 4
.\}
    RESET timezone;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**RESET**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

**SET**(7), **SHOW**(7)
