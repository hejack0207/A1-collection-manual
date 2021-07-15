# systemd\-escape(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-escape - Escape strings for usage in systemd unit names

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-escape&nbsp;'u systemd-escape [OPTIONS...] [STRING...]
```

<a name="description"></a>

# Description


**systemd-escape**
may be used to escape strings for inclusion in systemd unit names. The command may be used to escape and to undo escaping of strings.

The command takes any number of strings on the command line, and will process them individually, one after another. It will output them separated by spaces to stdout.

By default, this command will escape the strings passed, unless
**--unescape**
is passed which results in the inverse operation being applied. If
**--mangle**
is given, a special mode of escaping is applied instead, which assumes the string is already escaped but will escape everything that appears obviously non-escaped.

For details on the escaping and unescaping algorithms see the relevant section in
**systemd.unit**(5).

<a name="options"></a>

# Options


The following options are understood:

**--suffix=**
Appends the specified unit type suffix to the escaped string. Takes one of the unit types supported by systemd, such as
"service"
or
"mount". May not be used in conjunction with
**--template=**,
**--unescape**
or
**--mangle**.

**--template=**
Inserts the escaped strings in a unit name template. Takes a unit name template such as
foobar@.service. With
**--unescape**, expects instantiated unit names for this template and extracts and unescapes just the instance part. May not be used in conjunction with
**--suffix=**,
**--instance**
or
**--mangle**.

**--path**, **-p**
When escaping or unescaping a string, assume it refers to a file system path. This eliminates leading, trailing or duplicate
"/"
characters and rejects
"."
and
".."
path components. This is particularly useful for generating strings suitable for unescaping with the
"%f"
specifier in unit files, see
**systemd.unit**(5).

**--unescape**, **-u**
Instead of escaping the specified strings, undo the escaping, reversing the operation. May not be used in conjunction with
**--suffix=**
or
**--mangle**.

**--mangle**, **-m**
Like
**--escape**, but only escape characters that are obviously not escaped yet, and possibly automatically append an appropriate unit type suffix to the string. May not be used in conjunction with
**--suffix=**,
**--template=**
or
**--unescape**.

**--instance**
With
**--unescape**, unescape and print only the instance part of an instantiated unit name template. Results in an error for an uninstantiated template like
ssh@.service
or a non-template name like
ssh.service. Must be used in conjunction with
**--unescape**
and may not be used in conjunction with
**--template**.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="examples"></a>

# Examples


To escape a single string:

.if n \{.RS 4
.\}
    $ systemd-escape Hallöchen, Meister*(Aq
    Hallexc3exb6chenex2cex20Meister
.if n \{.RE
.\}

To undo escaping on a single string:

.if n \{.RS 4
.\}
    $ systemd-escape -u Hallexc3exb6chenex2cex20Meister*(Aq
    Hallöchen, Meister
.if n \{.RE
.\}

To generate the mount unit for a path:

.if n \{.RS 4
.\}
    $ systemd-escape -p --suffix=mount "/tmp//waldi/foobar/"
    tmp-waldi-foobar.mount
.if n \{.RE
.\}

To generate instance names of three strings:

.if n \{.RS 4
.\}
    $ systemd-escape --template=systemd-nspawn@.service My Container 1*(Aq *(Aqcontainerb*(Aq *(Aqcontainer/III*(Aq
    systemd-nspawn@Myex20Containerex201.service systemd-nspawn@containerb.service systemd-nspawn@container-III.service
.if n \{.RE
.\}

To extract the instance part of an instantiated unit:

.if n \{.RS 4
.\}
    $ systemd-escape -u --instance systemd-nspawn@Myex20Containerex201.service*(Aq
    My Container 1
.if n \{.RE
.\}

To extract the instance part of an instance of a particular template:

.if n \{.RS 4
.\}
    $ systemd-escape -u --template=systemd-nspawn@.service systemd-nspawn@Myex20Containerex201.service*(Aq
    My Container 1
.if n \{.RE
.\}

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.unit**(5),
**systemctl**(1)
