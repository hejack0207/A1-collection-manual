# systemd\&.syntax(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.syntax - General syntax of systemd configuration files

<a name="introduction"></a>

# Introduction


This page describes the basic principles of configuration files used by
**systemd**(1)
and related programs for:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd unit files, see
  **systemd.unit**(5),
  **systemd.service**(5),
  **systemd.socket**(5),
  **systemd.device**(5),
  **systemd.mount**(5),
  **systemd.automount**(5),
  **systemd.swap**(5),
  **systemd.target**(5),
  **systemd.path**(5),
  **systemd.timer**(5),
  **systemd.slice**(5),
  **systemd.scope**(5)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  daemon config files, see
  **systemd-system.conf**(5),
  **systemd-user.conf**(5),
  **logind.conf**(5),
  **journald.conf**(5),
  **journal-remote.conf**(5),
  **journal-upload.conf**(5),
  **systemd-sleep.conf**(5),
  **timesyncd.conf**(5)

The syntax is inspired by
\m[blue]**XDG Desktop Entry Specification**\m[]\s-2\u[1]\d\s+2
.desktop
files, which are in turn inspired by Microsoft Windows
.ini
files.

Each file is a plain text file divided into sections, with configuration entries in the style
_key_=_value_. Empty lines and lines starting with
"#"
or
";"
are ignored, which may be used for commenting.

Lines ending in a backslash are concatenated with the following line while reading and the backslash is replaced by a space character. This may be used to wrap long lines. The limit on line length is very large (currently 1 MB), but it is recommended to avoid such long lines and use multiple directives, variable substitution, or other mechanism as appropriate for the given file type. When a comment line or lines follow a line ending with a backslash, the comment block is ignored, so the continued line is concatenated with whatever follows the comment block.

**Example&nbsp;1.&nbsp;**

.if n \{.RS 4
.\}
    [Section A]
    KeyOne=value 1
    KeyTwo=value 2
    
    # a comment
    
    [Section B]
    Setting="something" "some thing" "..."
    KeyTwo=value 2 e
           value 2 continued
    
    [Section C]
    KeyThree=value 2e
    # this line is ignored
    ; this line is ignored too
           value 2 continued
.if n \{.RE
.\}

Boolean arguments used in configuration files can be written in various formats. For positive settings the strings
**1**,
**yes**,
**true**
and
**on**
are equivalent. For negative settings, the strings
**0**,
**no**,
**false**
and
**off**
are equivalent.

Time span values encoded in configuration files can be written in various formats. A stand-alone number specifies a time in seconds. If suffixed with a time unit, the unit is honored. A concatenation of multiple values with units is supported, in which case the values are added up. Example:
"50"
refers to 50 seconds;
"2min&nbsp;200ms"
refers to 2 minutes and 200 milliseconds, i.e. 120200&nbsp;ms. The following time units are understood:
"s",
"min",
"h",
"d",
"w",
"ms",
"us". For details see
**systemd.time**(7).

Various settings are allowed to be specified more than once, in which case the interpretation depends on the setting. Often, multiple settings form a list, and setting to an empty value "resets", which means that previous assignments are ignored. When this is allowed, it is mentioned in the description of the setting. Note that using multiple assignments to the same value makes the file incompatible with parsers for the XDG
.desktop
file format.

<a name="see-also"></a>

# See Also


**systemd.time**(7)

<a name="notes"></a>

# Notes


*  1.  
  XDG Desktop Entry Specification
      http://standards.freedesktop.org/desktop-entry-spec/latest/
