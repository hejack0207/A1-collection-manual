# polkit(8)

polkit, January 2009

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

polkit - Authorization Manager

<a name="overview"></a>

# Overview


polkit provides an authorization API intended to be used by privileged programs (“MECHANISMS”) offering service to unprivileged programs (“SUBJECTS”) often through some form of inter-process communication mechanism. In this scenario, the mechanism typically treats the subject as untrusted. For every request from a subject, the mechanism needs to determine if the request is authorized or if it should refuse to service the subject. Using the polkit APIs, a mechanism can offload this decision to a trusted party: The polkit authority.

The polkit authority is implemented as an system daemon,
**polkitd**(8), which itself has little privilege as it is running as the
_polkitd_
system user. Mechanisms, subjects and authentication agents communicate with the authority using the system message bus.

In addition to acting as an authority, polkit allows users to obtain temporary authorization through authenticating either an administrative user or the owner of the session the client belongs to. This is useful for scenarios where a mechanism needs to verify that the operator of the system really is the user or really is an administrative user.

<a name="system-architecture"></a>

# System Architecture


The system architecture of polkit is comprised of the
_Authority_
(implemented as a service on the system message bus) and an
_Authentication Agent_
per user session (provided and started by the users graphical environment).
_Actions_
are defined by applications. Vendors, sites and system administrators can control authorization policy through
_Authorization Rules_.

[IMAGE]\s-2\u[1]\d\s+2

.if n \{.RS 4
.\}
     +-------------------+
     |   Authentication  |
     |       Agent       |
     +-------------------+
     | libpolkit-agent-1 |
     +-------------------+
            ^                                  +---------+
            |                                  | Subject |
            +--------------+                   +---------+
                           |                        ^
                           |                        |
    User Session           |                        |
    =======================|========================|=============
    System Context         |                        |
                           |                        |
                           |                    +---+
                           V                    |
                         /------------e         |
                         | System Bus |         |
                         e------------/         |
                           ^        ^           V
                           |        |      +---------------------+
            +--------------+        |      |      Mechanism      |
            |                       |      +---------------------+
            V                       +----> | libpolkit-gobject-1 |
    +------------------+                   +---------------------+
    |    polkitd(8)    |
    +------------------+
    | org.freedesktop. |
    |    PolicyKit1    |<---------+
    +------------------+          |
              ^                   |
              |            +--------------------------------------+
              |            | /usr/share/polkit-1/actions/*.policy |
              |            +--------------------------------------+
              |
       +--------------------------------------+
       | /etc/polkit-1/rules.d/*.rules        |
       | /usr/share/polkit-1/rules.d/*.rules  |
       +--------------------------------------+
.if n \{.RE
.\}

For convenience, the
libpolkit-gobject-1
library wraps the polkit D-Bus API and is usable from any C/C++ program as well as higher-level languages supporting
\m[blue]**GObjectIntrospection**\m[]\s-2\u[2]\d\s+2
such as Javascript and Python. A mechanism can also use the D-Bus API or the
**pkcheck**(1)
command to check authorizations. The
libpolkit-agent-1
library provides an abstraction of the native authentication system, e.g.
**pam**(8)
and also facilities registration and communication with the polkit D-Bus service.

See the
\m[blue]**developer documentation**\m[]\s-2\u[3]\d\s+2
for more information about writing polkit applications.

<a name="authentication-agents"></a>

# Authentication Agents


An authentication agent is used to make the user of a session prove that the user of the session really is the user (by authenticating as the user) or an administrative user (by authenticating as a administrator). In order to integrate well with the rest of the user session (e.g. match the look and feel), authentication agents are meant to be provided by the user session that the user uses. For example, an authentication agent may look like this:

[IMAGE]\s-2\u[4]\d\s+2

.if n \{.RS 4
.\}
    +----------------------------------------------------------+
    |                                                          |
    |  [Icon]  Authentication required                         |
    |                                                          |
    |          Authentication is required to format INTEL      |
    |          SSDSA2MH080G1GC (/dev/sda)                      |
    |                                                          |
    |          Administrator                                   |
    |                                                          |
    |          Password: [__________________________________]  |
    |                                                          |
    | [Cancel]                                  [Authenticate] |
    +----------------------------------------------------------+
.if n \{.RE
.\}

If the system is configured without a
_root_
account it may prompt for a specific user designated as the administrative user:

[IMAGE]\s-2\u[5]\d\s+2

.if n \{.RS 4
.\}
    +----------------------------------------------------------+
    |                                                          |
    |  [Icon]  Authentication required                         |
    |                                                          |
    |          Authentication is required to format INTEL      |
    |          SSDSA2MH080G1GC (/dev/sda)                      |
    |                                                          |
    |          [Icon] David Zeuthen                            |
    |                                                          |
    |          Password: [__________________________________]  |
    |                                                          |
    | [Cancel]                                  [Authenticate] |
    +----------------------------------------------------------+
.if n \{.RE
.\}

Applications that do not run under a desktop environment (for example, if launched from a
**ssh**(1)
login) may not have have an authentication agent associated with them. Such applications may use the
PolkitAgentTextListener
type or the
**pkttyagent**(1)
helper so the user can authenticate using a textual interface.

<a name="declaring-actions"></a>

# Declaring Actions


A mechanism need to declare a set of
_actions_
in order to use polkit. Actions correspond to operations that clients can request the mechanism to carry out and are defined in XML files that the mechanism installs into the
/usr/share/polkit-1/actions
directory.

polkit actions are namespaced and can only contain the characters
[A-Z][a-z][0-9].-
e.g. ASCII, digits, period and hyphen. Each XML file can contain more than one action but all actions need to be in the same namespace and the file needs to be named after the namespace and have the extension
.policy.

The XML file must have the following doctype declaration

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD polkit Policy Configuration 1.0//EN"
    "http://www.freedesktop.org/software/polkit/policyconfig-1.dtd">
.if n \{.RE
.\}

The
_policyconfig_
element must be present exactly once. Elements that can be used inside
_policyconfig_
includes:

_vendor_
The name of the project or vendor that is supplying the actions in the XML document. Optional.

_vendor\_url_
A URL to the project or vendor that is supplying the actions in the XML document. Optional.

_icon\_name_
An icon representing the project or vendor that is supplying the actions in the XML document. The icon name must adhere to the
\m[blue]**Freedesktop.org Icon Naming Specification**\m[]\s-2\u[6]\d\s+2. Optional.

_action_
Declares an action. The action name is specified using the
id
attribute and can only contain the characters
[A-Z][a-z][0-9].-
e.g. ASCII, digits, period and hyphen.

Elements that can be used inside
_action_
include:

_description_
A human readable description of the action, e.g.
“Install unsigned software”.

_message_
A human readable message displayed to the user when asking for credentials when authentication is needed, e.g.
“Installing unsigned software requires authentication”.

_defaults_
This element is used to specify implicit authorizations for clients. Elements that can be used inside
_defaults_
include:

_allow\_any_
Implicit authorizations that apply to any client. Optional.

_allow\_inactive_
Implicit authorizations that apply to clients in inactive sessions on local consoles. Optional.

_allow\_active_
Implicit authorizations that apply to clients in active sessions on local consoles. Optional.

Each of the
_allow\_any_,
_allow\_inactive_
and
_allow\_active_
elements can contain the following values:

no
Not authorized.

yes
Authorized.

auth_self
Authentication by the owner of the session that the client originates from is required. Note that this is not restrictive enough for most uses on multi-user systems;
auth_admin* is generally recommended.

auth_admin
Authentication by an administrative user is required.

auth_self_keep
Like
auth_self
but the authorization is kept for a brief period (e.g. five minutes). The warning about
auth_self
above applies likewise.

auth_admin_keep
Like
auth_admin
but the authorization is kept for a brief period (e.g. five minutes).

_annotate_
Used for annotating an action with a key/value pair. The key is specified using the the
key
attribute and the value is specified using the
value
attribute. This element may appear zero or more times. See below for known annotations.

_vendor_
Used for overriding the vendor on a per-action basis. Optional.

_vendor\_url_
Used for overriding the vendor URL on a per-action basis. Optional.

_icon\_name_
Used for overriding the icon name on a per-action basis. Optional.

For localization,
_description_
and
_message_
elements may occur multiple times with different
xml:lang
attributes.

To list installed polkit actions, use the
**pkaction**(1)
command.

<a name="known-annotations"></a>

### Known annotations


The
org.freedesktop.policykit.exec.path
annotation is used by the
**pkexec**
program shipped with polkit - see the
**pkexec**(1)
man page for details.

The
org.freedesktop.policykit.imply
annotation (its value is a string containing a space separated list of action identifiers) can be used to define
_meta actions_. The way it works is that if a subject is authorized for an action with this annotation, then it is also authorized for any action specified by the annotation. A typical use of this annotation is when defining an UI shell with a single lock button that should unlock multiple actions from distinct mechanisms.

The
org.freedesktop.policykit.owner
annotation can be used to define a set of users who can query whether a client is authorized to perform this action. If this annotation is not specified then only root can query whether a client running as a different user is authorized for an action. The value of this annotation is a string containing a space separated list of
PolkitIdentity
entries, for example
"unix-user:42 unix-user:colord". A typical use of this annotation is for a daemon process that runs as a system user rather than root.

<a name="authorization-rules"></a>

# Authorization Rules


**polkitd**
reads
.rules
files from the
/etc/polkit-1/rules.d
and
/usr/share/polkit-1/rules.d
directories by sorting the files in lexical order based on the basename on each file (if theres a tie, files in
/etc
are processed before files in
/usr). For example, for the following four files, the order is

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  /etc/polkit-1/rules.d/10-auth.rules

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  /usr/share/polkit-1/rules.d/10-auth.rules

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  /etc/polkit-1/rules.d/15-auth.rules

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  /usr/share/polkit-1/rules.d/20-auth.rules

Both directories are monitored so if a rules file is changed, added or removed, existing rules are purged and all files are read and processed again. Rules files are written in the
\m[blue]**JavaScript**\m[]\s-2\u[7]\d\s+2
programming language and interface with
**polkitd**
through the global
polkit
object (of type
**Polkit**).

While the JavaScript interpreter used in particular versions of polkit may support non-standard features (such as the
_let_
keyword), authorization rules must conform to
\m[blue]**ECMA-262 edition 5**\m[]\s-2\u[8]\d\s+2
(in other words, the JavaScript interpreter used may change in future versions of polkit).

Authorization rules are intended for two specific audiences

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  System Administrators

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Special-purpose Operating Systems / Environments

and those audiences only. In particular, applications, mechanisms and general-purpose operating systems must never include any authorization rules.

<a name="the-polkit-type"></a>

### The Polkit type


The following methods are available on the
polkit
object:
.HP \w'void&nbsp;addRule('u
**void addRule(polkit.Result&nbsp;function(**_action_**,&nbsp;**_subject_**)&nbsp;{...});**
.HP \w'void&nbsp;addAdminRule('u
**void addAdminRule(string[]&nbsp;function(**_action_**,&nbsp;**_subject_**)&nbsp;{...});**
.HP \w'void&nbsp;log('u
**void log(string&nbsp;**_message_**);**
.HP \w'string&nbsp;spawn('u
**string spawn(string[]&nbsp;**_argv_**);**

The
**addRule()**
method is used for adding a function that may be called whenever an authorization check for
_action_
and
_subject_
is performed. Functions are called in the order they have been added until one of the functions returns a value. Hence, to add an authorization rule that is processed before other rules, put it in a file in
/etc/polkit-1/rules.d
with a name that sorts before other rules files, for example
00-early-checks.rules. Each function should return a value from
polkit.Result

.if n \{.RS 4
.\}
    polkit.Result = {
        NO              : "no",
        YES             : "yes",
        AUTH_SELF       : "auth_self",
        AUTH_SELF_KEEP  : "auth_self_keep",
        AUTH_ADMIN      : "auth_admin",
        AUTH_ADMIN_KEEP : "auth_admin_keep",
        NOT_HANDLED     : null
    };
.if n \{.RE
.\}

corresponding to the values that can be used as defaults. If the function returns
**polkit.Result.NOT\_HANDLED**,
**null**,
**undefined**
or does not return a value at all, the next user function is tried.

Keep in mind that if
**polkit.Result.AUTH\_SELF\_KEEP**
or
**polkit.Result.AUTH\_ADMIN\_KEEP**
is returned, authorization checks for the same action identifier and subject will succeed (that is, return
**polkit.Result.YES**) for the next brief period (e.g. five minutes)
_even_
if the variables passed along with the check are different. Therefore, if the result of an authorization rule depend on such variables, it should not use the
**"*\_KEEP"**
constants (if similar functionality is required, the authorization rule can easily implement temporary authorizations using the
\m[blue]**Date**\m[]\s-2\u[9]\d\s+2
type for timestamps).

The
**addAdminRule()**
method is used for adding a function may be called whenever administrator authentication is required. The function is used to specify what identies may be used for administrator authentication for the authorization check identified by
_action_
and
_subject_. Functions added are called in the order they have been added until one of the functions returns a value. Each function should return an array of strings where each string is of the form
"unix-group:&lt;group&gt;",
"unix-netgroup:&lt;netgroup&gt;"
or
"unix-user:&lt;user&gt;". If the function returns
**null**,
**undefined**
or does not return a value at all, the next function is tried.

There is no guarantee that a function registered with
**addRule()**
or
**addAdminRule()**
is ever called - for example an early rules file could register a function that always return a value, hence ensuring that functions added later are never called.

If user-provided code takes a long time to execute an exception will be thrown which normally results in the function being terminated (the current limit is 15 seconds). This is used to catch runaway scripts.

The
**spawn()**
method spawns an external helper identified by the argument vector
_argv_
and waits for it to terminate. If an error occurs or the helper doesnt exit normally with exit code 0, an exception is thrown. If the helper does not exit within 10 seconds it is killed. Otherwise, the program\*(Aqs
_standard output_
is returned as a string. The
**spawn()**
method should be used sparingly as helpers may take a very long or indeterminate amount of time to complete and no other authorization check can be handled while the helper is running. Note that the spawned programs will run as the unprivileged
_polkitd_
system user.

The
**log()**
method writes the given
_message_
to the system logger prefixed with the JavaScript filename and line number. Log entries are emitted using the
**LOG\_AUTHPRIV**
flag meaning that the log entries usually ends up in the file
/var/log/secure. The
**log()**
method is usually only used when debugging rules. The
**Action**
and
**Subject**
types has suitable
**toString()**
methods defined for easy logging, for example,

.if n \{.RS 4
.\}
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.policykit.exec") {
            polkit.log("action=" + action);
            polkit.log("subject=" + subject);
        }
    });
.if n \{.RE
.\}

will produce the following when the user runs pkexec -u bateman bash -i\*(Aq from a shell:

.if n \{.RS 4
.\}
    May 24 14:28:50 thinkpad polkitd[32217]: /etc/polkit-1/rules.d/10-test.rules:3: action=[Action id=org.freedesktop.policykit.exec*(Aq command_line=*(Aq/usr/bin/bash -i*(Aq program=*(Aq/usr/bin/bash*(Aq user=*(Aqbateman*(Aq user.gecos=*(AqPatrick Bateman*(Aq user.display=*(AqPatrick Bateman (bateman)*(Aq]
    May 24 14:28:50 thinkpad polkitd[32217]: /etc/polkit-1/rules.d/10-test.rules:4: subject=[Subject pid=1352 user=davidz*(Aq groups=davidz,wheel, seat=*(Aqseat0*(Aq session=*(Aq1*(Aq local=true active=true]
.if n \{.RE
.\}

<a name="the-action-type"></a>

### The Action type


The
_action_
parameter passed to user functions is an object with information about the action being checked. It is of type
**Action**
and has the following attribute:

**string** id
The action identifier, for example
_org.freedesktop.policykit.exec_.

The following methods are available on the
**Action**
type:
.HP \w'string&nbsp;lookup('u
**string lookup(string&nbsp;**_key_**);**

The
**lookup()**
method is used to lookup the polkit variables passed from the mechanism. For example, the
**pkexec**(1)
mechanism sets the variable
_program_
which can be obtained in Javascript using the expression
action.lookup("program"). If there is no value for the given
_key_, then
**undefined**
is returned.

Consult the documentation for each mechanism for what variables are available for each action.

<a name="the-subject-type"></a>

### The Subject type


The
_subject_
parameter passed to user functions is an object with information about the process being checked. It is of type
**Subject**
and has the following attributes

**int** pid
The process id.

**string** user
The user name.

**string[]** groups
Array of groups that
_user_
user belongs to.

**string** seat
The seat that the subject is associated with - blank if not on a local seat.

**string** session
The session that the subject is associated with.

**boolean** local
Set to
**true**
only if seat is local.

**boolean** active
Set to
**true**
only if the session is active.

The following methods are available on the
**Subject**
type:
.HP \w'boolean&nbsp;isInGroup('u
**boolean isInGroup(string&nbsp;**_groupName_**);**
.HP \w'boolean&nbsp;isInNetGroup('u
**boolean isInNetGroup(string&nbsp;**_netGroupName_**);**

The
**isInGroup()**
method can be used to check if the subject is in a given group and
**isInNetGroup()**
can be used to check if the subject is in a given netgroup.

<a name="authorization-rules-examples"></a>

### Authorization Rules Examples


Allow all users in the
admin
group to perform user administration without changing policy for other users:

.if n \{.RS 4
.\}
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.accounts.user-administration" &&
            subject.isInGroup("admin")) {
            return polkit.Result.YES;
        }
    });
.if n \{.RE
.\}

Define administrative users to be the users in the
wheel
group:

.if n \{.RS 4
.\}
    polkit.addAdminRule(function(action, subject) {
        return ["unix-group:wheel"];
    });
.if n \{.RE
.\}

Forbid users in group
children
to change hostname configuration (that is, any action with an identifier starting with
org.freedesktop.hostname1.) and allow anyone else to do it after authenticating as themselves:

.if n \{.RS 4
.\}
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.hostname1.") == 0) {
            if (subject.isInGroup("children")) {
                return polkit.Result.NO;
            } else {
                return polkit.Result.AUTH_SELF_KEEP;
            }
        }
    });
.if n \{.RE
.\}

Run an external helper to determine if the current user may reboot the system:

.if n \{.RS 4
.\}
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.login1.reboot") == 0) {
            try {
                // user-may-reboot exits with success (exit code 0)
                // only if the passed username is authorized
                polkit.spawn(["/opt/company/bin/user-may-reboot",
                              subject.user]);
                return polkit.Result.YES;
            } catch (error) {
                // Nope, but do allow admin authentication
                return polkit.Result.AUTH_ADMIN;
            }
        }
    });
.if n \{.RE
.\}

The following example shows how the authorization decision can depend on variables passed by the
**pkexec**(1)
mechanism:

.if n \{.RS 4
.\}
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.policykit.exec" &&
            action.lookup("program") == "/usr/bin/cat") {
            return polkit.Result.AUTH_ADMIN;
        }
    });
.if n \{.RE
.\}

The following example shows another use of variables passed from the mechanism. In this case, the mechanism is
\m[blue]**UDisks**\m[]\s-2\u[10]\d\s+2
which defines a set of
\m[blue]**actions and variables**\m[]\s-2\u[11]\d\s+2
that is used to match on:

.if n \{.RS 4
.\}
    // Allow users in group engineers*(Aq to perform any operation on
    // some drives without having to authenticate
    //
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.udisks2.") == 0 &&
            action.lookup("drive.vendor") == "SEAGATE" &&
            action.lookup("drive.model") == "ST3300657SS" &&
            subject.isInGroup("engineers")) {
                return polkit.Result.YES;
            }
        }
    });
.if n \{.RE
.\}

<a name="author"></a>

# Author


Written by David Zeuthen
&lt;[davidz@redhat.com](mailto:davidz@redhat.com)&gt;
with a lot of help from many others.

<a name="bugs"></a>

# Bugs


Please send bug reports to either the distribution or the polkit-devel mailing list, see the link
\m[blue]**http://lists.freedesktop.org/mailman/listinfo/polkit-devel**\m[]
on how to subscribe.

<a name="see-also"></a>

# See Also


**polkitd**(8),
**pkaction**(1),
**pkcheck**(1),
**pkexec**(1),
**pkttyagent**(1)

<a name="notes"></a>

# Notes


*  1.  
  /usr/share/gtk-doc/html/polkit-1/polkit-architecture.png
*  2.  
  GObjectIntrospection
      https://live.gnome.org/GObjectIntrospection
*  3.  
  developer documentation
      http://www.freedesktop.org/software/polkit/docs/latest/
*  4.  
  /usr/share/gtk-doc/html/polkit-1/polkit-authentication-agent-example.png
*  5.  
  /usr/share/gtk-doc/html/polkit-1/polkit-authentication-agent-example-wheel.png
*  6.  
  Freedesktop.org Icon Naming Specification
      http://standards.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html
*  7.  
  JavaScript
      http://en.wikipedia.org/wiki/JavaScript
*  8.  
  ECMA-262 edition 5
      http://en.wikipedia.org/wiki/ECMAScript#ECMAScript.2C_5th_Edition
*  9.  
  **Date**
      https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Date
* 10.  
  UDisks
      http://udisks.freedesktop.org/docs/latest/udisks.8.html
* 11.  
  actions and variables
      http://udisks.freedesktop.org/docs/latest/udisks-polkit-actions.html
