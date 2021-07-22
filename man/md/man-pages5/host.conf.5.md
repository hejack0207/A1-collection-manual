# host.conf(5) - resolver configuration file

Linux, 2017-09-15


<a name="description"></a>

# Description

The file
_/etc/host.conf_
contains configuration information specific to the resolver library.
It should contain one configuration keyword per line, followed by
appropriate configuration information.
The following keywords are recognized:

* _trim_  
  This keyword may be listed more than once.
  Each time it should be
  followed by a list of domains, separated by colons (':'), semicolons
  (';') or commas (','), with the leading dot.
  When set, the
  resolver library will automatically trim the given domain name from the
  end of any hostname resolved via DNS.
  This is intended for use with
  local hosts and domains.
  (Related note:
  _trim_
  will not affect hostnames gathered via NIS or the
  **hosts**(5)
  file.
  Care should be taken to
  ensure that the first hostname for each entry in the hosts file is
  fully qualified or unqualified, as appropriate for the local
  installation.)
* _multi_  
  Valid values are
  _on_ and _off_.
  If set to
  _on_,
  the resolver library will return all valid addresses for a host that
  appears in the
  _/etc/hosts_
  file,
  instead of only the first.
  This is
  _off_
  by default, as it may cause a substantial performance loss at sites
  with large hosts files.
* _reorder_  
  Valid values are
  _on_ and _off_.
  If set to
  _on_,
  the resolver library
  will attempt to reorder host addresses so that local addresses
  (i.e., on the same subnet) are listed first when a
  **gethostbyname**(3)
  is performed.
  Reordering is done for all lookup methods.
  The default value is
  _off_.

<a name="environment"></a>

# Environment

The following environment variables can be used to allow users to
override the behavior which is configured in
_/etc/host.conf_:

* **RESOLV_HOST_CONF**  
  If set, this variable points to a file that should be read instead of
  _/etc/host.conf_.
* **RESOLV_MULTI**  
  Overrides the
  _multi_
  command.
* **RESOLV_REORDER**  
  Overrides the
  _reorder_
  command.
* **RESOLV_ADD_TRIM_DOMAINS**  
  A list of domains,  separated by colons (':'), semicolons (';') or
  commas (','), with the leading dot, which will be added to the list of
  domains that should be trimmed.
* **RESOLV_OVERRIDE_TRIM_DOMAINS**  
  A list of domains,  separated by colons (':'), semicolons (';') or
  commas (','), with the leading dot, which will replace the list of
  domains that should be trimmed.
  Overrides the
  _trim_
  command.

<a name="files"></a>

# Files


* _/etc/host.conf_  
  Resolver configuration file
* _/etc/resolv.conf_  
  Resolver configuration file
* _/etc/hosts_  
  Local hosts database

<a name="notes"></a>

# Notes

The following differences exist compared to the original implementation.
A new command
_spoof_
and a new environment variable
**RESOLV_SPOOF_CHECK**
can take arguments like
_off_, _nowarn_, and _warn_.
Line comments can appear anywhere and not only at the beginning of a line.

<a name="historical"></a>

### Historical

The
**nsswitch.conf**(5)
file is the modern way of controlling the order of host lookups.

In glibc 2.4 and earlier, the following keyword is recognized:

* _order_  
  This keyword specifies how host lookups are to be performed.
  It should be followed by one or more lookup methods, separated by commas.
  Valid methods are
  _bind_, _hosts_, and _nis_.
* **RESOLV_SERV_ORDER**  
  Overrides the
  _order_
  command.

Since glibc 2.0.7, the following keywords and environment variable have
been recognized but never implemented:

* _nospoof_  
  Valid values are
  _on_ and _off_.
  If set to
  _on_,
  the resolver library will attempt to prevent hostname spoofing to
  enhance the security of
  **rlogin** and **rsh**.
  It works as follows: after performing a host address lookup,
  the resolver library will perform a hostname lookup for that address.
  If the two hostnames
  do not match, the query fails.
  The default value is
  _off_.
* _spoofalert_  
  Valid values are
  _on_ and _off_.
  If this option is set to
  _on_
  and the
  _nospoof_
  option is also set,
  the resolver library will log a warning of the error via the
  syslog facility.
  The default value is
  _off_.
* _spoof_  
  Valid values are
  _off_, _nowarn_, and _warn_.
  If this option is set to
  _off_,
  spoofed addresses are permitted and no warnings will be emitted
  via the syslog facility.
  If this option is set to
  _warn_,
  the resolver library will attempt to prevent hostname spoofing to
  enhance the security and log a warning of the error via the syslog
  facility.
  If this option is set to
  _nowarn_,
  the resolver library will attempt to prevent hostname spoofing to
  enhance the security but not emit warnings via the syslog facility.
  Setting this option to anything else is equal to setting it to
  _nowarn_.
* **RESOLV_SPOOF_CHECK**  
  Overrides the
  _nospoof_, _spoofalert_, and _spoof_
  commands in the same way as the
  _spoof_
  command is parsed.
  Valid values are
  _off_, _nowarn_, and _warn_.

<a name="see-also"></a>

# See Also

**gethostbyname**(3),
**hosts**(5),
**nsswitch.conf**(5),
**resolv.conf**(5),
**hostname**(7),
**named**(8)

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
