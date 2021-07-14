# nfs.systemd(7) - managing NFS services through systemd.

```
nfs-utils.service
nfs-server.service
nfs-client.target
etc
```

<a name="description"></a>

# Description

The
_nfs-utils_
package provides a suite of
_systemd_
unit files which allow the various services to be started and
managed.  These unit files ensure that the services are started in the
correct order, and the prerequisites are active before dependant
services start.  As there are quite  few unit files, it is not
immediately obvious how best to achieve certain results.  The
following subsections attempt to cover the issues that are most likely
to come up.

<a name="configuration"></a>

### Configuration

The standard systemd unit files do not provide any easy way to pass
any command line arguments to daemons so as to configure their
behavior.  In many case such configuration can be performed by making
changes to
_/etc/nfs.conf_
or other configuration files.  When that is not convenient, a
distribution might provide systemd "drop-in" files which replace the
**ExecStart=**
setting to start the program with different arguments.  For example a
drop-in file
**systemd/system/nfs-mountd.service.d/local.conf**
containing
    [Service]
    EnvironmentFile=/etc/sysconfig/nfs
    ExecStart=
    ExecStart= /usr/sbin/rpc.mountd $RPCMOUNTDOPTS
would cause the
**nfs-mountd.service**
unit to run the
_rpc.mountd_
program using, for arguments, the value given for
**RPCMOUNTDOPTS**
in
_/etc/sysconfig/nfs_.
This allows for seamless integration with existing configuration
tools.

<a name="enabling-unit-files"></a>

### Enabling unit files

There are three unit files which are designed to be manually enabled.
All others are automatically run as required.  The three are:

* **nfs-client.target**  
  This should be enabled on any host which ever serves as an NFS client.
  There is little cost in transparently enabling it whenever NFS client
  software is installed.
* **nfs-server.service**  
  This must be enabled to provide NFS service to clients.  It starts and
  configures the required daemons in the required order.
* **nfs-blkmap.service**  
  The
  **blkmapd**
  daemon is only required on NFS clients which are using pNFS (parallel
  NFS), and particularly using the
  **blocklayout**
  layout protocol.  If you might use this particular extension to NFS,
  the
  **nfs-blkmap.service**
  unit should be enabled.

Several other units which might be considered to be optional, such as
_rpc-gssd.service_
are careful to only start if the required configuration file exists.
_rpc-gssd.service_
will not start if the
_krb5.keytab_
file does not exist (typically in
_/etc_).

<a name="restarting-nfs-services"></a>

### Restarting NFS services

Most NFS daemons can be restarted at any time.  They will reload any
state that they need, and continue servicing requests.  This is rarely
necessary though.

When configuration changesare make, it can be hard to know exactly
which services need to be restarted to ensure that the configuration
takes effect.  The simplest approach, which is often the best, is to
restart everything.  To help with this, the
**nfs-utils.service**
unit is provided.  It declares appropriate dependencies with other
unit files so that
**systemctl restart nfs-utils**
will restart all NFS daemons that are running.  This will cause all
configuration changes to take effect
_except_
for changes to mount options lists in
_/etc/fstab_
or
_/etc/nfsmount.conf_.
Mount options can only be changed by unmounting and remounting
filesystem.  This can be a disruptive operation so it should only be
done when the value justifies the cost.  The command
**umount -a -t nfs; mount -a -t nfs**
should unmount and remount all NFS filesystems.

<a name="masking-unwanted-services"></a>

### Masking unwanted services

Rarely there may be a desire to prohibit some services from running
even though there are normally part of a working NFS system.  This may
be needed to reduce system load to an absolute minimum, or to reduce
attack surface by not running daemons that are not absolutely
required.

Three particular services which this can apply to are
_rpcbind_,
_idmapd_,
and
_rpc-gssd_.
_rpcbind_
is not part of the
_nfs-utils_
package, but it used by several NFS services.  However it is
**not**
needed when only NFSv4 is in use.  If a site will never use NFSv3 (or
NFSv2) and does not want
_rpcbind_
to be running, the correct approach is to run
**systemctl mask rpcbind**
This will disable
_rpcbind_,
and the various NFS services which depend on it (and are only needed
for NFSv3) will refuse to start, without interfering with the
operation of NFSv4 services.  In particular,
_rpc.statd_
will not run when
_rpcbind_
is masked.

_idmapd_
is only needed for NFSv4, and even then is not needed when the client
and server agree to use user-ids rather than user-names to identify the
owners of files.  If
_idmapd_
is not needed and not wanted, it can be masked with
**systemctl mask idmapd**
_rpc-gssd_
is assumed to be needed if the
_krb5.keytab_
file is present.  If a site needs this file present but does not want
_rpc-gssd_
running, it can be masked with
**systemctl mask rpc-gssd**

<a name="files"></a>

# Files

/etc/nfs.conf  
/etc/nfsmount.conf  
/etc/idmapd.conf

<a name="see-also"></a>

# See Also

**systemd.unit**(5),
**nfs.conf**(5),
**nfsmount.conf**(5).
