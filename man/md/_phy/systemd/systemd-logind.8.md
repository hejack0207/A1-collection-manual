# systemd\-logind\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-logind.service, systemd-logind - Login manager

<a name="synopsis"></a>

# Synopsis

```

 systemd-logind.service 
 /usr/lib/systemd/systemd-logind
```

<a name="description"></a>

# Description


**systemd-logind**
is a system service that manages user logins. It is responsible for:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Keeping track of users and sessions, their processes and their idle state. This is implemented by allocating a systemd slice unit for each user below
  user.slice, and a scope unit below it for each concurrent session of a user. Also, a per-user service manager is started as system service instance of
  user@.service
  for each logged in user.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Generating and managing session IDs. If auditing is available and an audit session ID is already set for a session, then this ID is reused as the session ID. Otherwise, an independent session counter is used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Providing
  \m[blue]**polkit**\m[]\s-2\u[1]\d\s+2-based access for users for operations such as system shutdown or sleep

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Implementing a shutdown/sleep inhibition logic for applications

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Handling of power/sleep hardware keys

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Multi-seat management

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Session switch management

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Device access management for users

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Automatic spawning of text logins (gettys) on virtual console activation and user runtime directory management

User sessions are registered with logind via the
**pam\_systemd**(8)
PAM module.

See
**logind.conf**(5)
for information about the configuration of this service.

See
**sd-login**(3)
for information about the basic concepts of logind such as users, sessions and seats.

See the
\m[blue]**logind D-Bus API Documentation**\m[]\s-2\u[2]\d\s+2
for information about the APIs
systemd-logind
provides.

For more information on the inhibition logic see the
\m[blue]**Inhibitor Lock Developer Documentation**\m[]\s-2\u[3]\d\s+2.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-user-sessions.service**(8),
**loginctl**(1),
**logind.conf**(5),
**pam\_systemd**(8)
**sd-login**(3)

<a name="notes"></a>

# Notes


*  1.  
  polkit
      http://www.freedesktop.org/wiki/Software/polkit
*  2.  
  logind D-Bus API Documentation
      https://www.freedesktop.org/wiki/Software/systemd/logind
*  3.  
  Inhibitor Lock Developer Documentation
      https://www.freedesktop.org/wiki/Software/systemd/inhibit
