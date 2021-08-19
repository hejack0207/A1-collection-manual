# avcstat(8) - Display SELinux AVC statistics

dwalsh@redhat.com, 18 Nov 2004


<a name="synopsis"></a>

# Synopsis

```
avcstat [-c] [-f status_file] [interval]
```

<a name="description"></a>

# Description

Display SELinux AVC statistics.  If the
_interval_
parameter is specified, the program will loop, displaying updated
statistics every
_interval_
seconds.
Relative values are displayed by default. 

<a name="options"></a>

# Options


* **-c**  
  Display the cumulative values.
* **-f**  
  Specifies the location of the AVC statistics file, defaulting to
  _/sys/fs/selinux/avc/cache_stats_.

<a name="author"></a>

# Author

This manual page was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;.
The program was written by James Morris &lt;[jmorris@redhat.com](mailto:jmorris@redhat.com)&gt;.

<a name="see-also"></a>

# See Also

**selinux**(8)
