# sa1(8) - Collect and store binary data in the system activity daily data file.

Linux, JULY 2018

```
/usr/lib64/sa/sa1 [ --boot | interval count ]
```

<a name="description"></a>

# Description

The
**sa1**
command is a shell procedure variant of the
**sadc**
command and handles all of the flags and parameters of that command. The
**sa1**
command collects and stores binary data in the current standard
system activity daily data file.

The standard system activity daily data file is named
_saDD_
unless
**sadc**'s
option
**-D**
is used, in which case its name is
_saYYYYMMDD_,
where YYYY stands for the current year, MM for the current month
and DD for the current day. By default it is located in the
_/var/log/sa_
directory.

The
_interval_
and
_count_
parameters specify that the record should be written
_count_
times at
_interval_
seconds. If no arguments are given to
**sa1**
then a single record is written.

The
**sa1**
command is designed to be started automatically by the cron command.


<a name="options"></a>

# Options


* --boot  
  This option tells
  **sa1**
  that the
  **sadc**
  command should be called without specifying the
  _interval_
  and
  _count_
  parameters in order to insert a dummy record, marking the time when the counters
  restart from 0.
  

<a name="example"></a>

# Example

To collect data (including those from disks) every 10 minutes,
place the following entry in your root crontab file:

**0,10,20,30,40,50 * * * * /usr/lib64/sa/sa1 1 1 -S DISK**


<a name="files"></a>

# Files

_/var/log/sa/saDD_  
_/var/log/sa/saYYYYMMDD_
The standard system activity daily data files and their default location.
YYYY stands for the current year, MM for the current month and DD for the
current day.

<a name="author"></a>

# Author

Sebastien Godard (sysstat &lt;at&gt; orange.fr)

<a name="see-also"></a>

# See Also

**sar**(1),
**sadc**(8),
**sa2**(8),
**sadf**(1),
**sysstat**(5)

_https://github.com/sysstat/sysstat_

_http://pagesperso-orange.fr/sebastien.godard/_
