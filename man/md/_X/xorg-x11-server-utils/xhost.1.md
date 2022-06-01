# xhost(1) - server access control program for X

X Version 11, xhost 1.0.7

```
xhost [[+-]name ...]
```

<a name="description"></a>

# Description

The _xhost_ program
is used to add and delete host names or user names to the list allowed
to make connections to the X server.  In the case of hosts, this provides
a rudimentary form of privacy control and security.  It is only sufficient
for a workstation (single user) environment, although it does limit the
worst abuses.  Environments which require more sophisticated measures should
implement the user-based mechanism or use the hooks in the
protocol for passing other authentication data to the server.

<a name="options"></a>

# Options

_Xhost_ accepts the following command line options described below.  For
security, the options that affect access control may only be run from the
"controlling host".  For workstations, this is the same machine as the
server.  For X terminals, it is the login host.

* **-help**  
  Prints a usage message.
* **[+]**_name_  
  The given _name_ (the plus sign is optional)
  is added to the list allowed to connect to the X server.
  The name can be a host name or a complete name (See
  .SM
  **NAMES**
  for more details).
* **-**_name_  
  The given _name_ is removed from the list of allowed
  to connect to the server.  The name can be a host name or a complete
  name (See
  .SM
  **NAMES**
  for more details).
  Existing connections are not broken, but new
  connection attempts will be denied.
  Note that the current machine is allowed to be removed; however, further
  connections (including attempts to add it back) will not be permitted.
  Resetting the server (thereby breaking all connections)
  is the only way to allow local connections again.
* **\+**  
  Access is granted to everyone, even if they aren't on the list
  (i.e., access control is turned off).
* **-**  
  Access is restricted to only those on the list
  (i.e., access control is turned on).
* _nothing_  
  If no command line arguments are given,
  a message indicating whether or not access control is currently enabled
  is printed, followed by the list of those allowed to connect.
  This is the only option that may be used from machines other than
  the controlling host.

<a name="names"></a>

# Names

A complete name has the syntax
\`\`family:name'' where the families are
as follows:

    .ta 1i
    inet	Internet host (IPv4)
    inet6	Internet host (IPv6)
    dnet	DECnet host
    nis	Secure RPC network name
    krb	Kerberos V5 principal
    local	contains only one name, the empty string
    si	Server Interpreted

The family is case insensitive.
The format of the name varies with the family.

When Secure RPC is being used, the
network independent netname (e.g., "nis:unix._uid_@_domainname_") can
be specified, or a local user can be specified with just the username
and a trailing at-sign (e.g., "nis:pat@").

For backward compatibility with pre-R6 _xhost_,
names that contain an at-sign (@) are assumed to be in the nis family.
Otherwise they are assumed to be Internet addresses. If compiled to support
IPv6, then all IPv4 and IPv6 addresses returned by getaddrinfo(3) are added to
the access list in the appropriate inet or inet6 family.

The local family specifies all the local connections at once. However,
the server interpreted address "si:localuser:_username_" can be
used to specify a single local user. (See the
_Xsecurity_(7) manual page for more details.)

Server interpreted addresses consist of a case-sensitive type tag and a
string representing a given value, separated by a colon.  For example,
"si:hostname:almas" is a server interpreted address of type _hostname_,
with a value of _almas_.   For more information on the available forms
of server interpreted addresses, see the _Xsecurity_(7)
manual page.

The initial access control list for display number **n**
may be set by the file /etc/X**n.hosts**, where
**n** is the display number of the server.  See _Xserver_(1)
for details.

<a name="diagnostics"></a>

# Diagnostics

For each name added to the access control list,
a line of the form "_name_ being added to access control list"
is printed.
For each name removed from the access control list,
a line of the form "_name_ being removed from access control list"
is printed.

<a name="see-also"></a>

# See Also

X(7), Xsecurity(7), Xserver(1), xdm(1), xauth(1), getaddrinfo(3)

<a name="environment"></a>

# Environment


* **DISPLAY**  
  to get the default host and display to use.

<a name="bugs"></a>

# Bugs


You can't specify a display on the command line because
**-display**
is a valid command line argument (indicating that you want
to remove the machine named
_\`\`display''_
from the access list).

The X server stores network addresses, not host names, unless you use
the server-interpreted hostname type address.  If somehow you change a
host's network address while the server is still running, and you are
using a network-address based form of authentication, _xhost_ must
be used to add the new address and/or remove the old address.

<a name="authors"></a>

# Authors

Bob Scheifler, MIT Laboratory for Computer Science,  
Jim Gettys, MIT Project Athena (DEC).
