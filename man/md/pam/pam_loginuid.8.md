# pam_loginuid(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_loginuid - Record users login uid to the process attribute

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_loginuid.so&nbsp;'u pam_loginuid.so [require_auditd]
```

<a name="description"></a>

# Description


The pam_loginuid module sets the loginuid process attribute for the process that was authenticated. This is necessary for applications to be correctly audited. This PAM module should only be used for entry point applications like: login, sshd, gdm, vsftpd, crond and atd. There are probably other entry point applications besides these. You should not use it for applications like sudo or su as that defeats the purpose by changing the loginuid to the account they just switched to.

<a name="options"></a>

# Options


**require\_auditd**
This option, when given, will cause this module to query the audit daemon status and deny logins if it is not running.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**session**
module type is provided.

<a name="return-values"></a>

# Return Values



PAM_SUCCESS
The loginuid value is set and auditd is running if check requested.

PAM_IGNORE
The /proc/self/loginuid file is not present on the system or the login process runs inside uid namespace and kernel does not support overwriting loginuid.

PAM_SESSION_ERR
Any other error prevented setting loginuid or auditd is not running.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    #%PAM-1.0
    auth       required     pam_unix.so
    auth       required     pam_nologin.so
    account    required     pam_unix.so
    password   required     pam_unix.so
    session    required     pam_unix.so
    session    required     pam_loginuid.so
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8),
**auditctl**(8),
**auditd**(8)

<a name="author"></a>

# Author


pam_loginuid was written by Steve Grubb &lt;[sgrubb@redhat.com](mailto:sgrubb@redhat.com)&gt;
