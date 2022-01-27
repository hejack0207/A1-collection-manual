# getent(1) - get entries from Name Service Switch libraries

Linux, 2015-04-19

```
getent&nbsp;[option]...&nbsp;database&nbsp;key...
```

<a name="description"></a>

# Description

The
**getent**
command displays entries from databases supported by the
Name Service Switch libraries,
which are configured in
_/etc/nsswitch.conf_.
If one or more
_key_
arguments are provided,
then only the entries that match the supplied keys will be displayed.
Otherwise, if no
_key_
is provided, all entries will be displayed (unless the database does not
support enumeration).

The
_database_
may be any of those supported by the GNU C Library, listed below:

* **ahosts**  
  When no
  _key_
  is provided, use
  **sethostent**(3),
  **gethostent**(3),
  and
  **endhostent**(3)
  to enumerate the hosts database.
  This is identical to using
  **hosts**.
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  in succession to
  **getaddrinfo**(3)
  with the address family
  **AF_UNSPEC**,
  enumerating each socket address structure returned.
* **ahostsv4**  
  Same as
  **ahosts**,
  but use the address family
  **AF_INET**.
* **ahostsv6**  
  Same as
  **ahosts**,
  but use the address family
  **AF_INET6**.
  The call to
  **getaddrinfo**(3)
  in this case includes the
  **AI_V4MAPPED**
  flag.
* **aliases**  
  When no
  _key_
  is provided, use
  **setaliasent**(3),
  **getaliasent**(3),
  and
  **endaliasent**(3)
  to enumerate the aliases database.
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  in succession to
  **getaliasbyname**(3)
  and display the result.
* **ethers**  
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  in succession to
  **ether_aton**(3)
  and
  **ether_hostton**(3)
  until a result is obtained, and display the result.
  Enumeration is not supported on
  **ethers**,
  so a
  _key_
  must be provided.
* **group**  
  When no
  _key_
  is provided, use
  **setgrent**(3),
  **getgrent**(3),
  and
  **endgrent**(3)
  to enumerate the group database.
  When one or more
  _key_
  arguments are provided, pass each numeric
  _key_
  to
  **getgrgid**(3)
  and each nonnumeric
  _key_
  to
  **getgrnam**(3)
  and display the result.
* **gshadow**  
  When no
  _key_
  is provided, use
  **setsgent**(3),
  **getsgent**(3),
  and
  **endsgent**(3)
  to enumerate the gshadow database.
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  in succession to
  **getsgnam**(3)
  and display the result.
* **hosts**  
  When no
  _key_
  is provided, use
  **sethostent**(3),
  **gethostent**(3),
  and
  **endhostent**(3)
  to enumerate the hosts database.
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  to
  **gethostbyaddr**(3)
  or
  **gethostbyname2**(3),
  depending on whether a call to
  **inet_pton**(3)
  indicates that the
  _key_
  is an IPv6 or IPv4 address or not, and display the result.
* **initgroups**  
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  in succession to
  **getgrouplist**(3)
  and display the result.
  Enumeration is not supported on
  **initgroups**,
  so a
  _key_
  must be provided.
* **netgroup**  
  When one
  _key_
  is provided, pass the
  _key_
  to
  **setnetgrent**(3)
  and, using
  **getnetgrent**(3)
  display the resulting string triple
  (_hostname_, _username_, _domainname_).
  Alternatively, three
  _keys_
  may be provided, which are interpreted as the
  _hostname_,
  _username_
  and
  _domainname_
  to match to a netgroup name via
  **innetgr**(3).
  Enumeration is not supported on
  **netgroup**,
  so either one or three
  _keys_
  must be provided.
* **networks**  
  When no
  _key_
  is provided, use
  **setnetent**(3),
  **getnetent**(3),
  and
  **endnetent**(3)
  to enumerate the networks database.
  When one or more
  _key_
  arguments are provided, pass each numeric
  _key_
  to
  **getnetbyaddr**(3)
  and each nonnumeric
  _key_
  to
  **getnetbyname**(3)
  and display the result.
* **passwd**  
  When no
  _key_
  is provided, use
  **setpwent**(3),
  **getpwent**(3),
  and
  **endpwent**(3)
  to enumerate the passwd database.
  When one or more
  _key_
  arguments are provided, pass each numeric
  _key_
  to
  **getpwuid**(3)
  and each nonnumeric
  _key_
  to
  **getpwnam**(3)
  and display the result.
* **protocols**  
  When no
  _key_
  is provided, use
  **setprotoent**(3),
  **getprotoent**(3),
  and
  **endprotoent**(3)
  to enumerate the protocols database.
  When one or more
  _key_
  arguments are provided, pass each numeric
  _key_
  to
  **getprotobynumber**(3)
  and each nonnumeric
  _key_
  to
  **getprotobyname**(3)
  and display the result.
* **rpc**  
  When no
  _key_
  is provided, use
  **setrpcent**(3),
  **getrpcent**(3),
  and
  **endrpcent**(3)
  to enumerate the rpc database.
  When one or more
  _key_
  arguments are provided, pass each numeric
  _key_
  to
  **getrpcbynumber**(3)
  and each nonnumeric
  _key_
  to
  **getrpcbyname**(3)
  and display the result.
* **services**  
  When no
  _key_
  is provided, use
  **setservent**(3),
  **getservent**(3),
  and
  **endservent**(3)
  to enumerate the services database.
  When one or more
  _key_
  arguments are provided, pass each numeric
  _key_
  to
  **getservbynumber**(3)
  and each nonnumeric
  _key_
  to
  **getservbyname**(3)
  and display the result.
* **shadow**  
  When no
  _key_
  is provided, use
  **setspent**(3),
  **getspent**(3),
  and
  **endspent**(3)
  to enumerate the shadow database.
  When one or more
  _key_
  arguments are provided, pass each
  _key_
  in succession to
  **getspnam**(3)
  and display the result.

<a name="options"></a>

# Options


* **-s&nbsp;_service_**, **--service&nbsp;_service_**  
  
  Override all databases with the specified service.
  (Since glibc 2.2.5.)
* **-s&nbsp;_database_:_service_**, **--service&nbsp;_database_:_service_**  
  
  Override only specified databases with the specified service.
  The option may be used multiple times,
  but only the last service for each database will be used.
  (Since glibc 2.4.)
* **-i**, **--no-idn**  
  
  Disables IDN encoding in lookups for
  **ahosts**/**getaddrinfo**(3)
  (Since glibc-2.13.)
* **-?**, **--help**  
  Print a usage summary and exit.
* **--usage**  
  Print a short usage summary and exit.
* **-V**, **--version**  
  Print the version number, license, and disclaimer of warranty for
  **getent**.

<a name="exit-status"></a>

# Exit Status

One of the following exit values can be returned by
**getent**:

* **0**
  Command completed successfully.
* **1**
  Missing arguments, or
  _database_
  unknown.
* **2**
  One or more supplied
  _key_
  could not be found in the
  _database_.
* **3**
  Enumeration not supported on this
  _database_.

<a name="see-also"></a>

# See Also

**nsswitch.conf**(5)

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
