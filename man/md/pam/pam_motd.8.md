# pam_motd(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_motd - Display the motd file

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_motd.so&nbsp;'u pam_motd.so [motd=/path/filename] [motd_dir=/path/dirname.d]
```

<a name="description"></a>

# Description


pam_motd is a PAM module that can be used to display arbitrary motd (message of the day) files after a successful login. By default, pam_motd shows files in the following locations:

/etc/motd
/run/motd
/usr/lib/motd
/etc/motd.d/
/run/motd.d/
/usr/lib/motd.d/

Each message size is limited to 64KB.

If
/etc/motd
does not exist, then
/run/motd
is shown. If
/run/motd
does not exist, then
/usr/lib/motd
is shown.

Similar overriding behavior applies to the directories. Files in
/etc/motd.d/
override files with the same name in
/run/motd.d/
and
/usr/lib/motd.d/. Files in
/run/motd.d/
override files with the same name in
/usr/lib/motd.d/.

Files the in the directories listed above are displayed in lexicographic order by name.

To silence a message, a symbolic link with target
/dev/null
may be placed in
/etc/motd.d
with the same filename as the message to be silenced. Example: Creating a symbolic link as follows silences
/usr/lib/motd.d/my_motd.

**ln -s /dev/null /etc/motd.d/my\_motd**

The
**MOTD\_SHOWN=pam**
environment variable is set after showing the motd files, even when all of them were silenced using symbolic links.

<a name="options"></a>

# Options


**motd=****/path/filename**
The
/path/filename
file is displayed as message of the day. Multiple paths to try can be specified as a colon-separated list. By default this option is set to
/etc/motd:/run/motd:/usr/lib/motd.

**motd\_dir=****/path/dirname.d**
The
/path/dirname.d
directory is scanned and each file contained inside of it is displayed. Multiple directories to scan can be specified as a colon-separated list. By default this option is set to
/etc/motd.d:/run/motd.d:/usr/lib/motd.d.

When no options are given, the default behavior applies for both options. Specifying either option (or both) will disable the default behavior for both options.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**session**
module type is provided.

<a name="return-values"></a>

# Return Values


PAM_ABORT
Not all relevant data or options could be obtained.

PAM_BUF_ERR
Memory buffer error.

PAM_IGNORE
This is the default return value of this module.

<a name="examples"></a>

# Examples


The suggested usage for
/etc/pam.d/login
is:

.if n \{.RS 4
.\}
    session  optional  pam_motd.so
          
.if n \{.RE
.\}

To use a
motd
file from a different location:

.if n \{.RS 4
.\}
    session  optional  pam_motd.so motd=/elsewhere/motd
          
.if n \{.RE
.\}

To use a
motd
file from elsewhere, along with a corresponding
.d
directory:

.if n \{.RS 4
.\}
    session  optional  pam_motd.so motd=/elsewhere/motd motd_dir=/elsewhere/motd.d
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**motd**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_motd was written by Ben Collins &lt;[bcollins@debian.org](mailto:bcollins@debian.org)&gt;.

The
**motd\_dir=**
option was added by Allison Karlitskaya &lt;[allison.karlitskaya@redhat.com](mailto:allison.karlitskaya@redhat.com)&gt;.
