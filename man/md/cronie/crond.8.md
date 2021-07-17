# cron(8) - daemon to execute scheduled commands

cronie, 2013-09-26

```
crond [-c | -h | -i | -n | -p | -P | -s | -m<mailcommand>]
crond -x [ext,sch,proc,pars,load,misc,test,bit]
crond -V
```

<a name="description"></a>

# Description

_Cron_
is started from
_/etc/rc.d/init.d_
or
_/etc/init.d_
when classical sysvinit scripts are used. In case systemd is enabled, then unit file is installed into
_/lib/systemd/system/crond.service_
and daemon is started by
_systemctl start crond.service_
command. It returns immediately, thus, there is no need to need to start it with
the '&' parameter.

_Cron_
searches
_/var/spool/cron_
for crontab files which are named after accounts in
_/etc/passwd;_
The found crontabs are loaded into the memory.
_Cron_
also searches for
_/etc/anacrontab_
and any files in the
_/etc/cron.d_
directory, which have a different format (see
**crontab**(5)).
_Cron_
examines all stored crontabs and checks each job to see if it needs to be
run in the current minute.  When executing commands, any output is mailed
to the owner of the crontab (or to the user specified in the
_MAILTO_
environment variable in the crontab, if such exists).  Any job output can
also be sent to syslog by using the
**-s**
option.

There are two ways how changes in crontables are checked.  The first
method is checking the modtime of a file.  The second method is using the
inotify support.  Using of inotify is logged in the
_/var/log/cron_
log after the daemon is started.  The inotify support checks for changes
in all crontables and accesses the hard disk only when a change is
detected.

When using the modtime option,
_Cron_
checks its crontables' modtimes every minute to check for any changes and
reloads the crontables which have changed.  There is no need to restart
_Cron_
after some of the crontables were modified.  The modtime option is also
used when inotify can not be initialized.

_Cron_
checks these files and directories:

* _/etc/crontab_  
  system crontab.  Nowadays the file is empty by default.  Originally it
  was usually used to run daily, weekly, monthly jobs.  By default these
  jobs are now run through anacron which reads
  _/etc/anacrontab_
  configuration file.  See
  **anacrontab**(5)
  for more details.
* _/etc/cron.d/_  
  directory that contains system cronjobs stored for different users.
* _/var/spool/cron_  
  directory that contains user crontables created by the
  _crontab_
  command.

Note that the
**crontab**(1)
command updates the modtime of the spool directory whenever it changes a
crontab.


<a name="daylight-saving-time-and-other-time-changes"></a>

### Daylight Saving Time and other time changes

Local time changes of less than three hours, such as those caused by the
Daylight Saving Time changes, are handled in a special way.  This only
applies to jobs that run at a specific time and jobs that run with a
granularity greater than one hour.  Jobs that run more frequently are
scheduled normally.

If time was adjusted one hour forward, those jobs that would have run in
the interval that has been skipped will be run immediately.  Conversely,
if time was adjusted backward, running the same job twice is avoided.

Time changes of more than 3 hours are considered to be corrections to the
clock or the timezone, and the new time is used immediately.

It is possible to use different time zones for crontables.  See
**crontab**(5)
for more information.

<a name="pam-access-control"></a>

### PAM Access Control

_Cron_
supports access control with PAM if the system has PAM installed.  For
more information, see
**pam**(8).
A PAM configuration file for
_crond_
is installed in
_/etc/pam.d/crond_.
The daemon loads the PAM environment from the pam_env module.  This can
be overridden by defining specific settings in the appropriate crontab
file.

<a name="options"></a>

# Options


* **-h**  
  Prints a help message and exits.
* **-i**  
  Disables inotify support.
* **-m**  
  This option allows you to specify a shell command to use for sending
  _Cron_
  mail output instead of using
  **sendmail**(8)
  This command must accept a fully formatted mail message (with headers) on
  standard input and send it as a mail message to the recipients specified
  in the mail headers.  Specifying the string
  _off_
  (i.e., crond -m off)
  will disable the sending of mail.
* **-n**  
  Tells the daemon to run in the foreground.  This can be useful when
  starting it out of init. With this option is needed to change pam setting.
  _/etc/pam.d/crond_
  must not enable
  _pam_loginuid.so_
  module.
* **-p**  
  Allows
  _Cron_
  to accept any user set crontables.
* **-P**  
  Don't set PATH.  PATH is instead inherited from the environment.
* **-c**  
  This option enables clustering support, as described below.
* **-s**  
  This option will direct
  _Cron_
  to send the job output to the system log using
  **syslog**(3).
  This is useful if your system does not have
  **sendmail**(8),
  installed or if mail is disabled.
* **-x**  
  This option allows you to set debug flags.
* **-V**  
  Print version and exit.

<a name="signals"></a>

# Signals

When the
_SIGHUP_
is received, the
_Cron_
daemon will close and reopen its log file.  This proves to be useful in
scripts which rotate and age log files.  Naturally, this is not relevant
if
_Cron_
was built to use
_syslog_(3).

<a name="clustering-support"></a>

# Clustering Support

In this version of
_Cron_
it is possible to use a network-mounted shared
_/var/spool/cron_
across a cluster of hosts and specify that only one of the hosts should
run the crontab jobs in this directory at any one time.  This is done by
starting
_Cron_
with the
**-c**
option, and have the
_/var/spool/cron/.cron.hostname_
file contain just one line, which represents the hostname of whichever
host in the cluster should run the jobs.  If this file does not exist, or
the hostname in it does not match that returned by
**gethostname**(2),
then all crontab files in this directory are ignored.  This has no effect
on cron jobs specified in the
_/etc/crontab_
file or on files in the
_/etc/cron.d_
directory.  These files are always run and considered host-specific.

Rather than editing
_/var/spool/cron/.cron.hostname_
directly, use the
**-n**
option of
**crontab**(1)
to specify the host.

You should ensure that all hosts in a cluster, and the file server from
which they mount the shared crontab directory, have closely synchronised
clocks, e.g., using
**ntpd**(8),
otherwise the results will be very unpredictable.

Using cluster sharing automatically disables inotify support, because
inotify cannot be relied on with network-mounted shared file systems.

<a name="caveats"></a>

# Caveats

All
**crontab**
files have to be regular files or symlinks to regular files, they must
not be executable or writable for anyone else but the owner.  This
requirement can be overridden by using the
**-p**
option on the crond command line.  If inotify support is in use, changes
in the symlinked crontabs are not automatically noticed by the cron
daemon.  The cron daemon must receive a SIGHUP signal to reload the
crontabs.  This is a limitation of the inotify API.

The syslog output will be used instead of mail, when sendmail is not
installed.

<a name="see-also"></a>

# See Also

**crontab**(1),
**crontab**(5),
**inotify**(7),
**pam**(8)

<a name="author"></a>

# Author

.MT [vixie@isc.org](mailto:vixie@isc.org)
Paul Vixie
.ME  
.MT [mmaslano@redhat.com](mailto:mmaslano@redhat.com)
Marcela Mašláňová
.ME  
.MT [colin@colin-dean.org](mailto:colin@colin-dean.org)
Colin Dean
.ME  
.MT [tmraz@fedoraproject.org](mailto:tmraz@fedoraproject.org)
Tomáš Mráz
.ME
