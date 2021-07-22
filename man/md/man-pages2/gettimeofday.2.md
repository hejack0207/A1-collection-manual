# gettimeofday(2) - get / set time

Linux, 2017-09-15

    #include <sys/time.h>
    
    int gettimeofday(struct timeval *tv, struct timezone *tz);
    
    int settimeofday(const struct timeval *tv, const struct timezone *tz);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 settimeofday():     Since glibc 2.19:         _DEFAULT_SOURCE     Glibc 2.19 and earlier:         _BSD_SOURCE
```

<a name="description"></a>

# Description

The functions
**gettimeofday**()
and
**settimeofday**()
can get and set the time as well as a timezone.
The
_tv_
argument is a
_struct timeval_
(as specified in
_&lt;sys/time.h&gt;_):

.in +4n
.EX
struct timeval {
    time_t      tv_sec;     /* seconds */
    suseconds_t tv_usec;    /* microseconds */
};
.EE
.in

and gives the number of seconds and microseconds since the Epoch (see
**time**(2)).
The
_tz_
argument is a
_struct timezone_:

.in +4n
.EX
struct timezone {
    int tz_minuteswest;     /* minutes west of Greenwich */
    int tz_dsttime;         /* type of DST correction */
};
.EE
.in

If either
_tv_
or
_tz_
is NULL, the corresponding structure is not set or returned.


(However, compilation warnings will result if
_tv_
is NULL.)





The use of the
_timezone_
structure is obsolete; the
_tz_
argument should normally be specified as NULL.
(See NOTES below.)

Under Linux, there are some peculiar "warp clock" semantics associated
with the
**settimeofday**()
system call if on the very first call (after booting)
that has a non-NULL
_tz_
argument, the
_tv_
argument is NULL and the
_tz_minuteswest_
field is nonzero.
(The
_tz_dsttime_
field should be zero for this case.)
In such a case it is assumed that the CMOS clock
is on local time, and that it has to be incremented by this amount
to get UTC system time.
No doubt it is a bad idea to use this feature.

<a name="return-value"></a>

# Return Value

**gettimeofday**()
and
**settimeofday**()
return 0 for success, or -1 for failure (in which case
_errno_
is set appropriately).

<a name="errors"></a>

# Errors


* **EFAULT**  
  One of
  _tv_
  or
  _tz_
  pointed outside the accessible address space.
* **EINVAL**  
  Timezone (or something else) is invalid.
* **EPERM**  
  The calling process has insufficient privilege to call
  **settimeofday**();
  under Linux the
  **CAP_SYS_TIME**
  capability is required.

<a name="conforming-to"></a>

# Conforming to

SVr4, 4.3BSD.
POSIX.1-2001 describes
**gettimeofday**()
but not
**settimeofday**().
POSIX.1-2008 marks
**gettimeofday**()
as obsolete, recommending the use of
**clock_gettime**(2)
instead.

<a name="notes"></a>

# Notes

The time returned by
**gettimeofday**()
_is_
affected by discontinuous jumps in the system time
(e.g., if the system administrator manually changes the system time).
If you need a monotonically increasing clock, see
**clock_gettime**(2).

Macros for operating on
_timeval_
structures are described in
**timeradd**(3).

Traditionally, the fields of
_struct timeval_
were of type
_long_.


<a name="c-librarykernel-differences"></a>

### C library/kernel differences

On some architectures, an implementation of
**gettimeofday**()
is provided in the
**vdso**(7).


<a name="the-tz_dsttime-field"></a>

### The tz_dsttime field

On a non-Linux kernel, with glibc, the
_tz_dsttime_
field of
_struct timezone_
will be set to a nonzero value by
**gettimeofday**()
if the current timezone has ever had or will have a daylight saving
rule applied.
In this sense it exactly mirrors the meaning of
**daylight**(3)
for the current zone.
On Linux, with glibc, the setting of the
_tz_dsttime_
field of
_struct timezone_
has never been used by
**settimeofday**()
or
**gettimeofday**().




Thus, the following is purely of historical interest.

On old systems, the field
_tz_dsttime_
contains a symbolic constant (values are given below)
that indicates in which part of the year Daylight Saving Time
is in force.
(Note: this value is constant throughout the year:
it does not indicate that DST is in force, it just selects an
algorithm.)
The daylight saving time algorithms defined are as follows:

.in +4n
.EX
**DST\_NONE**     /* not on DST */
**DST\_USA**      /* USA style DST */
**DST\_AUST**     /* Australian style DST */
**DST\_WET**      /* Western European DST */
**DST\_MET**      /* Middle European DST */
**DST\_EET**      /* Eastern European DST */
**DST\_CAN**      /* Canada */
**DST\_GB**       /* Great Britain and Eire */
**DST\_RUM**      /* Romania */
**DST\_TUR**      /* Turkey */
**DST\_AUSTALT**  /* Australian style with shift in 1986 */
.EE
.in

Of course it turned out that the period in which
Daylight Saving Time is in force cannot be given
by a simple algorithm, one per country; indeed,
this period is determined by unpredictable political
decisions.
So this method of representing timezones
has been abandoned.

<a name="see-also"></a>

# See Also

**date**(1),
**adjtimex**(2),
**clock_gettime**(2),
**time**(2),
**ctime**(3),
**ftime**(3),
**timeradd**(3),
**capabilities**(7),
**time**(7),
**vdso**(7),
**hwclock**(8)

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
