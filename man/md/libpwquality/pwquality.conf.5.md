# pwquality.conf(5)

Red Hat, Inc., 2018-09-14

.if n .ad l
.nh

<a name="name"></a>

# Name

pwquality.conf - configuration for the libpwquality library

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" /etc/security/pwquality.conf 
 /etc/security/pwquality.conf.d/*.conf
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**pwquality.conf** provides a way to configure the default password
quality requirements for the system passwords. This file is read by the
libpwquality library and utilities that use this library for checking
and generating passwords.

The file has a very simple _name = value_ format with possible comments
starting with \f(CW`#\*(C' character. The whitespace at the beginning of line, end
of line, and around the \f(CW`=\*(C' sign is ignored.

The libpwquality library also first reads all _*.conf_ files from the
_/etc/security/pwquality.conf.d_ directory in \s-1ASCII\s0 sorted order. The
values of the same settings are overridden in the order the files are parsed.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The possible options in the file are:

* **difok**  
  .IX Item "difok"
  Number of characters in the new password that must not be present in the
  old password. (default 1)
  .Sp
  The special value of 0 disables all checks of similarity of the new password
  with the old password except the new password being exactly the same as
  the old one.
* **minlen**  
  .IX Item "minlen"
  Minimum acceptable size for the new password (plus one if credits are not
  disabled which is the default). (See **pam\_pwquality**\|(8).)
  Cannot be set to lower value than 6. (default 8)
* **dcredit**  
  .IX Item "dcredit"
  The maximum credit for having digits in the new password. If less than 0
  it is the minimum number of digits in the new password. (default 0)
* **ucredit**  
  .IX Item "ucredit"
  The maximum credit for having uppercase characters in the new password.
  If less than 0 it is the minimum number of uppercase characters in the new
  password. (default 0)
* **lcredit**  
  .IX Item "lcredit"
  The maximum credit for having lowercase characters in the new password.
  If less than 0 it is the minimum number of lowercase characters in the new
  password. (default 0)
* **ocredit**  
  .IX Item "ocredit"
  The maximum credit for having other characters in the new password.
  If less than 0 it is the minimum number of other characters in the new
  password. (default 0)
* **minclass**  
  .IX Item "minclass"
  The minimum number of required classes of characters for the new
  password (digits, uppercase, lowercase, others). (default 0)
* **maxrepeat**  
  .IX Item "maxrepeat"
  The maximum number of allowed same consecutive characters in the new password.
  The check is disabled if the value is 0. (default 0)
* **maxsequence**  
  .IX Item "maxsequence"
  The maximum length of monotonic character sequences in the new password.
  Examples of such sequence are '12345' or 'fedcb'. Note
  that most such passwords will not pass the simplicity check unless
  the sequence is only a minor part of the password.
  The check is disabled if the value is 0. (default 0)
* **maxclassrepeat**  
  .IX Item "maxclassrepeat"
  The maximum number of allowed consecutive characters of the same class in the
  new password.
  The check is disabled if the value is 0. (default 0)
* **gecoscheck**  
  .IX Item "gecoscheck"
  If nonzero, check whether the words longer than 3 characters from the _\s-1GECOS\s0_
  field of the user's **passwd**\|(5) entry are contained in the new password.
  The check is disabled if the value is 0. (default 0)
* **dictcheck**  
  .IX Item "dictcheck"
  If nonzero, check whether the password (with possible modifications)
  matches a word in a dictionary. Currently the dictionary check is performed
  using the cracklib library. (default 1)
* **usercheck=**_N_  
  .IX Item "usercheck=N"
  If nonzero, check whether the password (with possible modifications)
  contains the user name in some form. It is not performed for user names shorter
  than 3 characters. (default 1)
* **enforcing=**_N_  
  .IX Item "enforcing=N"
  If nonzero, reject the password if it fails the checks, otherwise
  only print the warning. This setting applies only to the pam_pwquality module
  and possibly other applications that explicitly change their behavior
  based on it. It does not affect **pwmake**\|(1) and **pwscore**\|(1). (default 1)
* **badwords**  
  .IX Item "badwords"
  Space separated list of words that must not be contained in the password. These
  are additional words to the cracklib dictionary check. This setting can be
  also used by applications to emulate the gecos check for user accounts that are
  not created yet.
* **dictpath**  
  .IX Item "dictpath"
  Path to the cracklib dictionaries. Default is to use the cracklib default.
* **retry=**_N_  
  .IX Item "retry=N"
  Prompt user at most _N_ times before returning with error. The default is
  _1_.
* **enforce\_for\_root**  
  .IX Item "enforce_for_root"
  The module will return error on failed check even if the user changing the
  password is root. This option is off by default which means that just
  the message about the failed check is printed but root can change
  the password anyway. Note that root is not asked for an old password
  so the checks that compare the old and new password are not performed.
* **local\_users\_only**  
  .IX Item "local_users_only"
  The module will not test the password quality for users that are not present
  in the _/etc/passwd_ file. The module still asks for the password so
  the following modules in the stack can use the **use\_authtok** option.
  This option is off by default.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pwscore**\|(1), **pwmake**\|(1), **pam\_pwquality**\|(8)

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;
