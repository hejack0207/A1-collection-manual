# virt-clone(1) - clone existing virtual machine images

"", ""

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```

 virt-clone [OPTION]...
```

<a name="description"></a>

# Description


**virt-clone** is a command line tool for cloning existing virtual machine
images using the **libvirt** hypervisor management library. It will copy
the disk images of any existing virtual machine, and define a new guest
with an identical virtual hardware configuration. Elements which require
uniqueness will be updated to avoid a clash between old and new guests.

By default, virt-clone will show an error if the necessary information to
clone the guest is not provided. The --auto-clone option will generate
all needed input, aside from the source guest to clone.

Please note, virt-clone does not change anything _inside_ the guest OS, it
only duplicates disks and does host side changes. So things like changing
passwords, changing static IP address, etc are outside the scope of this
tool. For these types of changes, please see **virt-sysprep**.

<a name="general-options"></a>

# General Options


Most options are not required. Minimum requirements are --original or
--original-xml (to specify the guest to clone), --name, and appropriate
storage options via -file.
.INDENT 0.0

* <b>**--connect** URI</b>  
  Connect to a non-default hypervisor. See virt-install(1) for details
* <b>**-o**, **--original** ORIGINAL_GUEST</b>  
  Name of the original guest to be cloned. This guest must be shut off.
* <b>**--original-xml** ORIGINAL_XML</b>  
  Libvirt guest xml file to use as the original guest. The guest does not need to
  be defined on the libvirt connection. This takes the place of the
  **--original** parameter.
* <b>**--auto-clone**</b>  
  Generate a new guest name, and paths for new storage.

An example of possible generated output:
.INDENT 7.0
.INDENT 3.5

    .ft C
    Original name        : MyVM
    Generated clone name : MyVM-clone
    
    Original disk path   : /home/user/foobar.img
    Generated disk path  : /home/user/foobar-clone.img
    .ft P
.UNINDENT
.UNINDENT

If generated names collide with existing VMs or storage, a number is appended,
such as foobar-clone-1.img, or MyVM-clone-3.

* <b>**-n**, **--name** NAME</b>  
  Name of the new guest virtual machine instance. This must be unique amongst
  all guests known to the hypervisor connection, including those not
  currently active.
* <b>**-u**, **--uuid** UUID</b>  
  UUID for the guest; if none is given a random UUID will be generated. If you
  specify UUID, you should use a 32-digit hexadecimal number. UUID are intended
  to be unique across the entire data center, and indeed world. Bear this in
  mind if manually specifying a UUID
* <b>**-f**, **--file** PATH</b>  
  Path to the file, disk partition, or logical volume to use as the backing store
  for the new guest's virtual disk. If the original guest has multiple disks,
  this parameter must be repeated multiple times, once per disk in the original
  virtual machine.
* <b>**--nvram** NVRAMFILE</b>  
  Optional path to the new nvram VARS file, if no path is specified and the
  guest has nvram the new nvram path will be auto-generated. If the guest
  doesn't have nvram this option will be ignored.
* <b>**--force-copy** TARGET</b>  
  Force cloning the passed disk target ('hdc', 'sda', etc.). By default,
  **virt-clone** will skip certain disks, such as those marked 'readonly' or
  'shareable'.
* <b>**--skip-copy** TARGET</b>  
  Skip cloning the passed disk target ('hdc', 'sda', etc.). By default,
  **virt-clone** will clone certain disk images, typically read/write
  devices. Use this to skip copying of a specific device, so the new
  VM uses the same storage path as the original VM.
* <b>**--nonsparse**</b>  
  Fully allocate the new storage if the path being cloned is a sparse file.
  See virt-install(1) for more details on sparse vs. nonsparse.
* <b>**--preserve-data**</b>  
  No storage is cloned: disk images specific by --file are preserved as is,
  and referenced in the new clone XML. This is useful if you want to clone
  a VM XML template, but not the storage contents.
* <b>**--reflink**</b>  
  When --reflink is specified, perform a lightweight copy. This is much faster
  if source images and destination images are all on the same btrfs filesystem.
  If COW copy is not possible, then virt-clone fails.
* <b>**-m**, **--mac** MAC</b>  
  Fixed MAC address for the guest; If this parameter is omitted, or the value
  **RANDOM** is specified a suitable address will be randomly generated. Addresses
  are applied sequentially to the networks as they are listed in the original
  guest XML.
* <b>**--print-xml**</b>  
  Print the generated clone XML and exit without cloning.
* <b>**--replace**</b>  
  Shutdown and remove any existing guest with the passed **--name** before
  cloning the original guest.
* <b>**-h**, **--help**</b>  
  Show the help message and exit
* <b>**--version**</b>  
  Show program's version number and exit
* <b>**--check**</b>  
  Enable or disable some validation checks. See virt-install(1) for more details.
* <b>**-q**, **--quiet**</b>  
  Suppress non-error output.
* <b>**-d**, **--debug**</b>  
  Print debugging information to the terminal when running the install process.
  The debugging information is also stored in
  **~/.cache/virt-manager/virt-clone.log** even if this parameter is omitted.
  .UNINDENT

<a name="examples"></a>

# Examples


Clone the guest called **demo** on the default connection, auto generating
a new name and disk clone path.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-clone e
         --original demo e
         --auto-clone
    .ft P
.UNINDENT
.UNINDENT

Clone the guest called **demo** which has a single disk to copy
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-clone e
         --original demo e
         --name newdemo e
         --file /var/lib/xen/images/newdemo.img
    .ft P
.UNINDENT
.UNINDENT

Clone a QEMU guest with multiple disks
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-clone e
         --connect qemu:///system e
         --original demo e
         --name newdemo e
         --file /var/lib/xen/images/newdemo.img e
         --file /var/lib/xen/images/newdata.img
    .ft P
.UNINDENT
.UNINDENT

Clone a guest to a physical device which is at least as big as the
original guests disks. If the destination device is bigger, the
new guest can do a filesystem resize when it boots.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-clone e
         --connect qemu:///system e
         --original demo e
         --name newdemo e
         --file /dev/HostVG/DemoVM e
         --mac 52:54:00:34:11:54
    .ft P
.UNINDENT
.UNINDENT

<a name="bugs"></a>

# Bugs


Please see _https://virt-manager.org/bugs_

<a name="copyright"></a>

# Copyright


Copyright (C) Fujitsu Limited, Copyright (C) Red Hat, Inc,
and various contributors.
This is free software. You may redistribute copies of it under the terms
of the GNU General Public License _https://www.gnu.org/licenses/gpl.html_.
There is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also


**virt-sysprep(1)**, **virsh(1)**, **virt-install(1)**, **virt-manager(1)**, the project website _https://virt-manager.org_

