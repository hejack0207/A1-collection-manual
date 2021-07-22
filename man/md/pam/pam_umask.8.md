# pam_umask(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_umask - PAM module to set the file mode creation mask

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_umask.so&nbsp;'u pam_umask.so [debug] [silent] [usergroups] [nousergroups] [umask=mask]
```

<a name="description"></a>

# Description


pam_umask is a PAM module to set the file mode creation mask of the current environment. The umask affects the default permissions assigned to newly created files.

The PAM module tries to get the umask value from the following places in the following order:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  umask= entry in the users GECOS field

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  umask= argument

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  UMASK entry from /etc/login.defs

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  UMASK= entry from /etc/default/login

The GECOS field is split on comma ,\*(Aq characters. The module also in addition to the umask= entry recognizes pri= entry, which sets the nice priority value for the session, and ulimit= entry, which sets the maximum size of files the processes in the session can create.

<a name="options"></a>

# Options



**debug**
Print debug information.

**silent**
Dont print informative messages.

**usergroups**
If the user is not root and the username is the same as primary group name, the umask group bits are set to be the same as owner bits (examples: 022 -&gt; 002, 077 -&gt; 007).

**nousergroups**
This is the direct opposite of the usergroups option described above, which can be useful in case pam_umask has been compiled with usergroups enabled by default and you want to disable it at runtime.

**umask=****mask**
Sets the calling processs file mode creation mask (umask) to
**mask**
& 0777. The value is interpreted as Octal.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**session**
type is provided.

<a name="return-values"></a>

# Return Values



PAM_SUCCESS
The new umask was set successfully.

PAM_BUF_ERR
Memory buffer error.

PAM_CONV_ERR
The conversation method supplied by the application failed to obtain the username.

PAM_INCOMPLETE
The conversation method supplied by the application returned PAM_CONV_AGAIN.

PAM_SERVICE_ERR
No username was given.

PAM_USER_UNKNOWN
User not known.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/login
to set the user specific umask at login:

.if n \{.RS 4
.\}
            session optional pam_umask.so umask=0022
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_umask was written by Thorsten Kukuk &lt;[kukuk@thkukuk.de](mailto:kukuk@thkukuk.de)&gt;.
