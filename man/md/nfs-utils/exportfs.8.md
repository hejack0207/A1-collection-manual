# exportfs(8) - maintain table of exported NFS file systems

30 September 2013

```
/usr/sbin/exportfs [-avi] [-o options,..] [client:/path..]
/usr/sbin/exportfs -r [-v]
/usr/sbin/exportfs [-av] -u [client:/path..]
/usr/sbin/exportfs[-v]
/usr/sbin/exportfs -f
/usr/sbin/exportfs -s

```

<a name="description"></a>

# Description

An NFS server maintains a table of local physical file systems
that are accessible to NFS clients.
Each file system in this table is  referred to as an
_exported file system_,
or
_export_,
for short.

The
**exportfs**
command maintains the current table of exports for the NFS server.
The master export table is kept in a file named
_/var/lib/nfs/etab_.
This file is read by
**rpc.mountd**
when a client sends an NFS MOUNT request.

Normally the master export table is initialized with the contents of
_/etc/exports_
and files under
_/etc/exports.d_
by invoking
**exportfs -a**.
However, a system administrator can choose to add or delete
exports without modifying
_/etc/exports_
or files under
_/etc/exports.d_
by using the
**exportfs**
command.

**exportfs**
and its partner program
**rpc.mountd**
work in one of two modes: a legacy mode which applies to 2.4 and
earlier versions of the Linux kernel, and a new mode which applies to
2.6 and later versions, providing the
**nfsd**
virtual filesystem has been mounted at
_/proc/fs/nfsd_
or
_/proc/fs/nfs_.
On 2.6 kernels, if this filesystem is not mounted, the legacy mode is used.

In the new mode,
**exportfs**
does not give any information to the kernel, but provides it only to
**rpc.mountd**
through the
_/var/lib/nfs/etab_
file.
**rpc.mountd**
then manages kernel requests for information about exports, as needed.

In the legacy mode,
exports which identify a specific host, rather than a subnet or netgroup,
are entered directly into the kernel's export table,
as well as being written to
_/var/lib/nfs/etab_.
Further, exports listed in
_/var/lib/nfs/rmtab_
which match a non host-specific export request will cause an
appropriate export entry for the host given in
_rmtab_
to be added to the kernel's export table.

<a name="options"></a>

# Options


* **-d kind  or  --debug kind**  
  Turn on debugging. Valid kinds are: all, auth, call, general and parse.
  Debugging can also be turned on by setting
  **debug=**
  in the
  **[exportfs]**
  section of
  _/etc/nfs.conf_.
  
* **-a**  
  Export or unexport all directories.
* **-o **_options,..._  
  Specify a list of export options in the same manner as in
  **exports**(5).
* **-i**  
  Ignore the
  _/etc/exports_
  file and files under
  _/etc/exports.d_
  directory.  Only default options and options given on the command line are used.
* **-r**  
  Reexport all directories, synchronizing
  _/var/lib/nfs/etab_
  with
  _/etc/exports_
  and files under 
  _/etc/exports.d_.
  This option removes entries in
  _/var/lib/nfs/etab_
  which have been deleted from
  _/etc/exports_
  or files under
  _/etc/exports.d_,
  and removes any entries from the
  kernel export table which are no longer valid.
* **-u**  
  Unexport one or more directories.
* **-f**  
  If
  _/proc/fs/nfsd_
  or
  _/proc/fs/nfs_
  is mounted, flush everything out of the kernel's export table.
  Fresh entries for active clients are added to the kernel's export table by
  **rpc.mountd**
  when they make their next NFS mount request.
* **-v**  
  Be verbose. When exporting or unexporting, show what's going on. When
  displaying the current export list, also display the list of export
  options.
* **-s**  
  Display the current export list suitable for /etc/exports.
  

<a name="configuration-file"></a>

# Configuration File

The
**[exportfs]**
section of the
_/etc/nfs.conf_
configuration file can contain a
**debug**
value, which can be one or more from the list
**general**,
**call**,
**auth**,
**parse**,
**all**.
When a list is given, the members should be comma-separated.

**exportfs**
will also recognize the
**state-directory-path**
value from the
**[mountd]**
section.


<a name="discussion"></a>

# Discussion


<a name="exporting-directories"></a>

### Exporting Directories

The first synopsis shows how to invoke
**exportfs**
when adding new entries to the export table.  When using
**exportfs -a**,
all exports listed in
_/etc/exports_
and files under
_/etc/exports.d_
are added to
_/var/lib/nfs/etab_.
The kernel's export table is also updated as needed.

The
_host:/path_
argument specifies a local directory to export,
along with the client or clients who are permitted to access it.
See
**exports(5)**
for a description of supported options and access list formats.

IPv6 presentation addresses contain colons, which are already used
to separate the "host" and "path" command line arguments.
When specifying a client using a raw IPv6 address,
enclose the address in square brackets.
For IPv6 network addresses, place the prefix just after the closing
bracket.

To export a directory to the world, simply specify
_:/path_.

The export options for a particular host/directory pair derive from
several sources.
The default export options are
**sync,ro,root_squash,wdelay**.
These can be overridden by entries in
_/etc/exports_
or files under
_/etc/exports.d_.

A system administrator may override options from these sources using the
**-o**
command-line option on
**exportfs**.
This option takes a comma-separated list of options in the same fashion
as one would specify them in
_/etc/exports_.
In this way
**exportfs**
can be used to modify the export options of an already exported directory.

<a name="unexporting-directories"></a>

### Unexporting Directories

The third synopsis shows how to unexport a currently exported directory.
When using
**exportfs -ua**,
all entries listed in
_/var/lib/nfs/etab_
are removed from the kernel export tables, and the file is cleared. This
effectively shuts down all NFS activity.

To remove an export, specify a
_host:/path_
pair. This deletes the specified entry from
_/var/lib/nfs/etab_
and removes the corresponding kernel entry (if any).


<a name="dumping-the-export-table"></a>

### Dumping the Export Table

Invoking
**exportfs**
without options shows the current list of exported file systems.
Adding the
**-v**
option causes
**exportfs**
to display the export options for each export.

<a name="examples"></a>

# Examples

The following adds all directories listed in
_/etc/exports_
and files under
_/etc/exports.d_
to
_/var/lib/nfs/etab_
and pushes the resulting export entries into the kernel:

    "# exportfs -a

To export the
_/usr/tmp_
directory to host
**django**,
allowing insecure file locking requests from clients:

    "# exportfs -o insecure_locks django:/usr/tmp

To unexport the
_/usr/tmp_
directory:

    "# exportfs -u django:/usr/tmp

To unexport all exports listed in
_/etc/exports_
and files under
_/etc/exports.d_:

    "# exportfs -au

To export the
_/usr/tmp_
directory to IPv6 link-local clients:

    "# exportfs [fe80::]/64:/usr/tmp

<a name="usage-notes"></a>

# Usage Notes

Exporting to IP networks or DNS and NIS domains does not enable clients
from these groups to access NFS immediately.
Rather, these sorts of exports are hints to
**rpc.mountd**(8)
to grant any mount requests from these clients.
This is usually not a problem, because any existing mounts are preserved in
_rmtab_
across reboots.

When unexporting a network or domain entry, any current exports to members
of this group will be checked against the remaining valid exports and
if they themselves are no longer valid they will be removed.

<a name="files"></a>

# Files


* _/etc/exports_  
  input file listing exports, export options, and access control lists
* _/etc/exports.d_  
  directory where extra input files are stored.
  **Note:**
  only files that end with 
  _.exports_
  are used.
* _/var/lib/nfs/etab_  
  master table of exports
* _/var/lib/nfs/rmtab_  
  table of clients accessing server's exports

<a name="see-also"></a>

# See Also

**exports**(5),
**nfs.conf**(5),
**rpc.mountd**(8),
**netgroup**(5)

<a name="authors"></a>

# Authors

Olaf Kirch &lt;[okir@monad.swb](mailto:okir@monad.swb).de&gt;  
Neil Brown &lt;[neilb@cse.unsw](mailto:neilb@cse.unsw).edu.au&gt;
