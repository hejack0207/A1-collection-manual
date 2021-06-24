# netlink(3) - Netlink macros

GNU, 2014-03-20

    #include <asm/types.h>
    #include <linux/netlink.h>
    
    int NLMSG_ALIGN(size_t len);
    int NLMSG_LENGTH(size_t len);
    int NLMSG_SPACE(size_t len);
    void *NLMSG_DATA(struct nlmsghdr *nlh);
    struct nlmsghdr *NLMSG_NEXT(struct nlmsghdr *nlh, int len);
    int NLMSG_OK(struct nlmsghdr *nlh, int len);
    int NLMSG_PAYLOAD(struct nlmsghdr *nlh, int len);

<a name="description"></a>

# Description

_&lt;linux/netlink.h&gt;_
defines several standard macros to access or create a netlink datagram.
They are similar in spirit to the macros defined in
**cmsg**(3)
for auxiliary data.
The buffer passed to and from a netlink socket should
be accessed using only these macros.

* **NLMSG_ALIGN**()  
  Round the length of a netlink message up to align it properly.
* **NLMSG_LENGTH**()  
  Given the payload length,
  _len_,
  this macro returns the aligned length to store in the
  _nlmsg_len_
  field of the
  _nlmsghdr_.
* **NLMSG_SPACE**()  
  Return the number of bytes that a netlink message with payload of
  _len_
  would occupy.
* **NLMSG_DATA**()  
  Return a pointer to the payload associated with the passed
  _nlmsghdr_.
*   
  **NLMSG_NEXT**()
  Get the next
  _nlmsghdr_
  in a multipart message.
  The caller must check if the current
  _nlmsghdr_
  didn't have the
  **NLMSG_DONE**
  set—this function doesn't return NULL on end.
  The
  _len_
  argument is an lvalue containing the remaining length
  of the message buffer.
  This macro decrements it by the length of the message header.
* **NLMSG_OK**()  
  Return true if the netlink message is not truncated and
  is in a form suitable for parsing.
* **NLMSG_PAYLOAD**()  
  Return the length of the payload associated with the
  _nlmsghdr_.

<a name="conforming-to"></a>

# Conforming to

These macros are nonstandard Linux extensions.

<a name="notes"></a>

# Notes

It is often better to use netlink via
_libnetlink_
than via the low-level kernel interface.

<a name="see-also"></a>

# See Also

**libnetlink**(3),
**netlink**(7)

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
