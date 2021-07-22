# pam_faillock(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_faillock - Module counting authentication failures during a specified interval

<a name="synopsis"></a>

# Synopsis

```
.HP \w'auth&nbsp;...&nbsp;pam_faillock.so&nbsp;'u auth ... pam_faillock.so {preauth|authfail|authsucc} [conf=/path/to/config-file] [dir=/path/to/tally-directory] [even_deny_root] [deny=n] [fail_interval=n] [unlock_time=n] [root_unlock_time=n] [admin_group=name] [audit] [silent] [no_log_info] .HP \w'account&nbsp;...&nbsp;pam_faillock.so&nbsp;'u account ... pam_faillock.so [dir=/path/to/tally-directory] [no_log_info]
```

<a name="description"></a>

# Description


This module maintains a list of failed authentication attempts per user during a specified interval and locks the account in case there were more than
_deny_
consecutive failed authentications.

Normally, failed attempts to authenticate
_root_
will
**not**
cause the root account to become blocked, to prevent denial-of-service: if your users arent given shell accounts and root may only login via
**su**
or at the machine console (not telnet/rsh, etc), this is safe.

<a name="options"></a>

# Options


**{preauth|authfail|authsucc}**
This argument must be set accordingly to the position of this module instance in the PAM stack.

The
_preauth_
argument must be used when the module is called before the modules which ask for the user credentials such as the password. The module just examines whether the user should be blocked from accessing the service in case there were anomalous number of failed consecutive authentication attempts recently. This call is optional if
_authsucc_
is used.

The
_authfail_
argument must be used when the module is called after the modules which determine the authentication outcome, failed. Unless the user is already blocked due to previous authentication failures, the module will record the failure into the appropriate user tally file.

The
_authsucc_
argument must be used when the module is called after the modules which determine the authentication outcome, succeeded. Unless the user is already blocked due to previous authentication failures, the module will then clear the record of the failures in the respective user tally file. Otherwise it will return authentication error. If this call is not done, the pam_faillock will not distinguish between consecutive and non-consecutive failed authentication attempts. The
_preauth_
call must be used in such case. Due to complications in the way the PAM stack can be configured it is also possible to call
_pam\_faillock_
as an account module. In such configuration the module must be also called in the
_preauth_
stage.

**conf=/path/to/config-file**
Use another configuration file instead of the default
/etc/security/faillock.conf.

The options for configuring the module behavior are described in the
**faillock.conf**(5)
manual page. The options specified on the module command line override the values from the configuration file.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**
and
**account**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_AUTH_ERR
An invalid option was given, the module was not able to retrieve the user name, no valid counter file was found, or too many failed logins.

PAM_BUF_ERR
Memory buffer error.

PAM_CONV_ERR
The conversation method supplied by the application failed to obtain the username.

PAM_INCOMPLETE
The conversation method supplied by the application returned PAM_CONV_AGAIN.

PAM_SUCCESS
Everything was successful.

PAM_IGNORE
User not present in passwd database.

<a name="notes"></a>

# Notes


Configuring options on the module command line is not recommend. The
/etc/security/faillock.conf
should be used instead.

The setup of
_pam\_faillock_
in the PAM stack is different from the
_pam\_tally2_
module setup.

Individual files with the failure records are created as owned by the user. This allows
**pam\_faillock.so**
module to work correctly when it is called from a screensaver.

Note that using the module in
**preauth**
without the
**silent**
option specified in
/etc/security/faillock.conf
or with
_requisite_
control field leaks an information about existence or non-existence of an user account in the system because the failures are not recorded for the unknown users. The message about the user account being locked is never displayed for non-existing user accounts allowing the adversary to infer that a particular account is not existing on a system.

<a name="examples"></a>

# Examples


Here are two possible configuration examples for
/etc/pam.d/login. They make
_pam\_faillock_
to lock the account after 4 consecutive failed logins during the default interval of 15 minutes. Root account will be locked as well. The accounts will be automatically unlocked after 20 minutes.

In the first example the module is called only in the
_auth_
phase and the module does not print any information about the account being blocked by
_pam\_faillock_. The
_preauth_
call can be added to tell users that their logins are blocked by the module and also to abort the authentication without even asking for password in such case.

/etc/security/faillock.conf
file example:

.if n \{.RS 4
.\}
    deny=4
    unlock_time=1200
    silent
        
.if n \{.RE
.\}

/etc/pam.d/config file example:

.if n \{.RS 4
.\}
    auth     required       pam_securetty.so
    auth     required       pam_env.so
    auth     required       pam_nologin.so
    # optionally call: auth requisite pam_faillock.so preauth
    # to display the message about account being locked
    auth     [success=1 default=bad] pam_unix.so
    auth     [default=die]  pam_faillock.so authfail
    auth     sufficient     pam_faillock.so authsucc
    auth     required       pam_deny.so
    account  required       pam_unix.so
    password required       pam_unix.so shadow
    session  required       pam_selinux.so close
    session  required       pam_loginuid.so
    session  required       pam_unix.so
    session  required       pam_selinux.so open
        
.if n \{.RE
.\}

In the second example the module is called both in the
_auth_
and
_account_
phases and the module informs the authenticating user when the account is locked if
**silent**
option is not specified in the
faillock.conf.

.if n \{.RS 4
.\}
    auth     required       pam_securetty.so
    auth     required       pam_env.so
    auth     required       pam_nologin.so
    auth     required       pam_faillock.so preauth
    # optionally use requisite above if you do not want to prompt for the password
    # on locked accounts
    auth     sufficient     pam_unix.so
    auth     [default=die]  pam_faillock.so authfail
    auth     required       pam_deny.so
    account  required       pam_faillock.so
    # if you drop the above call to pam_faillock.so the lock will be done also
    # on non-consecutive authentication failures
    account  required       pam_unix.so
    password required       pam_unix.so shadow
    session  required       pam_selinux.so close
    session  required       pam_loginuid.so
    session  required       pam_unix.so
    session  required       pam_selinux.so open
        
.if n \{.RE
.\}

<a name="files"></a>

# Files


/var/run/faillock/*
the files logging the authentication failures for users

/etc/security/faillock.conf
the config file for pam_faillock options

<a name="see-also"></a>

# See Also


**faillock**(8),
**faillock.conf**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_faillock was written by Tomas Mraz.
