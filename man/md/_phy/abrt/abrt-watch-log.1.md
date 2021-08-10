# abrt\-watch\-log(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-watch-log - Watch log file and run command when it grows or is replaced

<a name="synopsis"></a>

# Synopsis

```

 abrt-watch-log [-vs] [-F STR] ... FILE PROG [ARGS]
```

<a name="options"></a>

# Options


-F STR
Don’t run PROG if STRs aren’t found

-v, --verbose
Be more verbose. Can be given multiple times.

-s
Log to syslog

FILE
Watched file

PROG
Path to an executable

ARGS
Arguments for PROG

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
