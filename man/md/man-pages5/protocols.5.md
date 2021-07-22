# protocols(5) - protocols definition file

Linux, 2012-08-05


<a name="description"></a>

# Description

This file is a plain ASCII file, describing the various DARPA internet
protocols that are available from the TCP/IP subsystem.
It should be
consulted instead of using the numbers in the ARPA include files, or,
even worse, just guessing them.
These numbers will occur in the
protocol field of any IP header.

Keep this file untouched since changes would result in incorrect IP
packages.
Protocol numbers and names are specified by the IANA
(Internet Assigned Numbers Authority).


Each line is of the following format:

_protocol number aliases ..._

where the fields are delimited by spaces or tabs.
Empty lines are ignored.
If a line contains a hash mark (#), the hash mark and the part
of the line following it are ignored.

The field descriptions are:

* _protocol_  
  the native name for the protocol.
  For example
  _ip_,
  _tcp_,
  or
  _udp_.
* _number_  
  the official number for this protocol as it will appear within the IP
  header.
* _aliases_  
  optional aliases for the protocol.

This file might be distributed over a network using a network-wide
naming service like Yellow Pages/NIS or BIND/Hesiod.

<a name="files"></a>

# Files


* _/etc/protocols_  
  The protocols definition file.

<a name="see-also"></a>

# See Also

**getprotoent**(3)

[](http://www.iana.org​/assignments​/protocol-numbers)

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
