# fdformat(8) - low-level format a floppy disk

util-linux, July 2014

```
fdformat [options] device
```

<a name="description"></a>

# Description

**fdformat**
does a low-level format on a floppy disk.
_device_
is usually one of the following (for floppy devices the major = 2, and the
minor is shown for informational purposes only):

    .RS
    /dev/fd0d360  (minor = 4)
    /dev/fd0h1200 (minor = 8)
    /dev/fd0D360  (minor = 12)
    /dev/fd0H360  (minor = 12)
    /dev/fd0D720  (minor = 16)
    /dev/fd0H720  (minor = 16)
    /dev/fd0h360  (minor = 20)
    /dev/fd0h720  (minor = 24)
    /dev/fd0H1440 (minor = 28)
    
    /dev/fd1d360  (minor = 5)
    /dev/fd1h1200 (minor = 9)
    /dev/fd1D360  (minor = 13)
    /dev/fd1H360  (minor = 13)
    /dev/fd1D720  (minor = 17)
    /dev/fd1H720  (minor = 17)
    /dev/fd1h360  (minor = 21)
    /dev/fd1h720  (minor = 25)
    /dev/fd1H1440 (minor = 29)
    .RE

The generic floppy devices, /dev/fd0 and /dev/fd1, will fail to work with
**fdformat**
when a non-standard format is being used, or if the format has not been
autodetected earlier.  In this case, use
**setfdprm**(8)
to load the disk parameters.

<a name="options"></a>

# Options


* **-f**, **--from** _N_  
  Start at the track _N_ (default is 0).
* **-t**, **--to** _N_  
  Stop at the track _N_.
* **-r**, **--repair** _N_  
  Try to repair tracks failed during the verification (max _N_ retries).
* **-n**, **--no-verify**  
  Skip the verification that is normally performed after the formatting.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="see-also"></a>

# See Also

**fd**(4),
**emkfs**(8),
**mkfs**(8),
**setfdprm**(8)

<a name="author"></a>

# Author

Werner Almesberger ([almesber@nessie.cs](mailto:almesber@nessie.cs).id.ethz.ch)

<a name="availability"></a>

# Availability

The fdformat command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
