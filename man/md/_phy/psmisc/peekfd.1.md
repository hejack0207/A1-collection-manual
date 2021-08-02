# peekfd(1) - peek at file descriptors of running processes

psmisc, 2012-07-28

```
peekfd  [-8,--eight-bit-clean] [-n,--no-headers] [-f,--follow] [-d,--duplicates-removed] [-V,--version] [-h,--help] pid [fd] [fd] ...
```

<a name="description"></a>

# Description

**peekfd**
attaches to a running process and intercepts all reads and writes to
file descriptors.  You can specify the desired file descriptor numbers
or dump all of them.

<a name="options"></a>

# Options


* -8  
  Do no post-processing on the bytes being read or written.
* -n  
  Do not display headers indicating the source of the bytes dumped.
* -c  
  Also dump the requested file descriptor activity in any new child
  processes that are created.
* -d  
  Remove duplicate read/writes from the output.  If you're looking at a
  tty with echo, you might want this.
* -v  
  Display a version string.
* -h  
  Display a help message.

<a name="files"></a>

# Files

_/proc/*/fd_
Not used but useful for the user to look at to get good file descriptor
numbers.

<a name="environment"></a>

# Environment

None.

<a name="diagnostics"></a>

# Diagnostics

The following diagnostics may be issued on stderr:

* **Error attaching to pid ...**  
  An unknown error occurred while attempted to attach to a process..  you
  may need to be root.

<a name="bugs"></a>

# Bugs

Probably lots.  Don't be surprised if the process you are monitoring
dies.

<a name="author"></a>

# Author

.MT [trent.waddington@gmail.com](mailto:trent.waddington@gmail.com)
Trent Waddington
.ME

<a name="see-also"></a>

# See Also

**ttysnoop**(8)
