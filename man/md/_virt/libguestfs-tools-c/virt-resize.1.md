# virt-resize(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-resize - Resize a virtual machine disk

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 3  virt-resize [--resize /dev/sdaN=[+/-]<size>[%]]    [--expand /dev/sdaN] [--shrink /dev/sdaN]    [--ignore /dev/sdaN] [--delete /dev/sdaN] [...] indisk outdisk .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-resize is a tool which can resize a virtual machine disk, making
it larger or smaller overall, and resizing or deleting any partitions
contained within.

Virt-resize **cannot** resize disk images in-place.  Virt-resize
**should not** be used on live virtual machines - for consistent
results, shut the virtual machine down before resizing it.

If you are not familiar with the associated tools:
**virt-filesystems**\|(1) and **virt-df**\|(1), we recommend you go and read
those manual pages first.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

* 1.  
  This example takes \f(CW`olddisk\*(C' and resizes it into \f(CW\*(C\`newdisk\*(C',
  extending one of the guest’s partitions to fill the extra 5GB of
  space:
  .Sp
  .Vb 1
   virt-filesystems --long -h --all -a olddisk
   
   truncate -r olddisk newdisk
   truncate -s +5G newdisk
   
   # Note "/dev/sda2" is a partition inside the "olddisk" file.
   virt-resize --expand /dev/sda2 olddisk newdisk
  .Ve
* 2.  
  As above, but make the /boot partition 200MB bigger, while giving the
  remaining space to /dev/sda2:
  .Sp
  .Vb 2
   virt-resize --resize /dev/sda1=+200M --expand /dev/sda2 \e
     olddisk newdisk
  .Ve
* 3.  
  As in the first example, but expand a logical volume as the final
  step.  This is what you would typically use for Linux guests that use
  \s-1LVM:\s0
  .Sp
  .Vb 2
   virt-resize --expand /dev/sda2 --LV-expand /dev/vg_guest/lv_root \e
     olddisk newdisk
  .Ve
* 4.  
  As in the first example, but the output format will be qcow2 instead
  of a raw disk:
  .Sp
  .Vb 2
   qemu-img create -f qcow2 -o preallocation=metadata newdisk.qcow2 15G
   virt-resize --expand /dev/sda2 olddisk newdisk.qcow2
  .Ve

<a name="detailed-usage"></a>

# Detailed Usage

.IX Header "DETAILED USAGE"

<a name="s-1expanding-a-virtual-machine-disks0"></a>

### \s-1EXPANDING A VIRTUAL MACHINE DISK\s0

.IX Subsection "EXPANDING A VIRTUAL MACHINE DISK"

* 1. Shut down the virtual machine  
  .IX Item "1. Shut down the virtual machine"
* 2. Locate input disk image  
  .IX Item "2. Locate input disk image"
  Locate the input disk image (ie. the file or device on the host
  containing the guest’s disk).  If the guest is managed by libvirt, you
  can use \f(CW`virsh dumpxml\*(C' like this to find the disk image name:
  .Sp
  .Vb 4
   # virsh dumpxml guestname | xpath /domain/devices/disk/source
   Found 1 nodes:
   -- NODE --
   &lt;source dev="/dev/vg/lv_guest" /&gt;
  .Ve
* 3. Look at current sizing  
  .IX Item "3. Look at current sizing"
  Use **virt-filesystems**\|(1) to display the current partitions and
  sizes:
  .Sp
  .Vb 5
   # virt-filesystems --long --parts --blkdevs -h -a /dev/vg/lv_guest
   Name       Type       Size  Parent
   /dev/sda1  partition  101M  /dev/sda
   /dev/sda2  partition  7.9G  /dev/sda
   /dev/sda   device     8.0G  -
  .Ve
  .Sp
  (This example is a virtual machine with an 8 \s-1GB\s0 disk which we would
  like to expand up to 10 \s-1GB\s0).
* 4. Create output disk  
  .IX Item "4. Create output disk"
  Virt-resize cannot do in-place disk modifications.  You have to have
  space to store the resized output disk.
  .Sp
  To store the resized disk image in a file, create a file of a suitable
  size:
  .Sp
  .Vb 2
   # rm -f outdisk
   # truncate -s 10G outdisk
  .Ve
  .Sp
  Or use **lvcreate**\|(1) to create a logical volume:
  .Sp
  .Vb 1
   # lvcreate -L 10G -n lv_name vg_name
  .Ve
  .Sp
  Or use **virsh**\|(1) vol-create-as to create a libvirt storage volume:
  .Sp
  .Vb 2
   # virsh pool-list
   # virsh vol-create-as poolname newvol 10G
  .Ve
* 5. Resize  
  .IX Item "5. Resize"
  virt-resize takes two mandatory parameters, the input disk and the
  output disk (both can be e.g. a device, a file, or a \s-1URI\s0 to a remote
  disk).  The output disk is the one created in the previous step.
  .Sp
  .Vb 1
   # virt-resize indisk outdisk
  .Ve
  .Sp
  This command just copies disk image \f(CW`indisk\*(C' to disk image \f(CW\*(C\`outdisk\*(C'
  _without_ resizing or changing any existing partitions.  If
  \f(CW`outdisk\*(C' is larger, then an extra, empty partition is created at the
  end of the disk covering the extra space.  If \f(CW`outdisk\*(C' is smaller,
  then it will give an error.
  .Sp
  More realistically you'd want to expand existing partitions in the
  disk image by passing extra options (for the full list see the
  \s-1OPTIONS\*(R"\s0 section below).
  .Sp
  --expand\*(R" is the most useful option.  It expands the named
  partition within the disk to fill any extra space:
  .Sp
  .Vb 1
   # virt-resize --expand /dev/sda2 indisk outdisk
  .Ve
  .Sp
  (In this case, an extra partition is _not_ created at the end of the
  disk, because there will be no unused space).
  .Sp
  --resize\*(R" is the other commonly used option.  The following would
  increase the size of /dev/sda1 by 200M, and expand /dev/sda2
  to fill the rest of the available space:
  .Sp
  .Vb 2
   # virt-resize --resize /dev/sda1=+200M --expand /dev/sda2 \e
       indisk outdisk
  .Ve
  .Sp
  If the expanded partition in the image contains a filesystem or \s-1LVM
  PV,\s0 then if virt-resize knows how, it will resize the contents, the
  equivalent of calling a command such as **pvresize**\|(8),
  **resize2fs**\|(8), **ntfsresize**\|(8), **btrfs**\|(8), **xfs\_growfs**\|(8),
  or **resize.f2fs**\|(8).
  However virt-resize does not know how to resize some filesystems, so
  you would have to online resize them after booting the guest.
  .Sp
  .Vb 1
   # virt-resize --expand /dev/sda2 nbd://example.com outdisk
  .Ve
  .Sp
  The input disk can be a \s-1URI,\s0 in order to use a remote disk as the
  source.  The \s-1URI\s0 format is compatible with guestfish.  See
  \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
  .Sp
  Other options are covered below.
* 6. Test  
  .IX Item "6. Test"
  Thoroughly test the new disk image _before_ discarding the old one.
  .Sp
  If you are using libvirt, edit the \s-1XML\s0 to point at the new disk:
  .Sp
  .Vb 1
   # virsh edit guestname
  .Ve
  .Sp
  Change &lt;source ...&gt;, see
  http://libvirt.org/formatdomain.html#elementsDisks
  .Sp
  Then start up the domain with the new, resized disk:
  .Sp
  .Vb 1
   # virsh start guestname
  .Ve
  .Sp
  and check that it still works.  See also the \s-1NOTES\*(R"\s0 section below
  for additional information.
* 7. Resize LVs etc inside the guest  
  .IX Item "7. Resize LVs etc inside the guest"
  (This can also be done offline using **guestfish**\|(1))
  .Sp
  Once the guest has booted you should see the new space available, at
  least for filesystems that virt-resize knows how to resize, and for
  PVs.  The user may need to resize LVs inside PVs, and also resize
  filesystem types that virt-resize does not know how to expand.

<a name="s-1shrinking-a-virtual-machine-disks0"></a>

### \s-1SHRINKING A VIRTUAL MACHINE DISK\s0

.IX Subsection "SHRINKING A VIRTUAL MACHINE DISK"
Shrinking is somewhat more complex than expanding, and only an
overview is given here.

Firstly virt-resize will not attempt to shrink any partition content
(PVs, filesystems).  The user has to shrink content before passing the
disk image to virt-resize, and virt-resize will check that the content
has been shrunk properly.

(Shrinking can also be done offline using **guestfish**\|(1))

After shrinking PVs and filesystems, shut down the guest, and proceed
with steps 3 and 4 above to allocate a new disk image.

Then run virt-resize with any of the _--shrink_ and/or _--resize_
options.

<a name="s-1ignoring-or-deleting-partitionss0"></a>

### \s-1IGNORING OR DELETING PARTITIONS\s0

.IX Subsection "IGNORING OR DELETING PARTITIONS"
virt-resize also gives a convenient way to ignore or delete partitions
when copying from the input disk to the output disk.  Ignoring a
partition speeds up the copy where you don't care about the existing
contents of a partition.  Deleting a partition removes it completely,
but note that it also renumbers any partitions after the one which is
deleted, which can leave some guests unbootable.

<a name="s-1qcow2-ands0-non-sparse-s-1raw-formatss0"></a>

### \s-1QCOW2 AND\s0 NON-SPARSE \s-1RAW FORMATS\s0

.IX Subsection "QCOW2 AND NON-SPARSE RAW FORMATS"
If the input disk is in qcow2 format, then you may prefer that the
output is in qcow2 format as well.  Alternately, virt-resize can
convert the format on the fly.  The output format is simply determined
by the format of the empty output container that you provide.  Thus to
create qcow2 output, use:

.Vb 1
 qemu-img create -f qcow2 -o preallocation=metadata outdisk [size]
.Ve

instead of the truncate command.

Similarly, to get non-sparse raw output use:

.Vb 1
 fallocate -l size outdisk
.Ve

(on older systems that don’t have the **fallocate**\|(1) command use
\f(CW`dd if=/dev/zero of=outdisk bs=1M count=..\*(C')

<a name="s-1logical-partitionss0"></a>

### \s-1LOGICAL PARTITIONS\s0

.IX Subsection "LOGICAL PARTITIONS"
Logical partitions (a.k.a. _/dev/sda5+_ on disks using \s-1DOS\s0 partition
tables) cannot be resized.

To understand what is going on, firstly one of the four partitions
_/dev/sda1-4_ will have \s-1MBR\s0 partition type \f(CW05 or \f(CW`0f\*(C'.  This is
called the **extended partition**.  Use **virt-filesystems**\|(1) to see
the \s-1MBR\s0 partition type.

Logical partitions live inside the extended partition.

The extended partition can be expanded, but not shrunk (unless you
force it, which is not advisable).  When the extended partition is
copied across, all the logical partitions contained inside are copied
over implicitly.  Virt-resize does not look inside the extended
partition, so it copies the logical partitions blindly.

You cannot specify a logical partition (_/dev/sda5+_) at all on the
command line.  Doing so will give an error.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--align-first** **auto**  
  .IX Item "--align-first auto"
* **--align-first** **never**  
  .IX Item "--align-first never"
* **--align-first** **always**  
  .IX Item "--align-first always"
  Align the first partition for improved performance (see also the
  _--alignment_ option).
  .Sp
  The default is _--align-first auto_ which only aligns the first
  partition if it is safe to do so.  That is, only when we know how to
  fix the bootloader automatically, and at the moment that can only be
  done for Windows guests.
  .Sp
  _--align-first never_ means we never move the first partition.
  This is the safest option.  Try this if the guest does not boot
  after resizing.
  .Sp
  _--align-first always_ means we always align the first partition (if
  it needs to be aligned).  For some guests this will break the
  bootloader, making the guest unbootable.
* **--alignment** N  
  .IX Item "--alignment N"
  Set the alignment of partitions to \f(CW`N\*(C' sectors.  The default in
  virt-resize &lt; 1.13.19 was 64 sectors, and after that is 128
  sectors.
  .Sp
  Assuming 512 byte sector size inside the guest, here are some
  suitable values for this:
    * _--alignment 1_ (512 bytes)  
      .IX Item "--alignment 1 (512 bytes)"
      The partitions would be packed together as closely as possible, but
      would be completely unaligned.  In some cases this can cause very poor
      performance.  See **virt-alignment-scan**\|(1) for further details.
    * _--alignment 8_ (4K)  
      .IX Item "--alignment 8 (4K)"
      This would be the minimum acceptable alignment for reasonable
      performance on modern hosts.
    * _--alignment 128_ (64K)  
      .IX Item "--alignment 128 (64K)"
      This alignment provides good performance when the host is using high
      end network storage.
    * _--alignment 2048_ (1M)  
      .IX Item "--alignment 2048 (1M)"
      This is the standard alignment used by all newly installed guests
      since around 2008.
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
* **-d**  
  .IX Item "-d"
* **--debug**  
  .IX Item "--debug"
  (Deprecated: use _-v_ option instead)
  .Sp
  Enable debugging messages.
* **--delete** \s-1PART\s0  
  .IX Item "--delete PART"
  Delete the named partition.  It would be more accurate to describe
  this as don't copy it over\*(R", since virt-resize doesn't do in-place
  changes and the original disk image is left intact.
  .Sp
  Note that when you delete a partition, then anything contained in the
  partition is also deleted.  Furthermore, this causes any partitions
  that come after to be _renumbered_, which can easily make your guest
  unbootable.
  .Sp
  You can give this option multiple times.
* **--expand** \s-1PART\s0  
  .IX Item "--expand PART"
  Expand the named partition so it uses up all extra space (space left
  over after any other resize changes that you request have been done).
  .Sp
  If virt-resize knows how, it will expand the direct content of the
  partition.  For example, if the partition is an \s-1LVM PV,\s0 it will expand
  the \s-1PV\s0 to fit (like calling **pvresize**\|(8)).  Virt-resize leaves any
  other content it doesn't know about alone.
  .Sp
  Currently virt-resize can resize:
    * ·  
      ext2, ext3 and ext4 filesystems.
    * ·  
      \s-1NTFS\s0 filesystems, if libguestfs was compiled with support for \s-1NTFS.\s0
      .Sp
      The filesystem must have been shut down consistently last time it was
      used.  Additionally, **ntfsresize**\|(8) marks the resized filesystem as
      requiring a consistency check, so at the first boot after resizing
      Windows will check the disk.
    * ·  
      \s-1LVM\s0 PVs (physical volumes).  virt-resize does not usually resize
      anything inside the \s-1PV,\s0 but see the _--LV-expand_ option.  The user
      could also resize LVs as desired after boot.
    * ·  
      Btrfs filesystems, if libguestfs was compiled with support for btrfs.
    * ·  
      \s-1XFS\s0 filesystems, if libguestfs was compiled with support for \s-1XFS.\s0
    * ·  
      Linux swap partitions.
      .Sp
      Please note that libguestfs _destroys_ the existing swap content
      by recreating it with \f(CW`mkswap\*(C', so this should not be used when
      the guest is suspended.
    * ·  
      f2fs filesystems, if libguestfs was compiled with support for f2fs.
      .Sp
      Note that you cannot use _--expand_ and _--shrink_ together.
* **--format** **raw**  
  .IX Item "--format raw"
  Specify the format of the input disk image.  If this flag is not
  given then it is auto-detected from the image itself.
  .Sp
  If working with untrusted raw-format guest disk images, you should
  ensure the format is always specified.
  .Sp
  Note that this option _does not_ affect the output format.
  See \s-1QCOW2 AND\s0 NON-SPARSE \s-1RAW FORMATS\*(R"\s0.
* **--ignore** \s-1PART\s0  
  .IX Item "--ignore PART"
  Ignore the named partition.  Effectively this means the partition is
  allocated on the destination disk, but the content is not copied
  across from the source disk.  The content of the partition will be
  blank (all zero bytes).
  .Sp
  You can give this option multiple times.
* **--LV-expand** \s-1LOGVOL\s0  
  .IX Item "--LV-expand LOGVOL"
  This takes the logical volume and, as a final step, expands it to fill
  all the space available in its volume group.  A typical usage,
  assuming a Linux guest with a single \s-1PV\s0 _/dev/sda2_ and a root device
  called _/dev/vg\_guest/lv\_root_ would be:
  .Sp
  .Vb 2
   virt-resize indisk outdisk \e
     --expand /dev/sda2 --LV-expand /dev/vg_guest/lv_root
  .Ve
  .Sp
  This would first expand the partition (and \s-1PV\s0), and then expand the
  root device to fill the extra space in the \s-1PV.\s0
  .Sp
  The contents of the \s-1LV\s0 are also resized if virt-resize knows how to do
  that.  You can stop virt-resize from trying to expand the content by
  using the option _--no-expand-content_.
  .Sp
  Use **virt-filesystems**\|(1) to list the filesystems in the guest.
  .Sp
  You can give this option multiple times, _but_ it doesn't
  make sense to do this unless the logical volumes you specify
  are all in different volume groups.
* **--machine-readable**  
  .IX Item "--machine-readable"
* **--machine-readable**=format  
  .IX Item "--machine-readable=format"
  This option is used to make the output more machine friendly
  when being parsed by other programs.  See
  \s-1MACHINE READABLE OUTPUT\*(R"\s0 below.
* **-n**  
  .IX Item "-n"
* **--dry-run**  
  .IX Item "--dry-run"
  Print a summary of what would be done, but don’t do anything.
* **--no-copy-boot-loader**  
  .IX Item "--no-copy-boot-loader"
  By default, virt-resize copies over some sectors at the start of the
  disk (up to the beginning of the first partition).  Commonly these
  sectors contain the Master Boot Record (\s-1MBR\s0) and the boot loader, and
  are required in order for the guest to boot correctly.
  .Sp
  If you specify this flag, then this initial copy is not done.  You may
  need to reinstall the boot loader in this case.
* **--no-extra-partition**  
  .IX Item "--no-extra-partition"
  By default, virt-resize creates an extra partition if there is any
  extra, unused space after all resizing has happened.  Use this option
  to prevent the extra partition from being created.  If you do this
  then the extra space will be inaccessible until you run fdisk, parted,
  or some other partitioning tool in the guest.
  .Sp
  Note that if the surplus space is smaller than 10 \s-1MB,\s0 no extra
  partition will be created.
* **--no-expand-content**  
  .IX Item "--no-expand-content"
  By default, virt-resize will try to expand the direct contents
  of partitions, if it knows how (see _--expand_ option above).
  .Sp
  If you give the _--no-expand-content_ option then virt-resize
  will not attempt this.
* **--no-sparse**  
  .IX Item "--no-sparse"
  Turn off sparse copying.  See \s-1SPARSE COPYING\*(R"\s0 below.
* **--ntfsresize-force**  
  .IX Item "--ntfsresize-force"
  Pass the _--force_ option to **ntfsresize**\|(8), allowing resizing
  even if the \s-1NTFS\s0 disk is marked as needing a consistency check.
  You have to use this option if you want to resize a Windows
  guest multiple times without booting into Windows between each
  resize.
* **--output-format** **raw**  
  .IX Item "--output-format raw"
  Specify the format of the output disk image.  If this flag is not
  given then it is auto-detected from the image itself.
  .Sp
  If working with untrusted raw-format guest disk images, you should
  ensure the format is always specified.
  .Sp
  Note that this option _does not create_ the output format.  This
  option just tells libguestfs what it is so it doesn't try to guess it.
  You still need to create the output disk with the right format.  See
  \s-1QCOW2 AND\s0 NON-SPARSE \s-1RAW FORMATS\*(R"\s0.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t print the summary.
* **--resize** PART=SIZE  
  .IX Item "--resize PART=SIZE"
  Resize the named partition (expanding or shrinking it) so that it has
  the given size.
  .Sp
  \f(CW`SIZE\*(C' can be expressed as an absolute number followed by
  b/K/M/G to mean bytes, Kilobytes, Megabytes, or Gigabytes;
  or as a percentage of the current size;
  or as a relative number or percentage.
  For example:
  .Sp
  .Vb 1
   --resize /dev/sda2=10G
  
   --resize /dev/sda4=90%
  
   --resize /dev/sda2=+1G
  
   --resize /dev/sda2=-200M
  
   --resize /dev/sda1=+128K
  
   --resize /dev/sda1=+10%
  
   --resize /dev/sda1=-10%
  .Ve
  .Sp
  You can increase the size of any partition.  Virt-resize will expand
  the direct content of the partition if it knows how (see _--expand_
  above).
  .Sp
  You can only _decrease_ the size of partitions that contain
  filesystems or PVs which have already been shrunk.  Virt-resize will
  check this has been done before proceeding, or else will print an
  error (see also _--resize-force_).
  .Sp
  You can give this option multiple times.
* **--resize-force** PART=SIZE  
  .IX Item "--resize-force PART=SIZE"
  This is the same as _--resize_ except that it will let you decrease
  the size of any partition.  Generally this means you will lose any
  data which was at the end of the partition you shrink, but you may not
  care about that (eg. if shrinking an unused partition, or if you can
  easily recreate it such as a swap partition).
  .Sp
  See also the _--ignore_ option.
* **--shrink** \s-1PART\s0  
  .IX Item "--shrink PART"
  Shrink the named partition until the overall disk image fits in the
  destination.  The named partition **must** contain a filesystem or \s-1PV\s0
  which has already been shrunk using another tool (eg. **guestfish**\|(1)
  or other online tools).  Virt-resize will check this and give an error
  if it has not been done.
  .Sp
  The amount by which the overall disk must be shrunk (after carrying
  out all other operations requested by the user) is called the
  deficit\*(R".  For example, a straight copy (assume no other operations)
  from a 5GB disk image to a 4GB disk image results in a 1GB deficit.
  In this case, virt-resize would give an error unless the user
  specified a partition to shrink and that partition had more than a
  gigabyte of free space.
  .Sp
  Note that you cannot use _--expand_ and _--shrink_ together.
* **--unknown-filesystems** **ignore**  
  .IX Item "--unknown-filesystems ignore"
* **--unknown-filesystems** **warn**  
  .IX Item "--unknown-filesystems warn"
* **--unknown-filesystems** **error**  
  .IX Item "--unknown-filesystems error"
  Configure the behaviour of virt-resize when asking to expand a
  filesystem, and neither libguestfs has the support it, nor virt-resize
  knows how to expand the content of the filesystem.
  .Sp
  _--unknown-filesystems ignore_ will cause virt-resize to silently
  ignore such filesystems, and nothing is printed about them.
  .Sp
  _--unknown-filesystems warn_ (the default behaviour) will cause
  virt-resize to warn for each of the filesystem that cannot be
  expanded, but still continuing to resize the disk.
  .Sp
  _--unknown-filesystems error_ will cause virt-resize to error out
  at the first filesystem that cannot be expanded.
  .Sp
  See also unknown/unavailable method for expanding the \s-1TYPE\s0 filesystem on \s-1DEVICE/LV\*(R"\s0.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable debugging messages.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.

<a name="machine-readable-output"></a>

# Machine Readable Output

.IX Header "MACHINE READABLE OUTPUT"
The _--machine-readable_ option can be used to make the output more
machine friendly, which is useful when calling virt-resize from other
programs, GUIs etc.

There are two ways to use this option.

Firstly use the option on its own to query the capabilities of the
virt-resize binary.  Typical output looks like this:

.Vb 6
 $ virt-resize --machine-readable
 virt-resize
 ntfsresize-force
 32bitok
 ntfs
 btrfs
.Ve

A list of features is printed, one per line, and the program exits
with status 0.

Secondly use the option in conjunction with other options to make the
regular program output more machine friendly.

At the moment this means:

* 1.  
  Progress bar messages can be parsed from stdout by looking for this
  regular expression:
  .Sp
  .Vb 1
   ^[0-9]+/[0-9]+$
  .Ve
* 2.  
  The calling program should treat messages sent to stdout (except for
  progress bar messages) as status messages.  They can be logged and/or
  displayed to the user.
* 3.  
  The calling program should treat messages sent to stderr as error
  messages.  In addition, virt-resize exits with a non-zero status code
  if there was a fatal error.

Versions of the program prior to 1.13.9 did not support the
_--machine-readable_ option and will return an error.

It is possible to specify a format string for controlling the output;
see \s-1ADVANCED MACHINE READABLE OUTPUT\*(R"\s0 in **guestfs**\|(3).

<a name="notes"></a>

# Notes

.IX Header "NOTES"
.ie n .SS """Partition 1 does not end on cylinder boundary."""
.el .SS "\`\`Partition 1 does not end on cylinder boundary.''"
.IX Subsection "Partition 1 does not end on cylinder boundary."
Virt-resize aligns partitions to multiples of 128 sectors (see the
_--alignment_ parameter).  Usually this means the partitions will not
be aligned to the ancient \s-1CHS\s0 geometry.  However \s-1CHS\s0 geometry is
meaningless for disks manufactured since the early 1990s, and doubly
so for virtual hard drives.  Alignment of partitions to cylinders is
not required by any modern operating system.
.ie n .SS "\s-1GUEST BOOT STUCK AT ""GRUB""\s0"
.el .SS "\s-1GUEST BOOT STUCK AT \`\`GRUB''\s0"
.IX Subsection "GUEST BOOT STUCK AT GRUB"
If a Linux guest does not boot after resizing, and the boot is stuck
after printing \f(CW`GRUB\*(C' on the console, try reinstalling grub.

.Vb 6
 guestfish -i -a newdisk
 &gt;&lt;fs&gt; cat /boot/grub/device.map
 # check the contents of this file are sensible or
 # edit the file if necessary
 &gt;&lt;fs&gt; grub-install / /dev/vda
 &gt;&lt;fs&gt; exit
.Ve

For more flexible guest reconfiguration, including if you need to
specify other parameters to grub-install, use **virt-rescue**\|(1).

<a name="s-1resizing-windows-boot-partitionss0"></a>

### \s-1RESIZING WINDOWS BOOT PARTITIONS\s0

.IX Subsection "RESIZING WINDOWS BOOT PARTITIONS"
In Windows Vista and later versions, Microsoft switched to using a
separate boot partition.  In these VMs, typically _/dev/sda1_ is the
boot partition and _/dev/sda2_ is the main (C:) drive.  Resizing the
first (boot) partition causes the bootloader to fail with
\f(CW0xC0000225 error.  Resizing the second partition (ie. C: drive)
should work.

<a name="s-1windows-chkdsks0"></a>

### \s-1WINDOWS CHKDSK\s0

.IX Subsection "WINDOWS CHKDSK"
Windows disks which use \s-1NTFS\s0 must be consistent before virt-resize can
be used.  If the ntfsresize operation fails, try booting the original
\s-1VM\s0 and running \f(CW`chkdsk /f\*(C' on all \s-1NTFS\s0 partitions, then shut down the
\s-1VM\s0 cleanly.  For further information see:
https://bugzilla.redhat.com/show_bug.cgi?id=975753

_After resize_ Windows may initiate a lengthy chkdsk\*(R" on first boot
if \s-1NTFS\s0 partitions have been expanded.  This is just a safety check
and (unless it find errors) is nothing to worry about.

<a name="s-1windows-unmountable_boot_volume-bsods0"></a>

### \s-1WINDOWS UNMOUNTABLE_BOOT_VOLUME BSOD\s0

.IX Subsection "WINDOWS UNMOUNTABLE_BOOT_VOLUME BSOD"
After sysprepping a Windows guest and then resizing it with
virt-resize, you may see the guest fail to boot with an
\f(CW`UNMOUNTABLE\_BOOT\_VOLUME\*(C' \s-1BSOD.\s0  This error is caused by having
\f(CW`ExtendOemPartition=1\*(C' in the sysprep.inf file.  Removing this line
before sysprepping should fix the problem.

<a name="s-1windows-8s0"></a>

### \s-1WINDOWS 8\s0

.IX Subsection "WINDOWS 8"
Windows 8 fast startup\*(R" can prevent virt-resize from resizing \s-1NTFS\s0
partitions.  See
\s-1WINDOWS HIBERNATION AND WINDOWS 8 FAST STARTUP\*(R"\s0 in **guestfs**\|(3).

<a name="s-1sparse-copyings0"></a>

### \s-1SPARSE COPYING\s0

.IX Subsection "SPARSE COPYING"
You should create a fresh, zeroed target disk image for virt-resize to
use.

Virt-resize by default performs sparse copying.  This means that it
does not copy blocks from the source disk which are all zeroes.  This
improves speed and efficiency, but will produce incorrect results if
the target disk image contains unzeroed data.

The main time this can be a problem is if the target is a host
partition (eg. \f(CW`virt-resize source.img /dev/sda4\*(C') because the
usual partitioning tools tend to leave whatever data happened to be on
the disk before.

If you have to reuse a target which contains data already, you should
use the _--no-sparse_ option.  Note this can be much slower.
.ie n .SS """unknown/unavailable method for expanding the \s-1TYPE\s0 filesystem on \s-1DEVICE/LV""\s0"
.el .SS "\`\`unknown/unavailable method for expanding the \s-1TYPE\s0 filesystem on \s-1DEVICE/LV''\s0"
.IX Subsection "unknown/unavailable method for expanding the TYPE filesystem on DEVICE/LV"
Virt-resize was asked to expand a partition or a logical volume
containing a filesystem with the type \f(CW`TYPE\*(C', but there is no
available nor known expanding method for that filesystem.

This may be due to either of the following:

* 1.  
  There corresponding filesystem is not available in libguestfs,
  because there is no proper package in the host with utilities for it.
  This is usually the case for \f(CW`btrfs\*(C', \f(CW\*(C\`ntfs\*(C', \f(CW\*(C\`xfs\*(C', and \f(CW\*(C\`f2fs\*(C'
  filesystems.
  .Sp
  Check the results of:
  .Sp
  .Vb 3
   virt-resize --machine-readable
   guestfish -a /dev/null run : available
   guestfish -a /dev/null run : filesystem_available TYPE
  .Ve
  .Sp
  In this case, it is enough to install the proper packages
  adding support for them.  For example, \f(CW`libguestfs-xfs\*(C' on
  Red Hat Enterprise Linux, CentOS, Debian, Ubuntu, and distributions
  derived from them, for supporting the \f(CW`xfs\*(C' filesystem.
* 2.  
  Virt-resize has no support for expanding that type of filesystem.
  .Sp
  In this case, there’s nothing that can be done to let virt-resize
  expand that type of filesystem.

In both cases, virt-resize will not expand the mentioned filesystem;
the result (unless _--unknown-filesystems error_ is specified)
is that the partitions containing such filesystems will be actually
bigger as requested, but the filesystems will still be usable at
their older sizes.

<a name="alternative-tools"></a>

# Alternative Tools

.IX Header "ALTERNATIVE TOOLS"
There are several proprietary tools for resizing partitions.  We
won't mention any here.

**parted**\|(8) and its graphical shell gparted can do some types of
resizing operations on disk images.  They can resize and move
partitions, but I don't think they can do anything with the contents,
and they certainly don't understand \s-1LVM.\s0

**guestfish**\|(1) can do everything that virt-resize can do and a lot
more, but at a much lower level.  You will probably end up
hand-calculating sector offsets, which is something that virt-resize
was designed to avoid.  If you want to see the guestfish-equivalent
commands that virt-resize runs, use the _--debug_ flag.

**dracut**\|(8) includes a module called \f(CW`dracut-modules-growroot\*(C' which
can be used to grow the root partition when the guest first boots up.
There is documentation for this module in an associated \s-1README\s0 file.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if successful, or non-zero if there was an
error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-filesystems**\|(1),
**virt-df**\|(1),
**guestfs**\|(3),
**guestfish**\|(1),
**lvm**\|(8),
**pvresize**\|(8),
**lvresize**\|(8),
**resize2fs**\|(8),
**ntfsresize**\|(8),
**btrfs**\|(8),
**xfs\_growfs**\|(8),
**resize.f2fs**\|(8),
**virsh**\|(1),
**parted**\|(8),
**truncate**\|(1),
**fallocate**\|(1),
**grub**\|(8),
**grub-install**\|(8),
**virt-rescue**\|(1),
**virt-sparsify**\|(1),
**virt-alignment-scan**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2010-2012 Red Hat Inc.

<a name="license"></a>

# License

.IX Header "LICENSE"
This program is free software; you can redistribute it and/or modify it
under the terms of the \s-1GNU\s0 General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
\s-1WITHOUT ANY WARRANTY\s0; without even the implied warranty of
\s-1MERCHANTABILITY\s0 or \s-1FITNESS FOR A PARTICULAR PURPOSE.\s0  See the \s-1GNU\s0
General Public License for more details.

You should have received a copy of the \s-1GNU\s0 General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, \s-1MA 02110-1301 USA.\s0

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
To get a list of bugs against libguestfs, use this link:
https://bugzilla.redhat.com/buglist.cgi?component=libguestfs&product=Virtualization+Tools

To report a new bug against libguestfs, use this link:
https://bugzilla.redhat.com/enter_bug.cgi?component=libguestfs&product=Virtualization+Tools

When reporting a bug, please supply:

* ·  
  The version of libguestfs.
* ·  
  Where you got libguestfs (eg. which Linux distro, compiled from source, etc)
* ·  
  Describe the bug accurately and give a way to reproduce it.
* ·  
  Run **libguestfs-test-tool**\|(1) and paste the **complete, unedited**
  output into the bug report.
