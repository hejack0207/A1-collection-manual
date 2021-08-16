# cifsiostat(1) - Report CIFS statistics.

Linux, JULY 2018

```
.ie 'yes'no' \{ cifsiostat [ -h ] [ -k | -m ] [ -t ] [ -V ] [ --debuginfo ] [ --dec={ 0 | 1 | 2 } ] [ --human ] [ interval [ count ] ] .\} .el \{ cifsiostat [ -h ] [ -k | -m ] [ -t ] [ -V ] [ --dec={ 0 | 1 | 2 } ] [ --human ] [ interval [ count ] ] .\}
```

<a name="description"></a>

# Description

The
**cifsiostat**
command displays statistics about read and write operations
on CIFS filesystems.

The
_interval_
parameter specifies the amount of time in seconds between
each report. The first report contains statistics for the time since
system startup (boot). Each subsequent report contains statistics
collected during the interval since the previous report.
A report consists of a CIFS header row followed by
a line of statistics for each CIFS filesystem that is mounted.
The
_count_
parameter can be specified in conjunction with the
_interval_
parameter. If the
_count_
parameter is specified, the value of
_count_
determines the number of reports generated at
_interval_
seconds apart. If the
_interval_
parameter is specified without the
_count_
parameter, the
**cifsiostat**
command generates reports continuously.


<a name="report"></a>

# Report

The CIFS report provides statistics for each mounted CIFS filesystem.
The report shows the following fields:

**Filesystem:**
This columns shows the mount point of the CIFS filesystem.

**rB/s (rkB/s, rMB/s)**
Indicate the average number of bytes (kilobytes, megabytes) read per second.

**wB/s (wkB/s, wMB/s)**
Indicate the average number of bytes (kilobytes, megabytes) written per second.

**rop/s**
Indicate the number of 'read' operations that were issued to the filesystem
per second.

**wop/s**
Indicate the number of 'write' operations that were issued to the filesystem
per second.

**fo/s**
Indicate the number of open files per second.

**fc/s**
Indicate the number of closed files per second.

**fd/s**
Indicate the number of deleted files per second.

<a name="options"></a>

# Options

.if 'yes'no' \{

* --debuginfo  
  Print debug output to stderr.
  .\}
* --dec={ 0 | 1 | 2 }  
  Specify the number of decimal places to use (0 to 2, default value is 2).
* -h  
  Make the CIFS report easier to read by a human.
  **--human**
  is enabled implicitly with this option.
* --human  
  Print sizes in human readable format (e.g. 1.0k, 1.2M, etc.)
  The units displayed with this option supersede any other default units (e.g.
  kilobytes, sectors...) associated with the metrics.
* -k  
  Display statistics in kilobytes per second.
* -m  
  Display statistics in megabytes per second.
* -t  
  Print the time for each report displayed. The timestamp format may depend
  on the value of the S_TIME_FORMAT environment variable (see below).
* -V  
  Print version number then exit.
  

<a name="environment"></a>

# Environment

The
**cifsiostat**
command takes into account the following environment variables:


* S_COLORS  
  When this variable is set, display statistics in color on the terminal.
  Possible values for this variable are
  _never_,
  _always_
  or
  _auto_
  (the latter is the default).
  
  Please note that the color (being red, yellow, or some other color) used to display a value
  is not indicative of any kind of issue simply because of the color. It only indicates different
  ranges of values.
  
* S_COLORS_SGR  
  Specify the colors and other attributes used to display statistics on the terminal.
  Its value is a colon-separated list of capabilities that defaults to
  **I=32;22:N=34;1:Z=34;22**.
  Supported capabilities are:
  
    * **I=**  
      SGR substring for filesystem names.
      
    * **N=**  
      SGR substring for non-zero statistics values.
      
    * **Z=**  
      SGR substring for zero values.
  
* S_TIME_FORMAT  
  If this variable exists and its value is
  **ISO**
  then the current locale will be ignored when printing the date in the report
  header. The
  **cifsiostat**
  command will use the ISO 8601 format (YYYY-MM-DD) instead.
  The timestamp displayed with option -t will also be compliant with ISO 8601
  format.
  

<a name="bug"></a>

# Bug

_/proc_
filesystem must be mounted for
**cifsiostat**
to work.


<a name="file"></a>

# File

_/proc/fs/cifs/Stats_
contains CIFS statistics.

<a name="authors"></a>

# Authors

Written by Ivana Varekova (varekova &lt;at&gt; redhat.com)

Maintained by Sebastien Godard (sysstat &lt;at&gt; orange.fr)

<a name="see-also"></a>

# See Also

**sar**(1),
**pidstat**(1),
**mpstat**(1),
**vmstat**(8),
**iostat**(1),
**tapestat**(1),
**nfsiostat**(1)

_https://github.com/sysstat/sysstat_

_http://pagesperso-orange.fr/sebastien.godard/_
