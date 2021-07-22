# recvmmsg(2) - receive multiple messages on a socket

Linux, 2018-02-02

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <sys/socket.h>
    
    int recvmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
                 int flags, struct timespec *timeout);

<a name="description"></a>

# Description

The
**recvmmsg**()
system call is an extension of
**recvmsg**(2)
that allows the caller to receive multiple messages from a socket
using a single system call.
(This has performance benefits for some applications.)
A further extension over
**recvmsg**(2)
is support for a timeout on the receive operation.

The
_sockfd_
argument is the file descriptor of the socket to receive data from.

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
    unsigned int  msg_len;  /* Number of received bytes for header */
};
.EE
.in

The
_msg_hdr_
field is a
_msghdr_
structure, as described in
**recvmsg**(2).
The
_msg_len_
field is the number of bytes returned for the message in the entry.
This field has the same value as the return value of a single
**recvmsg**(2)
on the header.

The
_flags_
argument contains flags ORed together.
The flags are the same as documented for
**recvmsg**(2),
with the following addition:

* **MSG_WAITFORONE** (since Linux 2.6.34)  
  Turns on
  **MSG_DONTWAIT**
  after the first message has been received.

The
_timeout_
argument points to a
_struct timespec_
(see
**clock_gettime**(2))
defining a timeout (seconds plus nanoseconds) for the receive operation
(_but see BUGS!_).
(This interval will be rounded up to the system clock granularity,
and kernel scheduling delays mean that the blocking interval
may overrun by a small amount.)
If
_timeout_
is NULL, then the operation blocks indefinitely.

A blocking
**recvmmsg**()
call blocks until
_vlen_
messages have been received
or until the timeout expires.
A nonblocking call reads as many messages as are available
(up to the limit specified by
_vlen_)
and returns immediately.

On return from
**recvmmsg**(),
successive elements of
_msgvec_
are updated to contain information about each received message:
_msg_len_
contains the size of the received message;
the subfields of
_msg_hdr_
are updated as described in
**recvmsg**(2).
The return value of the call indicates the number of elements of
_msgvec_
that have been updated.

<a name="return-value"></a>

# Return Value

On success,
**recvmmsg**()
returns the number of messages received in
_msgvec_;
on error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors

Errors are as for
**recvmsg**(2).
In addition, the following error can occur:

* **EINVAL**  
  _timeout_
  is invalid.

See also BUGS.

<a name="versions"></a>

# Versions

The
**recvmmsg**()
system call was added in Linux 2.6.33.
Support in glibc was added in version 2.12.

<a name="conforming-to"></a>

# Conforming to

**recvmmsg**()
is Linux-specific.

<a name="bugs"></a>

# Bugs

The
_timeout_
argument does not work as intended.


The timeout is checked only after the receipt of each datagram,
so that if up to
_vlen-1_
datagrams are received before the timeout expires,
but then no further datagrams are received, the call will block forever.

If an error occurs after at least one message has been received,
the call succeeds, and returns the number of messages received.
The error code is expected to be returned on a subsequent call to
**recvmmsg**().
In the current implementation, however, the error code can be overwritten
in the meantime by an unrelated network event on a socket,
for example an incoming ICMP packet.

<a name="example"></a>

# Example


The following program uses
**recvmmsg**()
to receive multiple messages on a socket and stores
them in multiple buffers.
The call returns if all buffers are filled or if the
timeout specified has expired.

The following snippet periodically generates UDP datagrams
containing a random number:

.in +4n
.EX
$** while true; do echo $RANDOM &gt; /dev/udp/127.0.0.1/1234; **
**      sleep 0.25; done**
.EE
.in

These datagrams are read by the example application, which
can give the following output:

.in +4n
.EX
$** ./a.out**
5 messages received
1 11782
2 11345
3 304
4 13514
5 28421
.EE
.in

<a name="program-source"></a>

### Program source


.EX
#define _GNU_SOURCE
#include &lt;netinet/ip.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;string.h&gt;
#include &lt;sys/socket.h&gt;

int
main(void)
{
#define VLEN 10
#define BUFSIZE 200
#define TIMEOUT 1
    int sockfd, retval, i;
    struct sockaddr_in addr;
    struct mmsghdr msgs[VLEN];
    struct iovec iovecs[VLEN];
    char bufs[VLEN][BUFSIZE+1];
    struct timespec timeout;

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1) {
        perror("socket()");
        exit(EXIT_FAILURE);
    }

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    addr.sin_port = htons(1234);
    if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
        perror("bind()");
        exit(EXIT_FAILURE);
    }

    memset(msgs, 0, sizeof(msgs));
    for (i = 0; i &lt; VLEN; i++) {
        iovecs[i].iov_base         = bufs[i];
        iovecs[i].iov_len          = BUFSIZE;
        msgs[i].msg_hdr.msg_iov    = &iovecs[i];
        msgs[i].msg_hdr.msg_iovlen = 1;
    }

    timeout.tv_sec = TIMEOUT;
    timeout.tv_nsec = 0;

    retval = recvmmsg(sockfd, msgs, VLEN, 0, &timeout);
    if (retval == -1) {
        perror("recvmmsg()");
        exit(EXIT_FAILURE);
    }

    printf("%d messages received\\n", retval);
    for (i = 0; i &lt; retval; i++) {
        bufs[i][msgs[i].msg_len] = 0;
        printf("%d %s", i+1, bufs[i]);
    }
    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**clock_gettime**(2),
**recvmsg**(2),
**sendmmsg**(2),
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
