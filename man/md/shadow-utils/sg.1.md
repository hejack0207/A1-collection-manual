# sg(1)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

sg - execute command as different group ID

<a name="synopsis"></a>

# Synopsis

```
.HP \w'sg&nbsp;'u sg [-] [group&nbsp;[-c&nbsp;]&nbsp;command]
```

<a name="description"></a>

# Description


The
**sg**
command works similar to
**newgrp**
but accepts a command. The command will be executed with the
/bin/sh
shell. With most shells you may run
**sg**
from, you need to enclose multi-word commands in quotes. Another difference between
**newgrp**
and
**sg**
is that some shells treat
**newgrp**
specially, replacing themselves with a new instance of a shell that
**newgrp**
creates. This doesnt happen with
**sg**, so upon exit from a
**sg**
command you are returned to your previous group ID.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

**SYSLOG\_SG\_ENAB** (boolean)
Enable "syslog" logging of
**sg**
activity.

<a name="files"></a>

# Files


/etc/passwd
User account information.

/etc/shadow
Secure user account information.

/etc/group
Group account information.

/etc/gshadow
Secure group account information.

<a name="see-also"></a>

# See Also


**id**(1),
**login**(1),
**newgrp**(1),
**su**(1),
**gpasswd**(1),
**group**(5), **gshadow**(5).
