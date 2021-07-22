# pam_group(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_group - PAM module for group access

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_group.so&nbsp;'u pam_group.so
```

<a name="description"></a>

# Description


The pam_group PAM module does not authenticate the user, but instead it grants group memberships (in the credential setting phase of the authentication module) to the user. Such memberships are based on the service they are applying for.

By default rules for group memberships are taken from config file
/etc/security/group.conf.

This modules usefulness relies on the file-systems accessible to the user. The point being that once granted the membership of a group, the user may attempt to create a
**setgid**
binary with a restricted group ownership. Later, when the user is not given membership to this group, they can recover group membership with the precompiled binary. The reason that the file-systems that the user has access to are so significant, is the fact that when a system is mounted
_nosuid_
the user is unable to create or execute such a binary file. For this module to provide any level of security, all file-systems that the user has write access to should be mounted
_nosuid_.

The pam_group module functions in parallel with the
/etc/group
file. If the user is granted any groups based on the behavior of this module, they are granted
_in addition_
to those entries
/etc/group
(or equivalent).

<a name="options"></a>

# Options


This module does not recognise any options.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**auth**
module type is provided.

<a name="return-values"></a>

# Return Values


PAM_SUCCESS
group membership was granted.

PAM_ABORT
Not all relevant data could be gotten.

PAM_BUF_ERR
Memory buffer error.

PAM_CRED_ERR
Group membership was not granted.

PAM_IGNORE
**pam\_sm\_authenticate**
was called which does nothing.

PAM_USER_UNKNOWN
The user is not known to the system.

<a name="files"></a>

# Files


/etc/security/group.conf
Default configuration file

<a name="see-also"></a>

# See Also


**group.conf**(5),
**pam.d**(5),
**pam**(8).

<a name="authors"></a>

# Authors


pam_group was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
