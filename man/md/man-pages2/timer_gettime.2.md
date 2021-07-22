# timer_settime(2) - arm/disarm and fetch

Linux, 2017-09-15

state of POSIX per-process timer

<a name="synopsis"></a>

# Synopsis

     #include <time.h>
    
    int timer_settime(timer_t timerid, int flags,
                      const struct itimerspec *new_value,
                      struct itimerspec *old_value);
    int timer_gettime(timer_t timerid, struct itimerspec *curr_value);
```

 Link with -lrt. 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 timer_settime(), timer_gettime(): _POSIX_C_SOURCE&nbsp;>=&nbsp;199309L
```

<a name="description"></a>

# Description

**timer_settime**()
arms or disarms the timer identified by
_timerid_.
The
_new_value_
argument is pointer to an
_itimerspec_
structure that specifies the new initial value and
the new interval for the timer.
The
_itimerspec_
structure is defined as follows:

.in +4n
.EX
struct timespec {
    time_t tv_sec;                /* Seconds */
    long   tv_nsec;               /* Nanoseconds */
};

struct itimerspec {
    struct timespec it_interval;  /* Timer interval */
    struct timespec it_value;     /* Initial expiration */
};
.EE
.in

Each of the substructures of the
_itimerspec_
structure is a
_timespec_
structure that allows a time value to be specified
in seconds and nanoseconds.
These time values are measured according to the clock
that was specified when the timer was created by
**timer_create**(2).

If
_new_value-&gt;it_value_
specifies a nonzero value (i.e., either subfield is nonzero), then
**timer_settime**()
arms (starts) the timer,
setting it to initially expire at the given time.
(If the timer was already armed,
then the previous settings are overwritten.)
If
_new_value-&gt;it_value_
specifies a zero value
(i.e., both subfields are zero),
then the timer is disarmed.

The
_new_value-&gt;it_interval_
field specifies the period of the timer, in seconds and nanoseconds.
If this field is nonzero, then each time that an armed timer expires,
the timer is reloaded from the value specified in
_new_value-&gt;it_interval_.
If
_new_value-&gt;it_interval_
specifies a zero value,
then the timer expires just once, at the time specified by
_it_value_.

By default, the initial expiration time specified in
_new_value-&gt;it_value_
is interpreted relative to the current time on the timer's
clock at the time of the call.
This can be modified by specifying
**TIMER_ABSTIME**
in
_flags_,
in which case
_new_value-&gt;it_value_
is interpreted as an absolute value as measured on the timer's clock;
that is, the timer will expire when the clock value reaches the
value specified by
_new_value-&gt;it_value_.
If the specified absolute time has already passed,
then the timer expires immediately,
and the overrun count (see
**timer_getoverrun**(2))
will be set correctly.


If the value of the
**CLOCK_REALTIME**
clock is adjusted while an absolute timer based on that clock is armed,
then the expiration of the timer will be appropriately adjusted.
Adjustments to the
**CLOCK_REALTIME**
clock have no effect on relative timers based on that clock.



If
_old_value_
is not NULL, then it points to a buffer
that is used to return the previous interval of the timer (in
_old_value-&gt;it_interval_)
and the amount of time until the timer
would previously have next expired (in
_old_value-&gt;it_value_).

**timer_gettime**()
returns the time until next expiration, and the interval,
for the timer specified by
_timerid_,
in the buffer pointed to by
_curr_value_.
The time remaining until the next timer expiration is returned in
_curr_value-&gt;it_value_;
this is always a relative value, regardless of whether the
**TIMER_ABSTIME**
flag was used when arming the timer.
If the value returned in
_curr_value-&gt;it_value_
is zero, then the timer is currently disarmed.
The timer interval is returned in
_curr_value-&gt;it_interval_.
If the value returned in
_curr_value-&gt;it_interval_
is zero, then this is a "one-shot" timer.

<a name="return-value"></a>

# Return Value

On success,
**timer_settime**()
and
**timer_gettime**()
return 0.
On error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors

These functions may fail with the following errors:

* **EFAULT**  
  _new_value_,
  _old_value_,
  or
  _curr_value_
  is not a valid pointer.
* **EINVAL**  
  _timerid_
  is invalid.
  

**timer_settime**()
may fail with the following errors:

* **EINVAL**  
  _new_value.it_value_
  is negative; or
  _new_value.it_value.tv_nsec_
  is negative or greater than 999,999,999.

<a name="versions"></a>

# Versions

These system calls are available since Linux 2.6.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="example"></a>

# Example

See
**timer_create**(2).

<a name="see-also"></a>

# See Also

**timer_create**(2),
**timer_getoverrun**(2),
**time**(7)

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
