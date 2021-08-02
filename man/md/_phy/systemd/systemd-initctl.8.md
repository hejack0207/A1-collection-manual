# systemd\-initctl\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-initctl.service, systemd-initctl.socket, systemd-initctl - /dev/initctl compatibility

<a name="synopsis"></a>

# Synopsis

```

 systemd-initctl.service 
 systemd-initctl.socket 
 /usr/lib/systemd/systemd-initctl
```

<a name="description"></a>

# Description


systemd-initctl
is a system service that implements compatibility with the
/dev/initctl
FIFO file system object, as implemented by the SysV init system.
systemd-initctl
is automatically activated on request and terminates itself when it is unused.

<a name="see-also"></a>

# See Also


**systemd**(1)
