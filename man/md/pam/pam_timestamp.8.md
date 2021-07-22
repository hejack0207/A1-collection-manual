# pam_timestamp(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_timestamp - Authenticate using cached successful authentication attempts

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_timestamp.so&nbsp;'u pam_timestamp.so [timestampdir=directory] [timestamp_timeout=number] [verbose] [debug]
```

<a name="description"></a>

# Description


In a nutshell,
_pam\_timestamp_
caches successful authentication attempts, and allows you to use a recent successful attempt as the basis for authentication. This is similar mechanism which is used in
**sudo**.

When an application opens a session using
_pam\_timestamp_, a timestamp file is created in the
_timestampdir_
directory for the user. When an application attempts to authenticate the user, a
_pam\_timestamp_
will treat a sufficiently recent timestamp file as grounds for succeeding.

<a name="options"></a>

# Options


**timestampdir=****directory**
Specify an alternate directory where
_pam\_timestamp_
creates timestamp files.

**timestamp\_timeout=****number**
How long should
_pam\_timestamp_
treat timestamp as valid after their last modification date (in seconds). Default is 300 seconds.

**verbose**
Attempt to inform the user when access is granted.

**debug**
Turns on debugging messages sent to
**syslog**(3).

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**
and
**session**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_AUTH_ERR
The module was not able to retrieve the user name or no valid timestamp file was found.

PAM_SUCCESS
Everything was successful.

PAM_SESSION_ERR
Timestamp file could not be created or updated.

<a name="notes"></a>

# Notes


Users can get confused when they are not always asked for passwords when running a given program. Some users reflexively begin typing information before noticing that it is not being asked for.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    auth sufficient pam_timestamp.so verbose
    auth required   pam_unix.so
    
    session required pam_unix.so
    session optional pam_timestamp.so
        
.if n \{.RE
.\}

<a name="files"></a>

# Files


/var/run/pam_timestamp/...
timestamp files and directories

<a name="see-also"></a>

# See Also


**pam\_timestamp\_check**(8),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_timestamp was written by Nalin Dahyabhai.
