# partprobe(8) - inform the OS of partition table changes

parted, March 18, 2002

```
partprobe [-d] [-s] [devices...]
```

<a name="description"></a>

# Description

This manual page documents briefly the
**partprobe**
command.




**partprobe** is a program that informs the operating system kernel of
partition table changes.

<a name="options"></a>

# Options

This program uses short UNIX style options.

* **-d, --dry-run**  
  Don't update the kernel.
* **-s, --summary**  
  Show a summary of devices and their partitions.
* **-h, --help**  
  Show summary of options.
* **-v, --version**  
  Show version of program.

<a name="reporting-bugs"></a>

# Reporting Bugs

Report bugs to &lt;bug-parted@gnu.org&gt;

<a name="see-also"></a>

# See Also

**parted**(8).

<a name="author"></a>

# Author

This manual page was written by Timshel Knoll &lt;[timshel@debian.org](mailto:timshel@debian.org)&gt;,
for the Debian GNU/Linux system (but may be used by others).
