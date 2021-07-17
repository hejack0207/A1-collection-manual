# cronnext(1) - time of next job cron will execute

cronie, 2017-06-11

```
.TP 9 cronnext [-i users] [-e users] [-s] [-a] [-t time] [-q time] [-l] [-c] [-f] [-h] [-V] [file]...
```

<a name="description"></a>

# Description

Determine the time cron will execute the next job.  Without arguments, it
prints that time considering all crontabs, in number of seconds since the
Epoch, rounded to the minute. This number can be converted into other formats
using
**date**(1),
like
**date --date @43243254**

The file arguments are optional. If provided,
_cronnext_
uses them as crontabs instead of the ones installed in the system.

<a name="options"></a>

# Options


* **-i **_user,user,user,..._  
  Consider only the crontabs of the specified users.  Use
  <b>*system*</b>
  for the system crontab.
* **-e **_user,user,user,..._  
  Do not consider the crontabs of the specified users.
* **-s**  
  Do not consider the system crontab, usually the
  _/etc/crontab_
  file.  The system crontab usually contains the hourly, daily, weekly and
  montly crontabs, which might be better dealt with
  **anacron**(8).
* **-a**  
  Use the crontabs installed in the system in addition to the ones passed as
  file arguments. This is implicit if no file is passed.
* **-t **_time_  
  Determine the next job from this time, instead of now.  The time is
  expressed in number of seconds since the Epoch, as obtained for example by
  **date +%s --date "now + 2 hours"**,
  and is internally rounded to the minute.
* **-q **_time_  
  Do not check jobs over this time, expressed in the same way as in option
  **-t**.
* **-l**  
  Print the whole entries of the jobs that are the next to be executed by cron.
  The default is to only print their next time of execution.
* **-c**  
  Print every entry in every crontab with the next time it is executed.
* **-f**  
  Print all jobs that are executed in the given interval. Requires option
  **-q**.
* **-h**  
  Print usage output and exit.
* **-V**  
  Print version and exit.

<a name="author"></a>

# Author

.MT [sgerwk@aol.com](mailto:sgerwk@aol.com)
Marco Migliori
.ME

<a name="see-also"></a>

# See Also

**cron**(8),
**cron**(1),
**crontab**(5),
**crontab**(1),
**anacron**(8),
**anacrontab**(5),
**atq**(1),
**date**(1)
