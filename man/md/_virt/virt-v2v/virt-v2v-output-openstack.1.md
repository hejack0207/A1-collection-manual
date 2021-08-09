# virt-v2v-output-openstack(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v-output-openstack - Using virt-v2v to convert guests to OpenStack

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 5  virt-v2v [-i* options] -o openstack                         -oo server-id=SERVER                         [-oo guest-id=GUEST]                         [-oo verify-server-certificate=false]                         [-oo os-username=admin] [-oo os-*=*]   virt-v2v [-i* options] -o glance .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This page documents how to use **virt-v2v**\|(1) to convert guests to run
on OpenStack.  There are two output modes you can select, but only
_-o openstack_ should be used normally.

* **-o openstack** **-oo server-id=**\s-1SERVER\s0 [...]  
  .IX Item "-o openstack -oo server-id=SERVER [...]"
  Full description: \s-1OUTPUT TO OPENSTACK\*(R"\s0
  .Sp
  This is the modern method for uploading to OpenStack via the \s-1REST API.\s0
  Guests can be directly converted into Cinder volumes.
* **-o glance**  
  .IX Item "-o glance"
  Full description: \s-1OUTPUT TO GLANCE\*(R"\s0
  .Sp
  This is the old method for uploading to Glance.  Unfortunately Glance
  is not well suited to storing converted guests (since virt-v2v deals
  with pets\*(R" not templated \*(L"cattle\*(R"), so this method is not recommended
  unless you really know what you are doing.

<a name="output-to-openstack"></a>

# Output to Openstack

.IX Header "OUTPUT TO OPENSTACK"
To output to OpenStack, use the _-o openstack_ option.

<a name="openstack-setting-up-a-conversion-appliance"></a>

### OpenStack: Setting up a conversion appliance

.IX Subsection "OpenStack: Setting up a conversion appliance"
When virt-v2v is converting to OpenStack, it is unusual in that
virt-v2v **must** be running inside a virtual machine running on top of
the OpenStack overcloud.  This virtual machine is called the
conversion appliance\*(R".  Note this virtual machine is unrelated to the
guest which is being converted.

The reason for this is because to create Cinder volumes that will
contain the guest data (for the converted guest) we must attach those
Cinder volumes to an OpenStack virtual machine.

The \f(CW`openstack\*(C' command must be installed in the appliance.  We use
it for communicating with OpenStack.

When virt-v2v is running in the conversion appliance, you must supply
the name or \s-1UUID\s0 of the conversion appliance to virt-v2v, eg:

.Vb 6
 $ openstack server list
 +--------------------------------------+-----------+--------+
 | ID                                   | Name      | Status |
 +--------------------------------------+-----------+--------+
 | bbb0147a-44b9-4d19-9a9d-10ca9a984744 | test1     | ACTIVE |
 +--------------------------------------+-----------+--------+

 # virt-v2v [...] \e
       -o openstack -oo server-id=bbb0147a-44b9-4d19-9a9d-10ca9a984744
.Ve

or:

.Vb 1
 # virt-v2v [...] -o openstack -oo server-id=test1
.Ve

You can run many parallel conversions inside a single conversion
appliance if you want, subject to having enough resources available.
However OpenStack itself imposes a limit that you should be aware of:
OpenStack cannot attach more than around 25 disks [the exact number
varies with configuration] to a single appliance, and that limits the
number of guests which can be converted in parallel, because each
guest's disk must be attached to the appliance while being copied.

<a name="openstack-authentication"></a>

### OpenStack: Authentication

.IX Subsection "OpenStack: Authentication"
Converting to OpenStack requires access to the tenant (non-admin) \s-1API\s0
endpoints.  You will need to either set up your \f(CW`$OS\_*\*(C' environment
variables or use output options on the virt-v2v command line to
authenticate with OpenStack.

Normally there is a file called \f(CW`overcloudrc\*(C' or \f(CW\*(C\`keystonerc\_admin\*(C'
which you can simply \f(CW`source\*(C' to set everything up.

For example:

.Vb 1
 export OS_USERNAME=admin
.Ve

or:

.Vb 1
 virt-v2v [...] -o openstack -oo os-username=admin
.Ve

are equivalent, and have the same effect as using _--os-username_ on
the command line of OpenStack tools.

<a name="openstack-running-as-root"></a>

### OpenStack: Running as root

.IX Subsection "OpenStack: Running as root"
Because virt-v2v must access Cinder volumes which are presented as
_/dev_ devices to the conversion appliance, virt-v2v must usually run
as root in _-o openstack_ mode.

If you use \f(CW`sudo\*(C' to start virt-v2v and you are using environment
variables for authentication, remember to use the \f(CW`sudo -E\*(C' option to
preserve the environment.

<a name="openstack-guest-s-1ids0"></a>

### OpenStack: Guest \s-1ID\s0

.IX Subsection "OpenStack: Guest ID"
.Vb 1
 virt-v2v [...] -o openstack -oo guest-id=123-456-7890
.Ve

You may optionally specify _-oo guest-id=..._ on the command line.
The \s-1ID\s0 (which can be any string) is saved on each Cinder volume in the
\f(CW`virt\_v2v\_guest\_id\*(C' volume property.

This can be used to find disks associated with a guest, or to
associate which disks are related to which guests when converting many
guests.

<a name="openstack-ignore-server-certificate"></a>

### OpenStack: Ignore server certificate

.IX Subsection "OpenStack: Ignore server certificate"
Using _-oo verify-server-certificate=false_ you can tell the
openstack client to ignore the server certificate when connecting to
the OpenStack \s-1API\s0 endpoints.  This has the same effect as passing the
_--insecure_ option to the \f(CW`openstack\*(C' command.

<a name="openstack-converting-a-guest"></a>

### OpenStack: Converting a guest

.IX Subsection "OpenStack: Converting a guest"
The final command to convert the guest, running as root, will be:

.Vb 2
 # virt-v2v [-i options ...] \e
       -o openstack -oo server-id=NAME|UUID [-oo guest-id=ID]
.Ve

If you include authentication options on the command line then:

.Vb 2
 # virt-v2v [-i options ...] \e
       -o openstack -oo server-id=NAME|UUID -oo os-username=admin [etc]
.Ve

<a name="openstack-booting-the-guest"></a>

### OpenStack: Booting the guest

.IX Subsection "OpenStack: Booting the guest"
Guests are converted as Cinder volume(s) (one volume per disk in the
original guest).  To boot them use the
\f(CW`openstack server create --volume\*(C' option:

.Vb 11
 $ openstack volume list
 +--------------------------------------+---------------+-----------+
 | ID                                   | Name          | Status    |
 +--------------------------------------+---------------+-----------+
 | c4d06d15-22ef-462e-9eff-ab54ab285a1f | fedora-27-sda | available |
 +--------------------------------------+---------------+-----------+
 $ openstack server create \e
       --flavor x1.small \e
       --volume c4d06d15-22ef-462e-9eff-ab54ab285a1f \e
       myguest
 $ openstack console url show myguest
.Ve

<a name="openstack-other-conversion-options"></a>

### OpenStack: Other conversion options

.IX Subsection "OpenStack: Other conversion options"
To specify the Cinder volume type, use _-os_.  If not specified then
no Cinder volume type is used.

The following options are **not** supported with OpenStack: _-oa_,
_-of_.

<a name="output-to-glance"></a>

# Output to Glance

.IX Header "OUTPUT TO GLANCE"
Note this is a legacy option.  In most cases you should use
\s-1OUTPUT TO OPENSTACK\*(R"\s0 instead.

To output to OpenStack Glance, use the _-o glance_ option.

This runs the **glance**\|(1) \s-1CLI\s0 program which must be installed on the
virt-v2v conversion host.  For authentication to work, you will need
to set \f(CW`OS\_*\*(C' environment variables.

Normally there is a file called \f(CW`overcloudrc\*(C' or \f(CW\*(C\`keystonerc\_admin\*(C'
which you can simply \f(CW`source\*(C' to set everything up.

Virt-v2v adds metadata for the guest to Glance, describing such things
as the guest operating system and what drivers it requires.  The
command \f(CW`glance image-show\*(C' will display the metadata as \*(L"Property\*(R"
fields such as \f(CW`os\_type\*(C' and \f(CW\*(C\`hw\_disk\_bus\*(C'.

<a name="glance-and-sparseness"></a>

### Glance and sparseness

.IX Subsection "Glance and sparseness"
Glance image upload doesn't appear to correctly handle sparseness.
For this reason, using qcow2 will be faster and use less space on the
Glance server.  Use the virt-v2v _-of qcow2_ option.

<a name="glance-and-multiple-disks"></a>

### Glance and multiple disks

.IX Subsection "Glance and multiple disks"
If the guest has a single disk, then the name of the disk in Glance
will be the name of the guest.  You can control this using the _-on_
option.

Glance doesn't have a concept of associating multiple disks with a
single guest, and Nova doesn't allow you to boot a guest from multiple
Glance disks either.  If the guest has multiple disks, then the first
(assumed to be the system disk) will have the name of the guest, and
the second and subsequent data disks will be called
\f(CW`\f(CIguestname\f(CW-disk2\*(C', \f(CW\*(C\`\f(CIguestname\f(CW-disk3\*(C' etc.  It may be best to
leave the system disk in Glance, and import the data disks to Cinder.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-v2v**\|(1),
https://docs.openstack.org/python-openstackclient/latest/cli/man/openstack.html,
**glance**\|(1).

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
