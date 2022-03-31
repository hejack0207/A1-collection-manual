# netcap:(8) - a program to see capabilities

Red Hat, Sept 2020

```
netcap
```

<a name="description"></a>

# Description

**netcap** is a program that prints out a report of process capabilities. If the application is using tcp, udp, raw, or packet family of sockets AND has any capabilities, it will be in the report. If the process has partial capabilities, it is further examined to see if it has an open-ended bounding set. If this is found to be true, a '+' symbol is added.  If the process has ambient capabilities, a '@' symbols is added.

Some directories in the /proc file system are readonly by root. The program will try to access and report what it can. But if nothing comes out, try changing to the root user and re-run this program. 


<a name="see-also"></a>

# See Also

**pscap**(8),
**filecap**(8),
**capabilities**(7),
**netstat**(8).


<a name="author"></a>

# Author

Steve Grubb
