# virt-v2v-input-xen(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v-input-xen - Using virt-v2v to convert guests from Xen

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 4  export LIBGUESTFS_BACKEND=direct  virt-v2v -ic xen+ssh://root@xen.example.com\*(Aq           -ip passwordfile           GUEST_NAME [-o* options] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This page documents how to use **virt-v2v**\|(1) to convert guests from
\s-1RHEL 5\s0 Xen, or \s-1SLES\s0 and OpenSUSE Xen hosts.

<a name="input-from-xen"></a>

# Input from Xen

.IX Header "INPUT FROM XEN"

<a name="s-1sshs0-authentication"></a>

### \s-1SSH\s0 authentication

.IX Subsection "SSH authentication"
You can use \s-1SSH\s0 password authentication, by supplying the name of a
file containing the password to the _-ip_ option (note this option
does _not_ take the password directly).

If you are not using password authentication, an alternative is to use
ssh-agent, and add your ssh public key to
_/root/.ssh/authorized\_keys_ (on the Xen host).  After doing this,
you should check that passwordless access works from the virt-v2v
server to the Xen host.  For example:

.Vb 2
 $ ssh root@xen.example.com
 [ logs straight into the shell, no password is requested ]
.Ve

With some modern ssh implementations, legacy crypto policies required
to interoperate with \s-1RHEL 5\s0 sshd are disabled.  To enable them you may
need to run this command on the conversion server (ie. ssh client),
but read **update-crypto-policies**\|(8) first:

.Vb 1
 # update-crypto-policies --set LEGACY
.Ve

<a name="test-libvirt-connection-to-remote-xen-host"></a>

### Test libvirt connection to remote Xen host

.IX Subsection "Test libvirt connection to remote Xen host"
Use the **virsh**\|(1) command to list the guests on the remote Xen host:

.Vb 5
 $ virsh -c xen+ssh://root@xen.example.com list --all
  Id    Name                           State
 ----------------------------------------------------
  0     Domain-0                       running
  -     rhel49-x86_64-pv               shut off
.Ve

You should also try dumping the metadata from any guest on your
server, like this:

.Vb 5
 $ virsh -c xen+ssh://root@xen.example.com dumpxml rhel49-x86_64-pv
 &lt;domain type=xen\*(Aq&gt;
   &lt;name&gt;rhel49-x86_64-pv&lt;/name&gt;
   [...]
 &lt;/domain&gt;
.Ve

If the above commands do not work, then virt-v2v is not going to
work either.  Fix your libvirt configuration or the remote server
before continuing.

**If the guest disks are located on a host block device**, then the
conversion will fail.  See Xen or ssh conversions from block devices\*(R"
below for a workaround.

<a name="importing-a-guest"></a>

### Importing a guest

.IX Subsection "Importing a guest"
To import a particular guest from a Xen server, do:

.Vb 4
 $ LIBGUESTFS_BACKEND=direct \e
       virt-v2v -ic xen+ssh://root@xen.example.com\*(Aq \e
           rhel49-x86_64-pv \e
           -o local -os /var/tmp
.Ve

where \f(CW`rhel49-x86\_64-pv\*(C' is the name of the guest (which must be shut
down).

In this case the output flags are set to write the converted guest to
a temporary directory as this is just an example, but you can also
write to libvirt or any other supported target.

Setting the backend to \f(CW`direct\*(C' is a temporary
workaround until
libvirt bug 1140166 is fixed.

<a name="xen-or-ssh-conversions-from-block-devices"></a>

### Xen or ssh conversions from block devices

.IX Subsection "Xen or ssh conversions from block devices"
Currently virt-v2v cannot directly access a Xen guest (or any guest
located remotely over ssh) if that guest’s disks are located on host
block devices.

To tell if a Xen guest uses host block devices, look at the guest \s-1XML.\s0
You will see:

.Vb 3
  &lt;disk type=block\*(Aq device=\*(Aqdisk\*(Aq&gt;
    ...
    &lt;source dev=/dev/VG/guest\*(Aq/&gt;
.Ve

where \f(CW`type=\*(Aqblock\*(Aq\*(C', \f(CW\*(C\`source dev=\*(C' and \f(CW\*(C\`/dev/...\*(C' are all
indications that the disk is located on a host block device.

This happens because the qemu ssh block driver that we use to access
remote disks uses the ssh sftp protocol, and this protocol cannot
correctly detect the size of host block devices.

The workaround is to copy the guest over to the conversion server,
using the separate **virt-v2v-copy-to-local**\|(1) tool, followed by
running virt-v2v.  You will need sufficient space on the conversion
server to store a full copy of the guest.

.Vb 3
 virt-v2v-copy-to-local -ic xen+ssh://root@xen.example.com guest
 virt-v2v -i libvirtxml guest.xml -o local -os /var/tmp
 rm guest.xml guest-disk*
.Ve

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
