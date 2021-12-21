# iptunnel(8)

"", SEPTEMBER 2009

**iptunnel**
- creates, deletes, and displays configured tunnels


<a name="synopsis"></a>

# Synopsis

```
/usr/sbin/iptunnel [<operation>] [<args>]
```


<a name="note"></a>

# Note


This program is obsolete. For replacement check **ip tunnel**.


<a name="description"></a>

# Description

The **iptunnel**
command creates configured tunnels for sending and receiving
IPV6 or IPV4 packets that are encapsulated as the payload of an IPV4
datagram.

The
**iptunnel**
command can perform one of the following operations:

**create**
- create a tunnel interface, which you must subsequently configure.

**delete**
- delete a tunnel interface. You must disable the tunnel before you can delete it.

**show**
- show the tunnel attributes (name, tunnel end points, next hop for tunneled packets).


<a name="see-also"></a>

# See Also

**ip**(8).
