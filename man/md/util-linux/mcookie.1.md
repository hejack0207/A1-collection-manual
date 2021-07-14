# mcookie(1) - generate magic cookies for xauth

util-linux, December 2014

```
mcookie [options]
```

<a name="description"></a>

# Description

**mcookie**
generates a 128-bit random hexadecimal number for use with the X authority
system.  Typical usage:

**xauth add :0 . \`mcookie\`**

The "random" number generated is actually the MD5 message
digest of random information coming from one of the sources
_getrandom_()
system call,
_/dev/urandom_,
_/dev/random_,
or the
_libc pseudo-random functions_,
in this preference order. See also the option **--file**.

<a name="options"></a>

# Options


* **-f**,** --file **file  
  Use this _file_ as an additional source of randomness (for example /dev/urandom).
  When _file_ is '-', characters are read from standard input.
* **-m**,** --max-size **number  
  Read from _file_ only this _number_ of bytes.
  This option is meant to be used when reading additional
  randomness from a file or device.
* The
  _number_
  argument may be followed by the multiplicative suffixes KiB=1024,
  MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
  optional, e.g., "K" has the same meaning as "KiB") or the suffixes
  KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
* **-v**,** --verbose**  
  Inform where randomness originated, with amount of entropy read from each
  source.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="bugs"></a>

# Bugs

It is assumed that none of the randomness sources will block.

<a name="files"></a>

# Files

_/dev/urandom_  
_/dev/random_

<a name="see-also"></a>

# See Also

**md5sum**(1),
**X**(1),
**xauth**(1),
**rand**(3)

<a name="availability"></a>

# Availability

The mcookie command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
