# pam_localuser(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_localuser - require users to be listed in /etc/passwd

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_localuser.so&nbsp;'u pam_localuser.so [debug] [file=/path/passwd]
```

<a name="description"></a>

# Description


pam_localuser is a PAM module to help implementing site-wide login policies, where they typically include a subset of the networks users and a few accounts that are local to a particular workstation. Using pam_localuser and pam_wheel or pam_listfile is an effective way to restrict access to either local users and/or a subset of the network\*(Aqs users.

This could also be implemented using pam_listfile.so and a very short awk script invoked by cron, but its common enough to have been separated out.

<a name="options"></a>

# Options



**debug**
Print debug information.

**file=****/path/passwd**
Use a file other than
/etc/passwd.

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
The new localuser was set successfully.

PAM_BUF_ERR
Memory buffer error.

PAM_CONV_ERR
The conversation method supplied by the application failed to obtain the username.

PAM_INCOMPLETE
The conversation method supplied by the application returned PAM_CONV_AGAIN.

PAM_SERVICE_ERR
The user name is not valid or the passwd file is unavailable.

PAM_PERM_DENIED
The user is not listed in the passwd file.

<a name="examples"></a>

# Examples


Add the following lines to
/etc/pam.d/su
to allow only local users or group wheel to use su.

.if n \{.RS 4
.\}
    account sufficient pam_localuser.so
    account required pam_wheel.so
          
.if n \{.RE
.\}


<a name="files"></a>

# Files


/etc/passwd
Local user account information.

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_localuser was written by Nalin Dahyabhai &lt;[nalin@redhat.com](mailto:nalin@redhat.com)&gt;.
