# pam_filter(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_filter - PAM filter module

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_filter.so&nbsp;'u pam_filter.so [debug] [new_term] [non_term] run1|run2 filter [...]
```

<a name="description"></a>

# Description


This module is intended to be a platform for providing access to all of the input/output that passes between the user and the application. It is only suitable for tty-based and (stdin/stdout) applications.

To function this module requires
_filters_
to be installed on the system. The single filter provided with the module simply transposes upper and lower case letters in the input and output streams. (This can be very annoying and is not kind to termcap based editors).

Each component of the module has the potential to invoke the desired filter. The filter is always
**execv**(2)
with the privilege of the calling application and
_not_
that of the user. For this reason it cannot usually be killed by the user without closing their session.

<a name="options"></a>

# Options



**debug**
Print debug information.

**new\_term**
The default action of the filter is to set the
_PAM\_TTY_
item to indicate the terminal that the user is using to connect to the application. This argument indicates that the filter should set
_PAM\_TTY_
to the filtered pseudo-terminal.

**non\_term**
dont try to set the
_PAM\_TTY_
item.

**runX**
In order that the module can invoke a filter it should know when to invoke it. This argument is required to tell the filter when to do this.

Permitted values for
_X_
are
_1_
and
_2_. These indicate the precise time that the filter is to be run. To understand this concept it will be useful to have read the
**pam**(3)
manual page. Basically, for each management group there are up to two ways of calling the modules functions. In the case of the
_authentication_
and
_session_
components there are actually two separate functions. For the case of authentication, these functions are
**pam\_authenticate**(3)
and
**pam\_setcred**(3), here
**run1**
means run the filter from the
**pam\_authenticate**
function and
**run2**
means run the filter from
**pam\_setcred**. In the case of the session modules,
_run1_
implies that the filter is invoked at the
**pam\_open\_session**(3)
stage, and
_run2_
for
**pam\_close\_session**(3).

For the case of the account component. Either
_run1_
or
_run2_
may be used.

For the case of the password component,
_run1_
is used to indicate that the filter is run on the first occasion of
**pam\_chauthtok**(3)
(the
_PAM\_PRELIM\_CHECK_
phase) and
_run2_
is used to indicate that the filter is run on the second occasion (the
_PAM\_UPDATE\_AUTHTOK_
phase).

**filter**
The full pathname of the filter to be run and any command line arguments that the filter might expect.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**auth**,
**account**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values



PAM_SUCCESS
The new filter was set successfully.

PAM_ABORT
Critical error, immediate abort.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/login
to see how to configure login to transpose upper and lower case letters once the user has logged in:

.if n \{.RS 4
.\}
            session required pam_filter.so run1 /lib/security/pam_filter/upperLOWER
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_filter was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
