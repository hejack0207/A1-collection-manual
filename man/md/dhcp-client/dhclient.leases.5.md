# dhclient.leases(5) - DHCP client lease database


<a name="description"></a>

# Description

The Internet Systems Consortium DHCP client keeps a persistent
database of leases that it has acquired that are still valid.   The
database is a free-form ASCII file containing one valid declaration
per lease.   If more than one declaration appears for a given lease,
the last one in the file is used.   The file is written as a log, so
this is not an unusual occurrence.

The format of the lease declarations is described in
**dhclient.conf(5).**

<a name="files"></a>

# Files

**/var/lib/dhclient/dhclient.leases**

<a name="see-also"></a>

# See Also

dhclient(8), dhcp-options(5), dhclient.conf(5), dhcpd(8),
dhcpd.conf(5), RFC2132, RFC2131.

<a name="author"></a>

# Author

**dhclient(8)**
Information about Internet Systems Consortium can be found at
**https://www.isc.org.**
