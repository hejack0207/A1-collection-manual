# rtmon(8) - listens to and monitors RTnetlink

```
rtmon [ options ] file FILE [ all | LISTofOBJECTS ]
```

<a name="description"></a>

# Description

This manual page documents briefly the
**rtmon**
command.

**rtmon**
listens on
_netlink_
socket and monitors routing table changes.

_rtmon_
can be started before the first network configuration command is issued.
For example if you insert:

**rtmon file /var/log/rtmon.log**

in a startup script, you will be able to view the full history later.
Certainly, it is possible to start rtmon at any time. It prepends the history with the state snapshot dumped at the moment of starting.


<a name="options"></a>

# Options

_rtmon supports the following options:_

* **-Version**  
  Print version and exit.
* **help**  
  Show summary of options.
* **file FILE [ all | LISTofOBJECTS ]**  
  Log output to FILE. LISTofOBJECTS is the list of object types that we
  want to monitor. It may contain 'link', 'address', 'route'
  and 'all'. 'link' specifies the network device, 'address' the protocol
  (IP or IPv6) address on a device, 'route' the routing table entry
  and 'all' does what the name says.
* **-family [ inet | inet6 | link | help ]**  
  Specify protocol family. 'inet' is IPv4, 'inet6' is IPv6, 'link'
  means that no networking protocol is involved and 'help' prints usage information.
* **-4**  
  Use IPv4. Shortcut for -family inet.
* **-6**  
  Use IPv6. Shortcut for -family inet6.
* **-0**  
  Use a special family identifier meaning that no networking protocol is involved. Shortcut for -family link.

<a name="usage-examples"></a>

# Usage Examples


* **# rtmon file /var/log/rtmon.log**  
  Log to file /var/log/rtmon.log, then run:
* **# ip monitor file /var/log/rtmon.log**  
  to display logged output from file.

<a name="see-also"></a>

# See Also

**ip**(8)

<a name="author"></a>

# Author

**rtmon**
was written by Alexey Kuznetsov &lt;[kuznet@ms2.inr](mailto:kuznet@ms2.inr).ac.ru&gt;.

This manual page was written by Michael Prokop &lt;[mika@grml.org](mailto:mika@grml.org)&gt;,
for the Debian project (but may be used by others).
