# faillock(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

faillock - Tool for displaying and modifying the authentication failure record files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'faillock&nbsp;'u faillock [--dir&nbsp;/path/to/tally-directory] [--user&nbsp;username] [--reset]
```

<a name="description"></a>

# Description


The
_pam\_faillock.so_
module maintains a list of failed authentication attempts per user during a specified interval and locks the account in case there were more than
_deny_
consecutive failed authentications. It stores the failure records into per-user files in the tally directory.

The
**faillock**
command is an application which can be used to examine and modify the contents of the tally files. It can display the recent failed authentication attempts of the
_username_
or clear the tally files of all or individual
_usernames_.

<a name="options"></a>

# Options


**--dir ****/path/to/tally-directory**
The directory where the user files with the failure records are kept. The default is
/var/run/faillock.

**--user ****username**
The user whose failure records should be displayed or cleared.

**--reset**
Instead of displaying the users failure records, clear them.

<a name="files"></a>

# Files


/var/run/faillock/*
the files logging the authentication failures for users

<a name="see-also"></a>

# See Also


**pam\_faillock**(8),
**pam**(8)

<a name="author"></a>

# Author


faillock was written by Tomas Mraz.
