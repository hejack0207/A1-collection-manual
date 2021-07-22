# pam_issue(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_issue - PAM module to add issue file to user prompt

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_issue.so&nbsp;'u pam_issue.so [noesc] [issue=issue-file-name]
```

<a name="description"></a>

# Description


pam_issue is a PAM module to prepend an issue file to the username prompt. It also by default parses escape codes in the issue file similar to some common gettys (using \ex format).

Recognized escapes:

**\ed**
current day

**\el**
name of this tty

**\em**
machine architecture (uname -m)

**\en**
machines network node hostname (uname -n)

**\eo**
domain name of this system

**\er**
release number of operating system (uname -r)

**\et**
current time

**\es**
operating system name (uname -s)

**\eu**
number of users currently logged in

**\eU**
same as \eu except it is suffixed with "user" or "users" (eg. "1 user" or "10 users")

**\ev**
operating system version and build date (uname -v)

<a name="options"></a>

# Options



**noesc**
Turns off escape code parsing.

**issue=****issue-file-name**
The file to output if not using the default.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**auth**
module type is provided.

<a name="return-values"></a>

# Return Values



PAM_BUF_ERR
Memory buffer error.

PAM_IGNORE
The prompt was already changed.

PAM_SERVICE_ERR
A service module error occurred.

PAM_SUCCESS
The new prompt was set successfully.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/login
to set the user specific issue at login:

.if n \{.RS 4
.\}
            auth optional pam_issue.so issue=/etc/issue
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_issue was written by Ben Collins &lt;[bcollins@debian.org](mailto:bcollins@debian.org)&gt;.
