# sendmmsg(2) - send multiple messages on a socket

Linux, 2018-02-02

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <sys/socket.h>
    
    int sendmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
                 int flags);

<a name="description"></a>

# Description

The
**sendmmsg**()
system call is an extension of
**sendmsg**(2)
that allows the caller to transmit multiple messages on a socket
using a single system call.
(This has performance benefits for some applications.)


The
_sockfd_
argument is the file descriptor of the socket
on which data is to be transmitted.

The
_msgvec_
argument is a pointer to an array of
_mmsghdr_
structures.
The size of this array is specified in
_vlen_.

The
_mmsghdr_
structure is defined in
_&lt;sys/socket.h&gt;_
as:

.in +4n
.EX
struct mmsghdr {
    struct msghdr msg_hdr;  /* Message header */
    unsigned int  msg_len;  /* Number of bytes transmitted */
};
.EE
.in

The
_msg_hdr_
field is a
_msghdr_
structure, as described in
**sendmsg**(2).
The
_msg_len_
field is used to return the number of bytes sent from the message in
_msg_hdr_
(i.e., the same as the return value from a single
**sendmsg**(2)
call).

The
_flags_
argument contains flags ORed together.
The flags are the same as for
**sendmsg**(2).

A blocking
**sendmmsg**()
call blocks until
_vlen_
messages have been sent.
A nonblocking call sends as many messages as possible
(up to the limit specified by
_vlen_)
and returns immediately.

On return from
**sendmmsg**(),
the
_msg_len_
fields of successive elements of
_msgvec_
are updated to contain the number of bytes transmitted from the corresponding
_msg_hdr_.
The return value of the call indicates the number of elements of
_msgvec_
that have been updated.

<a name="return-value"></a>

# Return Value

On success,
**sendmmsg**()
returns the number of messages sent from
_msgvec_;
if this is less than
_vlen_,
the caller can retry with a further
**sendmmsg**()
call to send the remaining messages.

On error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors

Errors are as for
**sendmsg**(2).
An error is returned only if no datagrams could be sent.
See also BUGS.









<a name="versions"></a>

# Versions

The
**sendmmsg**()
system call was added in Linux 3.0.
Support in glibc was added in version 2.14.

<a name="conforming-to"></a>

# Conforming to

**sendmmsg**()
is Linux-specific.

<a name="notes"></a>

# Notes

The value specified in
_vlen_
is capped to
**UIO_MAXIOV**
(1024).










<a name="bugs"></a>

# Bugs

If an error occurs after at least one message has been sent,
the call succeeds, and returns the number of messages sent.
The error code is lost.
The caller can retry the transmission,
starting at the first failed message, but there is no guarantee that,
if an error is returned, it will be the same as the one that was lost
on the previous call.

<a name="example"></a>

# Example

The example below uses
**sendmmsg**()
to send
_onetwo_
and
_three_
in two distinct UDP datagrams using one system call.
The contents of the first datagram originates from a pair of buffers.

.EX
#define _GNU_SOURCE
#include &lt;netinet/ip.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;string.h&gt;
#include &lt;sys/types.h&gt;
#include &lt;sys/socket.h&gt;

int
main(void)
{
    int sockfd;
    struct sockaddr_in addr;
    struct mmsghdr msg[2];
    struct iovec msg1[2], msg2;
    int retval;

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1) {
        perror("socket()");
        exit(EXIT_FAILURE);
    }

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    addr.sin_port = htons(1234);
    if (connect(sockfd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
        perror("connect()");
        exit(EXIT_FAILURE);
    }

    memset(msg1, 0, sizeof(msg1));
    msg1[0].iov_base = "one";
    msg1[0].iov_len = 3;
    msg1[1].iov_base = "two";
    msg1[1].iov_len = 3;

    memset(&msg2, 0, sizeof(msg2));
    msg2.iov_base = "three";
    msg2.iov_len = 5;

    memset(msg, 0, sizeof(msg));
    msg[0].msg_hdr.msg_iov = msg1;
    msg[0].msg_hdr.msg_iovlen = 2;

    msg[1].msg_hdr.msg_iov = &msg2;
    msg[1].msg_hdr.msg_iovlen = 1;

    retval = sendmmsg(sockfd, msg, 2, 0);
    if (retval == -1)
        perror("sendmmsg()");
    else
        printf("%d messages sent\\n", retval);

    exit(0);
}
.EE

<a name="see-also"></a>

# See Also

**recvmmsg**(2),
**sendmsg**(2),
**socket**(2),
**socket**(7)

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
