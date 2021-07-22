# lp(4) - line printer devices

Linux, 1995-01-15

```
#include <linux/lp.h>
```

<a name="configuration"></a>

# Configuration

**lp**[0–2] are character devices for the parallel line printers;
they have major number 6 and minor number 0–2.
The minor numbers
correspond to the printer port base addresses 0x03bc, 0x0378 and 0x0278.
Usually they have mode 220 and are owned by root and group lp.
You can use printer ports either with polling or with interrupts.
Interrupts are recommended when high traffic is expected, for example,
for laser printers.
For typical dot matrix printers, polling will usually be enough.
The default is polling.

<a name="description"></a>

# Description

The following
**ioctl**(2)
calls are supported:

* **int ioctl(int **_fd_**, LPTIME, int **_arg_**)**  
  Sets the amount of time that the driver sleeps before rechecking the printer
  when the printer's buffer appears to be filled to
  _arg_.
  If you have a fast printer, decrease this number;
  if you have a slow printer, then increase it.
  This is in hundredths of a second, the default 2
  being 0.02 seconds.
  It influences only the polling driver.
* **int ioctl(int **_fd_**, LPCHAR, int **_arg_**)**  
  Sets the maximum number of busy-wait iterations which the polling driver does
  while waiting for the printer to get ready for receiving a character to
  _arg_.
  If printing is too slow, increase this number; if the
  system gets too slow, decrease this number.
  The default is 1000.
  It influences only the polling driver.
* **int ioctl(int **_fd_**, LPABORT, int **_arg_**)**  
  If
  _arg_
  is 0, the printer driver will retry on errors, otherwise
  it will abort.
  The default is 0.
* **int ioctl(int **_fd_**, LPABORTOPEN, int **_arg_**)**  
  If
  _arg_
  is 0,
  **open**(2)
  will be aborted on error, otherwise error will be ignored.
  The default is to ignore it.
* **int ioctl(int **_fd_**, LPCAREFUL, int **_arg_**)**  
  If
  _arg_
  is 0, then the out-of-paper, offline, and error signals are
  required to be false on all writes, otherwise they are ignored.
  The default is to ignore them.
* **int ioctl(int **_fd_**, LPWAIT, int **_arg_**)**  
  Sets the number of busy waiting iterations to wait before strobing the
  printer to accept a just-written character, and the number of iterations to
  wait before turning the strobe off again,
  to
  _arg_.
  The specification says this time should be 0.5
  microseconds, but experience has shown the delay caused by the code is
  already enough.
  For that reason, the default value is 0.
  
  This is used for both the polling and the interrupt driver.
* **int ioctl(int **_fd_**, LPSETIRQ, int **_arg_**)**  
  This
  **ioctl**(2)
  requires superuser privileges.
  It takes an
  _int_
  containing the new IRQ as argument.
  As a side effect, the printer will be reset.
  When
  _arg_
  is 0, the polling driver will be used, which is also default.
* **int ioctl(int **_fd_**, LPGETIRQ, int ***_arg_**)**  
  Stores the currently used IRQ in
  _arg_.
* **int ioctl(int **_fd_**, LPGETSTATUS, int ***_arg_**)**  
  Stores the value of the status port in
  _arg_.
  The bits have the following meaning:
  .TS
  l l.
  LP_PBUSY	inverted busy input, active high
  LP_PACK	unchanged acknowledge input, active low
  LP_POUTPA	unchanged out-of-paper input, active high
  LP_PSELECD	unchanged selected input, active high
  LP_PERRORP	unchanged error input, active low
  .TE

Refer to your printer manual for the meaning of the signals.
Note that undocumented bits may also be set, depending on your printer.

* **int ioctl(int **_fd_**, LPRESET)**  
  Resets the printer.
  No argument is used.

<a name="files"></a>

# Files

_/dev/lp*_








<a name="see-also"></a>

# See Also

**chmod**(1),
**chown**(1),
**mknod**(1),
**lpcntl**(8),
**tunelp**(8)

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
