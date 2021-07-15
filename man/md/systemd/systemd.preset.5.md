# systemd\&.preset(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.preset - Service enablement presets

<a name="synopsis"></a>

# Synopsis

```

 /etc/systemd/system-preset/*.preset 
 /run/systemd/system-preset/*.preset 
 /usr/lib/systemd/system-preset/*.preset 
 /etc/systemd/user-preset/*.preset 
 /run/systemd/user-preset/*.preset 
 /usr/lib/systemd/user-preset/*.preset
```

<a name="description"></a>

# Description


Preset files may be used to encode policy which units shall be enabled by default and which ones shall be disabled. They are read by
**systemctl preset**
(for more information see
**systemctl**(1)) which uses this information to enable or disable a unit according to preset policy.
**systemctl preset**
is used by the post install scriptlets of RPM packages (or other OS package formats), to enable/disable specific units by default on package installation, enforcing distribution, spin or administrator preset policy. This allows choosing a certain set of units to be enabled/disabled even before installing the actual package.

For more information on the preset logic please have a look at the
\m[blue]**Presets**\m[]\s-2\u[1]\d\s+2
document.

It is not recommended to ship preset files within the respective software packages implementing the units, but rather centralize them in a distribution or spin default policy, which can be amended by administrator policy.

If no preset files exist,
**systemctl preset**
will enable all units that are installed by default. If this is not desired and all units shall rather be disabled, it is necessary to ship a preset file with a single, catchall "disable *" line. (See example 1, below.)

<a name="preset-file-format"></a>

# Preset File Format


The preset files contain a list of directives consisting of either the word
"enable"
or
"disable"
followed by a space and a unit name (possibly with shell style wildcards), separated by newlines. Empty lines and lines whose first non-whitespace character is # or ; are ignored.

Presets must refer to the "real" unit file, and not to any aliases. See
**systemd.unit**(5)
for a description of unit aliasing.

Two different directives are understood:
"enable"
may be used to enable units by default,
"disable"
to disable units by default.

If multiple lines apply to a unit name, the first matching one takes precedence over all others.

Each preset file shall be named in the style of
&lt;priority&gt;-&lt;policy-name&gt;.preset. Files in
/etc/
override files with the same name in
/usr/lib/
and
/run/. Files in
/run/
override files with the same name in
/usr/lib/. Packages should install their preset files in
/usr/lib/. Files in
/etc/
are reserved for the local administrator, who may use this logic to override the preset files installed by vendor packages. All preset files are sorted by their filename in lexicographic order, regardless of which of the directories they reside in. If multiple files specify the same unit name, the entry in the file with the lexicographically earliest name will be applied. It is recommended to prefix all filenames with a two-digit number and a dash, to simplify the ordering of the files.

If the administrator wants to disable a preset file supplied by the vendor, the recommended way is to place a symlink to
/dev/null
in
/etc/systemd/system-preset/
bearing the same filename.

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Default to off**

.if n \{.RS 4
.\}
    # /usr/lib/systemd/system-preset/99-default.preset
    
    disable *
.if n \{.RE
.\}

This disables all units. Due to the filename prefix
"99-", it will be read last and hence can easily be overridden by spin or administrator preset policy.

**Example&nbsp;2.&nbsp;A GNOME spin**

.if n \{.RS 4
.\}
    # /usr/lib/systemd/system-preset/50-gnome.preset
    
    enable gdm.service
    enable colord.service
    enable accounts-daemon.service
    enable avahi-daemon.*
.if n \{.RE
.\}

This enables the three mentioned units, plus all
avahi-daemon
regardless of which unit type. A file like this could be useful for inclusion in a GNOME spin of a distribution. It will ensure that the units necessary for GNOME are properly enabled as they are installed. It leaves all other units untouched, and subject to other (later) preset files, for example like the one from the first example above.

**Example&nbsp;3.&nbsp;Administrator policy**

.if n \{.RS 4
.\}
    # /etc/systemd/system-preset/00-lennart.preset
    
    enable httpd.service
    enable sshd.service
    enable postfix.service
    disable *
.if n \{.RE
.\}

This enables three specific services and disables all others. This is useful for administrators to specifically select the units to enable, and disable all others. Due to the filename prefix
"00-"
it will be read early and override all other preset policy files.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-delta**(1)

<a name="notes"></a>

# Notes


*  1.  
  Presets
      https://www.freedesktop.org/wiki/Software/systemd/Preset
