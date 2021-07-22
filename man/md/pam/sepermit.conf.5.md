# sepermit\&.conf(5)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

sepermit.conf - configuration file for the pam_sepermit module

<a name="description"></a>

# Description


The lines of the configuration file have the following syntax:

_&lt;user&gt;_[:_&lt;option&gt;_:_&lt;option&gt;_...]

The
**user**
can be specified in the following manner:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a username

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a groupname, with
  **@group**
  syntax. This should not be confused with netgroups.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a SELinux user name with
  **%seuser**
  syntax.

The recognized options are:

**exclusive**
Only single login session will be allowed for the user and the users processes will be killed on logout.

**ignore**
The module will never return PAM_SUCCESS status for the user. It will return PAM_IGNORE if SELinux is in the enforcing mode, and PAM_AUTH_ERR otherwise. It is useful if you want to support passwordless guest users and other confined users with passwords simultaneously.

The lines which start with # character are comments and are ignored.

<a name="examples"></a>

# Examples


These are some example lines which might be specified in
/etc/security/sepermit.conf.

.if n \{.RS 4
.\}
    %guest_u:exclusive
    %staff_u:ignore
    %user_u:ignore
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**pam\_sepermit**(8),
**pam.d**(5),
**pam**(8),
**selinux**(8),

<a name="author"></a>

# Author


pam_sepermit and this manual page were written by Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;
