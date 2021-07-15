# environment\&.d(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

environment.d - Definition of user session environment

<a name="synopsis"></a>

# Synopsis

```

 ~/.config/environment.d/*.conf 
 /etc/environment.d/*.conf 
 /run/environment.d/*.conf 
 /usr/lib/environment.d/*.conf 
 /etc/environment
```

<a name="description"></a>

# Description


The
environment.d
directories contain a list of "global" environment variable assignments for the user environment.
**systemd-environment-d-generator**(8)
parses them and updates the environment exported by the systemd user instance to the services it starts.

It is recommended to use numerical prefixes for file names to simplify ordering.

For backwards compatibility, a symlink to
/etc/environment
is installed, so this file is also parsed.

<a name="configuration-directories-and-precedence"></a>

# Configuration Directories and Precedence


Configuration files are read from directories in
/etc/,
/run/, and
/usr/lib/, in order of precedence. Each configuration file in these configuration directories shall be named in the style of
_filename_.conf. Files in
/etc/
override files with the same name in
/run/
and
/usr/lib/. Files in
/run/
override files with the same name in
/usr/lib/.

Packages should install their configuration files in
/usr/lib/. Files in
/etc/
are reserved for the local administrator, who may use this logic to override the configuration files installed by vendor packages. All configuration files are sorted by their filename in lexicographic order, regardless of which of the directories they reside in. If multiple files specify the same option, the entry in the file with the lexicographically latest name will take precedence. It is recommended to prefix all filenames with a two-digit number and a dash, to simplify the ordering of the files.

If the administrator wants to disable a configuration file supplied by the vendor, the recommended way is to place a symlink to
/dev/null
in the configuration directory in
/etc/, with the same filename as the vendor configuration file. If the vendor configuration file is included in the initrd image, the image has to be regenerated.

<a name="configuration-format"></a>

# Configuration Format


The configuration files contain a list of
"_KEY_=_VALUE_"
environment variable assignments, separated by newlines. The right hand side of these assignments may reference previously defined environment variables, using the
"${OTHER_KEY}"
and
"$OTHER_KEY"
format. It is also possible to use
"${_FOO_:-_DEFAULT\_VALUE_}"
to expand in the same way as
"${_FOO_}"
unless the expansion would be empty, in which case it expands to
_DEFAULT\_VALUE_, and use
"${_FOO_:+_ALTERNATE\_VALUE_}"
to expand to
_ALTERNATE\_VALUE_
as long as
"${_FOO_}"
would have expanded to a non-empty value. No other elements of shell syntax are supported.

Each
_KEY_
must be a valid variable name. Empty lines and lines beginning with the comment character
"#"
are ignored.

<a name="example"></a>

### Example


**Example&nbsp;1.&nbsp;Setup environment to allow access to a program installed in /opt/foo**

/etc/environment.d/60-foo.conf:

.if n \{.RS 4
.\}
            FOO_DEBUG=force-software-gl,log-verbose
            PATH=/opt/foo/bin:$PATH
            LD_LIBRARY_PATH=/opt/foo/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
            XDG_DATA_DIRS=/opt/foo/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
            
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-environment-d-generator**(8),
**systemd.environment-generator**(7)
