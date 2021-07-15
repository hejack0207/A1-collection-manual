# systemd\-user\-sessions\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-user-sessions.service, systemd-user-sessions - Permit user logins after boot, prohibit user logins at shutdown

<a name="synopsis"></a>

# Synopsis

```

 systemd-user-sessions.service 
 /usr/lib/systemd/systemd-user-sessions
```

<a name="description"></a>

# Description


systemd-user-sessions.service
is a service that controls user logins through
**pam\_nologin**(8). After basic system initialization is complete, it removes
/run/nologin, thus permitting logins. Before system shutdown, it creates
/run/nologin, thus prohibiting further logins.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-logind.service**(8),
**pam\_nologin**(8)
