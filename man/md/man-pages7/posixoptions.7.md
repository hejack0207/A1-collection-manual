# posixoptions(7) - optional parts of the POSIX standard

"", 2018-04-30


<a name="description"></a>

# Description

The POSIX standard (the information below is from POSIX.1-2001)
describes a set of behaviors and interfaces for a compliant system.
However, many interfaces are optional and there are feature test macros
to test the availability of interfaces at compile time, and functions
**sysconf**(3),
**fpathconf**(3),
**pathconf**(3),
**confstr**(3)
to do this at run time.
From shell scripts one can use
**getconf**(1).
For more detail, see
**sysconf**(3).

We give the name of the POSIX abbreviation, the option, the name of the
**sysconf**(3)
parameter used to inquire about the option, and possibly
a very short description.
Much more precise detail can be found in the POSIX standard itself,
versions of which can nowadays be accessed freely on the web.

<a name="adv-_posix_advisory_info-_sc_advisory_info"></a>

### ADV - _POSIX_ADVISORY_INFO - _SC_ADVISORY_INFO

The following advisory functions are present:

    .in +4n
    posix_fadvise()
    posix_fallocate()
    posix_memalign()
    posix_madvise()
    .in

<a name="aio-_posix_asynchronous_io-_sc_asynchronous_io"></a>

### AIO - _POSIX_ASYNCHRONOUS_IO - _SC_ASYNCHRONOUS_IO

The header
_&lt;aio.h&gt;_
is present.
The following functions are present:

    .in +4n
    aio_cancel()
    aio_error()
    aio_fsync()
    aio_read()
    aio_return()
    aio_suspend()
    aio_write()
    lio_listio()
    .in

<a name="bar-_posix_barriers-_sc_barriers"></a>

### BAR - _POSIX_BARRIERS - _SC_BARRIERS

This option implies the
**_POSIX_THREADS**
and
**_POSIX_THREAD_SAFE_FUNCTIONS**
options.
The following functions are present:

    .in +4n
    pthread_barrier_destroy()
    pthread_barrier_init()
    pthread_barrier_wait()
    pthread_barrierattr_destroy()
    pthread_barrierattr_init()
    .in





<a name="-posix_chown_restricted"></a>

### --- - POSIX_CHOWN_RESTRICTED

If this option is in effect (as it always is under POSIX.1-2001),
then only root may change the owner of a file, and nonroot can
set the group of a file only to one of the groups it belongs to.
This affects the following functions

    .in +4n
    chown()
    fchown()
    .in


<a name="cs-_posix_clock_selection-_sc_clock_selection"></a>

### CS - _POSIX_CLOCK_SELECTION - _SC_CLOCK_SELECTION

This option implies the
**_POSIX_TIMERS**
option.
The following functions are present:

    .in +4n
    pthread_condattr_getclock()
    pthread_condattr_setclock()
    clock_nanosleep()
    .in

If
**CLOCK_REALTIME**
is changed by the function
_clock_settime_(),
then this affects all timers set for an absolute time.

<a name="cpt-_posix_cputime-_sc_cputime"></a>

### CPT - _POSIX_CPUTIME - _SC_CPUTIME

The
**CLOCK_PROCESS_CPUTIME_ID**
clock ID is supported.
The initial value of this clock is 0 for each process.
This option implies the
**_POSIX_TIMERS**
option.
The function
_clock_getcpuclockid_()
is present.





<a name="-_posix_file_locking-_sc_file_locking"></a>

### --- - _POSIX_FILE_LOCKING - _SC_FILE_LOCKING

This option has been deleted.
Not in final XPG6.

<a name="fsc-_posix_fsync-_sc_fsync"></a>

### FSC - _POSIX_FSYNC - _SC_FSYNC

The function
_fsync_()
is present.

<a name="ip6-_posix_ipv6-_sc_ipv6"></a>

### IP6 - _POSIX_IPV6 - _SC_IPV6

Internet Protocol Version 6 is supported.

<a name="-_posix_job_control-_sc_job_control"></a>

### --- - _POSIX_JOB_CONTROL - _SC_JOB_CONTROL

If this option is in effect (as it always is under POSIX.1-2001),
then the system implements POSIX-style job control,
and the following functions are present:

    .in +4n
    setpgid()
    tcdrain()
    tcflush()
    tcgetpgrp()
    tcsendbreak()
    tcsetattr()
    tcsetpgrp()
    .in

<a name="mf-_posix_mapped_files-_sc_mapped_files"></a>

### MF - _POSIX_MAPPED_FILES - _SC_MAPPED_FILES

Shared memory is supported.
The include file
_&lt;sys/mman.h&gt;_
is present.
The following functions are present:

    .in +4n
    mmap()
    msync()
    munmap()
    .in

<a name="ml-_posix_memlock-_sc_memlock"></a>

### ML - _POSIX_MEMLOCK - _SC_MEMLOCK

Shared memory can be locked into core.
The following functions are present:

    .in +4n
    mlockall()
    munlockall()
    .in

<a name="mrmlr-_posix_memlock_range-_sc_memlock_range"></a>

### MR/MLR - _POSIX_MEMLOCK_RANGE - _SC_MEMLOCK_RANGE

More precisely, ranges can be locked into core.
The following functions are present:

    .in +4n
    mlock()
    munlock()
    .in

<a name="mpr-_posix_memory_protection-_sc_memory_protection"></a>

### MPR - _POSIX_MEMORY_PROTECTION - _SC_MEMORY_PROTECTION

The function
_mprotect_()
is present.

<a name="msg-_posix_message_passing-_sc_message_passing"></a>

### MSG - _POSIX_MESSAGE_PASSING - _SC_MESSAGE_PASSING

The include file
_&lt;mqueue.h&gt;_
is present.
The following functions are present:

    .in +4n
    mq_close()
    mq_getattr()
    mq_notify()
    mq_open()
    mq_receive()
    mq_send()
    mq_setattr()
    mq_unlink()
    .in

<a name="mon-_posix_monotonic_clock-_sc_monotonic_clock"></a>

### MON - _POSIX_MONOTONIC_CLOCK - _SC_MONOTONIC_CLOCK

**CLOCK_MONOTONIC**
is supported.
This option implies the
**_POSIX_TIMERS**
option.
The following functions are affected:

    .in +4n
    aio_suspend()
    clock_getres()
    clock_gettime()
    clock_settime()
    timer_create()
    .in

<a name="-_posix_multi_process-_sc_multi_process"></a>

### --- - _POSIX_MULTI_PROCESS - _SC_MULTI_PROCESS

This option has been deleted.
Not in final XPG6.



<a name="-_posix_no_trunc"></a>

### --- - _POSIX_NO_TRUNC

If this option is in effect (as it always is under POSIX.1-2001),
then pathname components longer than
**NAME_MAX**
are not truncated,
but give an error.
This property may be dependent on the path prefix of the component.

<a name="pio-_posix_prioritized_io-_sc_prioritized_io"></a>

### PIO - _POSIX_PRIORITIZED_IO - _SC_PRIORITIZED_IO

This option says that one can specify priorities for asynchronous I/O.
This affects the functions

    .in +4n
    aio_read()
    aio_write()
    .in

<a name="ps-_posix_priority_scheduling-_sc_priority_scheduling"></a>

### PS - _POSIX_PRIORITY_SCHEDULING - _SC_PRIORITY_SCHEDULING

The include file
_&lt;sched.h&gt;_
is present.
The following functions are present:

    .in +4n
    sched_get_priority_max()
    sched_get_priority_min()
    sched_getparam()
    sched_getscheduler()
    sched_rr_get_interval()
    sched_setparam()
    sched_setscheduler()
    sched_yield()
    .in

If also
**_POSIX_SPAWN**
is in effect, then the following functions are present:

    .in +4n
    posix_spawnattr_getschedparam()
    posix_spawnattr_getschedpolicy()
    posix_spawnattr_setschedparam()
    posix_spawnattr_setschedpolicy()
    .in

<a name="rs-_posix_raw_sockets"></a>

### RS - _POSIX_RAW_SOCKETS

Raw sockets are supported.
The following functions are affected:

    .in +4n
    getsockopt()
    setsockopt()
    .in

<a name="-_posix_reader_writer_locks-_sc_reader_writer_locks"></a>

### --- - _POSIX_READER_WRITER_LOCKS - _SC_READER_WRITER_LOCKS

This option implies the
**_POSIX_THREADS**
option.
Conversely,
under POSIX.1-2001 the
**_POSIX_THREADS**
option implies this option.

The following functions are present:

.in +4n
    pthread_rwlock_destroy()
    pthread_rwlock_init()
    pthread_rwlock_rdlock()
    pthread_rwlock_tryrdlock()
    pthread_rwlock_trywrlock()
    pthread_rwlock_unlock()
    pthread_rwlock_wrlock()
    pthread_rwlockattr_destroy()
    pthread_rwlockattr_init()
    .in

<a name="rts-_posix_realtime_signals-_sc_realtime_signals"></a>

### RTS - _POSIX_REALTIME_SIGNALS - _SC_REALTIME_SIGNALS

Realtime signals are supported.
The following functions are present:

    .in +4n
    sigqueue()
    sigtimedwait()
    sigwaitinfo()
    .in

<a name="-_posix_regexp-_sc_regexp"></a>

### --- - _POSIX_REGEXP - _SC_REGEXP

If this option is in effect (as it always is under POSIX.1-2001),
then POSIX regular expressions are supported
and the following functions are present:

    .in +4n
    regcomp()
    regerror()
    regexec()
    regfree()
    .in

<a name="-_posix_saved_ids-_sc_saved_ids"></a>

### --- - _POSIX_SAVED_IDS - _SC_SAVED_IDS

If this option is in effect (as it always is under POSIX.1-2001),
then a process has a saved set-user-ID and a saved set-group-ID.
The following functions are affected:

    .in +4n
    exec()
    kill()
    seteuid()
    setegid()
    setgid()
    setuid()
    .in



<a name="sem-_posix_semaphores-_sc_semaphores"></a>

### SEM - _POSIX_SEMAPHORES - _SC_SEMAPHORES

The include file
_&lt;semaphore.h&gt;_
is present.
The following functions are present:

    .in +4n
    sem_close()
    sem_destroy()
    sem_getvalue()
    sem_init()
    sem_open()
    sem_post()
    sem_trywait()
    sem_unlink()
    sem_wait()
    .in

<a name="shm-_posix_shared_memory_objects-_sc_shared_memory_objects"></a>

### SHM - _POSIX_SHARED_MEMORY_OBJECTS - _SC_SHARED_MEMORY_OBJECTS

The following functions are present:

    .in +4n
    mmap()
    munmap()
    shm_open()
    shm_unlink()
    .in

<a name="-_posix_shell-_sc_shell"></a>

### --- - _POSIX_SHELL - _SC_SHELL

If this option is in effect (as it always is under POSIX.1-2001),
the function
_system_()
is present.

<a name="spn-_posix_spawn-_sc_spawn"></a>

### SPN - _POSIX_SPAWN - _SC_SPAWN

This option describes support for process creation in a context where
it is difficult or impossible to use
_fork_(),
for example, because no MMU is present.

If
**_POSIX_SPAWN**
is in effect, then the include file
_&lt;spawn.h&gt;_
and the following functions are present:

    .in +4n
    posix_spawn()
    posix_spawn_file_actions_addclose()
    posix_spawn_file_actions_adddup2()
    posix_spawn_file_actions_addopen()
    posix_spawn_file_actions_destroy()
    posix_spawn_file_actions_init()
    posix_spawnattr_destroy()
    posix_spawnattr_getsigdefault()
    posix_spawnattr_getflags()
    posix_spawnattr_getpgroup()
    posix_spawnattr_getsigmask()
    posix_spawnattr_init()
    posix_spawnattr_setsigdefault()
    posix_spawnattr_setflags()
    posix_spawnattr_setpgroup()
    posix_spawnattr_setsigmask()
    posix_spawnp()
    .in

If also
**_POSIX_PRIORITY_SCHEDULING**
is in effect, then
the following functions are present:

    .in +4n
    posix_spawnattr_getschedparam()
    posix_spawnattr_getschedpolicy()
    posix_spawnattr_setschedparam()
    posix_spawnattr_setschedpolicy()
    .in

<a name="spi-_posix_spin_locks-_sc_spin_locks"></a>

### SPI - _POSIX_SPIN_LOCKS - _SC_SPIN_LOCKS

This option implies the
**_POSIX_THREADS**
and
**_POSIX_THREAD_SAFE_FUNCTIONS**
options.
The following functions are present:

    .in +4n
    pthread_spin_destroy()
    pthread_spin_init()
    pthread_spin_lock()
    pthread_spin_trylock()
    pthread_spin_unlock()
    .in -4n

<a name="ss-_posix_sporadic_server-_sc_sporadic_server"></a>

### SS - _POSIX_SPORADIC_SERVER - _SC_SPORADIC_SERVER

The scheduling policy
**SCHED_SPORADIC**
is supported.
This option implies the
**_POSIX_PRIORITY_SCHEDULING**
option.
The following functions are affected:

    .in +4n
    sched_setparam()
    sched_setscheduler()
    .in

<a name="sio-_posix_synchronized_io-_sc_synchronized_io"></a>

### SIO - _POSIX_SYNCHRONIZED_IO - _SC_SYNCHRONIZED_IO

The following functions are affected:

    .in +4n
    open()
    msync()
    fsync()
    fdatasync()
    .in

<a name="tsa-_posix_thread_attr_stackaddr-_sc_thread_attr_stackaddr"></a>

### TSA - _POSIX_THREAD_ATTR_STACKADDR - _SC_THREAD_ATTR_STACKADDR

The following functions are affected:

    .in +4n
    pthread_attr_getstack()
    pthread_attr_getstackaddr()
    pthread_attr_setstack()
    pthread_attr_setstackaddr()
    .in

<a name="tss-_posix_thread_attr_stacksize-_sc_thread_attr_stacksize"></a>

### TSS - _POSIX_THREAD_ATTR_STACKSIZE - _SC_THREAD_ATTR_STACKSIZE

The following functions are affected:

    .in +4n
    pthread_attr_getstack()
    pthread_attr_getstacksize()
    pthread_attr_setstack()
    pthread_attr_setstacksize()
    .in

<a name="tct-_posix_thread_cputime-_sc_thread_cputime"></a>

### TCT - _POSIX_THREAD_CPUTIME - _SC_THREAD_CPUTIME

The clockID CLOCK_THREAD_CPUTIME_ID is supported.
This option implies the
**_POSIX_TIMERS**
option.
The following functions are affected:

    .in +4n
    pthread_getcpuclockid()
    clock_getres()
    clock_gettime()
    clock_settime()
    timer_create()
    .in

<a name="tpi-_posix_thread_prio_inherit-_sc_thread_prio_inherit"></a>

### TPI - _POSIX_THREAD_PRIO_INHERIT - _SC_THREAD_PRIO_INHERIT

The following functions are affected:

    .in +4n
    pthread_mutexattr_getprotocol()
    pthread_mutexattr_setprotocol()
    .in

<a name="tpp-_posix_thread_prio_protect-_sc_thread_prio_protect"></a>

### TPP - _POSIX_THREAD_PRIO_PROTECT - _SC_THREAD_PRIO_PROTECT

The following functions are affected:

    .in +4n
    pthread_mutex_getprioceiling()
    pthread_mutex_setprioceiling()
    pthread_mutexattr_getprioceiling()
    pthread_mutexattr_getprotocol()
    pthread_mutexattr_setprioceiling()
    pthread_mutexattr_setprotocol()
    .in

<a name="tps-_posix_thread_priority_scheduling-_sc_thread_priority_scheduling"></a>

### TPS - _POSIX_THREAD_PRIORITY_SCHEDULING - _SC_THREAD_PRIORITY_SCHEDULING

If this option is in effect, the different threads inside a process
can run with different priorities and/or different schedulers.
The following functions are affected:

    .in +4n
    pthread_attr_getinheritsched()
    pthread_attr_getschedpolicy()
    pthread_attr_getscope()
    pthread_attr_setinheritsched()
    pthread_attr_setschedpolicy()
    pthread_attr_setscope()
    pthread_getschedparam()
    pthread_setschedparam()
    pthread_setschedprio()
    .in

<a name="tsh-_posix_thread_process_shared-_sc_thread_process_shared"></a>

### TSH - _POSIX_THREAD_PROCESS_SHARED - _SC_THREAD_PROCESS_SHARED

The following functions are affected:

    .in +4n
    pthread_barrierattr_getpshared()
    pthread_barrierattr_setpshared()
    pthread_condattr_getpshared()
    pthread_condattr_setpshared()
    pthread_mutexattr_getpshared()
    pthread_mutexattr_setpshared()
    pthread_rwlockattr_getpshared()
    pthread_rwlockattr_setpshared()
    .in

<a name="tsf-_posix_thread_safe_functions-_sc_thread_safe_functions"></a>

### TSF - _POSIX_THREAD_SAFE_FUNCTIONS - _SC_THREAD_SAFE_FUNCTIONS

The following functions are affected:

    .in +4n
    readdir_r()
    getgrgid_r()
    getgrnam_r()
    getpwnam_r()
    getpwuid_r()
    flockfile()
    ftrylockfile()
    funlockfile()
    getc_unlocked()
    getchar_unlocked()
    putc_unlocked()
    putchar_unlocked()
    rand_r()
    strerror_r()
    strtok_r()
    asctime_r()
    ctime_r()
    gmtime_r()
    localtime_r()
    .in

<a name="tsp-_posix_thread_sporadic_server-_sc_thread_sporadic_server"></a>

### TSP - _POSIX_THREAD_SPORADIC_SERVER - _SC_THREAD_SPORADIC_SERVER

This option implies the
**_POSIX_THREAD_PRIORITY_SCHEDULING**
option.
The following functions are affected:

    .in +4n
    sched_getparam()
    sched_setparam()
    sched_setscheduler()
    .in

<a name="thr-_posix_threads-_sc_threads"></a>

### THR - _POSIX_THREADS - _SC_THREADS

Basic support for POSIX threads is available.
The following functions are present:

    .in +4n
    pthread_atfork()
    pthread_attr_destroy()
    pthread_attr_getdetachstate()
    pthread_attr_getschedparam()
    pthread_attr_init()
    pthread_attr_setdetachstate()
    pthread_attr_setschedparam()
    pthread_cancel()
    pthread_cleanup_push()
    pthread_cleanup_pop()
    pthread_cond_broadcast()
    pthread_cond_destroy()
    pthread_cond_init()
    pthread_cond_signal()
    pthread_cond_timedwait()
    pthread_cond_wait()
    pthread_condattr_destroy()
    pthread_condattr_init()
    pthread_create()
    pthread_detach()
    pthread_equal()
    pthread_exit()
    pthread_getspecific()
    pthread_join()
    pthread_key_create()
    pthread_key_delete()
    pthread_mutex_destroy()
    pthread_mutex_init()
    pthread_mutex_lock()
    pthread_mutex_trylock()
    pthread_mutex_unlock()
    pthread_mutexattr_destroy()
    pthread_mutexattr_init()
    pthread_once()
    pthread_rwlock_destroy()
    pthread_rwlock_init()
    pthread_rwlock_rdlock()
    pthread_rwlock_tryrdlock()
    pthread_rwlock_trywrlock()
    pthread_rwlock_unlock()
    pthread_rwlock_wrlock()
    pthread_rwlockattr_destroy()
    pthread_rwlockattr_init()
    pthread_self()
    pthread_setcancelstate()
    pthread_setcanceltype()
    pthread_setspecific()
    pthread_testcancel()
    .in

<a name="tmo-_posix_timeouts-_sc_timeouts"></a>

### TMO - _POSIX_TIMEOUTS - _SC_TIMEOUTS

The following functions are present:

    .in +4n
    mq_timedreceive()
    mq_timedsend()
    pthread_mutex_timedlock()
    pthread_rwlock_timedrdlock()
    pthread_rwlock_timedwrlock()
    sem_timedwait()
    posix_trace_timedgetnext_event()
    .in

<a name="tmr-_posix_timers-_sc_timers"></a>

### TMR - _POSIX_TIMERS - _SC_TIMERS

The following functions are present:

    .in +4n
    clock_getres()
    clock_gettime()
    clock_settime()
    nanosleep()
    timer_create()
    timer_delete()
    timer_gettime()
    timer_getoverrun()
    timer_settime()
    .in

<a name="trc-_posix_trace-_sc_trace"></a>

### TRC - _POSIX_TRACE - _SC_TRACE

POSIX tracing is available.
The following functions are present:

    .in +4n
    posix_trace_attr_destroy()
    posix_trace_attr_getclockres()
    posix_trace_attr_getcreatetime()
    posix_trace_attr_getgenversion()
    posix_trace_attr_getmaxdatasize()
    posix_trace_attr_getmaxsystemeventsize()
    posix_trace_attr_getmaxusereventsize()
    posix_trace_attr_getname()
    posix_trace_attr_getstreamfullpolicy()
    posix_trace_attr_getstreamsize()
    posix_trace_attr_init()
    posix_trace_attr_setmaxdatasize()
    posix_trace_attr_setname()
    posix_trace_attr_setstreamsize()
    posix_trace_attr_setstreamfullpolicy()
    posix_trace_clear()
    posix_trace_create()
    posix_trace_event()
    posix_trace_eventid_equal()
    posix_trace_eventid_get_name()
    posix_trace_eventid_open()
    posix_trace_eventtypelist_getnext_id()
    posix_trace_eventtypelist_rewind()
    posix_trace_flush()
    posix_trace_get_attr()
    posix_trace_get_status()
    posix_trace_getnext_event()
    posix_trace_shutdown()
    posix_trace_start()
    posix_trace_stop()
    posix_trace_trygetnext_event()
    .in

<a name="tef-_posix_trace_event_filter-_sc_trace_event_filter"></a>

### TEF - _POSIX_TRACE_EVENT_FILTER - _SC_TRACE_EVENT_FILTER

This option implies the
**_POSIX_TRACE**
option.
The following functions are present:

    .in +4n
    posix_trace_eventset_add()
    posix_trace_eventset_del()
    posix_trace_eventset_empty()
    posix_trace_eventset_fill()
    posix_trace_eventset_ismember()
    posix_trace_get_filter()
    posix_trace_set_filter()
    posix_trace_trid_eventid_open()
    .in

<a name="tri-_posix_trace_inherit-_sc_trace_inherit"></a>

### TRI - _POSIX_TRACE_INHERIT - _SC_TRACE_INHERIT

Tracing children of the traced process is supported.
This option implies the
**_POSIX_TRACE**
option.
The following functions are present:

    .in +4n
    posix_trace_attr_getinherited()
    posix_trace_attr_setinherited()
    .in

<a name="trl-_posix_trace_log-_sc_trace_log"></a>

### TRL - _POSIX_TRACE_LOG - _SC_TRACE_LOG

This option implies the
**_POSIX_TRACE**
option.
The following functions are present:

    .in +4n
    posix_trace_attr_getlogfullpolicy()
    posix_trace_attr_getlogsize()
    posix_trace_attr_setlogfullpolicy()
    posix_trace_attr_setlogsize()
    posix_trace_close()
    posix_trace_create_withlog()
    posix_trace_open()
    posix_trace_rewind()
    .in

<a name="tym-_posix_typed_memory_objects-_sc_typed_memory_object"></a>

### TYM - _POSIX_TYPED_MEMORY_OBJECTS - _SC_TYPED_MEMORY_OBJECT

The following functions are present:

    .in +4n
    posix_mem_offset()
    posix_typed_mem_get_info()
    posix_typed_mem_open()
    .in

<a name="-_posix_vdisable"></a>

### --- - _POSIX_VDISABLE

Always present (probably 0).
Value to set a changeable special control
character to indicate that it is disabled.

<a name="xopen-system-interface-extensions"></a>

# X/Open System Interface Extensions


<a name="xsi-_xopen_crypt-_sc_xopen_crypt"></a>

### XSI - _XOPEN_CRYPT - _SC_XOPEN_CRYPT

The following functions are present:

    .in +4n
    crypt()
    encrypt()
    setkey()
    .SS XSI - _XOPEN_REALTIME - _SC_XOPEN_REALTIME
    This option implies the following options:
    
    .PD 0
    .TP
    _POSIX_ASYNCHRONOUS_IO==200112L
    .TP
    _POSIX_FSYNC
    .TP
    _POSIX_MAPPED_FILES
    .TP
    _POSIX_MEMLOCK==200112L
    .TP
    _POSIX_MEMLOCK_RANGE==200112L
    .TP
    _POSIX_MEMORY_PROTECTION
    .TP
    _POSIX_MESSAGE_PASSING==200112L
    .TP
    _POSIX_PRIORITIZED_IO
    .TP
    _POSIX_PRIORITY_SCHEDULING==200112L
    .TP
    _POSIX_REALTIME_SIGNALS==200112L
    .TP
    _POSIX_SEMAPHORES==200112L
    .TP
    _POSIX_SHARED_MEMORY_OBJECTS==200112L
    .TP
    _POSIX_SYNCHRONIZED_IO==200112L
    .TP
    _POSIX_TIMERS==200112L
    .PD
    
    .SS ADV - --- - ---
    The Advanced Realtime option group implies that the following options
    are all defined to 200112L:
    
    .PD 0
    .TP
    _POSIX_ADVISORY_INFO
    .TP
    _POSIX_CLOCK_SELECTION
    (implies
    _POSIX_TIMERS)
    .TP
    _POSIX_CPUTIME
    (implies
    _POSIX_TIMERS)
    .TP
    _POSIX_MONOTONIC_CLOCK
    (implies
    _POSIX_TIMERS)
    .TP
    _POSIX_SPAWN
    .TP
    _POSIX_SPORADIC_SERVER
    (implies
    _POSIX_PRIORITY_SCHEDULING)
    .TP
    _POSIX_TIMEOUTS
    .TP
    _POSIX_TYPED_MEMORY_OBJECTS
    .PD
    
    .SS XSI - _XOPEN_REALTIME_THREADS - _SC_XOPEN_REALTIME_THREADS
    This option implies that the following options
    are all defined to 200112L:
    
    .PD 0
    .TP
    _POSIX_THREAD_PRIO_INHERIT
    .TP
    _POSIX_THREAD_PRIO_PROTECT
    .TP
    _POSIX_THREAD_PRIORITY_SCHEDULING
    .PD
    .SS ADVANCED REALTIME THREADS - --- - ---
    This option implies that the following options
    are all defined to 200112L:
    
    .PD 0
    .TP
    _POSIX_BARRIERS
    (implies
    _POSIX_THREADS,
    _POSIX_THREAD_SAFE_FUNCTIONS)
    .TP
    _POSIX_SPIN_LOCKS
    (implies
    _POSIX_THREADS,
    _POSIX_THREAD_SAFE_FUNCTIONS)
    .TP
    _POSIX_THREAD_CPUTIME
    (implies
    _POSIX_TIMERS)
    .TP
    _POSIX_THREAD_SPORADIC_SERVER
    (implies
    _POSIX_THREAD_PRIORITY_SCHEDULING)
    .PD
    
    .SS TRACING - --- - ---
    This option implies that the following options
    are all defined to 200112L:
    
    .PD 0
    .TP
    _POSIX_TRACE
    .TP
    _POSIX_TRACE_EVENT_FILTER
    .TP
    _POSIX_TRACE_LOG
    .TP
    _POSIX_TRACE_INHERIT
    .PD
    .SS STREAMS - _XOPEN_STREAMS - _SC_XOPEN_STREAMS
    The following functions are present:
    
    .nf
    .in +4n
    fattach()
    fdetach()
    getmsg()
    getpmsg()
    ioctl()
    isastream()
    putmsg()
    putpmsg()
    .in

<a name="xsi-_xopen_legacy-_sc_xopen_legacy"></a>

### XSI - _XOPEN_LEGACY - _SC_XOPEN_LEGACY

Functions included in the legacy option group were previously mandatory,
but are now optional in this version.
The following functions are present:

    .in +4n
    bcmp()
    bcopy()
    bzero()
    ecvt()
    fcvt()
    ftime()
    gcvt()
    getcwd()
    index()
    mktemp()
    rindex()
    utimes()
    wcswcs()
    .in

<a name="xsi-_xopen_unix-_sc_xopen_unix"></a>

### XSI - _XOPEN_UNIX - _SC_XOPEN_UNIX

The following functions are present:

    .in +4n
    mmap()
    munmap()
    msync()
    .in

This option implies the following options:


* **_POSIX_FSYNC**  
* **_POSIX_MAPPED_FILES**  
* **_POSIX_MEMORY_PROTECTION**  
* **_POSIX_THREAD_ATTR_STACKADDR**  
* **_POSIX_THREAD_ATTR_STACKSIZE**  
* **_POSIX_THREAD_PROCESS_SHARED**  
* **_POSIX_THREAD_SAFE_FUNCTIONS**  
* **_POSIX_THREADS**  

This option may imply the following options from the XSI option groups:


* Encryption (**_XOPEN_CRYPT**)  
* Realtime (**_XOPEN_REALTIME**)  
* Advanced Realtime (**ADB**)  
* Realtime Threads (**_XOPEN_REALTIME_THREADS**)  
* Advanced Realtime Threads (**ADVANCED REALTIME THREADS**)  
* Tracing (**TRACING**)  
* XSI Streams (**STREAMS**)  
* Legacy (**_XOPEN_LEGACY**)  

<a name="see-also"></a>

# See Also

**sysconf**(3),
**standards**(7)

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
