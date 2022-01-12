# systemd\-rfkill\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-rfkill.service, systemd-rfkill.socket, systemd-rfkill - Load and save the RF kill switch state at boot and change

<a name="synopsis"></a>

# Synopsis

```

 systemd-rfkill.service 
 systemd-rfkill.socket 
 /usr/lib/systemd/systemd-rfkill
```

<a name="description"></a>

# Description


systemd-rfkill.service
is a service that restores the RF kill switch state at early boot and saves it on each change. On disk, the RF kill switch state is stored in
/var/lib/systemd/rfkill/.

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-rfkill
understands the following kernel command line parameter:

_systemd.restore\_state=_
Takes a boolean argument. Defaults to
"1". If
"0", does not restore the rfkill settings on boot. However, settings will still be stored on shutdown.

<a name="see-also"></a>

# See Also


**systemd**(1)
