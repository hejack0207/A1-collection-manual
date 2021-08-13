# btrfs\-scrub(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-scrub - scrub btrfs filesystem, verify block checksums

<a name="synopsis"></a>

# Synopsis

```

 btrfs scrub <subcommand> <args>
```

<a name="description"></a>

# Description


**btrfs scrub** is used to scrub a btrfs filesystem, which will read all data and metadata blocks from all devices and verify checksums. Automatically repair corrupted blocks if there’s a correct copy available.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

Scrub is not a filesystem checker (fsck) and does not verify nor repair structural damage in the filesystem. It really only checks checksums of data and tree blocks, it doesn’t ensure the content of tree blocks is valid and consistent. There’s some validation performed when metadata blocks are read from disk but it’s not extensive and cannot substitute full _btrfs check_ run.


The user is supposed to run it manually or via a periodic system service. The recommended period is a month but could be less. The estimated device bandwidth utilization is about 80% on an idle filesystem. The IO priority class is by default _idle_ so background scrub should not significantly interfere with normal filesystem operation. The IO scheduler set for the device(s) might not support the priority classes though.

The scrubbing status is recorded in _/var/lib/btrfs/_ in textual files named _scrub.status.UUID_ for a filesystem identified by the given UUID. (Progress state is communicated through a named pipe in file _scrub.progress.UUID_ in the same directory.) The status file is updated every 5 seconds. A resumed scrub will continue from the last saved position.

<a name="subcommand"></a>

# Subcommand


**cancel** _&lt;path&gt;_|_&lt;device&gt;_
If a scrub is running on the filesystem identified by
_path_
or
_device_, cancel it.

If a
_device_
is specified, the corresponding filesystem is found and
**btrfs scrub cancel**
behaves as if it was called on that filesystem. The progress is saved in the status file so
**btrfs scrub resume**
can continue from the last position.

**resume** [-BdqrR] [-c _&lt;ioprio\_class&gt;_ -n _&lt;ioprio\_classdata&gt;_] _&lt;path&gt;_|_&lt;device&gt;_
Resume a cancelled or interrupted scrub on the filesystem identified by
_path_
or on a given
_device_. The starting point is read from the status file if it exists.

This does not start a new scrub if the last scrub finished successfully.

**Options**

see
**scrub start**.

**start** [-BdqrRf] [-c _&lt;ioprio\_class&gt;_ -n _&lt;ioprio\_classdata&gt;_] _&lt;path&gt;_|_&lt;device&gt;_
Start a scrub on all devices of the filesystem identified by
_path_
or on a single
_device_. If a scrub is already running, the new one will not start.

Without options, scrub is started as a background process. The automatic repairs of damaged copies is performed by default for block group profiles with redundancy.

The default IO priority of scrub is the idle class. The priority can be configured similar to the
**ionice**(1) syntax using
_-c_
and
_-n_
options. Note that not all IO schedulers honor the ionice settings.

**Options**

-B
do not background and print scrub statistics when finished

-d
print separate statistics for each device of the filesystem (_-B_
only) at the end

-r
run in read-only mode, do not attempt to correct anything, can be run on a read-only filesystem

-R
raw print mode, print full data instead of summary

-c _&lt;ioprio\_class&gt;_
set IO priority class (see
**ionice**(1) manpage)

-n _&lt;ioprio\_classdata&gt;_
set IO priority classdata (see
**ionice**(1) manpage)

-f
force starting new scrub even if a scrub is already running, this can useful when scrub status file is damaged and reports a running scrub although it is not, but should not normally be necessary

-q
(deprecated) alias for global
_-q_
option

**status** [-d] _&lt;path&gt;_|_&lt;device&gt;_
Show status of a running scrub for the filesystem identified by
_path_
or for the specified
_device_.

If no scrub is running, show statistics of the last finished or cancelled scrub for that filesystem or device.

**Options**

-d
print separate statistics for each device of the filesystem

<a name="exit-status"></a>

# Exit Status


**btrfs scrub** returns a zero exit status if it succeeds. Non zero is returned in case of failure:

1
scrub couldn’t be performed

2
there is nothing to resume

3
scrub found uncorrectable errors

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **ionice**(1)
