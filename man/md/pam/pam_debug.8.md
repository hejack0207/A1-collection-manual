# pam_debug(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_debug - PAM module to debug the PAM stack

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_debug.so&nbsp;'u pam_debug.so [auth=value] [cred=value] [acct=value] [prechauthtok=value] [chauthtok=value] [auth=value] [open_session=value] [close_session=value]
```

<a name="description"></a>

# Description


The pam_debug PAM module is intended as a debugging aide for determining how the PAM stack is operating. This module returns what its module arguments tell it to return.

<a name="options"></a>

# Options


**auth=****value**
The
**pam\_sm\_authenticate**(3)
function will return
_value_.

**cred=****value**
The
**pam\_sm\_setcred**(3)
function will return
_value_.

**acct=****value**
The
**pam\_sm\_acct\_mgmt**(3)
function will return
_value_.

**prechauthtok=****value**
The
**pam\_sm\_chauthtok**(3)
function will return
_value_
if the
_PAM\_PRELIM\_CHECK_
flag is set.

**chauthtok=****value**
The
**pam\_sm\_chauthtok**(3)
function will return
_value_
if the
_PAM\_PRELIM\_CHECK_
flag is
**not**
set.

**open\_session=****value**
The
**pam\_sm\_open\_session**(3)
function will return
_value_.

**close\_session=****value**
The
**pam\_sm\_close\_session**(3)
function will return
_value_.

Where
_value_
can be one of: success, open_err, symbol_err, service_err, system_err, buf_err, perm_denied, auth_err, cred_insufficient, authinfo_unavail, user_unknown, maxtries, new_authtok_reqd, acct_expired, session_err, cred_unavail, cred_expired, cred_err, no_module_data, conv_err, authtok_err, authtok_recover_err, authtok_lock_busy, authtok_disable_aging, try_again, ignore, abort, authtok_expired, module_unknown, bad_item, conv_again, incomplete.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**auth**,
**account**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values


PAM_SUCCESS
Default return code if no other value was specified, else specified return value.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    auth    requisite       pam_permit.so
    auth    [success=2 default=ok]  pam_debug.so auth=perm_denied cred=success
    auth    [default=reset]         pam_debug.so auth=success cred=perm_denied
    auth    [success=done default=die] pam_debug.so
    auth    optional        pam_debug.so auth=perm_denied cred=perm_denied
    auth    sufficient      pam_debug.so auth=success cred=success
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_debug was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
