# virt-v2v-output-rhv(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v-output-rhv - Using virt-v2v to convert guests to oVirt or RHV

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 7  virt-v2v [-i* options] -o rhv-upload [-oc ENGINE_URL] -os STORAGE                         [-op PASSWORD] [-of raw]                         [-oo rhv-cafile=FILE]                         [-oo rhv-cluster=CLUSTER]                         [-oo rhv-direct]                         [-oo rhv-disk-uuid=UUID ...]                         [-oo rhv-verifypeer]   virt-v2v [-i* options] -o rhv -os [esd:/path|/path]   virt-v2v [-i* options] -o vdsm                         [-oo vdsm-image-uuid=UUID]                         [-oo vdsm-vol-uuid=UUID]                         [-oo vdsm-vm-uuid=UUID]                         [-oo vdsm-ovf-output=DIR] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This page documents how to use **virt-v2v**\|(1) to convert guests to an
oVirt or \s-1RHV\s0 management instance.  There are three output modes that
you can select, but only _-o rhv-upload_ should be used normally, the
other two are deprecated:

* **-o rhv-upload** **-os** \s-1STORAGE\s0  
  .IX Item "-o rhv-upload -os STORAGE"
  Full description: \s-1OUTPUT TO RHV\*(R"\s0
  .Sp
  This is the modern method for uploading to oVirt/RHV via the \s-1REST API.\s0
  It requires oVirt/RHV ≥ 4.2.
* **-o rhv** **-os** esd:/path  
  .IX Item "-o rhv -os esd:/path"
* **-o rhv** **-os** /path  
  .IX Item "-o rhv -os /path"
  Full description: \s-1OUTPUT TO EXPORT STORAGE DOMAIN\*(R"\s0
  .Sp
  This is the old method for uploading to oVirt/RHV via the
  Export Storage Domain (\s-1ESD\s0).  The \s-1ESD\s0 can either be accessed
  over \s-1NFS\s0 (using the _-os esd:/path_ form) or if you have
  already NFS-mounted it somewhere specify the path to the mountpoint
  as _-os /path_.
  .Sp
  The Export Storage Domain was deprecated in oVirt 4, and so we expect
  that this method will stop working at some point in the future.
* **-o vdsm**  
  .IX Item "-o vdsm"
  This is the old method used internally by the RHV-M user interface.
  It is never intended to be used directly by end users.

<a name="output-to-rhv"></a>

# Output to Rhv

.IX Header "OUTPUT TO RHV"
This new method to upload guests to oVirt or \s-1RHV\s0 directly via the \s-1REST
API\s0 requires oVirt/RHV ≥ 4.2.

You need to specify _-o rhv-upload_ as well as the following extra
parameters:
.ie n .IP "_-oc_ ""https://ovirt-engine.example.com/ovirt-engine/api""" 4
.el .IP "_-oc_ \f(CWhttps://ovirt-engine.example.com/ovirt-engine/api" 4
.IX Item "-oc https://ovirt-engine.example.com/ovirt-engine/api"
The \s-1URL\s0 of the \s-1REST API\s0 which is usually the server name with
\f(CW`/ovirt-engine/api\*(C' appended, but might be different if you installed
oVirt Engine on a different path.
.Sp
You can optionally add a username and port number to the \s-1URL.\s0  If the
username is not specified then virt-v2v defaults to using
\f(CW`admin@internal\*(C' which is the typical superuser account for oVirt
instances.

* _-of raw_  
  .IX Item "-of raw"
  Currently you must use _-of raw_ and you cannot use _-oa preallocated_.
  .Sp
  These restrictions will be loosened in a future version.
* _-op_ _password-file_  
  .IX Item "-op password-file"
  A file containing a password to be used when connecting to the oVirt
  engine.  Note the file should contain the whole password, without
  any trailing newline, and for security the file should have mode
  \f(CW0600 so that others cannot read it.
  .ie n .IP "_-os_ ""ovirt-data""" 4
  .el .IP "_-os_ \f(CWovirt-data" 4
  .IX Item "-os ovirt-data"
  The storage domain.
* _-oo rhv-cafile=__ca.pem_  
  .IX Item "-oo rhv-cafile=ca.pem"
  The _ca.pem_ file (Certificate Authority), copied from
  _/etc/pki/ovirt-engine/ca.pem_ on the oVirt engine.
  .Sp
  If _-oo rhv-verifypeer_ is enabled then this option can
  be used to control which \s-1CA\s0 is used to verify the client’s
  identity.  If this option is not used then the system’s
  global trust store is used.
  .ie n .IP "_-oo rhv-cluster=_""CLUSTERNAME""" 4
  .el .IP "_-oo rhv-cluster=_\f(CWCLUSTERNAME" 4
  .IX Item "-oo rhv-cluster=CLUSTERNAME"
  Set the \s-1RHV\s0 Cluster Name.  If not given it uses \f(CW`Default\*(C'.
  .ie n .IP "_-oo rhv-disk-uuid=_""UUID""" 4
  .el .IP "_-oo rhv-disk-uuid=_\f(CWUUID" 4
  .IX Item "-oo rhv-disk-uuid=UUID"
  This option can used to manually specify UUIDs for the disks when
  creating the virtual machine.  If not specified, the oVirt engine will
  generate random UUIDs for the disks.  Please note that:
    * ·  
      you **must** pass as many _-oo rhv-disk-uuid=UUID_ options as the
      amount of disks in the guest
    * ·  
      the specified UUIDs are used as they are, without checking whether
      they are already used by other disks
      .Sp
      This option is considered advanced, and to be used mostly in
      combination with _--no-copy_.
* _-oo rhv-direct_  
  .IX Item "-oo rhv-direct"
  If this option is given then virt-v2v will attempt to directly upload
  the disk to the oVirt node, otherwise it will proxy the upload through
  the oVirt engine.  Direct upload requires that you have network access
  to the oVirt nodes.  Non-direct upload is slightly slower but should
  work in all situations.
* _-oo rhv-verifypeer_  
  .IX Item "-oo rhv-verifypeer"
  Verify the oVirt/RHV server’s identity by checking the server‘s
  certificate against the Certificate Authority.

<a name="output-to-export-storage-domain"></a>

# Output to Export Storage Domain

.IX Header "OUTPUT TO EXPORT STORAGE DOMAIN"
This section only applies to the _-o rhv_ output mode.  If you use
virt-v2v from the RHV-M user interface, then behind the scenes the
import is managed by \s-1VDSM\s0 using the _-o vdsm_ output mode (which end
users should not try to use directly).

You have to specify _-o rhv_ and an _-os_ option that points to the
RHV-M Export Storage Domain.  You can either specify the \s-1NFS\s0 server
and mountpoint, eg. \f(CW`-os rhv-storage:/rhv/export\*(C', or you can
mount that first and point to the directory where it is mounted,
eg. \f(CW`-os /tmp/mnt\*(C'.  Be careful not to point to the Data Storage
Domain by accident as that will not work.

On successful completion virt-v2v will have written the new guest to
the Export Storage Domain, but it will not yet be ready to run.  It
must be imported into \s-1RHV\s0 using the \s-1UI\s0 before it can be used.

In \s-1RHV\s0 ≥ 2.2 this is done from the Storage tab.  Select the
export domain the guest was written to.  A pane will appear underneath
the storage domain list displaying several tabs, one of which is \s-1VM\s0
Import.  The converted guest will be listed here.  Select the
appropriate guest an click Import\*(R".  See the \s-1RHV\s0 documentation for
additional details.

If you export several guests, then you can import them all at the same
time through the \s-1UI.\s0

<a name="testing-s-1rhvs0-conversions"></a>

### Testing \s-1RHV\s0 conversions

.IX Subsection "Testing RHV conversions"
If you do not have an oVirt or \s-1RHV\s0 instance to test against, then you
can test conversions by creating a directory structure which looks
enough like a RHV-M Export Storage Domain to trick virt-v2v:

.Vb 8
 uuid=\\`uuidgen\\`
 mkdir /tmp/rhv
 mkdir /tmp/rhv/$uuid
 mkdir /tmp/rhv/$uuid/images
 mkdir /tmp/rhv/$uuid/master
 mkdir /tmp/rhv/$uuid/master/vms
 touch /tmp/rhv/$uuid/dom_md
 virt-v2v [...] -o rhv -os /tmp/rhv
.Ve

<a name="debugging-rhv-m-import-failures"></a>

### Debugging RHV-M import failures

.IX Subsection "Debugging RHV-M import failures"
When you export to the RHV-M Export Storage Domain, and then import
that guest through the RHV-M \s-1UI,\s0 you may encounter an import failure.
Diagnosing these failures is infuriatingly difficult as the \s-1UI\s0
generally hides the true reason for the failure.

There are several log files of interest:

* _/var/log/vdsm/import/_  
  .IX Item "/var/log/vdsm/import/"
  In oVirt ≥ 4.1.0, \s-1VDSM\s0 preserves the virt-v2v log file for
  30 days in this directory.
  .Sp
  This directory is found on the host which performed the conversion.
  The host can be selected in the import dialog, or can be found under
  the \f(CW`Events\*(C' tab in oVirt administration.
* _/var/log/vdsm/vdsm.log_  
  .IX Item "/var/log/vdsm/vdsm.log"
  As above, this file is present on the host which performed the
  conversion.  It contains detailed error messages from low-level
  operations executed by \s-1VDSM,\s0 and is useful if the error was not caused
  by virt-v2v, but by \s-1VDSM.\s0
* _/var/log/ovirt-engine/engine.log_  
  .IX Item "/var/log/ovirt-engine/engine.log"
  This log file is stored on the RHV-M server.  It contains more detail
  for any errors caused by the oVirt \s-1GUI.\s0

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-v2v**\|(1).

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones

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
