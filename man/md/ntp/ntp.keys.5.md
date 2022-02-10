# ntp.keys(5)

4.2.8p15, 23 Jun 2020

.Sh NAME
.Nm ntp.keys
.Nd NTP symmetric key file format



<a name="name"></a>

# Name

ntp.keys - NTP symmetric key file format configuration file
.de1 NOP
..
.ie t .ds B-Font [CB]
.ds I-Font [CI]
.ds R-Font [CR]
.el .ds B-Font B
.ds I-Font I
.ds R-Font R

<a name="synopsis"></a>

# Synopsis

```
\fB-Font] [\fB-Font]--option-name\f[]] [\fB-Font]--option-name\f[] \f\*[I-Font]value\f[]] 
 .ne 2
</synopsis>

<synopsis>
All arguments must be options. 
 .ne 2
```


<a name="description"></a>

# Description

This document describes the format of an NTP symmetric key file.
For a description of the use of this type of file, see the
"Authentication Support"
section of the
\fCntp.conf\f[](5)\f[]
page.

.ne 2

\fCntpd\f[](8)\f[]
reads its keys from a file specified using the
-Font]-k\f[]
command line option or the
-Font]keys\f[]
statement in the configuration file.
While key number 0 is fixed by the NTP standard
(as 56 zero bits)
and may not be changed,
one or more keys numbered between 1 and 65535
may be arbitrarily set in the keys file.

.ne 2

The key file uses the same comment conventions
as the configuration file.
Key entries use a fixed format of the form

.ne 2

.in +4
-Font]keyno\f[] \f\*[I-Font]type\f[] \f\*[I-Font]key\f[] \f\*[I-Font]opt_IP_list\f[]
.in -4

.ne 2

where
-Font]keyno\f[]
is a positive integer (between 1 and 65535),
-Font]type\f[]
is the message digest algorithm,
-Font]key\f[]
is the key itself, and
-Font]opt_IP_list\f[]
is an optional comma-separated list of IPs
where the
-Font]keyno\f[]
should be trusted.
that are allowed to serve time.
Each IP in
-Font]opt_IP_list\f[]
may contain an optional
-Font]/subnetbits\f[]
specification which identifies the number of bits for
the desired subnet of trust.
If
-Font]opt_IP_list\f[]
is empty,
any properly-authenticated message will be
accepted.

.ne 2

The
-Font]key\f[]
may be given in a format
controlled by the
-Font]type\f[]
field.
The
-Font]type\f[]
\f[C]MD5\f[]
is always supported.
If
\f[C]ntpd\f[]
was built with the OpenSSL library
then any digest library supported by that library may be specified.
However, if compliance with FIPS 140-2 is required the
-Font]type\f[]
must be either
\f[C]SHA\f[]
or
\f[C]SHA1\f[].

.ne 2

What follows are some key types, and corresponding formats:

.ne 2


* .NOP \f[C]MD5\f[]  
  The key is 1 to 16 printable characters terminated by
  an EOL,
  whitespace,
  or
  a
  \f[C]#\f[]
  (which is the "start of comment" character).

.ne 2
  
.ns

* .NOP \f[C]SHA\f[]    
  .ns
* .NOP \f[C]SHA1\f[]    
  .ns
* .NOP \f[C]RMD160\f[]  
  The key is a hex-encoded ASCII string of 40 characters,
  which is truncated as necessary.


.ne 2

Note that the keys used by the
\fCntpq\f[](8)\f[]
and
\fCntpdc\f[](8)\f[]
programs are checked against passwords
requested by the programs and entered by hand,
so it is generally appropriate to specify these keys in ASCII format.

<a name="files"></a>

# Files


* .NOP /etc/ntp.keys\f[]  
  the default name of the configuration file


<a name="see-also"></a>

# See Also

\fCntp.conf\f[](5)\f[],
\fCntpd\f[](8)\f[],
\fCntpdate\f[](8)\f[],
\fCntpdc\f[](8)\f[],
\fCsntp\f[](8)\f[]

<a name="authors"></a>

# Authors

The University of Delaware and Network Time Foundation

<a name="copyright"></a>

# Copyright

Copyright (C) 1992-2020 The University of Delaware and Network Time Foundation all rights reserved.
This program is released under the terms of the NTP license, &lt;http://ntp.org/license&gt;.

<a name="bugs"></a>

# Bugs

Please send bug reports to: http://bugs.ntp.org, bugs@ntp.org

<a name="notes"></a>

# Notes

This document was derived from FreeBSD.

.ne 2

This manual page was _AutoGen_-erated from the **ntp.keys**
option definitions.
