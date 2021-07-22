# pam_permit(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_permit - The promiscuous module

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_permit.so&nbsp;'u pam_permit.so
```

<a name="description"></a>

# Description


pam_permit is a PAM module that always permit access. It does nothing else.

In the case of authentication, the users name will be set to
_nobody_
if the application didnt set one. Many applications and PAM modules become confused if this name is unknown.

This module is very dangerous. It should be used with extreme caution.

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


PAM_SUCCESS
This module always returns this value.

<a name="examples"></a>

# Examples


Add this line to your other login entries to disable account management, but continue to permit users to log in.

.if n \{.RS 4
.\}
    account  required  pam_permit.so
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_permit was written by Andrew G. Morgan, &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
