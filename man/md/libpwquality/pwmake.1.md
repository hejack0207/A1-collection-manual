# pwmake(1)

Red Hat, Inc., 2017-02-10

.if n .ad l
.nh

<a name="name"></a>

# Name

pwmake - simple tool for generating random relatively easily pronounceable
passwords

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" pwmake <entropy-bits>
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**pwmake** is a simple configurable tool for generating random and relatively
easily pronounceable passwords. The tool allows you to specify the number of
entropy bits that are used to generate the password.

The entropy is pulled from _/dev/urandom_.

The minimum number of bits is _56_ which is usable for passwords on
systems/services where brute force attacks are of very limited rate of tries.
The _64_ bits should be adequate for applications where the attacker
does not have direct access to the password hash file. For situations where
the attacker might obtain the direct access to the password hash or the
password is used as an encryption key _80_ to _128_ bits should be
used depending on your level of paranoia.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The first and only argument is the number of bits of entropy used to generate
the password.

<a name="files"></a>

# Files

.IX Header "FILES"
_/etc/security/pwquality.conf_ - The configuration file for the libpwquality
library.

<a name="return-codes"></a>

# Return Codes

.IX Header "RETURN CODES"
**pwmake** returns 0 on success, non zero on error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_pwscore_\|(1), _pam\_pwquality_\|(8)

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;
