# ioctl_tty(2) - ioctls for terminals and serial lines

Linux, 2017-09-15

```
"#include <termios.h>" 
 int ioctl(int fd, int cmd, ...);
```

<a name="description"></a>

# Description

The
**ioctl**(2)
call for terminals and serial ports accepts many possible command arguments.
Most require a third argument, of varying type, here called
_argp_
or
_arg_.

Use of
_ioctl_
makes for nonportable programs.
Use the POSIX interface described in
**termios**(3)
whenever possible.

<a name="get-and-set-terminal-attributes"></a>

### Get and set terminal attributes


* **TCGETS	struct termios ***_argp_  
  Equivalent to
  _tcgetattr(fd, argp)_.  
  Get the current serial port settings.
* **TCSETS	const struct termios ***_argp_  
  Equivalent to
  _tcsetattr(fd, TCSANOW, argp)_.  
  Set the current serial port settings.
* **TCSETSW	const struct termios ***_argp_  
  Equivalent to
  _tcsetattr(fd, TCSADRAIN, argp)_.  
  Allow the output buffer to drain, and
  set the current serial port settings.
* **TCSETSF	const struct termios ***_argp_  
  Equivalent to
  _tcsetattr(fd, TCSAFLUSH, argp)_.  
  Allow the output buffer to drain, discard pending input, and
  set the current serial port settings.

The following four ioctls are just like
**TCGETS**,
**TCSETS**,
**TCSETSW**,
**TCSETSF**,
except that they take a
_struct termio&nbsp;*_
instead of a
_struct termios&nbsp;*_.

* **TCGETA	struct termio ***_argp_
* **TCSETA	const struct termio ***_argp_
* **TCSETAW	const struct termio ***_argp_
* **TCSETAF	const struct termio ***_argp_

<a name="locking-the-termios-structure"></a>

### Locking the termios structure

The
_termios_
structure of a terminal can be locked.
The lock is itself a
_termios_
structure, with nonzero bits or fields indicating a
locked value.

* **TIOCGLCKTRMIOS	struct termios ***_argp_  
  Gets the locking status of the
  _termios_
  structure of the terminal.
* **TIOCSLCKTRMIOS	const struct termios ***_argp_  
  Sets the locking status of the
  _termios_
  structure of the terminal.
  Only a process with the
  **CAP_SYS_ADMIN**
  capability can do this.

<a name="get-and-set-window-size"></a>

### Get and set window size

Window sizes are kept in the kernel, but not used by the kernel
(except in the case of virtual consoles, where the kernel will
update the window size when the size of the virtual console changes,
for example, by loading a new font).

The following constants and structure are defined in
_&lt;sys/ioctl.h&gt;_.

* **TIOCGWINSZ	struct winsize ***_argp_  
  Get window size.
* **TIOCSWINSZ	const struct winsize ***_argp_  
  Set window size.

The struct used by these ioctls is defined as

.in +4n
.EX
struct winsize {
    unsigned short ws_row;
    unsigned short ws_col;
    unsigned short ws_xpixel;   /* unused */
    unsigned short ws_ypixel;   /* unused */
};
.EE
.in

When the window size changes, a
**SIGWINCH**
signal is sent to the
foreground process group.

<a name="sending-a-break"></a>

### Sending a break


* **TCSBRK	int **_arg_  
  Equivalent to
  _tcsendbreak(fd, arg)_.  
  If the terminal is using asynchronous serial data transmission, and
  _arg_
  is zero, then send a break (a stream of zero bits) for between
  0.25 and 0.5 seconds.
  If the terminal is not using asynchronous
  serial data transmission, then either a break is sent, or the function
  returns without doing anything.
  When
  _arg_
  is nonzero, nobody knows what will happen.
* (SVr4, UnixWare, Solaris, Linux treat
  _tcsendbreak(fd,arg)_
  with nonzero
  _arg_
  like
  _tcdrain(fd)_.
  SunOS treats
  _arg_
  as a multiplier, and sends a stream of bits
  _arg_
  times as long as done for zero
  _arg_.
  DG/UX and AIX treat
  _arg_
  (when nonzero) as a time interval measured in milliseconds.
  HP-UX ignores
  _arg_.)
* **TCSBRKP	int **_arg_  
  So-called "POSIX version" of
  **TCSBRK**.
  It treats nonzero
  _arg_
  as a timeinterval measured in deciseconds, and does nothing
  when the driver does not support breaks.
* **TIOCSBRK	void**  
  Turn break on, that is, start sending zero bits.
* **TIOCCBRK	void**  
  Turn break off, that is, stop sending zero bits.

<a name="software-flow-control"></a>

### Software flow control


* **TCXONC	int **_arg_  
  Equivalent to
  _tcflow(fd, arg)_.  
  See
  **tcflow**(3)
  for the argument values
  **TCOOFF**,
  **TCOON**,
  **TCIOFF**,
  **TCION**.

<a name="buffer-count-and-flushing"></a>

### Buffer count and flushing


* **FIONREAD	int ***_argp_  
  Get the number of bytes in the input buffer.
* **TIOCINQ	int ***_argp_  
  Same as
  **FIONREAD**.
* **TIOCOUTQ	int ***_argp_  
  Get the number of bytes in the output buffer.
* **TCFLSH	int **_arg_  
  Equivalent to
  _tcflush(fd, arg)_.  
  See
  **tcflush**(3)
  for the argument values
  **TCIFLUSH**,
  **TCOFLUSH**,
  **TCIOFLUSH**.

<a name="faking-input"></a>

### Faking input


* **TIOCSTI	const char ***_argp_  
  Insert the given byte in the input queue.

<a name="redirecting-console-output"></a>

### Redirecting console output


* **TIOCCONS	void**  
  Redirect output that would have gone to
  _/dev/console_
  or
  _/dev/tty0_
  to the given terminal.
  If that was a pseudoterminal master, send it to the slave.
  In Linux before version 2.6.10,
  anybody can do this as long as the output was not redirected yet;
  since version 2.6.10, only a process with the
  **CAP_SYS_ADMIN**
  capability may do this.
  If output was redirected already
  **EBUSY**
  is returned,
  but redirection can be stopped by using this ioctl with
  _fd_
  pointing at
  _/dev/console_
  or
  _/dev/tty0_.

<a name="controlling-terminal"></a>

### Controlling terminal


* **TIOCSCTTY	int **_arg_  
  Make the given terminal the controlling terminal of the calling process.
  The calling process must be a session leader and not have a
  controlling terminal already.
  For this case,
  _arg_
  should be specified as zero.
* If this terminal is already the controlling terminal
  of a different session group, then the ioctl fails with
  **EPERM**,
  unless the caller has the
  **CAP_SYS_ADMIN**
  capability and
  _arg_
  equals 1, in which case the terminal is stolen, and all processes that had
  it as controlling terminal lose it.
* **TIOCNOTTY	void**  
  If the given terminal was the controlling terminal of the calling process,
  give up this controlling terminal.
  If the process was session leader,
  then send
  **SIGHUP**
  and
  **SIGCONT**
  to the foreground process group
  and all processes in the current session lose their controlling terminal.

<a name="process-group-and-session-id"></a>

### Process group and session ID


* **TIOCGPGRP	pid_t ***_argp_  
  When successful, equivalent to
  _*argp = tcgetpgrp(fd)_.  
  Get the process group ID of the foreground process group on this terminal.
* **TIOCSPGRP	const pid_t ***_argp_  
  Equivalent to
  _tcsetpgrp(fd, *argp)_.  
  Set the foreground process group ID of this terminal.
* **TIOCGSID	pid_t ***_argp_  
  Get the session ID of the given terminal.
  This fails with the error
  **ENOTTY**
  if the terminal is not a master pseudoterminal
  and not our controlling terminal.
  Strange.

<a name="exclusive-mode"></a>

### Exclusive mode


* **TIOCEXCL	void**  
  Put the terminal into exclusive mode.
  No further
  **open**(2)
  operations on the terminal are permitted.
  (They fail with
  **EBUSY**,
  except for a process with the
  **CAP_SYS_ADMIN**
  capability.)
* **TIOCGEXCL	int ***_argp_  
  (since Linux 3.8)
  If the terminal is currently in exclusive mode,
  place a nonzero value in the location pointed to by
  _argp_;
  otherwise, place zero in
  _*argp_.
* **TIOCNXCL	void**  
  Disable exclusive mode.

<a name="line-discipline"></a>

### Line discipline


* **TIOCGETD	int ***_argp_  
  Get the line discipline of the terminal.
* **TIOCSETD	const int ***_argp_  
  Set the line discipline of the terminal.

<a name="pseudoterminal-ioctls"></a>

### Pseudoterminal ioctls


* **TIOCPKT	const int ***_argp_  
  Enable (when
  *_argp_
  is nonzero) or disable packet mode.
  Can be applied to the master side of a pseudoterminal only (and will return
  **ENOTTY**
  otherwise).
  In packet mode, each subsequent
  **read**(2)
  will return a packet that either contains a single nonzero control byte,
  or has a single byte containing zero ('\0') followed by data
  written on the slave side of the pseudoterminal.
  If the first byte is not
  **TIOCPKT_DATA**
  (0), it is an OR of one
  or more of the following bits:
*     TIOCPKT_FLUSHREAD   The read queue for the terminal is flushed.
    TIOCPKT_FLUSHWRITE  The write queue for the terminal is flushed.
    TIOCPKT_STOP        Output to the terminal is stopped.
    TIOCPKT_START       Output to the terminal is restarted.
    TIOCPKT_DOSTOP      The start and stop characters are ^S/^Q.
    TIOCPKT_NOSTOP      The start and stop characters are not ^S/^Q.
* While this mode is in use, the presence
  of control status information to be read
  from the master side may be detected by a
  **select**(2)
  for exceptional conditions or a
  **poll**(2)
  for the
  _POLLPRI_
  event.
* This mode is used by
  **rlogin**(1)
  and
  **rlogind**(8)
  to implement a remote-echoed,
  locally **^S**/**^Q** flow-controlled remote login.
* **TIOCGPKT	const int ***_argp_  
  (since Linux 3.8)
  Return the current packet mode setting in the integer pointed to by
  _argp_.
* **TIOCSPTLCK	int ***_argp_  
  Set (if
  _*argp_
  is nonzero) or remove (if
  _*argp_
  is zero) the pseudoterminal slave device.
  (See also
  **unlockpt**(3).)
* **TIOCGPTLCK	int ***_argp_  
  (since Linux 3.8)
  Place the current lock state of the pseudoterminal slave device
  in the location pointed to by
  _argp_.
* **TIOCGPTPEER	int **_flags_  
  
  (since Linux 4.13)
  Given a file descriptor in
  _fd_
  that refers to a pseudoterminal master,
  open (with the given
  **open**(2)-style
  _flags_)
  and return a new file descriptor that refers to the peer
  pseudoterminal slave device.
  This operation can be performed
  regardless of whether the pathname of the slave device
  is accessible through the calling process's mount namespace.
* Security-conscious programs interacting with namespaces may wish to use this
  operation rather than
  **open**(2)
  with the pathname returned by
  **ptsname**(3),
  and similar library functions that have insecure APIs.
  (For example, confusion can occur in some cases using
  **ptsname**(3)
  with a pathname where a devpts filesystem
  has been mounted in a different mount namespace.)

The BSD ioctls
**TIOCSTOP**,
**TIOCSTART**,
**TIOCUCNTL**,
**TIOCREMOTE**
have not been implemented under Linux.

<a name="modem-control"></a>

### Modem control


* **TIOCMGET	int ***_argp_  
  Get the status of modem bits.
* **TIOCMSET	const int ***_argp_  
  Set the status of modem bits.
* **TIOCMBIC	const int ***_argp_  
  Clear the indicated modem bits.
* **TIOCMBIS	const int ***_argp_  
  Set the indicated modem bits.

The following bits are used by the above ioctls:

    TIOCM_LE        DSR (data set ready/line enable)
    TIOCM_DTR       DTR (data terminal ready)
    TIOCM_RTS       RTS (request to send)
    TIOCM_ST        Secondary TXD (transmit)
    TIOCM_SR        Secondary RXD (receive)
    TIOCM_CTS       CTS (clear to send)
    TIOCM_CAR       DCD (data carrier detect)
    TIOCM_CD         see TIOCM_CAR
    TIOCM_RNG       RNG (ring)
    TIOCM_RI         see TIOCM_RNG
    TIOCM_DSR       DSR (data set ready)

* **TIOCMIWAIT	int **_arg_  
  Wait for any of the 4 modem bits (DCD, RI, DSR, CTS) to change.
  The bits of interest are specified as a bit mask in
  _arg_,
  by ORing together any of the bit values,
  **TIOCM_RNG**,
  **TIOCM_DSR**,
  **TIOCM_CD**,
  and
  **TIOCM_CTS**.
  The caller should use
  **TIOCGICOUNT**
  to see which bit has changed.
* **TIOCGICOUNT	struct serial_icounter_struct ***_argp_  
  Get counts of input serial line interrupts (DCD, RI, DSR, CTS).
  The counts are written to the
  _serial_icounter_struct_
  structure pointed to by
  _argp_.
* Note: both 1-&gt;0 and 0-&gt;1 transitions are counted, except for
  RI, where only 0-&gt;1 transitions are counted.

<a name="marking-a-line-as-local"></a>

### Marking a line as local


* **TIOCGSOFTCAR	int ***_argp_  
  ("Get software carrier flag")
  Get the status of the CLOCAL flag in the c_cflag field of the
  _termios_
  structure.
* **TIOCSSOFTCAR	const int ***_argp_  
  ("Set software carrier flag")
  Set the CLOCAL flag in the
  _termios_
  structure when
  *_argp_
  is nonzero, and clear it otherwise.

If the
**CLOCAL**
flag for a line is off, the hardware carrier detect (DCD)
signal is significant, and an
**open**(2)
of the corresponding terminal will block until DCD is asserted,
unless the
**O_NONBLOCK**
flag is given.
If
**CLOCAL**
is set, the line behaves as if DCD is always asserted.
The software carrier flag is usually turned on for local devices,
and is off for lines with modems.

<a name="linux-specific"></a>

### Linux-specific

For the
**TIOCLINUX**
ioctl, see
**ioctl_console**(2).

<a name="kernel-debugging"></a>

### Kernel debugging

**#include &lt;linux/tty.h&gt;**

* **TIOCTTYGSTRUCT	struct tty_struct ***_argp_  
  Get the
  _tty_struct_
  corresponding to
  _fd_.
  This command was removed in Linux 2.5.67.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

<a name="return-value"></a>

# Return Value

The
**ioctl**(2)
system call returns 0 on success.
On error, it returns -1 and sets
_errno_
appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  Invalid command parameter.
* **ENOIOCTLCMD**  
  Unknown command.
* **ENOTTY**  
  Inappropriate
  _fd_.
* **EPERM**  
  Insufficient permission.

<a name="example"></a>

# Example

Check the condition of DTR on the serial port.

.EX
#include &lt;termios.h&gt;
#include &lt;fcntl.h&gt;
#include &lt;sys/ioctl.h&gt;

int
main(void)
{
    int fd, serial;

    fd = open("/dev/ttyS0", O_RDONLY);
    ioctl(fd, TIOCMGET, &serial);
    if (serial & TIOCM_DTR)
        puts("TIOCM_DTR is set");
    else
        puts("TIOCM_DTR is not set");
    close(fd);
}
.EE

<a name="see-also"></a>

# See Also

**ldattach**(1),
**ioctl**(2),
**ioctl_console**(2),
**termios**(3),
**pty**(7)















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
