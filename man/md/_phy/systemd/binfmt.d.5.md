# binfmt\&.d(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

binfmt.d - Configure additional binary formats for executables at boot

<a name="synopsis"></a>

# Synopsis

```

 /etc/binfmt.d/*.conf 
 /run/binfmt.d/*.conf 
 /usr/lib/binfmt.d/*.conf
```

<a name="description"></a>

# Description


At boot,
**systemd-binfmt.service**(8)
reads configuration files from the above directories to register in the kernel additional binary formats for executables.

<a name="configuration-format"></a>

# Configuration Format


Each file contains a list of binfmt_misc kernel binary format rules. Consult the kernels
\m[blue]**binfmt-misc.rst**\m[]\s-2\u[1]\d\s+2
documentation file for more information on registration of additional binary formats and how to write rules.

Empty lines and lines beginning with ; and # are ignored. Note that this means you may not use ; and # as delimiter in binary format rules.

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

<a name="example"></a>

# Example


**Example&nbsp;1.&nbsp;/etc/binfmt.d/wine.conf example:**

.if n \{.RS 4
.\}
    # Start WINE on Windows executables
    :DOSWin:M::MZ::/usr/bin/wine:
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-binfmt.service**(8),
**systemd-delta**(1),
**wine**(8)

<a name="notes"></a>

# Notes


*  1.  
  binfmt-misc.rst
      https://www.kernel.org/doc/html/latest/admin-guide/binfmt-misc.html
