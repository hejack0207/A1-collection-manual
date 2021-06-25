# rtnetlink(3) - macros to manipulate rtnetlink messages

GNU, 2014-09-06

```
#include <asm/types.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <sys/socket.h> 
 rtnetlink_socket = socket(AF_NETLINK, int socket_type, NETLINK_ROUTE); 
 int RTA_OK(struct rtattr *rta, int rtabuflen); 
 void *RTA_DATA(struct rtattr *rta); 
 unsigned int RTA_PAYLOAD(struct rtattr *rta); 
 struct rtattr *RTA_NEXT(struct rtattr *rta, unsigned int rtabuflen); 
 unsigned int RTA_LENGTH(unsigned int length); 
 unsigned int RTA_SPACE(unsigned int length);
```

<a name="description"></a>

# Description

All
**rtnetlink**(7)
messages consist of a
**netlink**(7)
message header and appended attributes.
The attributes should be manipulated only using the macros provided here.

**RTA_OK(**_rta_**, **_attrlen_**)**
returns true if
_rta_
points to a valid routing attribute;
_attrlen_
is the running length of the attribute buffer.
When not true then you must assume there are no more attributes in the
message, even if
_attrlen_
is nonzero.

**RTA_DATA(**_rta_**)**
returns a pointer to the start of this attribute's data.

**RTA_PAYLOAD(**_rta_**)**
returns the length of this attribute's data.

**RTA_NEXT(**_rta_**, **_attrlen_**)**
gets the next attribute after
_rta_.
Calling this macro will update
_attrlen_.
You should use
**RTA_OK**
to check the validity of the returned pointer.

**RTA_LENGTH(**_len_**)**
returns the length which is required for
_len_
bytes of data plus the header.

**RTA_SPACE(**_len_**)**
returns the amount of space which will be needed in a message with
_len_
bytes of data.

<a name="conforming-to"></a>

# Conforming to

These macros are nonstandard Linux extensions.

<a name="bugs"></a>

# Bugs

This manual page is incomplete.

<a name="example"></a>

# Example


Creating a rtnetlink message to set the MTU of a device:

.in +4n
.EX
#include &lt;linux/rtnetlink.h&gt;

...

struct {
    struct nlmsghdr  nh;
    struct ifinfomsg if;
    char             attrbuf[512];
} req;

struct rtattr *rta;
unsigned int mtu = 1000;

int rtnetlink_sk = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);

memset(&req, 0, sizeof(req));
req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
req.nh.nlmsg_flags = NLM_F_REQUEST;
req.nh.nlmsg_type = RTM_NEWLINK;
req.if.ifi_family = AF_UNSPEC;
req.if.ifi_index = INTERFACE_INDEX;
req.if.ifi_change = 0xffffffff; /* ??? */
rta = (struct rtattr *)(((char *) &req) +
                         NLMSG_ALIGN(req.nh.nlmsg_len));
rta-&gt;rta_type = IFLA_MTU;
rta-&gt;rta_len = RTA_LENGTH(sizeof(unsigned int));
req.nh.nlmsg_len = NLMSG_ALIGN(req.nh.nlmsg_len) +
                              RTA_LENGTH(sizeof(mtu));
memcpy(RTA_DATA(rta), &mtu, sizeof(mtu));
send(rtnetlink_sk, &req, req.nh.nlmsg_len, 0);
.EE
.in

<a name="see-also"></a>

# See Also

**netlink**(3),
**netlink**(7),
**rtnetlink**(7)

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
