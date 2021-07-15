# systemd\&.offline\-updates(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.offline-updates - Implementation of offline updates in systemd

<a name="implementing-offline-system-updates"></a>

# Implementing Offline System Updates


This man page describes how to implement "offline" system updates with systemd. By "offline" OS updates we mean package installations and updates that are run with the system booted into a special system update mode, in order to avoid problems related to conflicts of libraries and services that are currently running with those on disk. This document is inspired by this
\m[blue]**GNOME design whiteboard**\m[]\s-2\u[1]\d\s+2.

The logic:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  The package manager prepares system updates by downloading all (RPM or DEB or whatever) packages to update off-line in a special directory
  /var/lib/system-update
  (or another directory of the package/upgrade managers choice).

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  When the user OKed the update, the symlink
  /system-update
  is created that points to
  /var/lib/system-update
  (or wherever the directory with the upgrade files is located) and the system is rebooted. This symlink is in the root directory, since we need to check for it very early at boot, at a time where
  /var
  is not available yet.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Very early in the new boot
  **systemd-system-update-generator**(8)
  checks whether
  /system-update
  exists. If so, it (temporarily and for this boot only) redirects (i.e. symlinks)
  default.target
  to
  system-update.target, a special target that pulls in the base system (i.e.
  sysinit.target, so that all file systems are mounted but little else) and the system update units.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  The system now continues to boot into
  default.target, and thus into
  system-update.target. This target pulls in all system update units. Only one service should perform an update (see the next point), and all the other ones should exit cleanly with a "success" return code and without doing anything. Update services should be ordered after
  sysinit.target
  so that the update starts after all file systems have been mounted.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  As the first step, an update service should check if the
  /system-update
  symlink points to the location used by that update service. In case it does not exist or points to a different location, the service must exit without error. It is possible for multiple update services to be installed, and for multiple update services to be launched in parallel, and only the one that corresponds to the tool that
  _created_
  the symlink before reboot should perform any actions. It is unsafe to run multiple updates in parallel.

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  The update service should now do its job. If applicable and possible, it should create a file system snapshot, then install all packages. After completion (regardless whether the update succeeded or failed) the machine must be rebooted, for example by calling
  **systemctl reboot**. In addition, on failure the script should revert to the old file system snapshot (without the symlink).

.ie n \{\h'-04' 7.\h'+01'\c
.\}
.el \{.sp -1

*   7.  
  .\}
  The upgrade scripts should exit only after the update is finished. It is expected that the service which performs the upgrade will cause the machine to reboot after it is done. If the
  system-update.target
  is successfully reached, i.e. all update services have run, and the
  /system-update
  symlink still exists, it will be removed and the machine rebooted as a safety measure.

.ie n \{\h'-04' 8.\h'+01'\c
.\}
.el \{.sp -1

*   8.  
  .\}
  After a reboot, now that the
  /system-update
  symlink is gone, the generator wont redirect
  default.target
  anymore and the system now boots into the default target again.

<a name="recommendations"></a>

# Recommendations


.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  To make things a bit more robust we recommend hooking the update script into
  system-update.target
  via a
  .wants/
  symlink in the distribution package, rather than depending on
  **systemctl enable**
  in the postinst scriptlets of your package. More specifically, for your update script create a .service file, without [Install] section, and then add a symlink like
  /usr/lib/systemd/system-update.target.wants/foobar.service
  →
  ../foobar.service
  to your package.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Make sure to remove the
  /system-update
  symlink as early as possible in the update script to avoid reboot loops in case the update fails.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Use
  _FailureAction=reboot_
  in the service file for your update script to ensure that a reboot is automatically triggered if the update fails.
  _FailureAction=_
  makes sure that the specified unit is activated if your script exits uncleanly (by non-zero error code, or signal/coredump). If your script succeeds you should trigger the reboot in your own code, for example by invoking loginds
  **Reboot()**
  call or calling
  **systemctl reboot**. See
  \m[blue]**logind dbus API**\m[]\s-2\u[2]\d\s+2
  for details.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  The update service should declare
  _DefaultDependencies=no_,
  _Requires=sysinit.target_,
  _After=sysinit.target_,
  _After=system-update-pre.target_,
  _Before=system-update.target_
  and explicitly pull in any other services it requires.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  It may be desirable to always run an auxiliary unit when booting into offline-updates mode, which itself does not install updates. To do this create a .service file with
  _Wants=system-update-pre.target_
  and
  _Before=system-update-pre.target_
  and add a symlink to that file under
  /usr/lib/systemd/system-update.target.wants
  .

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.generator**(7),
**systemd-system-update-generator**(8),
**dnf.plugin.system-upgrade**(8)

<a name="notes"></a>

# Notes


*  1.  
  GNOME design whiteboard
      https://wiki.gnome.org/Design/OS/SoftwareUpdates
*  2.  
  logind dbus API
      https://www.freedesktop.org/wiki/Software/systemd/logind
