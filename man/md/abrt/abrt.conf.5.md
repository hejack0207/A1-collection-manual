# abrt\&.conf(5)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt.conf - Configuration file for ABRT.

<a name="synopsis"></a>

# Synopsis

```

 /etc/abrt/abrt.conf
```

<a name="description"></a>

# Description


ABRT is a daemon that watches for application crashes. When a crash occurs, it collects the problem data and takes action according to its configuration. This document describes ABRT’s configuration file.

The configuration file consists of items in the format "Option = Value". A description of each item follows:

**DumpLocation = ****directory**
The directory where ABRT should store coredumps and other files which are needed for reporting.

Default is
_/var/spool/abrt_.

**MaxCrashReportsSize = ****number**
The maximum disk space (specified in MiB) that ABRT will use for all the crash dumps. Value of 0 means "unlimited space".

Default is 5000.

**WatchCrashdumpArchiveDir = ****directory**
The daemon will watch this directory and call
_abrt-handle-upload_
on files which appear there. This is used to auto-unpack crashdump tarballs uploaded via FTP, SCP, etc.

Note: The directory must exist and be writable for
_abrtd_. It will not be created automatically.

Example: /var/spool/abrt-upload

Default is none, hence the feature is disabled.

**DeleteUploaded = ****yes/no**
The daemon will delete an uploaded crashdump archive after an atempt to unpack it. An archive will be delete whether unpacking finishes successfully or not.

If you decide to enable this, you have to tweak the SELinux policy:
# setsebool -P abrt_anon_write 1.

Default value is
_no_.

**DebugLevel = ****0-100**
Allows ABRT tools to detect problems in ABRT itself. By increasing the value you can force ABRT to detect, process and report problems in ABRT. You have to bear in mind that ABRT might fall into an infinite loop when handling problems caused by itself.

Default is 0 (non debug mode).

**AutoreportingEnabled = ****yes/no**
Enables automatic execution of the event configured in
_AutoreportingEvent_
option.

Default is
_no_.

**AutoreportingEvent = ****event**
A name of event which is run automatically after problem’s detection. The event should perform some fast analysis and exit with 70 if the problem is known.

Default is
_report\_uReport_.

**ShortenedReporting = ****yes/no**
Enables shortened GUI reporting where the reporting is interrupted after
_AutoreportingEvent_
is done.

Default is
_yes_
if application is running in a GNOME desktop session; otherwise it’s
_no_.

**ExploreChroots = ****yes/no**
Enables various features exploring process’s root directories if they differ from the default root directory. The following list includes examples of enabled features:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  query the RPM database in the process’s root directory,

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  save files like
  /etc/os-release
  from the process’s root directory.

This feature is disabled by default because it might be used by a local user to steal your data.

Caution: THIS FEATURE MIGHT BE USED BY A LOCAL USER TO STEAL YOUR DATA BY ARRANGING A SPECIAL ROOT DIRECTORY IN USER MOUNT NAMESPACE.

Default is
_no_.

<a name="files"></a>

# Files


/etc/abrt/abrt.conf

<a name="see-also"></a>

# See Also


abrtd(8) abrt-action-save-package-data.conf(5) abrt-handle-upload(1)

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
