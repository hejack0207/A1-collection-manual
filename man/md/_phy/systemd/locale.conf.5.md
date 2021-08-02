# locale\&.conf(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

locale.conf - Configuration file for locale settings

<a name="synopsis"></a>

# Synopsis

```

 /etc/locale.conf
```

<a name="description"></a>

# Description


The
/etc/locale.conf
file configures system-wide locale settings. It is read at early boot by
**systemd**(1).

The basic file format of
locale.conf
is a newline-separated list of environment-like shell-compatible variable assignments. It is possible to source the configuration from shell scripts, however, beyond mere variable assignments, no shell features are supported, allowing applications to read the file without implementing a shell compatible execution engine.

Note that the kernel command line options
_locale.LANG=_,
_locale.LANGUAGE=_,
_locale.LC\_CTYPE=_,
_locale.LC\_NUMERIC=_,
_locale.LC\_TIME=_,
_locale.LC\_COLLATE=_,
_locale.LC\_MONETARY=_,
_locale.LC\_MESSAGES=_,
_locale.LC\_PAPER=_,
_locale.LC\_NAME=_,
_locale.LC\_ADDRESS=_,
_locale.LC\_TELEPHONE=_,
_locale.LC\_MEASUREMENT=_,
_locale.LC\_IDENTIFICATION=_
may be used to override the locale settings at boot.

The locale settings configured in
/etc/locale.conf
are system-wide and are inherited by every service or user, unless overridden or unset by individual programs or individual users.

Depending on the operating system, other configuration files might be checked for locale configuration as well, however only as fallback.

/etc/locale.conf
is usually created and updated using
**systemd-localed.service**(8).
**localectl**(1)
may be used to alter the settings in this file during runtime from the command line. Use
**systemd-firstboot**(1)
to initialize them on mounted (but not booted) system images.

<a name="options"></a>

# Options


The following locale settings may be set using
/etc/locale.conf:
_LANG=_,
_LANGUAGE=_,
_LC\_CTYPE=_,
_LC\_NUMERIC=_,
_LC\_TIME=_,
_LC\_COLLATE=_,
_LC\_MONETARY=_,
_LC\_MESSAGES=_,
_LC\_PAPER=_,
_LC\_NAME=_,
_LC\_ADDRESS=_,
_LC\_TELEPHONE=_,
_LC\_MEASUREMENT=_,
_LC\_IDENTIFICATION=_. Note that
_LC\_ALL_
may not be configured in this file. For details about the meaning and semantics of these settings, refer to
**locale**(7).

<a name="example"></a>

# Example


**Example&nbsp;1.&nbsp;German locale with English messages**

/etc/locale.conf:

.if n \{.RS 4
.\}
    LANG=de_DE.UTF-8
    LC_MESSAGES=en_US.UTF-8
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**locale**(7),
**localectl**(1),
**systemd-localed.service**(8),
**systemd-firstboot**(1)
