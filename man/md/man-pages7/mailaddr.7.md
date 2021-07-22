# mailaddr(7)

Linux, 2017-05-03

.UC 5

<a name="name"></a>

# Name

mailaddr - mail addressing description

<a name="description"></a>

# Description

.nh
This manual page gives a brief introduction to SMTP mail addresses,
as used on the Internet.
These addresses are in the general format

	user@domain

where a domain is a hierarchical dot-separated list of subdomains.
These examples are valid forms of the same address:

	john.doe@monet.example.com  
	John Doe &lt;john.doe@monet.example.com&gt;  
	john.doe@monet.example.com (John Doe)

The domain part ("monet.example.com") is a mail-accepting domain.
It can be a host and in the past it usually was, but it doesn't have to be.
The domain part is not case sensitive.

The local part ("john.doe") is often a username,
but its meaning is defined by the local software.
Sometimes it is case sensitive,
although that is unusual.
If you see a local-part that looks like garbage,
it is usually because of a gateway between an internal e-mail
system and the net, here are some examples:

	"surname/admd=telemail/c=us/o=hp/prmd=hp"@some.where  
	USER%SOMETHING@some.where  
	machine!machine!name@some.where  
	I2461572@some.where

(These are, respectively, an X.400 gateway, a gateway to an arbitrary
internal mail system that lacks proper internet support, an UUCP
gateway, and the last one is just boring username policy.)

The real-name part ("John Doe") can either be placed before
&lt;&gt;, or in () at the end.
(Strictly speaking the two aren't the same,
but the difference is beyond the scope of this page.)
The name may have to be quoted using "", for example, if it contains ".":

	"John Q. Doe" &lt;john.doe@monet.example.com&gt;

<a name="abbreviation"></a>

### Abbreviation


Some mail systems let users abbreviate the domain name.
For instance,
users at example.com may get away with "john.doe@monet" to
send mail to John Doe.
_This behavior is deprecated._
Sometimes it works, but you should not depend on it.

<a name="route-addrs"></a>

### Route-addrs


In the past, sometimes one had to route a message through
several hosts to get it to its final destination.
Addresses which show these relays are termed "route-addrs".
These use the syntax:

	&lt;@hosta,@hostb:user@hostc&gt;

This specifies that the message should be sent to hosta,
from there to hostb, and finally to hostc.
Many hosts disregard route-addrs and send directly to hostc.

Route-addrs are very unusual now.
They occur sometimes in old mail archives.
It is generally possible to ignore all but the "user@hostc"
part of the address to determine the actual address.

<a name="postmaster"></a>

### Postmaster


Every site is required to have a user or user alias designated
"postmaster" to which problems with the mail system may be
addressed.
The "postmaster" address is not case sensitive.

<a name="files"></a>

# Files

_/etc/aliases_  
_~/.forward_

<a name="see-also"></a>

# See Also

**mail**(1),
**aliases**(5),
**forward**(5),
**sendmail**(8)

[IETF RFC&nbsp;5322](http://www.ietf.org​/rfc​/rfc5322.txt)

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
