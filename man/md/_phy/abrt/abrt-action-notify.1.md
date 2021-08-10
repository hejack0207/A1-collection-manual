# abrt\-action\-notify(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-action-notify - Announces a new occurrence of problem via all accessible channels

<a name="synopsis"></a>

# Synopsis

```

 abrt-action-notify [-h] -d PROBLEM_DIR [-v] [-a] [-e AUTOREPORTING_EVENT]
```

<a name="description"></a>

# Description


The current implementation emits a D-Bus signal on System bus in path /org/freedesktop/problems of org.freedesktop.problems interface for Crash member.

<a name="integration-with-abrt-events"></a>

### Integration with ABRT events


_abrt-action-notify_ is used to notify new problems and consecutive occurrences of a single problem for all crash types.

.if n \{.RS 4
.\}
    EVENT=notify package!=
        abrt-action-notify
.if n \{.RE
.\}

<a name="options"></a>

# Options


-v, --verbose
Be verbose

-d, --problem-dir PROBLEM_DIR
Problem directory [Default: current directory]

-h, --help
Show help message

-a, --autoreporting
Force to run autoreporting event

-e, --autoreporting-event AUTOREPORTING_EVENT
Overwrite autoreporting event name

<a name="environment"></a>

# Environment


ABRT_VERBOSE
ABRT verbosity level

<a name="files"></a>

# Files


/etc/abrt/abrt.conf

AutoreportingEnabled
If enabled, abrt-action-notify runs AutoreportingEvent

AutoreportingEvent
Name of event to be run if autoreporting is enabled

<a name="see-also"></a>

# See Also


abrt.conf(5)

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
