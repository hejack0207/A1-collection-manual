# blkmapd(8) - pNFS block layout mapping daemon

11 August 2011

```
"blkmapd [-h] [-d] [-f]"
```

<a name="description"></a>

# Description

The
**blkmapd**
daemon performs device discovery and mapping for the parallel NFS (pNFS) block layout
client [RFC5663].

The pNFS block layout protocol builds a complex storage hierarchy from a set
of
_simple volumes._
These simple volumes are addressed by content, using a signature on the
volume to uniquely name each one.
The daemon locates a volume by examining each block device in the system for
the given signature.

The topology typically consists of a hierarchy of volumes built by striping,
slicing, and concatenating the simple volumes.
The
**blkmapd**
daemon uses the device-mapper driver to construct logical devices that
reflect the server topology, and passes these devices to the kernel for use
by the pNFS block layout client.

<a name="options"></a>

# Options


* **-h**  
  Display usage message.
* **-d**  
  Performs device discovery only then exits.
* **-f**  
  Runs
  **blkmapd**
  in the foreground and sends output to stderr (as opposed to syslogd)

<a name="configuration-file"></a>

# Configuration File

The
**blkmapd**
daemon recognizes the following value from the
**[general]**
section of the
_/etc/nfs.conf_
configuration file:

* **pipefs-directory**  
  Tells
  **blkmapd**
  where to look for the rpc_pipefs filesystem.  The default value is
  _/var/lib/nfs/rpc_pipefs_.

<a name="see-also"></a>

# See Also

**nfs**(5),
**dmsetup**(8),
**nfs.conf**(5)

RFC 5661 for the NFS version 4.1 specification.  
RFC 5663 for the pNFS block layout specification.

<a name="authors"></a>

# Authors
  
Haiying Tang &lt;[Tang_Haiying@emc.com](mailto:Tang_Haiying@emc.com)&gt;  
Jim Rees &lt;[rees@umich.edu](mailto:rees@umich.edu)&gt;
