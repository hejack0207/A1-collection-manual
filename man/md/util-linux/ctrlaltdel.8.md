# ctrlaltdel(8) - set the function of the Ctrl-Alt-Del combination

util-linux, October 2015

```
ctrlaltdel hard|soft
```

<a name="description"></a>

# Description

Based on examination of the
_linux/kernel/reboot.c_
code, it is clear that there are two supported functions that the
Ctrl-Alt-Del sequence can perform.

* **hard**  
  Immediately reboot the computer without calling
  **sync**(2)
  and without any other preparation.  This is the default.
* **soft**  
  Make the kernel send the SIGINT (interrupt) signal to the
  **init**
  process (this is always the process with PID 1).  If this option is used,
  the
  **init**(8)
  program must support this feature.  Since there are now several
  **init**(8)
  programs in the Linux community, please consult the documentation for the
  version that you are currently using.

When the command is run without any argument, it will display the current
setting.

The function of
**ctrlaltdel**
is usually set in the
_/etc/rc.local_
file.

<a name="options"></a>

# Options


* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="files"></a>

# Files

_/etc/rc.local_

<a name="see-also"></a>

# See Also

**init**(8),
**systemd**(1)

<a name="author"></a>

# Author

.UR [poe@daimi.aau](mailto:poe@daimi.aau).dk
Peter Orbaek
.UE

<a name="availability"></a>

# Availability

The ctrlaltdel command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
