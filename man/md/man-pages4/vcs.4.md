# vcs(4) - virtual console memory

Linux, 2017-05-03


<a name="description"></a>

# Description

_/dev/vcs0_
is a character device with major number 7 and minor number
0, usually of mode 0644 and owner root.tty.
It refers to the memory of the currently
displayed virtual console terminal.

_/dev/vcs[1-63]_
are character devices for virtual console
terminals, they have major number 7 and minor number 1 to 63, usually
mode 0644 and owner root.tty.
_/dev/vcsa[0-63]_
are the same, but
using
_unsigned short_s
(in host byte order) that include attributes,
and prefixed with four bytes giving the screen
dimensions and cursor position:
_lines_,
_columns_,
_x_,
_y_.
(_x_
=
_y_
= 0 at the top left corner of the screen.)

When a 512-character font is loaded,
the 9th bit position can be fetched by applying the
**ioctl**(2)
**VT_GETHIFONTMASK**
operation
(available in Linux kernels 2.6.18 and above)
on
_/dev/tty[1-63]_;
the value is returned in the
_unsigned short_
pointed to by the third
**ioctl**(2)
argument.

These devices replace the screendump
**ioctl**(2)
operations of
**ioctl_console**(2),
so the system
administrator can control access using filesystem permissions.

The devices for the first eight virtual consoles may be created by:

.in +4n
.EX
for x in 0 1 2 3 4 5 6 7 8; do
    mknod -m 644 /dev/vcs$x c 7 $x;
    mknod -m 644 /dev/vcsa$x c 7 $[$x+128];
done
chown root:tty /dev/vcs*
.EE
.in

No
**ioctl**(2)
requests are supported.

<a name="files"></a>

# Files

_/dev/vcs[0-63]_  
_/dev/vcsa[0-63]_



<a name="versions"></a>

# Versions

Introduced with version 1.1.92 of the Linux kernel.

<a name="example"></a>

# Example

You may do a screendump on vt3 by switching to vt1 and typing

    cat /dev/vcs3 &gt;foo

Note that the output does not contain
newline characters, so some processing may be required, like
in

    fold -w 81 /dev/vcs3 | lpr

or (horrors)

    xetterm -dump 3 -file /proc/self/fd/1

The
_/dev/vcsa0_
device is used for Braille support.

This program displays the character and screen attributes under the
cursor of the second virtual console, then changes the background color
there:

.EX
#include &lt;unistd.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;stdio.h&gt;
#include &lt;fcntl.h&gt;
#include &lt;sys/ioctl.h&gt;
#include &lt;linux/vt.h&gt;

int
main(void)
{
    int fd;
    char *device = "/dev/vcsa2";
    char *console = "/dev/tty2";
    struct {unsigned char lines, cols, x, y;} scrn;
    unsigned short s;
    unsigned short mask;
    unsigned char ch, attrib;

    fd = open(console, O_RDWR);
    if (fd &lt; 0) {
        perror(console);
        exit(EXIT_FAILURE);
    }
    if (ioctl(fd, VT_GETHIFONTMASK, &mask) &lt; 0) {
        perror("VT_GETHIFONTMASK");
        exit(EXIT_FAILURE);
    }
    (void) close(fd);
    fd = open(device, O_RDWR);
    if (fd &lt; 0) {
        perror(device);
        exit(EXIT_FAILURE);
    }
    (void) read(fd, &scrn, 4);
    (void) lseek(fd, 4 + 2*(scrn.y*scrn.cols + scrn.x), 0);
    (void) read(fd, &s, 2);
    ch = s & 0xff;
    if (attrib & mask)
        ch |= 0x100;
    attrib = ((s & ~mask) &gt;&gt; 8);
    printf("ch='%c' attrib=0x%02x\\n", ch, attrib);
    attrib ^= 0x10;
    (void) lseek(fd, -1, 1);
    (void) write(fd, &attrib, 1);
    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**ioctl_console**(2),
**tty**(4),
**ttyS**(4),
**gpm**(8)

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
