# pam_usertype(8)

Linux-PAM, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_usertype - check if the authenticated user is a system or regular account

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_usertype.so&nbsp;'u pam_usertype.so [flag...] {condition}
```

<a name="description"></a>

# Description


pam_usertype.so is designed to succeed or fail authentication based on type of the account of the authenticated user. The type of the account is decided with help of
_SYS\_UID\_MIN_
and
_SYS\_UID\_MAX_
settings in
_/etc/login.defs_. One use is to select whether to load other modules based on this test.

The module should be given only one condition as module argument. Authentication will succeed only if the condition is met.

<a name="options"></a>

# Options


The following
_flag_s are supported:

**use\_uid**
Evaluate conditions using the account of the user whose UID the application is running under instead of the user being authenticated.

**audit**
Log unknown users to the system log.

Available
_condition_s are:

**issystem**
Succeed if the user is a system user.

**isregular**
Succeed if the user is a regular user.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**account**,
**auth**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values


PAM_SUCCESS
The condition was true.

PAM_BUF_ERR
Memory buffer error.

PAM_CONV_ERR
The conversation method supplied by the application failed to obtain the username.

PAM_INCOMPLETE
The conversation method supplied by the application returned PAM_CONV_AGAIN.

PAM_AUTH_ERR
The condition was false.

PAM_SERVICE_ERR
A service error occurred or the arguments cant be parsed correctly.

PAM_USER_UNKNOWN
User was not found.

<a name="examples"></a>

# Examples


Skip remaining modules if the user is a system user:

.if n \{.RS 4
.\}
    account sufficient pam_usertype.so issystem
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**login.defs**(5),
**pam**(8)

<a name="author"></a>

# Author


Pavel Březina &lt;[pbrezina@redhat.com](mailto:pbrezina@redhat.com)&gt;
