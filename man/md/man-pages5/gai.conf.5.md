# gai.conf(5) - getaddrinfo(3) configuration file

Linux, 2016-03-15


<a name="description"></a>

# Description

A call to
**getaddrinfo**(3)
might return multiple answers.
According to RFC&nbsp;3484 these answers must be sorted so that
the answer with the highest success rate is first in the list.
The RFC provides an algorithm for the sorting.
The static rules are not always adequate, though.
For this reason,
the RFC also requires that system administrators should have the possibility
to dynamically change the sorting.
For the glibc implementation, this can be achieved with the
_/etc/gai.conf_
file.

Each line in the configuration file consists of a keyword and its parameters.
White spaces in any place are ignored.
Lines starting with '#' are comments and are ignored.

The keywords currently recognized are:

* **label** _netmask_ _precedence_  
  The value is added to the label table used in the RFC&nbsp;3484 sorting.
  If any **label** definition is present in the configuration file,
  the default table is not used.
  All the label definitions
  of the default table which are to be maintained have to be duplicated.
  Following the keyword,
  the line has to contain a network mask and a precedence value.
* **precedence** _netmask_ _precedence_  
  This keyword is similar to **label**, but instead the value is added
  to the precedence table as specified in RFC&nbsp;3484.
  Once again, the
  presence of a single **precedence** line in the configuration file
  causes the default table to not be used.
* **reload** &lt;**yes**|**no**&gt;  
  This keyword controls whether a process checks whether the configuration
  file has been changed since the last time it was read.
  If the value is
  "**yes**", the file is reread.
  This might cause problems in multithreaded
  applications and is generally a bad idea.
  The default is "**no**".
* **scopev4** _mask_ _value_  
  Add another rule to the RFC&nbsp;3484 scope table for IPv4 address.
  By default, the scope IDs described in section 3.2 in RFC&nbsp;3438 are used.
  Changing these defaults should hardly ever be necessary.

<a name="files"></a>

# Files

_/etc/gai.conf_

<a name="versions"></a>

# Versions

The
_gai.conf_

file is supported by glibc since version 2.5.

<a name="example"></a>

# Example

The default table according to RFC&nbsp;3484 would be specified with the
following configuration file:

.in +4n
.EX
label  ::1/128       0
label  ::/0          1
label  2002::/16     2
label ::/96          3
label ::ffff:0:0/96  4
precedence  ::1/128       50
precedence  ::/0          40
precedence  2002::/16     30
precedence ::/96          20
precedence ::ffff:0:0/96  10
.EE
.in




<a name="see-also"></a>

# See Also

**getaddrinfo**(3),
RFC&nbsp;3484

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
