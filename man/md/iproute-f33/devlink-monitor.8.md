# devlink\-monitor(8) - state monitoring

iproute2, 14 Mar 2016

```

 .in +8 .ti -8 devlink monitor [ all | OBJECT-LIST ] 

```


<a name="description"></a>

# Description

The
**devlink**
utility can monitor the state of devlink devices and ports
continuously. This option has a slightly different format. Namely, the
**monitor**
command is the first in the command line and then the object list.

_OBJECT-LIST_
is the list of object types that we want to monitor.
It may contain
**dev**, **port**, **health**, **trap**, **trap-group**, **trap-policer**.

**devlink**
opens Devlink Netlink socket, listens on it and dumps state changes.


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-sb**(8),
**devlink-port**(8),
**devlink-health**(8),
**devlink-trap**(8),  


<a name="author"></a>

# Author

Jiri Pirko &lt;[jiri@mellanox.com](mailto:jiri@mellanox.com)&gt;
