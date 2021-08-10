# abrtd(8)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrtd - automated bug reporting tools daemon.

<a name="synopsis"></a>

# Synopsis

```

 abrtd [-dsv[v]...]
```

<a name="description"></a>

# Description


_abrtd_ is a daemon that watches for application crashes. When a crash occurs, it collects the problem data (core file, application’s command line etc.) and takes action according to the type of application that crashed and according to the configuration in the _abrt.conf_ config file. There are plugins for various actions: for example to report the crash to Bugzilla, to mail the report, or to transfer the report via FTP or SCP. See the manual pages for the respective plugins.

<a name="options"></a>

# Options


-v
Log more detailed debugging information.

-d
Stay in the foreground and log to standard error.

-s
Log to system log even with option -d.

-t NUM
Exit after NUM seconds of inactivity.

-p
Add program names to log.

<a name="environment"></a>

# Environment


ABRT_EVENT_NICE
_abrtd_
runs its post-mortem processing with the nice value incremented by 10 in order to not take too much resources and keep the computer responsive. If you want to adjust the increment value, use the ABRT_EVENT_NICE environment variable.

<a name="caveats"></a>

# Caveats


When you use some other crash-catching tool specific for an application or an application type (for example BugBuddy for GNOME applications), crashes of this type will be handled by that tool and not by _abrtd_. If you want _abrtd_ to handle these crashes, turn off the higher-level crash-catching tool.

<a name="files"></a>

# Files


/etc/abrt/abrt.conf
Configuration file for the daemon.

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
