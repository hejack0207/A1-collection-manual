# anacrontab(5) - configuration file for Anacron

cronie, 2012-11-22


<a name="description"></a>

# Description

The
_/etc/anacrontab_
configuration file describes the jobs controlled by
**anacron**(8).
It can contain three types of lines: job-description lines, environment
assignments, or empty lines.

Job-description lines can have the following format:

   period in days   delay in minutes   job-identifier   command

The
_period in days_
variable specifies the frequency of execution of a job in days.  This
variable can be represented by an integer or a macro (@daily, @weekly,
@monthly), where @daily denotes the same value as the integer 1, @weekly
the same as 7, and @monthly specifies that the job is run once a month,
independent on the length of the month.

The
_delay in minutes_
variable specifies the number of minutes anacron waits, if necessary,
before executing a job.  This variable is represented by an integer where
0 means no delay.

The
_job-identifier_
variable specifies a unique name of a job which is used in the log files.

The
_command_
variable specifies the command to execute.  The command can either be a
command such as
**ls /proc &gt;&gt; /tmp/proc**
or a command to execute a custom script.

Environment assignment lines can have the following format:

   VAR=VALUE

Any spaces around
_VAR_
are removed.  No spaces around
_VALUE_
are allowed (unless you want them to be part of the value).  The
specified assignment takes effect from the next line until the end of the
file, or to the next assignment of the same variable.

The
_START_HOURS_RANGE_
variable defines an interval (in hours) when scheduled jobs can be run.
In case this time interval is missed, for example, due to a power down,
then scheduled jobs are not executed that day.

The
_RANDOM_DELAY_
variable denotes the maximum number of minutes that will be added to the
delay in minutes variable which is specified for each job.  A
_RANDOM_DELAY_
set to 12 would therefore add, randomly, between 0 and 12 minutes to the
delay in minutes for each job in that particular anacrontab.  When set to
0, no random delay is added.

Empty lines are either blank lines, line containing white spaces only, or
lines with white spaces followed by a '#' followed by an arbitrary
comment.

You can continue a line onto the next line by adding a '\\' at the end of it.

In case you want to disable Anacron, add a line with
_0anacron_
which is the name of the script running the Anacron into the
_/etc/cron.hourly/jobs.deny_
file.

<a name="example"></a>

# Example

This example shows how to set up an Anacron job similar in functionality to
_/etc/crontab_
which starts all regular jobs
between 6:00 and 8:00
_only._
A
_RANDOM_DELAY_
which can be 30 minutes at the most is specified.  Jobs will run
serialized in a queue where each job is started only after the previous
one is finished.

    # environment variables
    SHELL=/bin/sh
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    MAILTO=root
    RANDOM_DELAY=30
    # Anacron jobs will start between 6am and 8am.
    START_HOURS_RANGE=6-8
    # delay will be 5 minutes + RANDOM_DELAY for cron.daily
    1		5	cron.daily		nice run-parts /etc/cron.daily
    7		0	cron.weekly		nice run-parts /etc/cron.weekly
    @monthly	0	cron.monthly		nice run-parts /etc/cron.monthly

<a name="see-also"></a>

# See Also

**anacron**(8),
**crontab**(1)

The Anacron
_README_
file.

<a name="author"></a>

# Author

.MT itzur@​actcom.​co.​il
Itai Tzur
.ME

Currently maintained by
.MT pasc@​(debian.​org|​redellipse.​net)
Pascal Hakim
.ME .

For Fedora, maintained by
.MT [mmaslano@redhat.com](mailto:mmaslano@redhat.com)
Marcela Mašláňová
.ME .
