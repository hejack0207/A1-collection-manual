# virt-v2v-release-notes-1.42(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v-release-notes - virt-v2v Release Notes

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
These are the release notes for **virt-v2v 1.42**,
released on **16th April 2020**.

<a name="new-features"></a>

### New features

.IX Subsection "New features"
This is the first release where virt-v2v lives in a separate
repository from libguestfs.  The two projects are now broadly
decoupled from one another.

Add a new _-o json_ output mode.  Primarily this is used to do
conversions to KubeVirt (Pino Toscano).

Use new libvirt \f(CW`&lt;firmware&gt;\*(C' feature to get the source guest
firmware (Pino Toscano).

virt-v2v _-o rhv-upload_ new option _-oo rhv-disk-uuid_ allows disk
UUIDs to be specified.  Also _-oo rhv-cafile_ is now optional
(Pino Toscano).

Conversions over ssh now use **nbdkit-ssh-plugin**\|(1) instead of the
\s-1QEMU\s0 ssh driver.  Similarly **nbdkit-curl-plugin**\|(1) is used instead
of the \s-1QEMU\s0 curl driver.  This allowed us to add more flexible
features such as password authentication, bandwidth throttling (new
_--bandwidth_ option), readahead, and automatic retry on network
failures.

For Windows guests, \s-1QEMU\s0 Guest Agent \s-1MSI\s0 may now be installed
(Tomáš Golembiovský).

<a name="other-fixes"></a>

### Other fixes

.IX Subsection "Other fixes"
In _-o libvirt_ mode, support Windows Server 2019 (Pino Toscano).

Fix Ubuntu Server conversions (Pino Toscano).

Fix installation of qemu-ga by only installing arch-specific
files in the guest (Pino Toscano).

Delay installation of qemu-ga until after virtio-win drivers have been
installed and rebooted (Tomáš Golembiovský).

Save the log from running RHEV-APT installer to allow
debugging (Tomáš Golembiovský).

Check \s-1RHV\s0 cluster exists before trying to convert when using
_-o rhv-upload_ mode.  Also allows us to detect and reject various other
conditions early.  (Pino Toscano).

Label nbdkit sockets correctly for SELinux/sVirt
(Martin Kletzander).

You can use a block device as the Windows virtio driver \s-1ISO.\s0

Multiple fixes to \s-1RHV\s0 uploads: Set \f(CW`DISKTYPE\*(C' field correctly when
converting to \s-1RHV\s0 and \s-1VDSM.\s0  Properly clean up on failure.  Display
disk \s-1ID\s0 in error messages, and log script parameters, to help with
debugging.  Multiple code cleanups.  (Nir Soffer).

Support conversions to \s-1RHV\s0 in qcow2 format (Nir Soffer).

Fix detection of disk status and failures after conversion to \s-1RHV\s0
(Daniel Erez).

Cancel disk transfer and remove uploaded disks on failure of
conversion to \s-1RHV\s0 (Pino Toscano).

Images containing small holes (sparse regions) should now
convert faster (Nir Soffer).

The **nbdkit-cacheextents-filter**\|(1) is used to accelerate
sources which have slow sparseness detection, primarily
this means VMware sources using \s-1VDDK\s0 (Martin Kletzander).

Require at least 100 free inodes on each guest filesystem before doing
conversion, since lack of inodes could cause conversion failures
(Pino Toscano).

Fix osinfo output for CentOS 8 conversions (Pino Toscano).

VMware tools are now removed from Windows guests automatically in most
cases (Pino Toscano).

_-i ova_ mode no longer reads the whole input \s-1OVF\s0 into memory, but
parses it off disk (Pino Toscano).

When converting to OpenStack, we now wait up to 5 minutes (instead of
60 seconds) for the Cinder volume to get attached to the conversion
appliance, since in some cases it was taking a long time.

If using a new enough version of nbdkit, virt-v2v logs should be much
less verbose.

<a name="security"></a>

### Security

.IX Subsection "Security"
There were no security-related bugs found in this release.

<a name="build-changes"></a>

### Build changes

.IX Subsection "Build changes"
Libguestfs ≥ 1.40 is required, it is now packaged and distributed
separately from virt-v2v.  For developers you can use a locally built
(and not installed) copy of libguestfs.

Libvirt is now required to build virt-v2v.  Additionally you will
require the OCaml bindings to libvirt (https://libvirt.org/ocaml/),
although a copy is bundled for now (it will be removed later).
(Pino Toscano).

Libosinfo is required to build virt-v2v.  It is used to query
information about guest drivers.  (Pino Toscano).

Fixes for OCaml ≥ 4.10.  The minimum version of OCaml required is
still 4.01, but may be increased to 4.05 in future.

Test conversions of Debian 9 and Fedora 29 (Pino Toscano).

Various fixes to srcdir != builddir (Pino Toscano).

Remove gnulib modules not used by virt-v2v (Pino Toscano).

<a name="internals"></a>

### Internals

.IX Subsection "Internals"
When converting \s-1SUSE\s0 guests, always try to install \s-1QXL\s0 driver (Mike
Latimer).

Two new modules (Nbdkit and Nbdkit_sources) factor out generic nbdkit
operations and nbdkit source operations respectively.

Format Python code to comply with \s-1PEP 8 /\s0 pycodestyle (Pino Toscano).

Tests have been moved to the _tests/_ subdirectory, and manuals to
the _docs/_ subdirectory.

<a name="bugs-fixed"></a>

### Bugs fixed

.IX Subsection "Bugs fixed"

* https://bugzilla.redhat.com/1791802  
  .IX Item "https://bugzilla.redhat.com/1791802"
  virt-v2v does not install qemu-ga on \s-1EL8\s0 guest
* https://bugzilla.redhat.com/1791257  
  .IX Item "https://bugzilla.redhat.com/1791257"
  update-crypto-policies command example is incorrect in virt-v2v-input-xen
* https://bugzilla.redhat.com/1791240  
  .IX Item "https://bugzilla.redhat.com/1791240"
  [\s-1RFE\s0] Make the rhv-cafile optional
* https://bugzilla.redhat.com/1785528  
  .IX Item "https://bugzilla.redhat.com/1785528"
  Should remove info about Remove VMware tools from Windows guests\*(R" in virt-v2v-input-vmware man page
* https://bugzilla.redhat.com/1746699  
  .IX Item "https://bugzilla.redhat.com/1746699"
  Can't import guest from export domain to data domain on rhv4.3 due to error Invalid parameter: 'DiskType=1'\*(R"
* https://bugzilla.redhat.com/1733168  
  .IX Item "https://bugzilla.redhat.com/1733168"
  virt-v2v: Use scp -T in -i vmx -it ssh mode
* https://bugzilla.redhat.com/1723305  
  .IX Item "https://bugzilla.redhat.com/1723305"
  Delete info export PATH=/path/to/nbdkit-1.1.x:$PATH\*(R" in virt-v2v-input-vmware manual page
* https://bugzilla.redhat.com/1691659  
  .IX Item "https://bugzilla.redhat.com/1691659"
  virt-v2v should show a message when qemu-guest-agent is installed in guest successfully during conversion
* https://bugzilla.redhat.com/1690574  
  .IX Item "https://bugzilla.redhat.com/1690574"
  virt-v2v fails to import a guest while cannot find \`file_architecture\` for a file
* https://bugzilla.redhat.com/1680361  
  .IX Item "https://bugzilla.redhat.com/1680361"
  [v2v][\s-1RHV\s0][Scale] v2v Migration to \s-1RHV\s0 failed on timed out waiting for transfer to finalize
* https://bugzilla.redhat.com/1626503  
  .IX Item "https://bugzilla.redhat.com/1626503"
  Unable to maintain static \s-1IP\s0 address configuration post \s-1VM\s0 migration
* https://bugzilla.redhat.com/1612653  
  .IX Item "https://bugzilla.redhat.com/1612653"
  Guest has no disk after rhv-upload converting if target data domain has similar name with other data domain on rhv4.2
* https://bugzilla.redhat.com/1605242  
  .IX Item "https://bugzilla.redhat.com/1605242"
  Update nbdkit info for vddk in v2v man page
* https://bugzilla.redhat.com/1584678  
  .IX Item "https://bugzilla.redhat.com/1584678"
  On W2K12r2 rhev-apt does not run non-interactively, causing race when starting rhev-apt service from the command line
* https://bugzilla.redhat.com/1518539  
  .IX Item "https://bugzilla.redhat.com/1518539"
  Macvtap network will be lost during v2v conversion

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-v2v**\|(1).

Previous release notes covering virt-v2v can be found in the
libguestfs project: **guestfs-release-notes-1.40**\|(1).

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Daniel Erez

Richard W.M. Jones

Tomáš Golembiovský

Martin Kletzander

Mike Latimer

Nir Soffer

Pino Toscano

Ming Xie

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2009-2020 Red Hat Inc.

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
