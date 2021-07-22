# pam_tty_audit(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_tty_audit - Enable or disable TTY auditing for specified users

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_tty_audit.so&nbsp;'u pam_tty_audit.so [disable=patterns] [enable=patterns]
```

<a name="description"></a>

# Description


The pam_tty_audit PAM module is used to enable or disable TTY auditing. By default, the kernel does not audit input on any TTY.

<a name="options"></a>

# Options


**disable=****patterns**
For each user matching
**patterns**, disable TTY auditing. This overrides any previous
**enable**
option matching the same user name on the command line. See NOTES for further description of
**patterns**.

**enable=****patterns**
For each user matching
**patterns**, enable TTY auditing. This overrides any previous
**disable**
option matching the same user name on the command line. See NOTES for further description of
**patterns**.

**open\_only**
Set the TTY audit flag when opening the session, but do not restore it when closing the session. Using this option is necessary for some services that dont
**fork()**
to run the authenticated session, such as
**sudo**.

**log\_passwd**
Log keystrokes when ECHO mode is off but ICANON mode is active. This is the mode in which the tty is placed during password entry. By default, passwords are not logged. This option may not be available on older kernels (3.9?).

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**session**
type is supported.

<a name="return-values"></a>

# Return Values


PAM_SESSION_ERR
Error reading or modifying the TTY audit flag. See the system log for more details.

PAM_SUCCESS
Success.

<a name="notes"></a>

# Notes


When TTY auditing is enabled, it is inherited by all processes started by that user. In particular, daemons restarted by an user will still have TTY auditing enabled, and audit TTY input even by other users unless auditing for these users is explicitly disabled. Therefore, it is recommended to use
**disable=***
as the first option for most daemons using PAM.

To view the data that was logged by the kernel to audit use the command
**aureport --tty**.

The
**patterns**
are comma separated lists of glob patterns or ranges of uids. A range is specified as
_min\_uid_:_max\_uid_
where one of these values can be empty. If
_min\_uid_
is empty only user with the uid
_max\_uid_
will be matched. If
_max\_uid_
is empty users with the uid greater than or equal to
_min\_uid_
will be matched.

Please note that passwords in some circumstances may be logged by TTY auditing even if the
**log\_passwd**
is not used. For example, all input to an ssh session will be logged - even if there is a password being typed into some software running at the remote host because only the local TTY state affects the local TTY auditing.

<a name="examples"></a>

# Examples


Audit all administrative actions.

.if n \{.RS 4
.\}
    session	required pam_tty_audit.so disable=* enable=root
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**aureport**(8),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_tty_audit was written by Miloslav Trmač &lt;[mitr@redhat.com](mailto:mitr@redhat.com)&gt;. The log_passwd option was added by Richard Guy Briggs &lt;rgb@redhat.com&gt;.
