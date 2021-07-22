# nss(5) - Name Service Switch configuration file

Linux, 2013-02-13


<a name="description"></a>

# Description

Each call to a function which retrieves data from a system database
like the password or group database is handled by the Name Service
Switch implementation in the GNU C library.
The various services
provided are implemented by independent modules, each of which
naturally varies widely from the other.

The default implementations coming with the GNU C library are by
default conservative and do not use unsafe data.
This might be very costly in some situations, especially when the databases
are large.
Some modules allow the system administrator to request
taking shortcuts if these are known to be safe.
It is then the system administrator's responsibility to ensure the assumption
is correct.

There are other modules where the implementation changed over time.
If an implementation used to sacrifice speed for memory consumption,
it might create problems if the preference is switched.

The
_/etc/default/nss_
file contains a number of variable assignments.
Each variable controls the behavior of one or more
NSS modules.
White spaces are ignored.
Lines beginning with '#'
are treated as comments.

The variables currently recognized are:

* **NETID_AUTHORITATIVE =** _TRUE_|_FALSE_  
  If set to TRUE, the NIS backend for the
  **initgroups**(3)
  function will accept the information
  from the
  _netid.byname_
  NIS map as authoritative.
  This can speed up the function significantly if the
  _group.byname_
  map is large.
  The content of the
  _netid.byname_
  map is used **as is**.
  The system administrator has to make sure it is correctly generated.
* **SERVICES_AUTHORITATIVE =** _TRUE_|_FALSE_  
  If set to TRUE, the NIS backend for the
  **getservbyname**(3)
  and
  **getservbyname_r**(3)
  functions will assume that the
  _services.byservicename_
  NIS map exists and is authoritative, particularly
  that it contains both keys with /proto and without /proto for both
  primary service names and service aliases.
  The system administrator has to make sure it is correctly generated.
* **SETENT_BATCH_READ =** _TRUE_|_FALSE_  
  If set to TRUE, the NIS backend for the
  **setpwent**(3)
  and
  **setgrent**(3)
  functions will read the entire database at once and then
  hand out the requests one by one from memory with every corresponding
  **getpwent**(3)
  or
  **getgrent**(3)
  call respectively.
  Otherwise, each
  **getpwent**(3)
  or
  **getgrent**(3)
  call might result in a network communication with the server to get
  the next entry.

<a name="files"></a>

# Files

_/etc/default/nss_

<a name="example"></a>

# Example

The default configuration corresponds to the following configuration file:

.in +4n
.EX
NETID_AUTHORITATIVE=FALSE
SERVICES_AUTHORITATIVE=FALSE
SETENT_BATCH_READ=FALSE
.EE
.in




<a name="see-also"></a>

# See Also

_nsswitch.conf_

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
