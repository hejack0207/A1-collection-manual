# pam_warn(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_warn - PAM module which logs all PAM items if called

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_warn.so&nbsp;'u pam_warn.so
```

<a name="description"></a>

# Description


pam_warn is a PAM module that logs the service, terminal, user, remote user and remote host to
**syslog**(3). The items are not probed for, but instead obtained from the standard PAM items. The module always returns
**PAM\_IGNORE**, indicating that it does not want to affect the authentication process.

<a name="options"></a>

# Options


This module does not recognise any options.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**,
**account**,
**password**
and
**session**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_IGNORE
This module always returns PAM_IGNORE.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    #%PAM-1.0
    #
    # If we dont have config entries for a service, the
    # OTHER entries are used. To be secure, warn and deny
    # access to everything.
    other auth     required       pam_warn.so
    other auth     required       pam_deny.so
    other account  required       pam_warn.so
    other account  required       pam_deny.so
    other password required       pam_warn.so
    other password required       pam_deny.so
    other session  required       pam_warn.so
    other session  required       pam_deny.so
          
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_warn was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
