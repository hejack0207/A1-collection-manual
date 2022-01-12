# nameif(8) - name network interfaces based on MAC addresses

net\-tools, 2008\-10\-03

```
"nameif [-c configfile] [-s]"
"nameif [-c configfile] [-s] {interface macaddress}"
```


<a name="note"></a>

# Note


This program is obsolete. For replacement check **ip link**.
This functionality is also much better provided by udev methods.


<a name="description"></a>

# Description

**nameif**
renames network interfaces based on mac addresses. When no arguments are
given 
_/etc/mactab_
is read. Each line  of it contains an interface name and a Ethernet MAC 
address. Comments are allowed starting with #. 
Otherwise the interfaces specified on the command line are processed.
_nameif_
looks for the interface with the given MAC address and renames it to the
name given.

When the 
_-s_
argument is given all error messages go to the syslog.

When the 
_-c_
argument is given with a file name that file is read instead of /etc/mactab.


<a name="notes"></a>

# Notes

_nameif_
should be run before the interface is up, otherwise it'll fail.


<a name="files"></a>

# Files

/etc/mactab


<a name="see-also"></a>

# See Also

**ip(8),**
**udev(7)**


<a name="bugs"></a>

# Bugs

Only works for Ethernet currently.
