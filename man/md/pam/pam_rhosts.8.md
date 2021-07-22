# pam_rhosts(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_rhosts - The rhosts PAM module

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_rhosts.so&nbsp;'u pam_rhosts.so
```

<a name="description"></a>

# Description


This module performs the standard network authentication for services, as used by traditional implementations of
**rlogin**
and
**rsh**
etc.

The authentication mechanism of this module is based on the contents of two files;
/etc/hosts.equiv
(or and
~/.rhosts. Firstly, hosts listed in the former file are treated as equivalent to the localhost. Secondly, entries in the users own copy of the latter file is used to map "_remote-host remote-user_" pairs to that user\*(Aqs account on the current host. Access is granted to the user if their host is present in
/etc/hosts.equiv
and their remote account is identical to their local one, or if their remote account has an entry in their personal configuration file.

The module authenticates a remote user (internally specified by the item
_PAM\_RUSER_
connecting from the remote host (internally specified by the item
**PAM\_RHOST**). Accordingly, for applications to be compatible this authentication module they must set these items prior to calling
**pam\_authenticate()**. The module is not capable of independently probing the network connection for such information.

<a name="options"></a>

# Options


**debug**
Print debug information.

**silent**
Dont print informative messages.

**superuser=****account**
Handle
_account_
as root.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**auth**
module type is provided.

<a name="return-values"></a>

# Return Values


PAM_AUTH_ERR
The remote host, remote user name or the local user name couldnt be determined or access was denied by
.rhosts
file.

PAM_USER_UNKNOWN
User is not known to system.

<a name="examples"></a>

# Examples


To grant a remote user access by
/etc/hosts.equiv
or
.rhosts
for
**rsh**
add the following lines to
/etc/pam.d/rsh:

.if n \{.RS 4
.\}
    #%PAM-1.0
    #
    auth     required       pam_rhosts.so
    auth     required       pam_nologin.so
    auth     required       pam_env.so
    auth     required       pam_unix.so
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**rootok**(3),
**hosts.equiv**(5),
**rhosts**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_rhosts was written by Thorsten Kukuk &lt;[kukuk@thkukuk.de](mailto:kukuk@thkukuk.de)&gt;
