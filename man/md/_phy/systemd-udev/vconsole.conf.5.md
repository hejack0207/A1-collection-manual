# vconsole\&.conf(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

vconsole.conf - Configuration file for the virtual console

<a name="synopsis"></a>

# Synopsis

```

 /etc/vconsole.conf
```

<a name="description"></a>

# Description


The
/etc/vconsole.conf
file configures the virtual console, i.e. keyboard mapping and console font. It is applied at boot by udev using
90-vconsole.rules
file. You can safely mask this file if you want to avoid this kind of initialization.

The basic file format of the
vconsole.conf
is a newline-separated list of environment-like shell-compatible variable assignments. It is possible to source the configuration from shell scripts, however, beyond mere variable assignments no shell features are supported, allowing applications to read the file without implementing a shell compatible execution engine.

Note that the kernel command line options
_vconsole.keymap=_,
_vconsole.keymap\_toggle=_,
_vconsole.font=_,
_vconsole.font\_map=_,
_vconsole.font\_unimap=_
may be used to override the console settings at boot.

Depending on the operating system other configuration files might be checked for configuration of the virtual console as well, however only as fallback.

/etc/vconsole.conf
is usually created and updated using
**systemd-localed.service**(8).
**localectl**(1)
may be used to instruct
**systemd-localed.service**
to query or update configuration.

<a name="options"></a>

# Options


The following options are understood:

_KEYMAP=_, _KEYMAP\_TOGGLE=_
Configures the key mapping table for the keyboard.
_KEYMAP=_
defaults to
"us"
if not set. The
_KEYMAP\_TOGGLE=_
can be used to configure a second toggle keymap and is by default unset.

_FONT=_, _FONT\_MAP=_, _FONT\_UNIMAP=_
Configures the console font, the console map and the unicode font map.

<a name="kernel-command-line"></a>

# Kernel Command Line


A few configuration parameters from
vconsole.conf
may be overridden on the kernel command line:

_vconsole.keymap=_, _vconsole.keymap\_toggle=_
Overrides
_KEYMAP=_
and
_KEYMAP\_TOGGLE=_.

_vconsole.font=_, _vconsole.font\_map=_, _vconsole.font\_unimap=_
Overrides
_FONT=_,
_FONT\_MAP=_, and
_FONT\_UNIMAP=_.

<a name="example"></a>

# Example


**Example&nbsp;1.&nbsp;German keyboard and console**

/etc/vconsole.conf:

.if n \{.RS 4
.\}
    KEYMAP=de-latin1
    FONT=eurlatgr
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-vconsole-setup.service**(8),
**loadkeys**(1),
**setfont**(8),
**locale.conf**(5),
**systemd-localed.service**(8)
