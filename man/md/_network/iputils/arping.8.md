# arping(8)

iputils s20180629, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

arping - send ARP REQUEST to a neighbour host

<a name="synopsis"></a>

# Synopsis

```
.HP \w'arping&nbsp;'u arping [-AbDfhqUV] [-c&nbsp;count] [-w&nbsp;deadline] [-s&nbsp;source] [-I&nbsp;interface] destination

```


<a name="description"></a>

# Description


Ping
_destination_
on device
_interface_
by ARP packets, using source address
_source_.

<a name="options"></a>

# Options


**-A**
The same as
**-U**, but ARP REPLY packets used instead of ARP REQUEST.

**-b**
Send only MAC level broadcasts. Normally
**arping**
starts from sending broadcast, and switch to unicast after reply received.

**-c **_count_
Stop after sending
_count_
ARP REQUEST packets. With
_deadline_
option, instead wait for
_count_
ARP REPLY packets, or until the timeout expires.

**-D**
Duplicate address detection mode (DAD). See RFC2131, 4.4.1. Returns 0, if DAD succeeded i.e. no replies are received

**-f**
Finish after the first reply confirming that target is alive.

**-I **_interface_
Name of network device where to send ARP REQUEST packets.

**-h**
Print help page and exit.

**-q**
Quiet output. Nothing is displayed.

**-s **_source_
IP source address to use in ARP packets. If this option is absent, source address is:

· In DAD mode (with option
**-D**) set to 0.0.0.0.

· In Unsolicited ARP mode (with options
**-U**
or
**-A**) set to
_destination_.

· Otherwise, it is calculated from routing tables.

**-U**
Unsolicited ARP mode to update neighbours ARP caches. No replies are expected.

**-V**
Print version of the program and exit.

**-w **_deadline_
Specify a timeout, in seconds, before
**arping**
exits regardless of how many packets have been sent or received. In this case
**arping**
does not stop after
_count_
packet are sent, it waits either for
_deadline_
expire or until
_count_
probes are answered.

<a name="see-also"></a>

# See Also


**ping**(8),
**clockdiff**(8),
**tracepath**(8).

<a name="author"></a>

# Author


**arping**
was written by Alexey Kuznetsov &lt;[kuznet@ms2.inr](mailto:kuznet@ms2.inr).ac.ru&gt;.

<a name="security"></a>

# Security


**arping**
requires CAP_NET_RAW capability to be executed. It is not recommended to be used as set-uid root, because it allows user to modify ARP caches of neighbour hosts.

<a name="availability"></a>

# Availability


**arping**
is part of
_iputils_
package.
