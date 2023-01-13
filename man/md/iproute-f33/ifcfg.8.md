# ifcfg(8) - simplistic script which replaces ifconfig IP management

iproute2, September 24 2009

```
.in +8 .ti -8 ifcfg [ DEVICE ] [ command ] ADDRESS [ PEER ]  

```


<a name="description"></a>

# Description

This manual page documents briefly the
**ifcfg**
command.

This is a simplistic script replacing one option of
**ifconfig**
, namely, IP address management. It not only adds
addresses, but also carries out Duplicate Address Detection RFC-DHCP,
sends unsolicited ARP to update the caches of other hosts sharing
the interface, adds some control routes and restarts Router Discovery
when it is necessary.


<a name="ifconfig-command-syntax"></a>

# Ifconfig - Command Syntax


.SS

* **DEVICE**  
  - it may have alias, suffix, separated by colon.
  
* **command**  
  - add, delete or stop.
  
* **ADDRESS**  
  - optionally followed by prefix length.
  
* **peer**  
  - optional peer address for pointpoint interfaces.
  

<a name="notes"></a>

# Notes

This script is not suitable for use with IPv6.


<a name="see-also"></a>

# See Also

IP Command reference **ip-cref.ps**
