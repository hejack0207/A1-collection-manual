# pam_wheel(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_wheel - Only permit root access to members of group wheel

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_wheel.so&nbsp;'u pam_wheel.so [debug] [deny] [group=name] [root_only] [trust] [use_uid]
```

<a name="description"></a>

# Description


The pam_wheel PAM module is used to enforce the so-called
_wheel_
group. By default it permits access to the target user if the applicant user is a member of the
_wheel_
group. If no group with this name exist, the module is using the group with the group-ID
**0**.

<a name="options"></a>

# Options


**debug**
Print debug information.

**deny**
Reverse the sense of the auth operation: if the user is trying to get UID 0 access and is a member of the wheel group (or the group of the
**group**
option), deny access. Conversely, if the user is not in the group, return PAM_IGNORE (unless
**trust**
was also specified, in which case we return PAM_SUCCESS).

**group=****name**
Instead of checking the wheel or GID 0 groups, use the
**name**
group to perform the authentication.

**root\_only**
The check for wheel membership is done only when the target user UID is 0.

**trust**
The pam_wheel module will return PAM_SUCCESS instead of PAM_IGNORE if the user is a member of the wheel group (thus with a little play stacking the modules the wheel members may be able to su to root without being prompted for a passwd).

**use\_uid**
The check for wheel membership will be done against the current uid instead of the original one (useful when jumping with su from one account to another for example).

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
Authentication failure.

PAM_BUF_ERR
Memory buffer error.

PAM_IGNORE
The return value should be ignored by PAM dispatch.

PAM_PERM_DENY
Permission denied.

PAM_SERVICE_ERR
Cannot determine the user name.

PAM_SUCCESS
Success.

PAM_USER_UNKNOWN
User not known.

<a name="examples"></a>

# Examples


The root account gains access by default (rootok), only wheel members can become root (wheel) but Unix authenticate non-root applicants.

.if n \{.RS 4
.\}
    su      auth     sufficient     pam_rootok.so
    su      auth     required       pam_wheel.so
    su      auth     required       pam_unix.so
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_wheel was written by Cristian Gafton &lt;[gafton@redhat.com](mailto:gafton@redhat.com)&gt;.
