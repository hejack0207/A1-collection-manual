# pam_mkhomedir(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_mkhomedir - PAM module to create users home directory

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_mkhomedir.so&nbsp;'u pam_mkhomedir.so [silent] [debug] [umask=mode] [skel=skeldir]
```

<a name="description"></a>

# Description


The pam_mkhomedir PAM module will create a users home directory if it does not exist when the session begins. This allows users to be present in central database (such as NIS, kerberos or LDAP) without using a distributed file system or pre-creating a large number of directories. The skeleton directory (usually
/etc/skel/) is used to copy default files and also sets a umask for the creation.

The new users home directory will not be removed after logout of the user.

<a name="options"></a>

# Options


**silent**
Dont print informative messages.

**debug**
Turns on debugging via
**syslog**(3).

**umask=****mask**
The user file-creation mask is set to
_mask_. The default value of mask is 0022.

**skel=****/path/to/skel/directory**
Indicate an alternative
skel
directory to override the default
/etc/skel.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**session**
module type is provided.

<a name="return-values"></a>

# Return Values


PAM_BUF_ERR
Memory buffer error.

PAM_PERM_DENIED
Not enough permissions to create the new directory or read the skel directory.

PAM_USER_UNKNOWN
User not known to the underlying authentication module.

PAM_SUCCESS
Environment variables were set.

<a name="files"></a>

# Files


/etc/skel
Default skel directory

<a name="examples"></a>

# Examples


A sample /etc/pam.d/login file:

.if n \{.RS 4
.\}
      auth       requisite   pam_securetty.so
      auth       sufficient  pam_ldap.so
      auth       required    pam_unix.so
      auth       required    pam_nologin.so
      account    sufficient  pam_ldap.so
      account    required    pam_unix.so
      password   required    pam_unix.so
      session    required    pam_mkhomedir.so skel=/etc/skel/ umask=0022
      session    required    pam_unix.so
      session    optional    pam_lastlog.so
      session    optional    pam_mail.so standard
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.d**(5),
**pam**(8).

<a name="author"></a>

# Author


pam_mkhomedir was written by Jason Gunthorpe &lt;[jgg@debian.org](mailto:jgg@debian.org)&gt;.
