# limits\&.conf(5)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

limits.conf - configuration file for the pam_limits module

<a name="description"></a>

# Description


The
_pam\_limits.so_
module applies ulimit limits, nice priority and number of simultaneous login sessions limit to user login sessions. This description of the configuration file syntax applies to the
/etc/security/limits.conf
file and
*.conf
files in the
/etc/security/limits.d
directory.

The syntax of the lines is as follows:

_&lt;domain&gt;_
_&lt;type&gt;_
_&lt;item&gt;_
_&lt;value&gt;_

The fields listed above should be filled as follows:

**&lt;domain&gt;**

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a username

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a groupname, with
  **@group**
  syntax. This should not be confused with netgroups.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the wildcard
  <b>\*</b>, for default entry.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the wildcard
  **%**, for maxlogins limit only, can also be used with
  **%group**
  syntax. If the
  **%**
  wildcard is used alone it is identical to using
  <b>\*</b>
  with maxsyslogins limit. With a group specified after
  **%**
  it limits the total number of logins of all users that are member of the group.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  an uid range specified as
  _&lt;min\_uid&gt;_**:**_&lt;max\_uid&gt;_. If min_uid is omitted, the match is exact for the max_uid. If max_uid is omitted, all uids greater than or equal min_uid match.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a gid range specified as
  **@**_&lt;min\_gid&gt;_**:**_&lt;max\_gid&gt;_. If min_gid is omitted, the match is exact for the max_gid. If max_gid is omitted, all gids greater than or equal min_gid match. For the exact match all groups including the users supplementary groups are examined. For the range matches only the user\*(Aqs primary group is examined.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a gid specified as
  **%:**_&lt;gid&gt;_
  applicable to maxlogins limit only. It limits the total number of logins of all users that are member of the group with the specified gid.

**&lt;type&gt;**

**hard**
for enforcing
**hard**
resource limits. These limits are set by the superuser and enforced by the Kernel. The user cannot raise his requirement of system resources above such values.

**soft**
for enforcing
**soft**
resource limits. These limits are ones that the user can move up or down within the permitted range by any pre-existing
**hard**
limits. The values specified with this token can be thought of as
_default_
values, for normal system usage.

**-**
for enforcing both
**soft**
and
**hard**
resource limits together.

Note, if you specify a type of -\*(Aq but neglect to supply the item and value fields then the module will never enforce any limits on the specified user/group etc. .

**&lt;item&gt;**

**core**
limits the core file size (KB)

**data**
maximum data size (KB)

**fsize**
maximum filesize (KB)

**memlock**
maximum locked-in-memory address space (KB)

**nofile**
maximum number of open file descriptors

**rss**
maximum resident set size (KB) (Ignored in Linux 2.4.30 and higher)

**stack**
maximum stack size (KB)

**cpu**
maximum CPU time (minutes)

**nproc**
maximum number of processes

**as**
address space limit (KB)

**maxlogins**
maximum number of logins for this user (this limit does not apply to user with
_uid=0_)

**maxsyslogins**
maximum number of all logins on system; user is not allowed to log-in if total number of all user logins is greater than specified number (this limit does not apply to user with
_uid=0_)

**priority**
the priority to run user process with (negative values boost process priority)

**locks**
maximum locked files (Linux 2.4 and higher)

**sigpending**
maximum number of pending signals (Linux 2.6 and higher)

**msgqueue**
maximum memory used by POSIX message queues (bytes) (Linux 2.6 and higher)

**nice**
maximum nice priority allowed to raise to (Linux 2.6.12 and higher) values: [-20,19]

**rtprio**
maximum realtime priority allowed for non-privileged processes (Linux 2.6.12 and higher)

All items support the values
_-1_,
_unlimited_
or
_infinity_
indicating no limit, except for
**priority**
and
**nice**.

If a hard limit or soft limit of a resource is set to a valid value, but outside of the supported range of the local system, the system may reject the new limit or unexpected behavior may occur. If the control value
_required_
is used, the module will reject the login if a limit could not be set.

In general, individual limits have priority over group limits, so if you impose no limits for
_admin_
group, but one of the members in this group have a limits line, the user will have its limits set according to this line.

Also, please note that all limit settings are set
_per login_. They are not global, nor are they permanent; existing only for the duration of the session. One exception is the
_maxlogin_
option, this one is system wide. But there is a race, concurrent logins at the same time will not always be detect as such but only counted as one.

In the
_limits_
configuration file, the **#**\*(Aq character introduces a comment - after which the rest of the line is ignored.

The pam_limits module does report configuration problems found in its configuration file and errors via
**syslog**(3).

<a name="examples"></a>

# Examples


These are some example lines which might be specified in
/etc/security/limits.conf.

.if n \{.RS 4
.\}
    *               soft    core            0
    *               hard    nofile          512
    @student        hard    nproc           20
    @faculty        soft    nproc           20
    @faculty        hard    nproc           50
    ftp             hard    nproc           0
    @student        -       maxlogins       4
    :123            hard    cpu             5000
    @500:           soft    cpu             10000
    600:700         hard    locks           10
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**pam\_limits**(8),
**pam.d**(5),
**pam**(8),
**getrlimit**(2),
**getrlimit**(3p)

<a name="author"></a>

# Author


pam_limits was initially written by Cristian Gafton &lt;[gafton@redhat.com](mailto:gafton@redhat.com)&gt;
