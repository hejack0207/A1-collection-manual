# pam_succeed_if(8)

Linux-PAM, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_succeed_if - test account characteristics

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_succeed_if.so&nbsp;'u pam_succeed_if.so [flag...] [condition...]
```

<a name="description"></a>

# Description


pam_succeed_if.so is designed to succeed or fail authentication based on characteristics of the account belonging to the user being authenticated or values of other PAM items. One use is to select whether to load other modules based on this test.

The module should be given one or more conditions as module arguments, and authentication will succeed only if all of the conditions are met.

<a name="options"></a>

# Options


The following
_flag_s are supported:

**debug**
Turns on debugging messages sent to syslog.

**use\_uid**
Evaluate conditions using the account of the user whose UID the application is running under instead of the user being authenticated.

**quiet**
Dont log failure or success to the system log.

**quiet\_fail**
Dont log failure to the system log.

**quiet\_success**
Dont log success to the system log.

**audit**
Log unknown users to the system log.

_Condition_s are three words: a field, a test, and a value to test for.

Available fields are
_user_,
_uid_,
_gid_,
_shell_,
_home_,
_ruser_,
_rhost_,
_tty_
and
_service_:

**field &lt; number**
Field has a value numerically less than number.

**field &lt;= number**
Field has a value numerically less than or equal to number.

**field eq number**
Field has a value numerically equal to number.

**field &gt;= number**
Field has a value numerically greater than or equal to number.

**field &gt; number**
Field has a value numerically greater than number.

**field ne number**
Field has a value numerically different from number.

**field = string**
Field exactly matches the given string.

**field != string**
Field does not match the given string.

**field =~ glob**
Field matches the given glob.

**field !~ glob**
Field does not match the given glob.

**field in item:item:...**
Field is contained in the list of items separated by colons.

**field notin item:item:...**
Field is not contained in the list of items separated by colons.

**user ingroup group[:group:....]**
User is in given group(s).

**user notingroup group[:group:....]**
User is not in given group(s).

**user innetgr netgroup**
(user,host) is in given netgroup.

**user notinnetgr group**
(user,host) is not in given netgroup.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**account**,
**auth**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values


PAM_SUCCESS
The condition was true.

PAM_AUTH_ERR
The condition was false.

PAM_SERVICE_ERR
A service error occurred or the arguments cant be parsed correctly.

<a name="examples"></a>

# Examples


To emulate the behaviour of
_pam\_wheel_, except there is no fallback to group 0 being only approximated by checking also the root group membership:

.if n \{.RS 4
.\}
    auth required pam_succeed_if.so quiet user ingroup wheel:root
        
.if n \{.RE
.\}

Given that the type matches, only loads the othermodule rule if the UID is over 500. Adjust the number after default to skip several rules.

.if n \{.RS 4
.\}
    type [default=1 success=ignore] pam_succeed_if.so quiet uid > 500
    type required othermodule.so arguments...
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**glob**(7),
**pam**(8)

<a name="author"></a>

# Author


Nalin Dahyabhai &lt;[nalin@redhat.com](mailto:nalin@redhat.com)&gt;
