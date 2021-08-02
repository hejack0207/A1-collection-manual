# loader\&.conf(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

loader.conf - Configuration file for systemd-boot

<a name="synopsis"></a>

# Synopsis

```

 ESP/loader/loader.conf, ESP/loader/entries/*.conf
```

<a name="description"></a>

# Description


**systemd-boot**(7)
will read
_ESP_/loader/loader.conf
and any files with the
".conf"
extension under
_ESP_/loader/entries/
on the EFI system partition (ESP).

Each configuration file must consist of an option name, followed by whitespace, and the option value.
"#"
may be used to start a comment line. Empty and comment lines are ignored.

Boolean arguments may be written as
"yes"/"y"/"true"/"1"
or
"no"/"n"/"false"/"0".

<a name="options"></a>

# Options


The following configuration options in
loader.conf
are understood:

default
A glob pattern to select the default entry. The default entry may be changed in the boot menu itself, in which case the name of the selected entry will be stored as an EFI variable, overriding this option.

timeout
How long the boot menu should be shown before the default entry is booted, in seconds. This may be changed in the boot menu itself and will be stored as an EFI variable in that case, overriding this option.

If the timeout is disabled, the default entry will be booted immediately. The menu can be shown by pressing and holding a key before systemd-boot is launched.

console-mode
This option configures the resolution of the console. Takes a number or one of the special values listed below. The following values may be used:

0
Standard UEFI 80x25 mode

1
80x50 mode, not supported by all devices

2
the first non-standard mode provided by the device firmware, if any

auto
Pick a suitable mode automatically using heuristics

max
Pick the highest-numbered available mode

keep
Keep the mode selected by firmware (the default)

editor
Takes a boolean argument. Enable (the default) or disable the editor. The editor should be disabled if the machine can be accessed by unauthorized persons.

auto-entries
Takes a boolean argument. Enable (the default) or disable entries for other boot entries found on the boot partition. In particular, this may be useful when loader entries are created to show replacement descriptions for those entries.

auto-firmware
Takes a boolean argument. Enable (the default) or disable the "Reboot into firmware" entry.

<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    # /boot/efi/loader/loader.conf
    timeout 0
    default 01234567890abcdef1234567890abdf0-*
    editor no
        
.if n \{.RE
.\}

The menu will not be shown by default (the menu can still be shown by pressing and holding a key during boot). One of the entries with files with a name starting with
"01234567890abcdef1234567890abdf0-"
will be selected by default. If more than one entry matches, the one with the highest priority will be selected (generally the one with the highest version number). The editor will be disabled, so it is not possible to alter the kernel command line.

<a name="see-also"></a>

# See Also


**systemd-boot**(7),
**bootctl**(1)
