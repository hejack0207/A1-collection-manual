# pam\&.conf(5)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam.conf, pam.d - PAM configuration files

<a name="description"></a>

# Description


When a
_PAM_
aware privilege granting application is started, it activates its attachment to the PAM-API. This activation performs a number of tasks, the most important being the reading of the configuration file(s):
/etc/pam.conf. Alternatively, this may be the contents of the
/etc/pam.d/
directory. The presence of this directory will cause Linux-PAM to ignore
/etc/pam.conf.

These files list the
_PAM_s that will do the authentication tasks required by this service, and the appropriate behavior of the PAM-API in the event that individual
_PAM_s fail.

The syntax of the
/etc/pam.conf
configuration file is as follows. The file is made up of a list of rules, each rule is typically placed on a single line, but may be extended with an escaped end of line: \`\e&lt;LF&gt;. Comments are preceded with \`#\*(Aq marks and extend to the next end of line.

The format of each rule is a space separated collection of tokens, the first three being case-insensitive:

** service type control module-path module-arguments**

The syntax of files contained in the
/etc/pam.d/
directory, are identical except for the absence of any
_service_
field. In this case, the
_service_
is the name of the file in the
/etc/pam.d/
directory. This filename must be in lower case.

An important feature of
_PAM_, is that a number of rules may be
_stacked_
to combine the services of a number of PAMs for a given authentication task.

The
_service_
is typically the familiar name of the corresponding application:
_login_
and
_su_
are good examples. The
_service_-name,
_other_, is reserved for giving
_default_
rules. Only lines that mention the current service (or in the absence of such, the
_other_
entries) will be associated with the given service-application.

The
_type_
is the management group that the rule corresponds to. It is used to specify which of the management groups the subsequent module is to be associated with. Valid entries are:

account
this module type performs non-authentication based account management. It is typically used to restrict/permit access to a service based on the time of day, currently available system resources (maximum number of users) or perhaps the location of the applicant user -- root\*(Aq login only on the console.

auth
this module type provides two aspects of authenticating the user. Firstly, it establishes that the user is who they claim to be, by instructing the application to prompt the user for a password or other means of identification. Secondly, the module can grant group membership or other privileges through its credential granting properties.

password
this module type is required for updating the authentication token associated with the user. Typically, there is one module for each challenge/response\*(Aq based authentication (auth) type.

session
this module type is associated with doing things that need to be done for the user before/after they can be given service. Such things include the logging of information concerning the opening/closing of some data exchange with a user, mounting directories, etc.

If the
_type_
value from the list above is prepended with a
_-_
character the PAM library will not log to the system log if it is not possible to load the module because it is missing in the system. This can be useful especially for modules which are not always installed on the system and are not required for correct authentication and authorization of the login session.

The third field,
_control_, indicates the behavior of the PAM-API should the module fail to succeed in its authentication task. There are two types of syntax for this control field: the simple one has a single simple keyword; the more complicated one involves a square-bracketed selection of
_value=action_
pairs.

For the simple (historical) syntax valid
_control_
values are:

required
failure of such a PAM will ultimately lead to the PAM-API returning failure but only after the remaining
_stacked_
modules (for this
_service_
and
_type_) have been invoked.

requisite
like
_required_, however, in the case that such a module returns a failure, control is directly returned to the application or to the superior PAM stack. The return value is that associated with the first required or requisite module to fail. Note, this flag can be used to protect against the possibility of a user getting the opportunity to enter a password over an unsafe medium. It is conceivable that such behavior might inform an attacker of valid accounts on a system. This possibility should be weighed against the not insignificant concerns of exposing a sensitive password in a hostile environment.

sufficient
if such a module succeeds and no prior
_required_
module has failed the PAM framework returns success to the application or to the superior PAM stack immediately without calling any further modules in the stack. A failure of a
_sufficient_
module is ignored and processing of the PAM module stack continues unaffected.

optional
the success or failure of this module is only important if it is the only module in the stack associated with this
_service_+_type_.

include
include all lines of given type from the configuration file specified as an argument to this control.

substack
include all lines of given type from the configuration file specified as an argument to this control. This differs from
_include_
in that evaluation of the
_done_
and
_die_
actions in a substack does not cause skipping the rest of the complete module stack, but only of the substack. Jumps in a substack also can not make evaluation jump out of it, and the whole substack is counted as one module when the jump is done in a parent stack. The
_reset_
action will reset the state of a module stack to the state it was in as of beginning of the substack evaluation.

For the more complicated syntax valid
_control_
values have the following form:

.if n \{.RS 4
.\}
          [value1=action1 value2=action2 ...]
        
.if n \{.RE
.\}

Where
_valueN_
corresponds to the return code from the function invoked in the module for which the line is defined. It is selected from one of these:
_success_,
_open\_err_,
_symbol\_err_,
_service\_err_,
_system\_err_,
_buf\_err_,
_perm\_denied_,
_auth\_err_,
_cred\_insufficient_,
_authinfo\_unavail_,
_user\_unknown_,
_maxtries_,
_new\_authtok\_reqd_,
_acct\_expired_,
_session\_err_,
_cred\_unavail_,
_cred\_expired_,
_cred\_err_,
_no\_module\_data_,
_conv\_err_,
_authtok\_err_,
_authtok\_recover\_err_,
_authtok\_lock\_busy_,
_authtok\_disable\_aging_,
_try\_again_,
_ignore_,
_abort_,
_authtok\_expired_,
_module\_unknown_,
_bad\_item_,
_conv\_again_,
_incomplete_, and
_default_.

The last of these,
_default_, implies all
_valueN_s not mentioned explicitly. Note, the full list of PAM errors is available in
/usr/include/security/_pam_types.h. The
_actionN_
can take one of the following forms:

ignore
when used with a stack of modules, the modules return status will not contribute to the return code the application obtains.

bad
this action indicates that the return code should be thought of as indicative of the module failing. If this module is the first in the stack to fail, its status value will be used for that of the whole stack.

die
equivalent to bad with the side effect of terminating the module stack and PAM immediately returning to the application.

ok
this tells PAM that the administrator thinks this return code should contribute directly to the return code of the full stack of modules. In other words, if the former state of the stack would lead to a return of
_PAM\_SUCCESS_, the modules return code will override this value. Note, if the former state of the stack holds some value that is indicative of a modules failure, this \*(Aqok\*(Aq value will not be used to override that value.

done
equivalent to ok with the side effect of terminating the module stack and PAM immediately returning to the application.

N (an unsigned integer)
jump over the next N modules in the stack. Note that N equal to 0 is not allowed, it would be treated as
_ignore_
in such case. The side effect depends on the PAM function call: for
_pam\_authenticate_,
_pam\_acct\_mgmt_,
_pam\_chauthtok_, and
_pam\_open\_session_
it is
_ignore_; for
_pam\_setcred_
and
_pam\_close\_session_
it is one of
_ignore_,
_ok_, or
_bad_
depending on the modules return value.

reset
clear all memory of the state of the module stack and start again with the next stacked module.

Each of the four keywords: required; requisite; sufficient; and optional, have an equivalent expression in terms of the [...] syntax. They are as follows:

required
[success=ok new_authtok_reqd=ok ignore=ignore default=bad]

requisite
[success=ok new_authtok_reqd=ok ignore=ignore default=die]

sufficient
[success=done new_authtok_reqd=done default=ignore]

optional
[success=ok new_authtok_reqd=ok default=ignore]

_module-path_
is either the full filename of the PAM to be used by the application (it begins with a /\*(Aq), or a relative pathname from the default module location:
/lib/security/
or
/lib64/security/, depending on the architecture.

_module-arguments_
are a space separated list of tokens that can be used to modify the specific behavior of the given PAM. Such arguments will be documented for each individual module. Note, if you wish to include spaces in an argument, you should surround that argument with square brackets.

.if n \{.RS 4
.\}
        squid auth required pam_mysql.so user=passwd_query passwd=mada e
              db=eminence [query=select user_name from internet_service e
              where user_name=%u*(Aq and password=PASSWORD(*(Aq%p*(Aq) and e
            service=web_proxy*(Aq]
        
.if n \{.RE
.\}

When using this convention, you can include \`[ characters inside the string, and if you wish to include a \`]\*(Aq character inside the string that will survive the argument parsing, you should use \`\e]\*(Aq. In other words:

.if n \{.RS 4
.\}
        [..[..e]..]    -->   ..[..]..
        
.if n \{.RE
.\}

Any line in (one of) the configuration file(s), that is not formatted correctly, will generally tend (erring on the side of caution) to make the authentication process fail. A corresponding error is written to the system log files with a call to
**syslog**(3).

More flexible than the single configuration file is it to configure libpam via the contents of the
/etc/pam.d/
directory. In this case the directory is filled with files each of which has a filename equal to a service-name (in lower-case): it is the personal configuration file for the named service.

The syntax of each file in /etc/pam.d/ is similar to that of the
/etc/pam.conf
file and is made up of lines of the following form:

.if n \{.RS 4
.\}
    type  control  module-path  module-arguments
        
.if n \{.RE
.\}

The only difference being that the service-name is not present. The service-name is of course the name of the given configuration file. For example,
/etc/pam.d/login
contains the configuration for the
**login**
service.

<a name="see-also"></a>

# See Also


**pam**(3),
**PAM**(8),
**pam\_start**(3)
