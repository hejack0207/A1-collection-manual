# pam_systemd(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_systemd - Register user sessions in the systemd login manager

<a name="synopsis"></a>

# Synopsis

```

 pam_systemd.so
```

<a name="description"></a>

# Description


**pam\_systemd**
registers user sessions with the systemd login manager
**systemd-logind.service**(8), and hence the systemd control group hierarchy.

On login, this module — in conjunction with
systemd-logind.service
— ensures the following:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  If it does not exist yet, the user runtime directory
  /run/user/$UID
  is either created or mounted as new
  "tmpfs"
  file system with quota applied, and its ownership changed to the user that is logging in.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  The
  _$XDG\_SESSION\_ID_
  environment variable is initialized. If auditing is available and
  **pam\_loginuid.so**
  was run before this module (which is highly recommended), the variable is initialized from the auditing session id (/proc/self/sessionid). Otherwise, an independent session counter is used.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  A new systemd scope unit is created for the session. If this is the first concurrent session of the user, an implicit per-user slice unit below
  user.slice
  is automatically created and the scope placed into it. An instance of the system service
  user@.service, which runs the systemd user manager instance, is started.

On logout, this module ensures the following:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  If enabled in
  **logind.conf**(5)
  (_KillUserProcesses=_), all processes of the session are terminated. If the last concurrent session of a user ends, the users systemd instance will be terminated too, and so will the user\*(Aqs slice unit.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  If the last concurrent session of a user ends, the user runtime directory
  /run/user/$UID
  and all its contents are removed, too.

If the system was not booted up with systemd as init system, this module does nothing and immediately returns
**PAM\_SUCCESS**.

<a name="options"></a>

# Options


The following options are understood:

_class=_
Takes a string argument which sets the session class. The
_XDG\_SESSION\_CLASS_
environment variable (see below) takes precedence. One of
"user",
"greeter",
"lock-screen"
or
"background". See
**sd\_session\_get\_class**(3)
for details about the session class.

_type=_
Takes a string argument which sets the session type. The
_XDG\_SESSION\_TYPE_
environment variable (see below) takes precedence. One of
"unspecified",
"tty",
"x11",
"wayland"
or
"mir". See
**sd\_session\_get\_type**(3)
for details about the session type.

_desktop=_
Takes a single, short identifier string for the desktop environment. The
_XDG\_SESSION\_DESKTOP_
environment variable (see below) takes precedence. This may be used to indicate the session desktop used, where this applies and if this information is available. For example:
"GNOME", or
"KDE". It is recommended to use the same identifiers and capitalization as for
_$XDG\_CURRENT\_DESKTOP_, as defined by the
\m[blue]**Desktop Entry Specification**\m[]\s-2\u[1]\d\s+2. (However, note that the option only takes a single item, and not a colon-separated list like
_$XDG\_CURRENT\_DESKTOP_.) See
**sd\_session\_get\_desktop**(3)
for further details.

_debug_[=]
Takes an optional boolean argument. If yes or without the argument, the module will log debugging information as it operates.

<a name="module-types-provided"></a>

# Module Types Provided


Only
**session**
is provided.

<a name="environment"></a>

# Environment


The following environment variables are initialized by the module and available to the processes of the users session:

_$XDG\_SESSION\_ID_
A short session identifier, suitable to be used in filenames. The string itself should be considered opaque, although often it is just the audit session ID as reported by
/proc/self/sessionid. Each ID will be assigned only once during machine uptime. It may hence be used to uniquely label files or other resources of this session. Combine this ID with the boot identifier, as returned by
**sd\_id128\_get\_boot**(3), for a globally unique identifier for the current session.

_$XDG\_RUNTIME\_DIR_
Path to a user-private user-writable directory that is bound to the user login time on the machine. It is automatically created the first time a user logs in and removed on the users final logout. If a user logs in twice at the same time, both sessions will see the same
_$XDG\_RUNTIME\_DIR_
and the same contents. If a user logs in once, then logs out again, and logs in again, the directory contents will have been lost in between, but applications should not rely on this behavior and must be able to deal with stale files. To store session-private data in this directory, the user should include the value of
_$XDG\_SESSION\_ID_
in the filename. This directory shall be used for runtime file system objects such as
**AF\_UNIX**
sockets, FIFOs, PID files and similar. It is guaranteed that this directory is local and offers the greatest possible file system feature set the operating system provides. For further details, see the
\m[blue]**XDG Base Directory Specification**\m[]\s-2\u[2]\d\s+2.
_$XDG\_RUNTIME\_DIR_
is not set if the current user is not the original user of the session.

The following environment variables are read by the module and may be used by the PAM service to pass metadata to the module. If these variables are not set when the PAM module is invoked but can be determined otherwise they are set by the module, so that these variables are initialized for the session and applications if known at all.

_$XDG\_SESSION\_TYPE_
The session type. This may be used instead of
_session=_
on the module parameter line, and is usually preferred.

_$XDG\_SESSION\_CLASS_
The session class. This may be used instead of
_class=_
on the module parameter line, and is usually preferred.

_$XDG\_SESSION\_DESKTOP_
The desktop identifier. This may be used instead of
_desktop=_
on the module parameter line, and is usually preferred.

_$XDG\_SEAT_
The seat name the session shall be registered for, if any.

_$XDG\_VTNR_
The VT number the session shall be registered for, if any. (Only applies to seats with a VT available, such as
"seat0")

If not set,
**pam\_systemd**
will initialize
_$XDG\_SEAT_
and
_$XDG\_VTNR_
based on the
_$DISPLAY_
variable (if the latter is set).

<a name="session-limits"></a>

# Session Limits


PAM modules earlier in the stack, that is those that come before
**pam\_systemd.so**, can set session scope limits using the PAM context objects. The data for these objects is provided as NUL-terminated C strings and maps directly to the respective unit resource control directives. Note that these limits apply to individual sessions of the user, they do not apply to all user processes as a combined whole. In particular, the per-user
**user@.service**
unit instance, which runs the
**systemd --user**
manager process and its children, and is tracked outside of any session, being shared by all the users sessions, is not covered by these limits.

See
**systemd.resource-control**(5)
for more information about the resources. Also, see
**pam\_set\_data**(3)
for additional information about how to set the context objects.

_systemd.memory\_max_
Sets unit
_MemoryMax=_.

_systemd.tasks\_max_
Sets unit
_TasksMax=_.

_systemd.cpu\_weight_
Sets unit
_CPUWeight=_.

_systemd.io\_weight_
Sets unit
_IOWeight=_.

Example data as can be provided from an another PAM module:

.if n \{.RS 4
.\}
    pam_set_data(handle, "systemd.memory_max", (void *)"200M", cleanup);
    pam_set_data(handle, "systemd.tasks_max",  (void *)"50",   cleanup);
    pam_set_data(handle, "systemd.cpu_weight", (void *)"100",  cleanup);
    pam_set_data(handle, "systemd.io_weight",  (void *)"340",  cleanup);
          
.if n \{.RE
.\}


<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    #%PAM-1.0
    auth       required     pam_unix.so
    auth       required     pam_nologin.so
    account    required     pam_unix.so
    password   required     pam_unix.so
    session    required     pam_unix.so
    session    required     pam_loginuid.so
    session    required     pam_systemd.so
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-logind.service**(8),
**logind.conf**(5),
**loginctl**(1),
**pam.conf**(5),
**pam.d**(5),
**pam**(8),
**pam\_loginuid**(8),
**systemd.scope**(5),
**systemd.slice**(5),
**systemd.service**(5)

<a name="notes"></a>

# Notes


*  1.  
  Desktop Entry Specification
      http://standards.freedesktop.org/desktop-entry-spec/latest/
*  2.  
  XDG Base Directory Specification
      http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
