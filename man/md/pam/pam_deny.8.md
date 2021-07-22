# pam_deny(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_deny - The locking-out PAM module

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_deny.so&nbsp;'u pam_deny.so
```

<a name="description"></a>

# Description


This module can be used to deny access. It always indicates a failure to the application through the PAM framework. It might be suitable for using for default (the
_OTHER_) entries.

<a name="options"></a>

# Options


This module does not recognise any options.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**account**,
**auth**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values



PAM_AUTH_ERR
This is returned by the account and auth services.

PAM_CRED_ERR
This is returned by the setcred function.

PAM_AUTHTOK_ERR
This is returned by the password service.

PAM_SESSION_ERR
This is returned by the session service.

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


pam_deny was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;
