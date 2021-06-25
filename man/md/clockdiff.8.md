# clockdiff(8)

iputils s20180629, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

clockdiff - measure clock difference between hosts

<a name="synopsis"></a>

# Synopsis

```
.HP \w'clockdiff&nbsp;'u clockdiff [-o] [-o1] destination

```


<a name="description"></a>

# Description


**clockdiff**
Measures clock difference between us and
_destination_
with 1 msec resolution using ICMP TIMESTAMP [2] packets or, optionally, IP TIMESTAMP option [3] option added to ICMP ECHO. [1]

<a name="options"></a>

# Options


**-o**
Use IP TIMESTAMP with ICMP ECHO instead of ICMP TIMESTAMP messages. It is useful with some destinations, which do not support ICMP TIMESTAMP (f.e. Solaris &lt;2.4).

**-o1**
Slightly different form of
**-o**, namely it uses three-term IP TIMESTAMP with prespecified hop addresses instead of four term one. What flavor works better depends on target host. Particularly,
**-o**
is better for Linux.

<a name="warnings"></a>

# Warnings


· Some nodes (Cisco) use non-standard timestamps, which is allowed by RFC, but makes timestamps mostly useless.

· Some nodes generate messed timestamps (Solaris&gt;2.4), when run
**xntpd**. Seems, its IP stack uses a corrupted clock source, which is synchronized to time-of-day clock periodically and jumps randomly making timestamps mostly useless. Good news is that you can use NTP in this case, which is even better.

·
**clockdiff**
shows difference in time modulo 24 days.

<a name="see-also"></a>

# See Also


**ping**(8),
**arping**(8),
**tracepath**(8).

<a name="references"></a>

# References


[1] ICMP ECHO, RFC0792, page 14.

[2] ICMP TIMESTAMP, RFC0792, page 16.

[3] IP TIMESTAMP option, RFC0791, 3.1, page 16.

<a name="author"></a>

# Author


**clockdiff**
was compiled by Alexey Kuznetsov &lt;[kuznet@ms2.inr](mailto:kuznet@ms2.inr).ac.ru&gt;. It was based on code borrowed from BSD
**timed**
daemon.

<a name="security"></a>

# Security


**clockdiff**
requires CAP_NET_RAW capability to be executed. It is safe to be used as set-uid root.

<a name="availability"></a>

# Availability


**clockdiff**
is part of
_iputils_
package.
