# systemd\-tmpfiles(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-tmpfiles, systemd-tmpfiles-setup.service, systemd-tmpfiles-setup-dev.service, systemd-tmpfiles-clean.service, systemd-tmpfiles-clean.timer - Creates, deletes and cleans up volatile and temporary files and directories

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-tmpfiles&nbsp;'u systemd-tmpfiles [OPTIONS...] [CONFIGFILE...] 
 System units: 

</synopsis>
    systemd-tmpfiles-setup.service
    systemd-tmpfiles-setup-dev.service
    systemd-tmpfiles-clean.service
    systemd-tmpfiles-clean.timer
<synopsis>

 User units: 

```
    systemd-tmpfiles-setup.service
    systemd-tmpfiles-clean.service
    systemd-tmpfiles-clean.timer

<a name="description"></a>

# Description


**systemd-tmpfiles**
creates, deletes, and cleans up volatile and temporary files and directories, based on the configuration file format and location specified in
**tmpfiles.d**(5).

If invoked with no arguments, it applies all directives from all configuration files. When invoked with
**--replace=****PATH**, arguments specified on the command line are used instead of the configuration file
_PATH_. Otherwise, if one or more absolute filenames are passed on the command line, only the directives in these files are applied. If
"-"
is specified instead of a filename, directives are read from standard input. If only the basename of a configuration file is specified, all configuration directories as specified in
**tmpfiles.d**(5)
are searched for a matching file and the file found that has the highest priority is executed.

<a name="options"></a>

# Options


The following options are understood:

**--create**
If this option is passed, all files and directories marked with
_f_,
_F_,
_w_,
_d_,
_D_,
_v_,
_p_,
_L_,
_c_,
_b_,
_m_
in the configuration files are created or written to. Files and directories marked with
_z_,
_Z_,
_t_,
_T_,
_a_, and
_A_
have their ownership, access mode and security labels set.

**--clean**
If this option is passed, all files and directories with an age parameter configured will be cleaned up.

**--remove**
If this option is passed, the contents of directories marked with
_D_
or
_R_, and files or directories themselves marked with
_r_
or
_R_
are removed.

**--user**
Execute "user" configuration, i.e.
tmpfiles.d
files in user configuration directories.

**--boot**
Also execute lines with an exclamation mark.

**--prefix=****path**
Only apply rules with paths that start with the specified prefix. This option can be specified multiple times.

**--exclude-prefix=****path**
Ignore rules with paths that start with the specified prefix. This option can be specified multiple times.

**--root=****root**
Takes a directory path as an argument. All paths will be prefixed with the given alternate
_root_
path, including config search paths.

Note that this option does not alter how the users and groups specified in the configuration files are resolved. With or without this option, users and groups are always resolved according to the hosts user and group databases, any such databases stored under the specified root directories are not consulted.

**--replace=****PATH**
When this option is given, one ore more positional arguments must be specified. All configuration files found in the directories listed in
**tmpfiles.d**(5)
will be read, and the configuration given on the command line will be handled instead of and with the same priority as the configuration file
_PATH_.

This option is intended to be used when package installation scripts are running and files belonging to that package are not yet available on disk, so their contents must be given on the command line, but the admin configuration might already exist and should be given higher priority.

**--cat-config**
Copy the contents of config files to standard output. Before each file, the filename is printed as a comment.

**--no-pager**
Do not pipe output into a pager.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

It is possible to combine
**--create**,
**--clean**, and
**--remove**
in one invocation (in which case removal and clean-up are executed before creation of new files). For example, during boot the following command line is executed to ensure that all temporary and volatile directories are removed and created according to the configuration file:

.if n \{.RS 4
.\}
    systemd-tmpfiles --remove --create
.if n \{.RE
.\}

<a name="unprivileged-cleanup-operation"></a>

# Unprivileged \-\-Cleanup Operation


**systemd-tmpfiles**
tries to avoid changing the access and modification times on the directories it accesses, which requires
**CAP\_FOWNER**
privileges. When running as non-root, directories which are checked for files to clean up will have their access time bumped, which might prevent their cleanup.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned. If the configuration was syntactically invalid (syntax errors, missing arguments, ...), so some lines had to be ignored, but no other errors occurred,
**65**
is returned (**EX\_DATAERR**
from
/usr/include/sysexits.h). If the configuration was syntactically valid, but could not be executed (lack of permissions, creation of files in missing directories, invalid contents when writing to
/sys/
values, ...),
**73**
is returned (**EX\_CANTCREAT**
from
/usr/include/sysexits.h). Otherwise,
**1**
is returned (**EXIT\_FAILURE**
from
/usr/include/stdlib.h).

<a name="see-also"></a>

# See Also


**systemd**(1),
**tmpfiles.d**(5)
