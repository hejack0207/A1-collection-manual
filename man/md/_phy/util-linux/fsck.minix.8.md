# fsck.minix(8) - check consistency of Minix filesystem

util-linux, June 2015

```
fsck.minix [options] device
```

<a name="description"></a>

# Description

**fsck.minix**
performs a consistency check for the Linux MINIX filesystem.

The program assumes the filesystem is quiescent.
**fsck.minix**
should not be used on a mounted device unless you can be sure nobody is
writing to it.  Remember that the kernel can write to device when it
searches for files.

The _device_ name will usually have the following form:
.TS
tab(:);
l l.
/dev/hda[1–63]:IDE disk 1
/dev/hdb[1–63]:IDE disk 2
/dev/sda[1–15]:SCSI disk 1
/dev/sdb[1–15]:SCSI disk 2
.TE

If the filesystem was changed, i.e., repaired, then
**fsck.minix**
will print "FILE SYSTEM HAS CHANGED" and will
**sync**(2)
three times before exiting.  There is
_no_
need to reboot after check.

<a name="warning"></a>

# Warning

**fsck.minix**
should
**not**
be used on a mounted filesystem.  Using
**fsck.minix**
on a mounted filesystem is very dangerous, due to the possibility that
deleted files are still in use, and can seriously damage a perfectly good
filesystem!  If you absolutely have to run
**fsck.minix**
on a mounted filesystem, such as the root filesystem, make sure nothing
is writing to the disk, and that no files are "zombies" waiting for
deletion.

<a name="options"></a>

# Options


* **-l**, **--list**  
  List all filenames.
* **-r**, **--repair**  
  Perform interactive repairs.
* **-a**, **--auto**  
  Perform automatic repairs.  This option implies
  **--repair**
  and serves to answer all of the questions asked with the default.  Note
  that this can be extremely dangerous in the case of extensive filesystem
  damage.
* **-v**, **--verbose**  
  Be verbose.
* **-s**, **--super**  
  Output super-block information.
* **-m**, **--uncleared**  
  Activate MINIX-like "mode not cleared" warnings.
* **-f**, **--force**  
  Force a filesystem check even if the filesystem was marked as valid.
  Marking is done by the kernel when the filesystem is unmounted.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="diagnostics"></a>

# Diagnostics

There are numerous diagnostic messages.  The ones mentioned here are the
most commonly seen in normal usage.

If the device does not exist,
**fsck.minix**
will print "unable to read super block".  If the device exists, but is not
a MINIX filesystem,
**fsck.minix**
will print "bad magic number in super-block".

<a name="exit-codes"></a>

# Exit Codes

The exit code returned by
**fsck.minix**
is the sum of the following:


* **0**
  No errors
* **3**
  Filesystem errors corrected, system should be rebooted if filesystem was
  mounted
* **4**
  Filesystem errors left uncorrected
* **7**
  Combination of exit codes 3 and 4
* **8**
  Operational error
* **16**
  Usage or syntax error


<a name="authors"></a>

# Authors

.MT torvalds@​cs.​helsinki.​fi
Linus Torvalds
.ME  
Error code values by
.MT faith@​cs.​unc.​edu
Rik Faith
.ME  
Added support for filesystem valid flag:
.MT greg%​wind.​uucp@​plains.​nodak.​edu
Dr. Wettstein
.ME .  
Check to prevent fsck of mounted filesystem added by
.MT quinlan@​yggdrasil.​com
Daniel Quinlan
.ME .  
Minix v2 fs support by
.MT schwab@​issan.​informatik.​uni-dortmund.​de
Andreas Schwab
.ME ,
updated by
.MT janl@​math.​uio.​no
Nicolai Langfeldt
.ME .  
Portability patch by
.MT rmk@​ecs.​soton.​ac.​uk
Russell King
.ME .

<a name="see-also"></a>

# See Also

**fsck**(8),
**fsck.ext2**(8),
**mkfs**(8),
**mkfs.ext2**(8),
**mkfs.minix**(8),
**reboot**(8)

<a name="availability"></a>

# Availability

The fsck.minix command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
