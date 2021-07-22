# pam_time(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_time - PAM module for time control access

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_time.so&nbsp;'u pam_time.so [conffile=conf-file] [debug] [noaudit]
```

<a name="description"></a>

# Description


The pam_time PAM module does not authenticate the user, but instead it restricts access to a system and or specific applications at various times of the day and on specific days or over various terminal lines. This module can be configured to deny access to (individual) users based on their name, the time of day, the day of week, the service they are applying for and their terminal from which they are making their request.

By default rules for time/port access are taken from config file
/etc/security/time.conf. An alternative file can be specified with the
_conffile_
option.

If Linux PAM is compiled with audit support the module will report when it denies access.

<a name="options"></a>

# Options


**conffile=/path/to/time.conf**
Indicate an alternative time.conf style configuration file to override the default.

**debug**
Some debug information is printed with
**syslog**(3).

**noaudit**
Do not report logins at disallowed time to the audit subsystem.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**account**
type is provided.

<a name="return-values"></a>

# Return Values


PAM_SUCCESS
Access was granted.

PAM_ABORT
Not all relevant data could be gotten.

PAM_BUF_ERR
Memory buffer error.

PAM_PERM_DENIED
Access was not granted.

PAM_USER_UNKNOWN
The user is not known to the system.

<a name="files"></a>

# Files


/etc/security/time.conf
Default configuration file

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    #%PAM-1.0
    #
    # apply pam_time accounting to login requests
    #
    login  account  required  pam_time.so
          
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**time.conf**(5),
**pam.d**(5),
**pam**(8).

<a name="author"></a>

# Author


pam_time was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
