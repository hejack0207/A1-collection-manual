# timerfd_create(2)

Linux, 2017-09-15

timerfd_create, timerfd_settime, timerfd_gettime -
timers that notify via file descriptors

<a name="synopsis"></a>

# Synopsis

    #include <sys/timerfd.h>
    
    int timerfd_create(int clockid, int flags);
    
    int timerfd_settime(int fd, int flags,
                        const struct itimerspec *new_value,
                        struct itimerspec *old_value);
    
    int timerfd_gettime(int fd, struct itimerspec *curr_value);

<a name="description"></a>

# Description

These system calls create and operate on a timer
that delivers timer expiration notifications via a file descriptor.
They provide an alternative to the use of
**setitimer**(2)
or
**timer_create**(2),
with the advantage that the file descriptor may be monitored by
**select**(2),
**poll**(2),
and
**epoll**(7).

The use of these three system calls is analogous to the use of
**timer_create**(2),
**timer_settime**(2),
and
**timer_gettime**(2).
(There is no analog of
**timer_getoverrun**(2),
since that functionality is provided by
**read**(2),
as described below.)


<a name="timerfd_create"></a>

### timerfd_create()

**timerfd_create**()
creates a new timer object,
and returns a file descriptor that refers to that timer.
The
_clockid_
argument specifies the clock that is used to mark the progress
of the timer, and must one of the following:

* **CLOCK_REALTIME**  
  A settable system-wide real-time clock.
* **CLOCK_MONOTONIC**  
  A nonsettable monotonically increasing clock that measures time
  from some unspecified point in the past that does not change
  after system startup.
* **CLOCK_BOOTTIME** (Since Linux 3.15)  
  
  Like
  **CLOCK_MONOTONIC**,
  this is a monotonically increasing clock.
  However, whereas the
  **CLOCK_MONOTONIC**
  clock does not measure the time while a system is suspended, the
  **CLOCK_BOOTTIME**
  clock does include the time during which the system is suspended.
  This is useful for applications that need to be suspend-aware.
  **CLOCK_REALTIME**
  is not suitable for such applications, since that clock is affected
  by discontinuous changes to the system clock.
* **CLOCK_REALTIME_ALARM** (since Linux 3.11)  
  
  This clock is like
  **CLOCK_REALTIME**,
  but will wake the system if it is suspended.
  The caller must have the
  **CAP_WAKE_ALARM**
  capability in order to set a timer against this clock.
* **CLOCK_BOOTTIME_ALARM** (since Linux 3.11)  
  
  This clock is like
  **CLOCK_BOOTTIME**,
  but will wake the system if it is suspended.
  The caller must have the
  **CAP_WAKE_ALARM**
  capability in order to set a timer against this clock.

The current value of each of these clocks can be retrieved using
**clock_gettime**(2).

Starting with Linux 2.6.27, the following values may be bitwise ORed in
_flags_
to change the behavior of
**timerfd_create**():

* **TFD_NONBLOCK**  
  Set the
  **O_NONBLOCK**
  file status flag on the new open file description.
  Using this flag saves extra calls to
  **fcntl**(2)
  to achieve the same result.
* **TFD_CLOEXEC**  
  Set the close-on-exec
  (**FD_CLOEXEC**)
  flag on the new file descriptor.
  See the description of the
  **O_CLOEXEC**
  flag in
  **open**(2)
  for reasons why this may be useful.

In Linux versions up to and including 2.6.26,
_flags_
must be specified as zero.

<a name="timerfd_settime"></a>

### timerfd_settime()

**timerfd_settime**()
arms (starts) or disarms (stops)
the timer referred to by the file descriptor
_fd_.

The
_new_value_
argument specifies the initial expiration and interval for the timer.
The
_itimerspec_
structure used for this argument contains two fields,
each of which is in turn a structure of type
_timespec_:

.in +4n
.EX
struct timespec {
    time_t tv_sec;                /* Seconds */
    long   tv_nsec;               /* Nanoseconds */
};

struct itimerspec {
    struct timespec it_interval;  /* Interval for periodic timer */
    struct timespec it_value;     /* Initial expiration */
};
.EE
.in

_new_value.it_value_
specifies the initial expiration of the timer,
in seconds and nanoseconds.
Setting either field of
_new_value.it_value_
to a nonzero value arms the timer.
Setting both fields of
_new_value.it_value_
to zero disarms the timer.

Setting one or both fields of
_new_value.it_interval_
to nonzero values specifies the period, in seconds and nanoseconds,
for repeated timer expirations after the initial expiration.
If both fields of
_new_value.it_interval_
are zero, the timer expires just once, at the time specified by
_new_value.it_value_.

By default,
the initial expiration time specified in
_new_value_
is interpreted relative to the current time
on the timer's clock at the time of the call (i.e.,
_new_value.it_value_
specifies a time relative to the current value of the clock specified by
_clockid_).
An absolute timeout can be selected via the
_flags_
argument.

The
_flags_
argument is a bit mask that can include the following values:

* **TFD_TIMER_ABSTIME**  
  Interpret
  _new_value.it_value_
  as an absolute value on the timer's clock.
  The timer will expire when the value of the timer's
  clock reaches the value specified in
  _new_value.it_value_.
* **TFD_TIMER_CANCEL_ON_SET**  
  If this flag is specified along with
  **TFD_TIMER_ABSTIME**
  and the clock for this timer is
  **CLOCK_REALTIME**
  or
  **CLOCK_REALTIME_ALARM**,
  then mark this timer as cancelable if the real-time clock
  undergoes a discontinuous change
  (**settimeofday**(2),
  **clock_settime**(2),
  or similar).
  When such changes occur, a current or future
  **read**(2)
  from the file descriptor will fail with the error
  **ECANCELED**.

If the
_old_value_
argument is not NULL, then the
_itimerspec_
structure that it points to is used to return the setting of the timer
that was current at the time of the call;
see the description of
**timerfd_gettime**()
following.


<a name="timerfd_gettime"></a>

### timerfd_gettime()

**timerfd_gettime**()
returns, in
_curr_value_,
an
_itimerspec_
structure that contains the current setting of the timer
referred to by the file descriptor
_fd_.

The
_it_value_
field returns the amount of time
until the timer will next expire.
If both fields of this structure are zero,
then the timer is currently disarmed.
This field always contains a relative value, regardless of whether the
**TFD_TIMER_ABSTIME**
flag was specified when setting the timer.

The
_it_interval_
field returns the interval of the timer.
If both fields of this structure are zero,
then the timer is set to expire just once, at the time specified by
_curr_value.it_value_.

<a name="operating-on-a-timer-file-descriptor"></a>

### Operating on a timer file descriptor

The file descriptor returned by
**timerfd_create**()
supports the following operations:

* **read**(2)  
  If the timer has already expired one or more times since
  its settings were last modified using
  **timerfd_settime**(),
  or since the last successful
  **read**(2),
  then the buffer given to
  **read**(2)
  returns an unsigned 8-byte integer
  (_uint64_t_)
  containing the number of expirations that have occurred.
  (The returned value is in host byte order—that is,
  the native byte order for integers on the host machine.)
* If no timer expirations have occurred at the time of the
  **read**(2),
  then the call either blocks until the next timer expiration,
  or fails with the error
  **EAGAIN**
  if the file descriptor has been made nonblocking
  (via the use of the
  **fcntl**(2)
  **F_SETFL**
  operation to set the
  **O_NONBLOCK**
  flag).
* A
  **read**(2)
  fails with the error
  **EINVAL**
  if the size of the supplied buffer is less than 8 bytes.
* If the associated clock is either
  **CLOCK_REALTIME**
  or
  **CLOCK_REALTIME_ALARM**,
  the timer is absolute
  (**TFD_TIMER_ABSTIME**),
  and the flag
  **TFD_TIMER_CANCEL_ON_SET**
  was specified when calling
  **timerfd_settime**(),
  then
  **read**(2)
  fails with the error
  **ECANCELED**
  if the real-time clock undergoes a discontinuous change.
  (This allows the reading application to discover
  such discontinuous changes to the clock.)
* **poll**(2), **select**(2) (and similar)  
  The file descriptor is readable
  (the
  **select**(2)
  _readfds_
  argument; the
  **poll**(2)
  **POLLIN**
  flag)
  if one or more timer expirations have occurred.
* The file descriptor also supports the other file-descriptor
  multiplexing APIs:
  **pselect**(2),
  **ppoll**(2),
  and
  **epoll**(7).
* **ioctl**(2)  
  The following timerfd-specific command is supported:
    * **TFD_IOC_SET_TICKS** (since Linux 3.17)  
      
      Adjust the number of timer expirations that have occurred.
      The argument is a pointer to a nonzero 8-byte integer
      (_uint64_t_*)
      containing the new number of expirations.
      Once the number is set, any waiter on the timer is woken up.
      The only purpose of this command is to restore the expirations
      for the purpose of checkpoint/restore.
      This operation is available only if the kernel was configured with the
      **CONFIG_CHECKPOINT_RESTORE**
      option.
* **close**(2)  
  When the file descriptor is no longer required it should be closed.
  When all file descriptors associated with the same timer object
  have been closed,
  the timer is disarmed and its resources are freed by the kernel.
  

<a name="fork2-semantics"></a>

### fork(2) semantics

After a
**fork**(2),
the child inherits a copy of the file descriptor created by
**timerfd_create**().
The file descriptor refers to the same underlying
timer object as the corresponding file descriptor in the parent,
and
**read**(2)s
in the child will return information about
expirations of the timer.


<a name="execve2-semantics"></a>

### execve(2) semantics

A file descriptor created by
**timerfd_create**()
is preserved across
**execve**(2),
and continues to generate timer expirations if the timer was armed.

<a name="return-value"></a>

# Return Value

On success,
**timerfd_create**()
returns a new file descriptor.
On error, -1 is returned and
_errno_
is set to indicate the error.

**timerfd_settime**()
and
**timerfd_gettime**()
return 0 on success;
on error they return -1, and set
_errno_
to indicate the error.

<a name="errors"></a>

# Errors

**timerfd_create**()
can fail with the following errors:

* **EINVAL**  
  The
  _clockid_
  argument is neither
  **CLOCK_MONOTONIC**
  nor
  **CLOCK_REALTIME**;
* **EINVAL**  
  _flags_
  is invalid;
  or, in Linux 2.6.26 or earlier,
  _flags_
  is nonzero.
* **EMFILE**  
  The per-process limit on the number of open file descriptors has been reached.
* **ENFILE**  
  The system-wide limit on the total number of open files has been
  reached.
* **ENODEV**  
  Could not mount (internal) anonymous inode device.
* **ENOMEM**  
  There was insufficient kernel memory to create the timer.

**timerfd_settime**()
and
**timerfd_gettime**()
can fail with the following errors:

* **EBADF**  
  _fd_
  is not a valid file descriptor.
* **EFAULT**  
  _new_value_,
  _old_value_,
  or
  _curr_value_
  is not valid a pointer.
* **EINVAL**  
  _fd_
  is not a valid timerfd file descriptor.

**timerfd_settime**()
can also fail with the following errors:

* **EINVAL**  
  _new_value_
  is not properly initialized (one of the
  _tv_nsec_
  falls outside the range zero to 999,999,999).
* **EINVAL**  
  
  
  _flags_
  is invalid.

<a name="versions"></a>

# Versions

These system calls are available on Linux since kernel 2.6.25.
Library support is provided by glibc since version 2.8.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.

<a name="bugs"></a>

# Bugs

Currently,

**timerfd_create**()
supports fewer types of clock IDs than
**timer_create**(2).

<a name="example"></a>

# Example

The following program creates a timer and then monitors its progress.
The program accepts up to three command-line arguments.
The first argument specifies the number of seconds for
the initial expiration of the timer.
The second argument specifies the interval for the timer, in seconds.
The third argument specifies the number of times the program should
allow the timer to expire before terminating.
The second and third command-line arguments are optional.

The following shell session demonstrates the use of the program:

.in +4n
.EX
$** a.out 3 1 100**
0.000: timer started
3.000: read: 1; total=1
4.000: read: 1; total=2
**^Z **                 # type control-Z to suspend the program
[1]+  Stopped                 ./timerfd3_demo 3 1 100
$ **fg**                # Resume execution after a few seconds
a.out 3 1 100
9.660: read: 5; total=7
10.000: read: 1; total=8
11.000: read: 1; total=9
**^C **                 # type control-C to suspend the program
.EE
.in

<a name="program-source"></a>

### Program source


.EX






































#include &lt;sys/timerfd.h&gt;
#include &lt;time.h&gt;
#include &lt;unistd.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdint.h&gt;        /* Definition of uint64_t */

#define handle_error(msg) &nbsp;       do { perror(msg); exit(EXIT_FAILURE); } while (0)

static void
print_elapsed_time(void)
{
    static struct timespec start;
    struct timespec curr;
    static int first_call = 1;
    int secs, nsecs;

    if (first_call) {
        first_call = 0;
        if (clock_gettime(CLOCK_MONOTONIC, &start) == -1)
            handle_error("clock_gettime");
    }

    if (clock_gettime(CLOCK_MONOTONIC, &curr) == -1)
        handle_error("clock_gettime");

    secs = curr.tv_sec - start.tv_sec;
    nsecs = curr.tv_nsec - start.tv_nsec;
    if (nsecs &lt; 0) {
        secs--;
        nsecs += 1000000000;
    }
    printf("%d.%03d: ", secs, (nsecs + 500000) / 1000000);
}

int
main(int argc, char *argv[])
{
    struct itimerspec new_value;
    int max_exp, fd;
    struct timespec now;
    uint64_t exp, tot_exp;
    ssize_t s;

    if ((argc != 2) && (argc != 4)) {
        fprintf(stderr, "%s init-secs [interval-secs max-exp]\\n",
                argv[0]);
        exit(EXIT_FAILURE);
    }

    if (clock_gettime(CLOCK_REALTIME, &now) == -1)
        handle_error("clock_gettime");

    /* Create a CLOCK_REALTIME absolute timer with initial
       expiration and interval as specified in command line */

    new_value.it_value.tv_sec = now.tv_sec + atoi(argv[1]);
    new_value.it_value.tv_nsec = now.tv_nsec;
    if (argc == 2) {
        new_value.it_interval.tv_sec = 0;
        max_exp = 1;
    } else {
        new_value.it_interval.tv_sec = atoi(argv[2]);
        max_exp = atoi(argv[3]);
    }
    new_value.it_interval.tv_nsec = 0;

    fd = timerfd_create(CLOCK_REALTIME, 0);
    if (fd == -1)
        handle_error("timerfd_create");

    if (timerfd_settime(fd, TFD_TIMER_ABSTIME, &new_value, NULL) == -1)
        handle_error("timerfd_settime");

    print_elapsed_time();
    printf("timer started\\n");

    for (tot_exp = 0; tot_exp &lt; max_exp;) {
        s = read(fd, &exp, sizeof(uint64_t));
        if (s != sizeof(uint64_t))
            handle_error("read");

        tot_exp += exp;
        print_elapsed_time();
        printf("read: %llu; total=%llu\\n",
                (unsigned long long) exp,
                (unsigned long long) tot_exp);
    }

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**eventfd**(2),
**poll**(2),
**read**(2),
**select**(2),
**setitimer**(2),
**signalfd**(2),
**timer_create**(2),
**timer_gettime**(2),
**timer_settime**(2),
**epoll**(7),
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
