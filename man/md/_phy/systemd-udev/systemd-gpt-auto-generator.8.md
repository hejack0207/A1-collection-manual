# systemd\-gpt\-auto\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-gpt-auto-generator - Generator for automatically discovering and mounting root, /home and /srv partitions, as well as discovering and enabling swap partitions, based on GPT partition type GUIDs.

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-gpt-auto-generator
```

<a name="description"></a>

# Description


systemd-gpt-auto-generator
is a unit generator that automatically discovers root,
/home,
/srv
and swap partitions and creates mount and swap units for them, based on the partition type GUIDs of GUID partition tables (GPT), see
\m[blue]**UEFI Specification**\m[]\s-2\u[1]\d\s+2, chapter 5. It implements the
\m[blue]**Discoverable Partitions Specification**\m[]\s-2\u[2]\d\s+2. Note that this generator has no effect on non-GPT systems, or where the directories under the mount points are already non-empty. Also, on systems where the units are explicitly configured (for example, listed in
**fstab**(5)), the units this generator creates are overridden, but additional implicit dependencies might be created.

This generator will only look for root partitions on the same physical disk the EFI System Partition (ESP) is located on. It will only look for the other partitions on the same physical disk the root file system is located on. These partitions will not be searched for on systems where the root file system is distributed on multiple disks, for example via btrfs RAID.

systemd-gpt-auto-generator
is useful for centralizing file system configuration in the partition table and making configuration in
/etc/fstab
unnecessary.

This generator looks for the partitions based on their partition type GUID. The following partition type GUIDs are identified:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Partition Type GUIDs**
.TS
allbox tab(:);
lB lB lB.
T{
Partition Type GUID
T}:T{
Name
T}:T{
Explanation
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l.
T{
44479540-f297-41b2-9af7-d131d5f0458a
T}:T{
Root Partition (x86)
T}:T{
On 32-bit x86 systems, the first x86 root partition on the disk the EFI ESP is located on is mounted to the root directory /.
T}
T{
4f68bce3-e8cd-4db1-96e7-fbcaf984b709
T}:T{
Root Partition (x86-64)
T}:T{
On 64-bit x86 systems, the first x86-64 root partition on the disk the EFI ESP is located on is mounted to the root directory /.
T}
T{
69dad710-2ce4-4e3c-b16c-21a1d49abed3
T}:T{
Root Partition (32-bit ARM)
T}:T{
On 32-bit ARM systems, the first ARM root partition on the disk the EFI ESP is located on is mounted to the root directory /.
T}
T{
b921b045-1df0-41c3-af44-4c6f280d3fae
T}:T{
Root Partition (64-bit ARM)
T}:T{
On 64-bit ARM systems, the first ARM root partition on the disk the EFI ESP is located on is mounted to the root directory /.
T}
T{
993d8d3d-f80e-4225-855a-9daf8ed7ea97
T}:T{
Root Partition (Itanium/IA-64)
T}:T{
On Itanium systems, the first Itanium root partition on the disk the EFI ESP is located on is mounted to the root directory /.
T}
T{
933ac7e1-2eb4-4f13-b844-0e14e2aef915
T}:T{
Home Partition
T}:T{
The first home partition on the disk the root partition is located on is mounted to /home.
T}
T{
3b8f8425-20e0-4f3b-907f-1a25a76f98e8
T}:T{
Server Data Partition
T}:T{
The first server data partition on the disk the root partition is located on is mounted to /srv.
T}
T{
0657fd6d-a4ab-43c4-84e5-0933c84b4f4f
T}:T{
Swap
T}:T{
All swap partitions located on the disk the root partition is located on are enabled.
T}
T{
c12a7328-f81f-11d2-ba4b-00a0c93ec93b
T}:T{
EFI System Partition (ESP)
T}:T{
The first ESP located on the disk the root partition is located on is mounted to /boot or /efi, see below.
T}
.TE


This generator understands the following attribute flags for partitions:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp;Partition Attributes**
.TS
allbox tab(:);
lB lB lB lB.
T{
Name
T}:T{
Value
T}:T{
Applicable to
T}:T{
Explanation
T}
.T&
l l l l
l l l l
l l l l.
T{
**GPT\_FLAG\_READ\_ONLY**
T}:T{
0x1000000000000000
T}:T{
/, /srv, /home
T}:T{
Partition is mounted read-only
T}
T{
**GPT\_FLAG\_NO\_AUTO**
T}:T{
0x8000000000000000
T}:T{
/, /srv, /home
T}:T{
Partition is not mounted automatically
T}
T{
**GPT\_FLAG\_NO\_BLOCK\_IO\_PROTOCOL**
T}:T{
0x0000000000000002
T}:T{
ESP
T}:T{
Partition is not mounted automatically
T}
.TE


The
/home
and
/srv
partitions may be encrypted in LUKS format. In this case, a device mapper device is set up under the names
/dev/mapper/home
and
/dev/mapper/srv. Note that this might create conflicts if the same partition is listed in
/etc/crypttab
with a different device mapper device name.

Mount and automount units for the EFI System Partition (ESP) are generated on EFI systems. The ESP is mounted to
/boot, unless a mount point directory
/efi
exists, in which case it is mounted there. Since this generator creates an automount unit, the mount will only be activated on-demand, when accessed. On systems where
/boot
(or
/efi
if it exists) is an explicitly configured mount (for example, listed in
**fstab**(5)) or where the
/boot
(or
/efi) mount point is non-empty, no mount units are generated.

When using this generator in conjunction with btrfs file systems, make sure to set the correct default subvolumes on them, using
**btrfs subvolume set-default**.

systemd-gpt-auto-generator
implements
**systemd.generator**(7).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.mount**(5),
**systemd.swap**(5),
**systemd-fstab-generator**(8),
**systemd-cryptsetup@.service**(8),
**cryptsetup**(8),
**fstab**(5),
**btrfs**(8)

<a name="notes"></a>

# Notes


*  1.  
  UEFI Specification
      http://www.uefi.org/specifications
*  2.  
  Discoverable Partitions Specification
      https://www.freedesktop.org/wiki/Specifications/DiscoverablePartitionsSpec/
