# pwscore(1)

Red Hat, Inc., 2017-02-10

.if n .ad l
.nh

<a name="name"></a>

# Name

pwscore - simple configurable tool for checking quality of a password

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" pwscore [user]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**pwscore** is a simple tool for checking quality of a password. The password
is read from stdin.

The tool uses the **libpwquality** library to perform configurable checks
for minimum length, dictionary checking against cracklib dictionaries,
and other checks.

It either reports an error if the password fails any of the checks, or it
prints out the password quality score as an integer value between _0_ and
_100_.

The password quality score is relative to the **minlen** setting in the
configuration file. But in general values below 50 can be treated as moderate
quality and above it fairly strong quality. Any password that passes the quality
checks (especially the mandatory cracklib check) should withstand dictionary
attacks and scores above 50 with the default minlen setting even fast brute
force attacks.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The first and only optional argument is the user name that is used to check
the similarity of the password to the username.

<a name="files"></a>

# Files

.IX Header "FILES"
_/etc/security/pwquality.conf_ - The configuration file for the libpwquality
library.

<a name="return-codes"></a>

# Return Codes

.IX Header "RETURN CODES"
**pwscore** returns 0 on success, non zero on error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_pwscore_\|(1), _pwquality.conf_\|(5), _pam\_pwquality_\|(8)

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;
