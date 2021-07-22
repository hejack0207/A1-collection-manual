# hier(7) - description of the filesystem hierarchy

Linux, 2017-11-26


<a name="description"></a>

# Description

A typical Linux system has, among others, the following directories:

* _/_  
  This is the root directory.
  This is where the whole tree starts.
* _/bin_  
  This directory contains executable programs which are needed in
  single user mode and to bring the system up or repair it.
* _/boot_  
  Contains static files for the boot loader.
  This directory holds only
  the files which are needed during the boot process.
  The map installer
  and configuration files should go to
  _/sbin_
  and
  _/etc_.
  The operating system kernel (initrd for example) must be located in either
  _/_
  or
  _/boot_.
* _/dev_  
  Special or device files, which refer to physical devices.
  See
  **mknod**(1).
* _/etc_  
  Contains configuration files which are local to the machine.
  Some
  larger software packages, like X11, can have their own subdirectories
  below
  _/etc_.
  Site-wide configuration files may be placed here or in
  _/usr/etc_.
  Nevertheless, programs should always look for these files in
  _/etc_
  and you may have links for these files to
  _/usr/etc_.
* _/etc/opt_  
  Host-specific configuration files for add-on applications installed
  in
  _/opt_.
* _/etc/sgml_  
  This directory contains the configuration files for SGML (optional).
* _/etc/skel_  
  When a new user account is created, files from this directory are
  usually copied into the user's home directory.
* _/etc/X11_  
  Configuration files for the X11 window system (optional).
* _/etc/xml_  
  This directory contains the configuration files for XML (optional).
* _/home_  
  On machines with home directories for users, these are usually beneath
  this directory, directly or not.
  The structure of this directory
  depends on local administration decisions (optional).
* _/lib_  
  This directory should hold those shared libraries that are necessary
  to boot the system and to run the commands in the root filesystem.
* _/lib&lt;qual&gt;_  
  These directories are variants of
  _/lib_
  on system which support more than one binary format requiring separate
  libraries (optional).
* _/lib/modules_  
  Loadable kernel modules (optional).
* _/lost+found_  
  This directory contains items lost in the filesystem.
  These items are usually chunks of files mangled as a consequence of
  a faulty disk or a system crash.
* _/media_  
  This directory contains mount points for removable media such as CD
  and DVD disks or USB sticks.
  On systems where more than one device exists
  for mounting a certain type of media,
  mount directories can be created by appending a digit
  to the name of those available above starting with '0',
  but the unqualified name must also exist.
* _/media/floppy[1-9]_  
  Floppy drive (optional).
* _/media/cdrom[1-9]_  
  CD-ROM drive (optional).
* _/media/cdrecorder[1-9]_  
  CD writer (optional).
* _/media/zip[1-9]_  
  Zip drive (optional).
* _/media/usb[1-9]_  
  USB drive (optional).
* _/mnt_  
  This directory is a mount point for a temporarily mounted filesystem.
  In some distributions,
  _/mnt_
  contains subdirectories intended to be used as mount points for several
  temporary filesystems.
* _/opt_  
  This directory should contain add-on packages that contain static files.
* _/proc_  
  This is a mount point for the
  _proc_
  filesystem, which provides information about running processes and
  the kernel.
  This pseudo-filesystem is described in more detail in
  **proc**(5).
* _/root_  
  This directory is usually the home directory for the root user (optional).
* _/sbin_  
  Like
  _/bin_,
  this directory holds commands needed to boot the system, but which are
  usually not executed by normal users.
* _/srv_  
  This directory contains site-specific data that is served by this system.
* _/sys_  
  This is a mount point for the sysfs filesystem, which provides information
  about the kernel like
  _/proc_,
  but better structured, following the formalism of kobject infrastructure.
* _/tmp_  
  This directory contains temporary files which may be deleted with no
  notice, such as by a regular job or at system boot up.
* _/usr_  
  This directory is usually mounted from a separate partition.
  It should hold only shareable, read-only data, so that it can be mounted
  by various machines running Linux.
* _/usr/X11R6_  
  The X-Window system, version 11 release 6 (optional).
* _/usr/X11R6/bin_  
  Binaries which belong to the X-Window system; often, there is a
  symbolic link from the more traditional
  _/usr/bin/X11_
  to here.
* _/usr/X11R6/lib_  
  Data files associated with the X-Window system.
* _/usr/X11R6/lib/X11_  
  These contain miscellaneous files needed to run X;  Often, there is a
  symbolic link from
  _/usr/lib/X11_
  to this directory.
* _/usr/X11R6/include/X11_  
  Contains include files needed for compiling programs using the X11
  window system.
  Often, there is a symbolic link from
  _/usr/include/X11_
  to this directory.
* _/usr/bin_  
  This is the primary directory for executable programs.
  Most programs
  executed by normal users which are not needed for booting or for
  repairing the system and which are not installed locally should be
  placed in this directory.
* _/usr/bin/mh_  
  Commands for the MH mail handling system (optional).
* _/usr/bin/X11_  
  is the traditional place to look for X11 executables; on Linux, it
  usually is a symbolic link to
  _/usr/X11R6/bin_.
* _/usr/dict_  
  Replaced by
  _/usr/share/dict_.
* _/usr/doc_  
  Replaced by
  _/usr/share/doc_.
* _/usr/etc_  
  Site-wide configuration files to be shared between several machines
  may be stored in this directory.
  However, commands should always
  reference those files using the
  _/etc_
  directory.
  Links from files in
  _/etc_
  should point to the appropriate files in
  _/usr/etc_.
* _/usr/games_  
  Binaries for games and educational programs (optional).
* _/usr/include_  
  Include files for the C compiler.
* _/usr/include/bsd_  
  BSD compatibility include files (optional).
* _/usr/include/X11_  
  Include files for the C compiler and the X-Window system.
  This is
  usually a symbolic link to
  _/usr/X11R6/include/X11_.
* _/usr/include/asm_  
  Include files which declare some assembler functions.
  This used to be a
  symbolic link to
  _/usr/src/linux/include/asm_.
* _/usr/include/linux_  
  This contains information which may change from system release to
  system release and used to be a symbolic link to
  _/usr/src/linux/include/linux_
  to get at operating-system-specific information.
* (Note that one should have include files there that work correctly with
  the current libc and in user space.
  However, Linux kernel source is not
  designed to be used with user programs and does not know anything
  about the libc you are using.
  It is very likely that things will break
  if you let
  _/usr/include/asm_
  and
  _/usr/include/linux_
  point at a random kernel tree.
  Debian systems don't do this
  and use headers from a known good kernel
  version, provided in the libc*-dev package.)
* _/usr/include/g++_  
  Include files to use with the GNU C++ compiler.
* _/usr/lib_  
  Object libraries, including dynamic libraries, plus some executables
  which usually are not invoked directly.
  More complicated programs may
  have whole subdirectories there.
* _/usr/lib&lt;qual&gt;_  
  These directories are variants of
  _/usr/lib_
  on system which support more than one binary format requiring separate
  libraries, except that the symbolic link
  _/usr/lib&lt;qual&gt;/X11_
  is not required (optional).
* _/usr/lib/X11_  
  The usual place for data files associated with X programs, and
  configuration files for the X system itself.
  On Linux, it usually is
  a symbolic link to
  _/usr/X11R6/lib/X11_.
* _/usr/lib/gcc-lib_  
  contains executables and include files for the GNU C compiler,
  **gcc**(1).
* _/usr/lib/groff_  
  Files for the GNU groff document formatting system.
* _/usr/lib/uucp_  
  Files for
  **uucp**(1).
* _/usr/local_  
  This is where programs which are local to the site typically go.
* _/usr/local/bin_  
  Binaries for programs local to the site.
* _/usr/local/doc_  
  Local documentation.
* _/usr/local/etc_  
  Configuration files associated with locally installed programs.
* _/usr/local/games_  
  Binaries for locally installed games.
* _/usr/local/lib_  
  Files associated with locally installed programs.
* _/usr/local/lib&lt;qual&gt;_  
  These directories are variants of
  _/usr/local/lib_
  on system which support more than one binary format requiring separate
  libraries (optional).
* _/usr/local/include_  
  Header files for the local C compiler.
* _/usr/local/info_  
  Info pages associated with locally installed programs.
* _/usr/local/man_  
  Man pages associated with locally installed programs.
* _/usr/local/sbin_  
  Locally installed programs for system administration.
* _/usr/local/share_  
  Local application data that can be shared among different architectures
  of the same OS.
* _/usr/local/src_  
  Source code for locally installed software.
* _/usr/man_  
  Replaced by
  _/usr/share/man_.
* _/usr/sbin_  
  This directory contains program binaries for system administration
  which are not essential for the boot process, for mounting
  _/usr_,
  or for system repair.
* _/usr/share_  
  This directory contains subdirectories with specific application data, that
  can be shared among different architectures of the same OS.
  Often one finds stuff here that used to live in
  _/usr/doc_
  or
  _/usr/lib_
  or
  _/usr/man_.
* _/usr/share/dict_  
  Contains the word lists used by spell checkers (optional).
* _/usr/share/dict/words_  
  List of English words (optional).
* _/usr/share/doc_  
  Documentation about installed programs (optional).
* _/usr/share/games_  
  Static data files for games in
  _/usr/games_
  (optional).
* _/usr/share/info_  
  Info pages go here (optional).
* _/usr/share/locale_  
  Locale information goes here (optional).
* _/usr/share/man_  
  Manual pages go here in subdirectories according to the man page sections.
* _/usr/share/man/&lt;locale&gt;/man[1-9]_  
  These directories contain manual pages for the
  specific locale in source code form.
  Systems which use a unique language and code set for all manual pages
  may omit the &lt;locale&gt; substring.
* _/usr/share/misc_  
  Miscellaneous data that can be shared among different architectures of the
  same OS.
* _/usr/share/nls_  
  The message catalogs for native language support go here (optional).
* _/usr/share/sgml_  
  Files for SGML (optional).
* _/usr/share/sgml/docbook_  
  DocBook DTD (optional).
* _/usr/share/sgml/tei_  
  TEI DTD (optional).
* _/usr/share/sgml/html_  
  HTML DTD (optional).
* _/usr/share/sgml/mathtml_  
  MathML DTD (optional).
* _/usr/share/terminfo_  
  The database for terminfo (optional).
* _/usr/share/tmac_  
  Troff macros that are not distributed with groff (optional).
* _/usr/share/xml_  
  Files for XML (optional).
* _/usr/share/xml/docbook_  
  DocBook DTD (optional).
* _/usr/share/xml/xhtml_  
  XHTML DTD (optional).
* _/usr/share/xml/mathml_  
  MathML DTD (optional).
* _/usr/share/zoneinfo_  
  Files for timezone information (optional).
* _/usr/src_  
  Source files for different parts of the system, included with some packages
  for reference purposes.
  Don't work here with your own projects, as files
  below /usr should be read-only except when installing software (optional).
* _/usr/src/linux_  
  This was the traditional place for the kernel source.
  Some distributions put here the source for the default kernel they ship.
  You should probably use another directory when building your own kernel.
* _/usr/tmp_  
  Obsolete.
  This should be a link
  to
  _/var/tmp_.
  This link is present only for compatibility reasons and shouldn't be used.
* _/var_  
  This directory contains files which may change in size, such as spool
  and log files.
* _/var/account_  
  Process accounting logs (optional).
* _/var/adm_  
  This directory is superseded by
  _/var/log_
  and should be a symbolic link to
  _/var/log_.
* _/var/backups_  
  Reserved for historical reasons.
* _/var/cache_  
  Data cached for programs.
* _/var/cache/fonts_  
  Locally-generated fonts (optional).
* _/var/cache/man_  
  Locally-formatted man pages (optional).
* _/var/cache/www_  
  WWW proxy or cache data (optional).
* _/var/cache/&lt;package&gt;_  
  Package specific cache data (optional).
* _/var/catman/cat[1-9]_ or _/var/cache/man/cat[1-9]_  
  These directories contain preformatted manual pages according to their
  man page section.
  (The use of preformatted manual pages is deprecated.)
* _/var/crash_  
  System crash dumps (optional).
* _/var/cron_  
  Reserved for historical reasons.
* _/var/games_  
  Variable game data (optional).
* _/var/lib_  
  Variable state information for programs.
* _/var/lib/hwclock_  
  State directory for hwclock (optional).
* _/var/lib/misc_  
  Miscellaneous state data.
* _/var/lib/xdm_  
  X display manager variable data (optional).
* _/var/lib/&lt;editor&gt;_  
  Editor backup files and state (optional).
* _/var/lib/&lt;name&gt;_  
  These directories must be used for all distribution packaging support.
* _/var/lib/&lt;package&gt;_  
  State data for packages and subsystems (optional).
* _/var/lib/&lt;pkgtool&gt;_  
  Packaging support files (optional).
* _/var/local_  
  Variable data for
  _/usr/local_.
* _/var/lock_  
  Lock files are placed in this directory.
  The naming convention for
  device lock files is
  _LCK..&lt;device&gt;_
  where
  _&lt;device&gt;_
  is the device's name in the filesystem.
  The format used is that of HDU UUCP lock files, that is, lock files
  contain a PID as a 10-byte ASCII decimal number, followed by a newline
  character.
* _/var/log_  
  Miscellaneous log files.
* _/var/opt_  
  Variable data for
  _/opt_.
* _/var/mail_  
  Users' mailboxes.
  Replaces
  _/var/spool/mail_.
* _/var/msgs_  
  Reserved for historical reasons.
* _/var/preserve_  
  Reserved for historical reasons.
* _/var/run_  
  Run-time variable files, like files holding process identifiers (PIDs)
  and logged user information
  _(utmp)_.
  Files in this directory are usually cleared when the system boots.
* _/var/spool_  
  Spooled (or queued) files for various programs.
* _/var/spool/at_  
  Spooled jobs for
  **at**(1).
* _/var/spool/cron_  
  Spooled jobs for
  **cron**(8).
* _/var/spool/lpd_  
  Spooled files for printing (optional).
* _/var/spool/lpd/printer_  
  Spools for a specific printer (optional).
* _/var/spool/mail_  
  Replaced by
  _/var/mail_.
* _/var/spool/mqueue_  
  Queued outgoing mail (optional).
* _/var/spool/news_  
  Spool directory for news (optional).
* _/var/spool/rwho_  
  Spooled files for
  **rwhod**(8)
  (optional).
* _/var/spool/smail_  
  Spooled files for the
  **smail**(1)
  mail delivery program.
* _/var/spool/uucp_  
  Spooled files for
  **uucp**(1)
  (optional).
* _/var/tmp_  
  Like
  _/tmp_,
  this directory holds temporary files stored for an unspecified duration.
* _/var/yp_  
  Database files for NIS,
  formerly known as the Sun Yellow Pages (YP).

<a name="conforming-to"></a>

# Conforming to

The Filesystem Hierarchy Standard, Version 2.3
[](http://www.pathname.com​/fhs/).

<a name="bugs"></a>

# Bugs

This list is not exhaustive; different systems may be configured
differently.

<a name="see-also"></a>

# See Also

**find**(1),
**ln**(1),
**proc**(5),
**file-hierarchy**(7),
**mount**(8)

The Filesystem Hierarchy Standard

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
