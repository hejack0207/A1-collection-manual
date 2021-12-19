# dbus\-update\-activa(1)

D\-Bus 1\&.12\&.20, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dbus-update-activation-environment - update environment used for D-Bus session services

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dbus-update-activation-environment&nbsp;'u dbus-update-activation-environment [--systemd] [--verbose] --all | VAR... | VAR=VAL... 
```

<a name="description"></a>

# Description


**dbus-update-activation-environment**
updates the list of environment variables used by
**dbus-daemon --session**
when it activates session services without using
**systemd**.

With the
**--systemd**
option, if an instance of
**systemd --user**
is available on D-Bus, it also updates the list of environment variables used by
**systemd --user**
when it activates user services, including D-Bus session services for which
**dbus-daemon**
has been configured to delegate activation to
**systemd**. This is very similar to the
**import-environment**
command provided by
**systemctl**(1)).

Variables that are special to
**dbus-daemon**
or
**systemd**
may be set, but their values will be overridden when a service is started. For instance, it is not useful to add
**DBUS\_SESSION\_BUS\_ADDRESS**
to
**dbus-daemon**s activation environment, although it might still be useful to add it to
**systemd**s activation environment.

<a name="options"></a>

# Options


**--all**
Set all environment variables present in the environment used by
**dbus-update-activation-environment**.

**--systemd**
Set environment variables for systemd user services as well as for traditional D-Bus session services.

**--verbose**
Output messages to standard error explaining what dbus-update-activation-environment is doing.

_VAR_
If
_VAR_
is present in the environment of
**dbus-update-activation-environment**, set it to the same value for D-Bus services. Its value must be UTF-8 (if not, it is skipped with a warning). If
_VAR_
is not present in the environment, this argument is silently ignored.

_VAR_=_VAL_
Set
_VAR_
to
_VAL_, which must be UTF-8.

<a name="examples"></a>

# Examples


**dbus-update-activation-environment**
is primarily designed to be used in Linux distributions X11 session startup scripts, in conjunction with the "user bus" design.

To propagate
**DISPLAY**
and
**XAUTHORITY**
to
**dbus-daemon**
and, if present,
**systemd**, and propagate
**DBUS\_SESSION\_BUS\_ADDRESS**
to
**systemd**:

.if n \{.RS 4
.\}
            dbus-update-activation-environment --systemd e
                DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
          
.if n \{.RE
.\}

To propagate all environment variables except
**XDG\_SEAT**,
**XDG\_SESSION\_ID**
and
**XDG\_VTNR**
to
**dbus-daemon**
(and, if present,
**systemd**) for compatibility with legacy X11 session startup scripts:

.if n \{.RS 4
.\}
            # in a subshell so the variables remain set in the
            # parent script
            (
              unset XDG_SEAT
              unset XDG_SESSION_ID
              unset XDG_VTNR
    
              dbus-update-activation-environment --systemd --all
            )
          
.if n \{.RE
.\}


<a name="exit-status"></a>

# Exit Status


**dbus-update-activation-environment**
exits with status 0 on success, EX_USAGE (64) on invalid command-line options, EX_OSERR (71) if unable to connect to the session bus, or EX_UNAVAILABLE (69) if unable to set the environment variables. Other nonzero exit codes might be added in future versions.

<a name="environment"></a>

# Environment


**DBUS\_SESSION\_BUS\_ADDRESS**,
**XDG\_RUNTIME\_DIR**
and/or
**DISPLAY**
are used to find the address of the session bus.

<a name="limitations"></a>

# Limitations


**dbus-daemon**
does not provide a way to unset environment variables after they have been set (although
**systemd**
does), so
**dbus-update-activation-environment**
does not offer this functionality either.

POSIX does not specify the encoding of non-ASCII environment variable names or values and allows them to contain any non-zero byte, but neither
**dbus-daemon**
nor
**systemd**
supports environment variables with non-UTF-8 names or values. Accordingly,
**dbus-update-activation-environment**
assumes that any name or value that appears to be valid UTF-8 is intended to be UTF-8, and ignores other names or values with a warning.

<a name="bugs"></a>

# Bugs


Please send bug reports to the D-Bus bug tracker or mailing list. See
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[].

<a name="see-also"></a>

# See Also


**dbus-daemon**(1),
**systemd**(1), the
**import-environment**
command of
**systemctl**(1)

<a name="copyright"></a>

# Copyright
  
Copyright © 2015 Collabora Ltd.  

This man page is distributed under the same terms as dbus-update-activation-environment (MIT/X11). There is NO WARRANTY, to the extent permitted by law.

