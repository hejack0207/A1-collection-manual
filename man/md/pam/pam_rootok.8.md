# pam_rootok(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_rootok - Gain only root access

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_rootok.so&nbsp;'u pam_rootok.so [debug]
```

<a name="description"></a>

# Description


pam_rootok is a PAM module that authenticates the user if their
_UID_
is
_0_. Applications that are created setuid-root generally retain the
_UID_
of the user but run with the authority of an enhanced effective-UID. It is the real
_UID_
that is checked.

<a name="options"></a>

# Options


**debug**
Print debug information.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**,
**account**
and
**password**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_SUCCESS
The
_UID_
is
_0_.

PAM_AUTH_ERR
The
_UID_
is
**not**
_0_.

<a name="examples"></a>

# Examples


In the case of the
**su**(1)
application the historical usage is to permit the superuser to adopt the identity of a lesser user without the use of a password. To obtain this behavior with PAM the following pair of lines are needed for the corresponding entry in the
/etc/pam.d/su
configuration file:

.if n \{.RS 4
.\}
    # su authentication. Root is granted access by default.
    auth  sufficient   pam_rootok.so
    auth  required     pam_unix.so
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**su**(1),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_rootok was written by Andrew G. Morgan, &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
