# systemd\-firstboot(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-firstboot, systemd-firstboot.service - Initialize basic system settings on or before the first boot-up of a system

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-firstboot&nbsp;'u systemd-firstboot [OPTIONS...] 
 systemd-firstboot.service
```

<a name="description"></a>

# Description


**systemd-firstboot**
initializes the most basic system settings interactively on the first boot, or optionally non-interactively when a system image is created. The service is started if
_ConditionFirstBoot=yes_
is satisfied. This essentially means that
/etc
is empty, see
**systemd.unit**(5)
for details.

The following settings may be set up:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The system locale, more specifically the two locale variables
  _LANG=_
  and
  _LC\_MESSAGES_

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The system keyboard map

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The system time zone

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The system host name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The machine ID of the system

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The root users password

Each of the fields may either be queried interactively by users, set non-interactively on the tools command line, or be copied from a host system that is used to set up the system image.

If a setting is already initialized, it will not be overwritten and the user will not be prompted for the setting.

Note that this tool operates directly on the file system and does not involve any running system services, unlike
**localectl**(1),
**timedatectl**(1)
or
**hostnamectl**(1). This allows
**systemd-firstboot**
to operate on mounted but not booted disk images and in early boot. It is not recommended to use
**systemd-firstboot**
on the running system while it is up.

<a name="options"></a>

# Options


The following options are understood:

**--root=****root**
Takes a directory path as an argument. All paths will be prefixed with the given alternate
_root_
path, including config search paths. This is useful to operate on a system image mounted to the specified directory instead of the host system itself.

**--locale=****LOCALE**, **--locale-messages=****LOCALE**
Sets the system locale, more specifically the
_LANG=_
and
_LC\_MESSAGES_
settings. The argument should be a valid locale identifier, such as
"de_DE.UTF-8". This controls the
**locale.conf**(5)
configuration file.

**--keymap=****KEYMAP**
Sets the system keyboard layout. The argument should be a valid keyboard map, such as
"de-latin1". This controls the
"KEYMAP"
entry in the
**vconsole.conf**(5)
configuration file.

**--timezone=****TIMEZONE**
Sets the system time zone. The argument should be a valid time zone identifier, such as
"Europe/Berlin". This controls the
**localtime**(5)
symlink.

**--hostname=****HOSTNAME**
Sets the system hostname. The argument should be a host name, compatible with DNS. This controls the
**hostname**(5)
configuration file.

**--machine-id=****ID**
Sets the systems machine ID. This controls the
**machine-id**(5)
file.

**--root-password=****PASSWORD**, **--root-password-file=****PATH**
Sets the password of the systems root user. This creates a
**shadow**(5)
file. This setting exists in two forms:
**--root-password=**
accepts the password to set directly on the command line, and
**--root-password-file=**
reads it from a file. Note that it is not recommended to specify passwords on the command line, as other users might be able to see them simply by invoking
**ps**(1).

**--prompt-locale**, **--prompt-keymap**, **--prompt-timezone**, **--prompt-hostname**, **--prompt-root-password**
Prompt the user interactively for a specific basic setting. Note that any explicit configuration settings specified on the command line take precedence, and the user is not prompted for it.

**--prompt**
Query the user for locale, keymap, timezone, hostname and root password. This is equivalent to specifying
**--prompt-locale**,
**--prompt-keymap**,
**--prompt-timezone**,
**--prompt-hostname**,
**--prompt-root-password**
in combination.

**--copy-locale**, **--copy-keymap**, **--copy-timezone**, **--copy-root-password**
Copy a specific basic setting from the host. This only works in combination with
**--root=**
(see above).

**--copy**
Copy locale, keymap, time zone and root password from the host. This is equivalent to specifying
**--copy-locale**,
**--copy-keymap**,
**--copy-timezone**,
**--copy-root-password**
in combination.

**--setup-machine-id**
Initialize the systems machine ID to a random ID. This only works in combination with
**--root=**.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="kernel-command-line"></a>

# Kernel Command Line


_systemd.firstboot=_
Takes a boolean argument, defaults to on. If off,
systemd-firstboot.service
wont interactively query the user for basic settings at first boot, even if those settings are not initialized yet.

<a name="see-also"></a>

# See Also


**systemd**(1),
**locale.conf**(5),
**vconsole.conf**(5),
**localtime**(5),
**hostname**(5),
**machine-id**(5),
**shadow**(5),
**systemd-machine-id-setup**(1),
**localectl**(1),
**timedatectl**(1),
**hostnamectl**(1)
