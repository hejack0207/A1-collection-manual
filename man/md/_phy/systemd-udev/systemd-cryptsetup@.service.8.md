# systemd\-cryptsetup@\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-cryptsetup@.service, systemd-cryptsetup - Full disk decryption logic

<a name="synopsis"></a>

# Synopsis

```

 systemd-cryptsetup@.service 
 /usr/lib/systemd/systemd-cryptsetup
```

<a name="description"></a>

# Description


systemd-cryptsetup@.service
is a service responsible for setting up encrypted block devices. It is instantiated for each device that requires decryption for access.

systemd-cryptsetup@.service
will ask for hard disk passwords via the
\m[blue]**password agent logic**\m[]\s-2\u[1]\d\s+2, in order to query the user for the password using the right mechanism at boot and during runtime.

At early boot and when the system manager configuration is reloaded,
/etc/crypttab
is translated into
systemd-cryptsetup@.service
units by
**systemd-cryptsetup-generator**(8).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-cryptsetup-generator**(8),
**crypttab**(5),
**cryptsetup**(8)

<a name="notes"></a>

# Notes


*  1.  
  password agent logic
      https://www.freedesktop.org/wiki/Software/systemd/PasswordAgents
