# hostname(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

hostname - Local hostname configuration file

<a name="synopsis"></a>

# Synopsis

```

 /etc/hostname
```

<a name="description"></a>

# Description


The
/etc/hostname
file configures the name of the local system that is set during boot using the
**sethostname**(2)
system call. It should contain a single newline-terminated hostname string. Comments (lines starting with a \`#) are ignored. The hostname may be a free-form string up to 64 characters in length; however, it is recommended that it consists only of 7-bit ASCII lower-case characters and no spaces or dots, and limits itself to the format allowed for DNS domain name labels, even though this is not a strict requirement.

You may use
**hostnamectl**(1)
to change the value of this file during runtime from the command line. Use
**systemd-firstboot**(1)
to initialize it on mounted (but not booted) system images.

<a name="history"></a>

# History


The simple configuration file format of
/etc/hostname
originates from Debian GNU/Linux.

<a name="see-also"></a>

# See Also


**systemd**(1),
**sethostname**(2),
**hostname**(1),
**hostname**(7),
**machine-id**(5),
**machine-info**(5),
**hostnamectl**(1),
**systemd-hostnamed.service**(8),
**systemd-firstboot**(1)
