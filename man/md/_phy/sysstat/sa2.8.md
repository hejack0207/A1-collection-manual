# sa2(8) - Create a report from the current standard system activity daily data file.

Linux, JULY 2018

```
/usr/lib64/sa/sa2
```

<a name="description"></a>

# Description

The
**sa2**
command is a shell procedure variant of the
**sar**
command which writes a daily report in the
_sarDD_
or the
_sarYYYYMMDD_
file, where YYYY stands for the current year, MM for the current month
and DD for the current day.
By default the report is saved in the
_/var/log/sa_
directory.
The
**sa2**
command will also remove reports more than one week old by default.
You can however keep reports for a longer (or a shorter) period by setting
the
**HISTORY**
environment variable. Read the
**sysstat**(5)
manual page for details.

The
**sa2**
command accepts most of the flags and parameters of the
**sar**
command.

The
**sa2**
command is designed to be started automatically by the cron command.


<a name="examples"></a>

# Examples

To run the
**sa2**
command daily, place the following entry in your root crontab file:

**5 19 * * 1-5 /usr/lib64/sa/sa2 -A**

This will generate by default a daily report called
_sarDD_
in the
_/var/log/sa_
directory, where the DD parameter is a number representing the day of the
month.

<a name="files"></a>

# Files

_/var/log/sa/sarDD_  
_/var/log/sa/sarYYYYMMDD_
The standard system activity daily report files and their default location.
YYYY stands for the current year, MM for the current month and DD for the
current day.

<a name="author"></a>

# Author

Sebastien Godard (sysstat &lt;at&gt; orange.fr)

<a name="see-also"></a>

# See Also

**sar**(1),
**sadc**(8),
**sa1**(8),
**sadf**(1),
**sysstat**(5)

_https://github.com/sysstat/sysstat_

_http://pagesperso-orange.fr/sebastien.godard/_
