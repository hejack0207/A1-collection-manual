# perf\-kvm(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-kvm - Tool to trace/measure kvm guest os

<a name="synopsis"></a>

# Synopsis

```


```
    perf kvm [--host] [--guest] [--guestmount=<path>
            [--guestkallsyms=<path> --guestmodules=<path> | --guestvmlinux=<path>]]
            {top|record|report|diff|buildid-list} [<options>]
    perf kvm [--host] [--guest] [--guestkallsyms=<path> --guestmodules=<path>
            | --guestvmlinux=<path>] {top|record|report|diff|buildid-list|stat} [<options>]
    perf kvm stat [record|report|live] [<options>]

<a name="description"></a>

# Description


There are a couple of variants of perf kvm:

.if n \{.RS 4
.\}
    perf kvm [options] top <command>*(Aq to generates and displays
    a performance counter profile of guest os in realtime
    of an arbitrary workload.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm record <command>*(Aq to record the performance counter profile
    of an arbitrary workload and save it into a perf data file. We set the
    default behavior of perf kvm as --guest, so if neither --host nor --guest
    is input, the perf data file name is perf.data.guest. If --host is input,
    the perf data file name is perf.data.kvm. If you want to record data into
    perf.data.host, please input --host --no-guest. The behaviors are shown as
    following:
      Default(*(Aq)         ->  perf.data.guest
      --host              ->  perf.data.kvm
      --guest             ->  perf.data.guest
      --host --guest      ->  perf.data.kvm
      --host --no-guest   ->  perf.data.host
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm report*(Aq to display the performance counter profile information
    recorded via perf kvm record.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm diff*(Aq to displays the performance difference amongst two perf.data
    files captured via perf record.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm buildid-list*(Aq to  display the buildids found in a perf data file,
    so that other tools can be used to fetch packages with matching symbol tables
    for use by perf report. As buildid is read from /sys/kernel/notes in os, then
    if you want to list the buildid for guest, please make sure your perf data file
    was captured with --guestmount in perf kvm record.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm stat <command>*(Aq to run a command and gather performance counter
    statistics.
    Especially, perf kvm stat record/report*(Aq generates a statistical analysis
    of KVM events. Currently, vmexit, mmio (x86 only) and ioport (x86 only)
    events are supported. perf kvm stat record <command>*(Aq records kvm events
    and the events between start and end <command>.
    And this command produces a file which contains tracing results of kvm
    events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm stat report*(Aq reports statistical data which includes events
    handled time, samples, and so on.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kvm stat live*(Aq reports statistical data in a live mode (similar to
    record + report but with statistical data updated live at a given display
    rate).
.if n \{.RE
.\}

<a name="options"></a>

# Options


-i, --input=&lt;path&gt;
Input file name, for the
_report_,
_diff_
and
_buildid-list_
subcommands.

-o, --output=&lt;path&gt;
Output file name, for the
_record_
subcommand. Doesn’t work with
_report_, just redirect the output to a file when using
_report_.

--host
Collect host side performance profile.

--guest
Collect guest side performance profile.

--guestmount=&lt;path&gt;
Guest os root file system mount directory. Users mounts guest os root directories under &lt;path&gt; by a specific filesystem access method, typically, sshfs. For example, start 2 guest os. The one’s pid is 8888 and the other’s is 9999. #mkdir
/guestmount; cd/guestmount #sshfs -o allow_other,direct_io -p 5551 localhost:/ 8888/ #sshfs -o allow_other,direct_io -p 5552 localhost:/ 9999/ #perf kvm --host --guest --guestmount=~/guestmount top

--guestkallsyms=&lt;path&gt;
Guest os /proc/kallsyms file copy.
_perf_
kvm reads it to get guest kernel symbols. Users copy it out from guest os.

--guestmodules=&lt;path&gt;
Guest os /proc/modules file copy.
_perf_
kvm reads it to get guest kernel module information. Users copy it out from guest os.

--guestvmlinux=&lt;path&gt;
Guest os kernel vmlinux.

-v, --verbose
Be more verbose (show counter open errors, etc).

<a name="stat-report-options"></a>

# Stat Report Options


--vcpu=&lt;value&gt;
analyze events which occur on this vcpu. (default: all vcpus)

--event=&lt;value&gt;
event to be analyzed. Possible values: vmexit, mmio (x86 only), ioport (x86 only). (default: vmexit)

-k, --key=&lt;value&gt;
Sorting key. Possible values: sample (default, sort by samples number), time (sort by average time).

-p, --pid=
Analyze events only for given process ID(s) (comma separated list).

<a name="stat-live-options"></a>

# Stat Live Options


-d, --display
Time in seconds between display updates

-m, --mmap-pages=
Number of mmap data pages (must be a power of two) or size specification with appended unit character - B/K/M/G. The size is rounded up to have nearest pages power of two value.

-a, --all-cpus
System-wide collection from all CPUs.

-p, --pid=
Analyze events only for given process ID(s) (comma separated list).

--vcpu=&lt;value&gt;
analyze events which occur on this vcpu. (default: all vcpus)

--event=&lt;value&gt;
event to be analyzed. Possible values: vmexit, mmio (x86 only), ioport (x86 only). (default: vmexit)

-k, --key=&lt;value&gt;
Sorting key. Possible values: sample (default, sort by samples number), time (sort by average time).

--duration=&lt;value&gt;
Show events other than HLT (x86 only) or Wait state (s390 only) that take longer than duration usecs.

--proc-map-timeout
When processing pre-existing threads /proc/XXX/mmap, it may take a long time, because the file may be huge. A time out is needed in such cases. This option sets the time out limit. The default value is 500 ms.

<a name="see-also"></a>

# See Also


**perf-top**(1), **perf-record**(1), **perf-report**(1), **perf-diff**(1), **perf-buildid-list**(1), **perf-stat**(1)
