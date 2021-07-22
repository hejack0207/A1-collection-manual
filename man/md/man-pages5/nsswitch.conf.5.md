# nsswitch.conf(5) - Name Service Switch configuration file

Linux, 2017-05-03


<a name="description"></a>

# Description

The Name Service Switch (NSS) configuration file,
_/etc/nsswitch.conf_,
is used by the GNU C Library and certain other applications to determine
the sources from which to obtain name-service information in
a range of categories,
and in what order.
Each category of information is identified by a database name.

The file is plain ASCII text, with columns separated by spaces or tab
characters.
The first column specifies the database name.
The remaining columns describe the order of sources to query and a
limited set of actions that can be performed by lookup result.

The following databases are understood by the GNU C Library:

* **aliases**  
  Mail aliases, used by
  **getaliasent**(3)
  and related functions.
* **ethers**  
  Ethernet numbers.
* **group**  
  Groups of users, used by
  **getgrent**(3)
  and related functions.
* **hosts**  
  Host names and numbers, used by
  **gethostbyname**(3)
  and related functions.
* **initgroups**  
  Supplementary group access list, used by
  **getgrouplist**(3)
  function.
* **netgroup**  
  Network-wide list of hosts and users, used for access rules.
  C libraries before glibc 2.1 supported netgroups only over NIS.
* **networks**  
  Network names and numbers, used by
  **getnetent**(3)
  and related functions.
* **passwd**  
  User passwords, used by
  **getpwent**(3)
  and related functions.
* **protocols**  
  Network protocols, used by
  **getprotoent**(3)
  and related functions.
* **publickey**  
  Public and secret keys for Secure_RPC used by NFS and NIS+.
* **rpc**  
  Remote procedure call names and numbers, used by
  **getrpcbyname**(3)
  and related functions.
* **services**  
  Network services, used by
  **getservent**(3)
  and related functions.
* **shadow**  
  Shadow user passwords, used by
  **getspnam**(3)
  and related functions.

The GNU C Library ignores databases with unknown names.  Some
applications use this to implement special handling for their own
databases.  For example,
**sudo**(8)
consults the
**sudoers**
database.

Here is an example
_/etc/nsswitch.conf_
file:

.in +4n
.EX
passwd:         compat
group:          compat
shadow:         compat

hosts:          dns [!UNAVAIL=return] files
networks:       nis [NOTFOUND=return] files
ethers:         nis [NOTFOUND=return] files
protocols:      nis [NOTFOUND=return] files
rpc:            nis [NOTFOUND=return] files
services:       nis [NOTFOUND=return] files
.EE
.in

The first column is the database name.
The remaining columns specify:

* *  
  One or more service specifications, for example, "files", "db", or "nis".
  The order of the services on the line determines the order in which
  those services will be queried, in turn, until a result is found.
* *  
  Optional actions to perform if a particular result is obtained
  from the preceding service, for example, "[NOTFOUND=return]".

The service specifications supported on your system depend on the
presence of shared libraries, and are therefore extensible.
Libraries called
_/lib/libnss_SERVICE.so._**X**
will provide the named
_SERVICE_.
On a standard installation, you can use
"files", "db", "nis", and "nisplus".
For the
**hosts**
database, you can additionally specify "dns".
For the
**passwd**,
**group**,
and
**shadow**
databases, you can additionally specify
"compat" (see
**Compatibility mode**
below).
The version number
**X**
may be 1 for glibc 2.0, or 2 for glibc 2.1 and later.
On systems with additional libraries installed, you may have access to
further services such as "hesiod", "ldap", "winbind" and "wins".

An action may also be specified following a service specification.
The action modifies the behavior following a result obtained
from the preceding data source.
Action items take the general form:

[_STATUS_=_ACTION_]  
[!_STATUS_=_ACTION_]

where

_STATUS_
=&gt;
**success**
|
**notfound**
|
**unavail**
|
**tryagain**  
_ACTION_
=&gt;
**return**
|
**continue**
|
**merge**

The ! negates the test, matching all possible results except the
one specified.
The case of the keywords is not significant.

The
_STATUS_
value is matched against the result of the lookup function called by
the preceding service specification, and can be one of:

* **success**  
  No error occurred and the requested entry is returned.
  The default action for this condition is "return".
* **notfound**  
  The lookup succeeded, but the requested entry was not found.
  The default action for this condition is "continue".
* **unavail**  
  The service is permanently unavailable.
  This can mean either that the
  required file cannot be read, or, for network services, that the server
  is not available or does not allow queries.
  The default action for this condition is "continue".
* **tryagain**  
  The service is temporarily unavailable.
  This could mean a file is
  locked or a server currently cannot accept more connections.
  The default action for this condition is "continue".

The
_ACTION_
value can be one of:

* **return**  
  Return a result now.
  Do not call any further lookup functions.
  However, for compatibility reasons, if this is the selected action for the
  **group**
  database and the
  **notfound**
  status, and the configuration file does not contain the
  **initgroups**
  line, the next lookup function is always called,
  without affecting the search result.
* **continue**  
  Call the next lookup function.
* **merge**  
  _[SUCCESS=merge]_
  is used between two database entries.
  When a group is located in the first of the two group entries,
  processing will continue on to the next one.
  If the group is also found in the next entry (and the group name and GID
  are an exact match), the member list of the second entry will be added
  to the group object to be returned.
  Available since glibc 2.24.
  Note that merging will not be done for
  **getgrent**(3)
  nor will duplicate members be pruned when they occur in both entries
  being merged.

<a name="compatibility-mode-compat"></a>

### Compatibility mode (compat)

The NSS "compat" service is similar to "files" except that it
additionally permits special entries in corresponding files
for granting users or members of netgroups access to the system.
The following entries are valid in this mode:

For
**passwd**
and
**shadow**
databases:

* **+**_user_  
  Include the specified
  _user_
  from the NIS passwd/shadow map.
* **+@**_netgroup_  
  Include all users in the given
  _netgroup_.
* **-**_user_  
  Exclude the specified
  _user_
  from the NIS passwd/shadow map.
* **-@**_netgroup_  
  Exclude all users in the given
  _netgroup_.
* **+**  
  Include every user, except previously excluded ones, from the
  NIS passwd/shadow map.

For
**group**
database:

* **+**_group_  
  Include the specified
  _group_
  from the NIS group map.
* **-**_group_  
  Exclude the specified
  _group_
  from the NIS group map.
* **+**  
  Include every group, except previously excluded ones, from the
  NIS group map.

By default, the source is "nis", but this may be
overridden by specifying any NSS service except "compat" itself
as the source for the pseudo-databases
**passwd_compat**,
**group_compat**,
and
**shadow_compat**.

<a name="files"></a>

# Files

A service named
_SERVICE_
is implemented by a shared object library named
_libnss_SERVICE.so._**X**
that resides in
_/lib_.

* _/etc/nsswitch.conf_  
  NSS configuration file.
* _/lib/libnss_compat.so._**X**  
  implements "compat" source.
* _/lib/libnss_db.so._**X**  
  implements "db" source.
* _/lib/libnss_dns.so._**X**  
  implements "dns" source.
* _/lib/libnss_files.so._**X**  
  implements "files" source.
* _/lib/libnss_hesiod.so._**X**  
  implements "hesiod" source.
* _/lib/libnss_nis.so._**X**  
  implements "nis" source.
* _/lib/libnss_nisplus.so._**X**  
  implements "nisplus" source.

The following files are read when "files" source is specified
for respective databases:

* **aliases**  
  _/etc/aliases_
* **ethers**  
  _/etc/ethers_
* **group**  
  _/etc/group_
* **hosts**  
  _/etc/hosts_
* **initgroups**  
  _/etc/group_
* **netgroup**  
  _/etc/netgroup_
* **networks**  
  _/etc/networks_
* **passwd**  
  _/etc/passwd_
* **protocols**  
  _/etc/protocols_
* **publickey**  
  _/etc/publickey_
* **rpc**  
  _/etc/rpc_
* **services**  
  _/etc/services_
* **shadow**  
  _/etc/shadow_

<a name="notes"></a>

# Notes

Within each process that uses
**nsswitch.conf**,
the entire file is read only once.
If the file is later changed, the
process will continue using the old configuration.

Traditionally, there was only a single source for service information,
often in the form of a single configuration
file (e.g., _/etc/passwd_).
However, as other name services, such as the Network Information
Service (NIS) and the Domain Name Service (DNS), became popular,
a method was needed
that would be more flexible than fixed search orders coded into
the C library.
The Name Service Switch mechanism,
which was based on the mechanism used by
Sun Microsystems in the Solaris 2 C library,
introduced a cleaner solution to the problem.

<a name="see-also"></a>

# See Also

**getent**(1),
**nss**(5)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
