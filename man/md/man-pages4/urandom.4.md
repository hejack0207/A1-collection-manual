# random(4) - kernel random number source devices

Linux, 2017-09-15

```
#include <linux/random.h> 
 int ioctl(fd, RNDrequest, param);
```

<a name="description"></a>

# Description

The character special files _/dev/random_ and
_/dev/urandom_ (present since Linux 1.3.30)
provide an interface to the kernel's random number generator.
The file
_/dev/random_
has major device number 1 and minor device number 8.
The file
_/dev/urandom_
has major device number 1 and minor device number 9.

The random number generator gathers environmental noise
from device drivers and other sources into an entropy pool.
The generator also keeps an estimate of the
number of bits of noise in the entropy pool.
From this entropy pool, random numbers are created.

Linux 3.17 and later provides the simpler and safer
**getrandom**(2)
interface which requires no special files;
see the
**getrandom**(2)
manual page for details.

When read, the
_/dev/urandom_
device returns random bytes using a pseudorandom
number generator seeded from the entropy pool.
Reads from this device do not block (i.e., the CPU is not yielded),
but can incur an appreciable delay when requesting large amounts of data.

When read during early boot time,
_/dev/urandom_
may return data prior to the entropy pool being initialized.


If this is of concern in your application, use
**getrandom**(2)
or _/dev/random_ instead.

The _/dev/random_ device is a legacy interface which dates back to
a time where the cryptographic primitives used in the implementation
of _/dev/urandom_ were not widely trusted.
It will return random bytes only within the estimated number of
bits of fresh noise in the entropy pool, blocking if necessary.
_/dev/random_ is suitable for applications that need
high quality randomness, and can afford indeterminate delays.

When the entropy pool is empty, reads from _/dev/random_ will block
until additional environmental noise is gathered.
If
**open**(2)
is called for
_/dev/random_
with the
**O_NONBLOCK**
flag, a subsequent
**read**(2)
will not block if the requested number of bytes is not available.
Instead, the available bytes are returned.
If no byte is available,
**read**(2)
will return -1 and
_errno_
will be set to
**EAGAIN**.

The
**O_NONBLOCK**
flag has no effect when opening
_/dev/urandom_.
When calling
**read**(2)
for the device
_/dev/urandom_,
reads of up to 256 bytes will return as many bytes as are requested
and will not be interrupted by a signal handler.
Reads with a buffer over this limit may return less than the
requested number of bytes or fail with the error
**EINTR**,
if interrupted by a signal handler.

Since Linux 3.16,

a
**read**(2)
from
_/dev/urandom_
will return at most 32&nbsp;MB.
A
**read**(2)
from
_/dev/random_
will return at most 512 bytes

(340 bytes on Linux kernels before version 2.6.12).

Writing to _/dev/random_ or _/dev/urandom_ will update the
entropy pool with the data written, but this will not result in a
higher entropy count.
This means that it will impact the contents
read from both files, but it will not make reads from
_/dev/random_ faster.

<a name="usage"></a>

### Usage

The
_/dev/random_
interface is considered a legacy interface, and
_/dev/urandom_
is preferred and sufficient in all use cases, with the exception of
applications which require randomness during early boot time; for
these applications,
**getrandom**(2)
must be used instead,
because it will block until the entropy pool is initialized.

If a seed file is saved across reboots as recommended below (all major
Linux distributions have done this since 2000 at least), the output is
cryptographically secure against attackers without local root access as
soon as it is reloaded in the boot sequence, and perfectly adequate for
network encryption session keys.
Since reads from
_/dev/random_
may block, users will usually want to open it in nonblocking mode
(or perform a read with timeout),
and provide some sort of user notification if the desired
entropy is not immediately available.


<a name="configuration"></a>

### Configuration

If your system does not have
_/dev/random_ and _/dev/urandom_ created already, they
can be created with the following commands:

.in +4n
.EX
mknod -m 666 /dev/random c 1 8
mknod -m 666 /dev/urandom c 1 9
chown root:root /dev/random /dev/urandom
.EE
.in

When a Linux system starts up without much operator interaction,
the entropy pool may be in a fairly predictable state.
This reduces the actual amount of noise in the entropy pool
below the estimate.
In order to counteract this effect, it helps to carry
entropy pool information across shut-downs and start-ups.
To do this, add the lines to an appropriate script
which is run during the Linux system start-up sequence:

.in +4n
.EX
echo "Initializing random number generator..."
random_seed=/var/run/random-seed
# Carry a random seed from start-up to start-up
# Load and then save the whole entropy pool
if [ -f $random_seed ]; then
    cat $random_seed &gt;/dev/urandom
else
    touch $random_seed
fi
chmod 600 $random_seed
poolfile=/proc/sys/kernel/random/poolsize
[ -r $poolfile ] && bits=$(cat $poolfile) || bits=4096
bytes=$(expr $bits / 8)
dd if=/dev/urandom of=$random_seed count=1 bs=$bytes
.EE
.in

Also, add the following lines in an appropriate script which is
run during the Linux system shutdown:

.in +4n
.EX
# Carry a random seed from shut-down to start-up
# Save the whole entropy pool
echo "Saving random seed..."
random_seed=/var/run/random-seed
touch $random_seed
chmod 600 $random_seed
poolfile=/proc/sys/kernel/random/poolsize
[ -r $poolfile ] && bits=$(cat $poolfile) || bits=4096
bytes=$(expr $bits / 8)
dd if=/dev/urandom of=$random_seed count=1 bs=$bytes
.EE
.in

In the above examples, we assume Linux 2.6.0 or later, where
_/proc/sys/kernel/random/poolsize_
returns the size of the entropy pool in bits (see below).


<a name="proc-interfaces"></a>

### /proc interfaces

The files in the directory
_/proc/sys/kernel/random_
(present since 2.3.16) provide additional information about the
_/dev/random_
device:

* _entropy_avail_  
  This read-only file gives the available entropy, in bits.
  This will be a number in the range 0 to 4096.
* _poolsize_  
  This file
  gives the size of the entropy pool.
  The semantics of this file vary across kernel versions:
    * Linux 2.4:  
      This file gives the size of the entropy pool in
      _bytes_.
      Normally, this file will have the value 512, but it is writable,
      and can be changed to any value for which an algorithm is available.
      The choices are 32, 64, 128, 256, 512, 1024, or 2048.
    * Linux 2.6 and later:  
      This file is read-only, and gives the size of the entropy pool in
      _bits_.
      It contains the value 4096.
* _read_wakeup_threshold_  
  This file
  contains the number of bits of entropy required for waking up processes
  that sleep waiting for entropy from
  _/dev/random_.
  The default is 64.
* _write_wakeup_threshold_  
  This file
  contains the number of bits of entropy below which we wake up
  processes that do a
  **select**(2)
  or
  **poll**(2)
  for write access to
  _/dev/random_.
  These values can be changed by writing to the files.
* _uuid_ and _boot_id_  
  These read-only files
  contain random strings like 6fd5a44b-35f4-4ad4-a9b9-6b9be13e1fe9.
  The former is generated afresh for each read, the latter was
  generated once.
  

<a name="ioctl2-interface"></a>

### ioctl(2) interface

The following
**ioctl**(2)
requests are defined on file descriptors connected to either _/dev/random_
or _/dev/urandom_.
All requests performed will interact with the input
entropy pool impacting both _/dev/random_ and _/dev/urandom_.
The
**CAP_SYS_ADMIN**
capability is required for all requests except
**RNDGETENTCNT**.

* **RNDGETENTCNT**  
  Retrieve the entropy count of the input pool, the contents will be the same
  as the
  _entropy_avail_
  file under proc.
  The result will be stored in the int pointed to by the argument.
* **RNDADDTOENTCNT**  
  Increment or decrement the entropy count of the input pool
  by the value pointed to by the argument.
* **RNDGETPOOL**  
  Removed in Linux 2.6.9.
* **RNDADDENTROPY**  
  Add some additional entropy to the input pool,
  incrementing the entropy count.
  This differs from writing to _/dev/random_ or _/dev/urandom_,
  which only adds some
  data but does not increment the entropy count.
  The following structure is used:
* .in +4n
  .EX
  struct rand_pool_info {
      int    entropy_count;
      int    buf_size;
      __u32  buf[0];
  };
  .EE
  .in
* Here
  _entropy_count_
  is the value added to (or subtracted from) the entropy count, and
  _buf_
  is the buffer of size
  _buf_size_
  which gets added to the entropy pool.
* **RNDZAPENTCNT**, **RNDCLEARPOOL**  
  Zero the entropy count of all pools and add some system data (such as
  wall clock) to the pools.

<a name="files"></a>

# Files

_/dev/random_  
_/dev/urandom_

<a name="notes"></a>

# Notes

For an overview and comparison of the various interfaces that
can be used to obtain randomness, see
**random**(7).

<a name="bugs"></a>

# Bugs

During early boot time, reads from
_/dev/urandom_
may return data prior to the entropy pool being initialized.




<a name="see-also"></a>

# See Also

**mknod**(1),
**getrandom**(2),
**random**(7)

RFC&nbsp;1750, "Randomness Recommendations for Security"

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
