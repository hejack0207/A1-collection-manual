# pam_shells(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_shells - PAM module to check for valid login shell

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_shells.so&nbsp;'u pam_shells.so
```

<a name="description"></a>

# Description


pam_shells is a PAM module that only allows access to the system if the users shell is listed in
/etc/shells.

It also checks if
/etc/shells
is a plain file and not world writable.

<a name="options"></a>

# Options


This module does not recognise any options.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**
and
**account**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_AUTH_ERR
Access to the system was denied.

PAM_SUCCESS
The users login shell was listed as valid shell in
/etc/shells.

PAM_SERVICE_ERR
The module was not able to get the name of the user.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    auth  required  pam_shells.so
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**shells**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_shells was written by Erik Troan &lt;[ewt@redhat.com](mailto:ewt@redhat.com)&gt;.
