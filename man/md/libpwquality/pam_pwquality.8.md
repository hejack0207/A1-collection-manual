# pam_pwquality(8)

Red Hat, Inc., 2017-05-26

.if n .ad l
.nh

<a name="name"></a>

# Name

pam_pwquality - PAM module to perform password quality checking

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" pam_pwquality.so [...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This module can be plugged into the **password** stack of a given service
to provide some plug-in strength-checking for passwords.
The code was originally based on pam_cracklib module and the module is
backwards compatible with its options.

The action of this module is to prompt the user for a password and check
its strength against a system dictionary and a set of rules for identifying
poor choices.

The first action is to prompt for a single password, check its strength
and then, if it is considered strong, prompt for the password a second time
(to verify that it was typed correctly on the first occasion). All being
well, the password is passed on to subsequent modules to be installed as the
new authentication token.

The checks for strength are:

* Palindrome  
  .IX Item "Palindrome"
  Is the new password a palindrome?
* Case Change Only  
  .IX Item "Case Change Only"
  Is the new password the the old one with only a change of case?
* Similar  
  .IX Item "Similar"
  Is the new password too much like the old one? This is primarily controlled
  by one argument, **difok** which is a number of character changes (inserts,
  removals, or replacements) between the old and new password that are enough
  to accept the new password.
* Simple  
  .IX Item "Simple"
  Is the new password too small? This is controlled by 6 arguments
  **minlen**, **maxclassrepeat**, **dcredit**, **ucredit**, **lcredit**,
  and **ocredit**. See the section on the arguments for the details of how
  these work and there defaults.
* Rotated  
  .IX Item "Rotated"
  Is the new password a rotated version of the old password?
* Same consecutive characters  
  .IX Item "Same consecutive characters"
  Optional check for same consecutive characters.
* Too long monotonic character sequence  
  .IX Item "Too long monotonic character sequence"
  Optional check for too long monotonic character sequence.
* Contains user name  
  .IX Item "Contains user name"
  Check whether the password contains the user's name in some form.
* Dictionary check  
  .IX Item "Dictionary check"
  The _Cracklib_ routine is called to check if the password is part of
  a dictionary.

These checks are configurable either by use of the module arguments
or by modifying the _/etc/security/pwquality.conf_ configuration file. The
module arguments override the settings in the configuration file.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **debug**  
  .IX Item "debug"
  This option makes the module write information to _syslog_\|(3)
  indicating the behavior of the module (this option does not write password
  information to the log file).
* **authtok\_type=**_\s-1XXX\s0_  
  .IX Item "authtok_type=XXX"
  The default action is for the module to use the following prompts when
  requesting passwords: \f(CW"New UNIX password: " and
  \f(CW"Retype UNIX password: ". The example word
  _\s-1UNIX\s0_ can be replaced with this option, by default it is empty.
* **retry=**_N_  
  .IX Item "retry=N"
  Prompt user at most _N_ times before returning with error. The default is
  _1_.
* **difok=**_N_  
  .IX Item "difok=N"
  This argument will change the default of _1_ for the number of changes in
  the new password from the old password.
  .Sp
  The special value of _0_ disables all checks of similarity of the new password
  with the old password except the new password being exactly the same as
  the old one.
* **minlen=**_N_  
  .IX Item "minlen=N"
  The minimum acceptable size for the new password (plus one if credits are not
  disabled which is the default). In addition to the number of characters in
  the new password, credit (of +1 in length) is given for each different kind
  of character (_other_, _upper_, _lower_ and _digit_). The default for this
  parameter is _8_. Note that there is a pair of length limits also in
  _Cracklib_, which is used for dictionary checking, a way too short\*(R" limit
  of _4_ which is hard coded in and a build time defined limit (_6_) that will
  be checked without reference to **minlen**.
* **dcredit=**_N_  
  .IX Item "dcredit=N"
  (N &gt;= 0) This is the maximum credit for having digits in the new password.
  If you have less than or _N_ digits, each digit will count +1 towards meeting
  the current **minlen** value. The default for **dcredit** is _0_
  which means there is no bonus for digits in password.
  .Sp
  (N &lt; 0) This is the minimum number of digits that must be met for a new
  password.
* **ucredit=**_N_  
  .IX Item "ucredit=N"
  (N &gt;= 0) This is the maximum credit for having upper case letters in the new password.
  If you have less than or _N_ upper case letters, each upper case letter will count +1 towards meeting
  the current **minlen** value. The default for **ucredit** is _0_
  which means there is no bonus for upper case letters in password.
  .Sp
  (N &lt; 0) This is the minimum number of upper case letters that must be met for a new
  password.
* **lcredit=**_N_  
  .IX Item "lcredit=N"
  (N &gt;= 0) This is the maximum credit for having lower case letters in the new password.
  If you have less than or _N_ lower case letters, each lower case letter will count +1 towards meeting
  the current **minlen** value. The default for **lcredit** is _0_
  which means there is no bonus for lower case letters in password.
  .Sp
  (N &lt; 0) This is the minimum number of lower case letters that must be met for a new
  password.
* **ocredit=**_N_  
  .IX Item "ocredit=N"
  (N &gt;= 0) This is the maximum credit for having other characters in the new password.
  If you have less than or _N_ other characters, each other character will count +1 towards meeting
  the current **minlen** value. The default for **ocredit** is _0_
  which means there is no bonus for other characters in password.
  .Sp
  (N &lt; 0) This is the minimum number of other characters that must be met for a new
  password.
* **minclass=**_N_  
  .IX Item "minclass=N"
  The minimum number of required classes of characters for the new password.
  The four classes are digits, upper and lower letters and other characters.
  The difference to the **credit** check is that a specific class if of
  characters is not required. Instead _N_ out of four of the classes are
  required. By default the check is disabled.
* **maxrepeat=**_N_  
  .IX Item "maxrepeat=N"
  Reject passwords which contain more than _N_ same consecutive characters.
  The default is 0 which means that this check is disabled.
* **maxsequence=**_N_  
  .IX Item "maxsequence=N"
  Reject passwords which contain monotonic character sequences longer than _N_.
  The default is 0 which means that this check is disabled.
  Examples of such sequence are '12345' or 'fedcb'. Note that
  most such passwords will not pass the simplicity check unless the sequence
  is only a minor part of the password.
* **maxclassrepeat=**_N_  
  .IX Item "maxclassrepeat=N"
  Reject passwords which contain more than _N_ consecutive characters of the
  same class. The default is 0 which means that this check is disabled.
* **gecoscheck=**_N_  
  .IX Item "gecoscheck=N"
  If nonzero, check whether the individual words longer than 3 characters
  from the _passwd_\|(5) \s-1GECOS\s0 field of the user are contained in the new
  password. The default is 0 which means that this check is disabled.
* **dictcheck=**_N_  
  .IX Item "dictcheck=N"
  If nonzero, check whether the password (with possible modifications)
  matches a word in a dictionary. Currently the dictionary check is performed
  using the _cracklib_ library. The default is 1 which means that this check
  is enabled.
* **usercheck=**_N_  
  .IX Item "usercheck=N"
  If nonzero, check whether the password (with possible modifications)
  contains the user name in some form. The default is 1 which means that
  this check is enabled. It is not performed for user names shorter
  than 3 characters.
* **enforcing=**_N_  
  .IX Item "enforcing=N"
  If nonzero, reject the password if it fails the checks, otherwise
  only print the warning. The default is 1 which means that the weak password
  is rejected (for non-root users).
* **badwords=**_&lt;list of words&gt;_  
  .IX Item "badwords=&lt;list of words&gt;"
  The words more than 3 characters long from this space separated list are
  individually searched for and forbidden in the new password.
  By default the list is empty which means that this check is disabled.
* **dictpath=**_/path/to/dict_  
  .IX Item "dictpath=/path/to/dict"
  This options allows for specification of non-default path to the cracklib
  dictionaries.
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
* **use\_authtok**  
  .IX Item "use_authtok"
  This argument is used to _force_ the module to not prompt the user for
  a new password but use the one provided by the previously stacked
  **password** module.

<a name="module-types-provided"></a>

# Module Types Provided

.IX Header "MODULE TYPES PROVIDED"
Only the **password** module type is provided.

<a name="return-values"></a>

# Return Values

.IX Header "RETURN VALUES"

* \s-1PAM_SUCCESS\s0  
  .IX Item "PAM_SUCCESS"
  The new password passes all checks.
* \s-1PAM_AUTHTOK_ERR\s0  
  .IX Item "PAM_AUTHTOK_ERR"
  No new password was entered, the username could not be determined or the
  new password fails the strength checks.
* \s-1PAM_AUTHTOK_RECOVERY_ERR\s0  
  .IX Item "PAM_AUTHTOK_RECOVERY_ERR"
  The old password was not supplied by a previous stacked module or got not
  requested from the user. The first error can happen if **use\_authtok**
  is specified.
* \s-1PAM_SERVICE_ERR\s0  
  .IX Item "PAM_SERVICE_ERR"
  A internal error occurred.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
For an example of the use of this module, we show how it may be stacked
with the password component of _pam\_unix_\|(8).

.Vb 9
 #
 # These lines stack two password type modules. In this example the
 # user is given 3 opportunities to enter a strong password. The
 # "use_authtok" argument ensures that the pam_unix module does not
 # prompt for a password, but instead uses the one provided by
 # pam_pwquality.
 #
 password required pam_pwquality.so retry=3
 password required pam_unix.so use_authtok
.Ve

Another example is for the case that you want to use sha256 password
encryption:

.Vb 9
 #
 # These lines allow modern systems to support passwords of at least 14
 # bytes with extra credit of 2 for digits and 2 for others the new
 # password must have at least three bytes that are not present in the
 # old password
 #
 password required pam_pwquality.so \e
               difok=3 minlen=15 dcredit=2 ocredit=2
 password required pam_unix.so use_authtok nullok sha256
.Ve

And here is another example in case you don't want to use credits:

.Vb 8
 #
 # These lines require the user to select a password with a minimum
 # length of 8 and with at least 1 digit number, 1 upper case letter,
 # and 1 other character
 #
 password required pam_pwquality.so \e
               dcredit=-1 ucredit=-1 ocredit=-1 lcredit=0 minlen=8
 password required pam_unix.so use_authtok nullok sha256
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_pwscore_\|(1), _pwquality.conf_\|(5), _pam\_pwquality_\|(8),
_pam.conf_\|(5), \s-1_PAM\s0_\|(8)

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;

Original author of **pam\_cracklib** module Cristian Gafton &lt;[gafton@redhat.com](mailto:gafton@redhat.com)&gt;
