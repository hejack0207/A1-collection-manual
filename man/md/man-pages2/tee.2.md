# tee(2) - duplicating pipe content

Linux, 2017-09-15

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <fcntl.h>
    
    ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags);


<a name="description"></a>

# Description







**tee**()
duplicates up to
_len_
bytes of data from the pipe referred to by the file descriptor
_fd_in_
to the pipe referred to by the file descriptor
_fd_out_.
It does not consume the data that is duplicated from
_fd_in_;
therefore, that data can be copied by a subsequent
**splice**(2).

_flags_
is a bit mask that is composed by ORing together
zero or more of the following values:

* **SPLICE_F_MOVE**  
  Currently has no effect for
  **tee**();
  see
  **splice**(2).
* **SPLICE_F_NONBLOCK**  
  Do not block on I/O; see
  **splice**(2)
  for further details.
* **SPLICE_F_MORE**  
  Currently has no effect for
  **tee**(),
  but may be implemented in the future; see
  **splice**(2).
* **SPLICE_F_GIFT**  
  Unused for
  **tee**();
  see
  **vmsplice**(2).

<a name="return-value"></a>

# Return Value

Upon successful completion,
**tee**()
returns the number of bytes that were duplicated between the input
and output.
A return value of 0 means that there was no data to transfer,
and it would not make sense to block, because there are no
writers connected to the write end of the pipe referred to by
_fd_in_.

On error,
**tee**()
returns -1 and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  **SPLICE_F_NONBLOCK**
  was specified in
  _flags_,
  and the operation would block.
* **EINVAL**  
  _fd_in_
  or
  _fd_out_
  does not refer to a pipe; or
  _fd_in_
  and
  _fd_out_
  refer to the same pipe.
* **ENOMEM**  
  Out of memory.

<a name="versions"></a>

# Versions

The
**tee**()
system call first appeared in Linux 2.6.17;
library support was added to glibc in version 2.5.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

Conceptually,
**tee**()
copies the data between the two pipes.
In reality no real data copying takes place though:
under the covers,
**tee**()
assigns data to the output by merely grabbing
a reference to the input.

<a name="example"></a>

# Example

The example below implements a basic
**tee**(1)
program using the
**tee**()
system call.
Here is an example of its use:

.in +4n
.EX
$ **date |./a.out out.log | cat**
Tue Oct 28 10:06:00 CET 2014
$ **cat out.log**
Tue Oct 28 10:06:00 CET 2014
.EE
.in

<a name="program-source"></a>

### Program source


.EX
#define _GNU_SOURCE
#include &lt;fcntl.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;unistd.h&gt;
#include &lt;errno.h&gt;
#include &lt;limits.h&gt;

int
main(int argc, char *argv[])
{
    int fd;
    int len, slen;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s &lt;file&gt;\\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    do {
        /*
         * tee stdin to stdout.
         */
        len = tee(STDIN_FILENO, STDOUT_FILENO,
                  INT_MAX, SPLICE_F_NONBLOCK);

        if (len &lt; 0) {
            if (errno == EAGAIN)
                continue;
            perror("tee");
            exit(EXIT_FAILURE);
        } else
            if (len == 0)
                break;

        /*
         * Consume stdin by splicing it to a file.
         */
        while (len &gt; 0) {
            slen = splice(STDIN_FILENO, NULL, fd, NULL,
                          len, SPLICE_F_MOVE);
            if (slen &lt; 0) {
                perror("splice");
                break;
            }
            len -= slen;
        }
    } while (1);

    close(fd);
    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**splice**(2),
**vmsplice**(2),
**pipe**(7)

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
