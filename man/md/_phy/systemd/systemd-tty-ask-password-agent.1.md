# systemd\-tty\-ask\-password\-agent(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-tty-ask-password-agent - List or process pending systemd password requests

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-tty-ask-password-agent&nbsp;'u systemd-tty-ask-password-agent [OPTIONS...] [VARIABLE=VALUE...]
```

<a name="description"></a>

# Description


**systemd-tty-ask-password-agent**
is a password agent that handles password requests of the system, for example for hard disk encryption passwords or SSL certificate passwords that need to be queried at boot-time or during runtime.

**systemd-tty-ask-password-agent**
implements the
\m[blue]**Password Agents Specification**\m[]\s-2\u[1]\d\s+2, and is one of many possible response agents which answer to queries formulated with
**systemd-ask-password**(1).

<a name="options"></a>

# Options


The following options are understood:

**--list**
Lists all currently pending system password requests.

**--query**
Process all currently pending system password requests by querying the user on the calling TTY.

**--watch**
Continuously process password requests.

**--wall**
Forward password requests to
**wall**(1)
instead of querying the user on the calling TTY.

**--plymouth**
Ask question with
**plymouth**(8)
instead of querying the user on the calling TTY.

**--console**
Ask question on
/dev/console
instead of querying the user on the calling TTY.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-ask-password-console.service**(8),
**wall**(1),
**plymouth**(8)

<a name="notes"></a>

# Notes


*  1.  
  Password Agents Specification
      https://www.freedesktop.org/wiki/Software/systemd/PasswordAgents
