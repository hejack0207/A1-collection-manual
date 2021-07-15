# systemd\-ask\-password\-console\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-ask-password-console.service, systemd-ask-password-console.path, systemd-ask-password-wall.service, systemd-ask-password-wall.path - Query the user for system passwords on the console and via wall

<a name="synopsis"></a>

# Synopsis

```

 systemd-ask-password-console.service 
 systemd-ask-password-console.path 
 systemd-ask-password-wall.service 
 systemd-ask-password-wall.path
```

<a name="description"></a>

# Description


systemd-ask-password-console.service
is a system service that queries the user for system passwords (such as hard disk encryption keys and SSL certificate passphrases) on the console. It is intended to be used during boot to ensure proper handling of passwords necessary for boot.
systemd-ask-password-wall.service
is a system service that informs all logged in users for system passwords via
**wall**(1). It is intended to be used after boot to ensure that users are properly notified.

See the
\m[blue]**developer documentation**\m[]\s-2\u[1]\d\s+2
for more information about the system password logic.

Note that these services invoke
**systemd-tty-ask-password-agent**(1)
with either the
**--watch --console**
or
**--watch --wall**
command line parameters.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-tty-ask-password-agent**(1),
**wall**(1)

<a name="notes"></a>

# Notes


*  1.  
  developer documentation
      https://www.freedesktop.org/wiki/Software/systemd/PasswordAgents
