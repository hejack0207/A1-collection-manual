# nfsmount.conf(5) - Configuration file for NFS mounts

9 October 2012

```
Configuration file for NFS mounts that allows options to be set globally, per server or per mount point.
```

<a name="description"></a>

# Description

The configuration file is made up of multiple sections 
followed by variables associated with that section.
A section is defined by a string enclosed by 
**[**
and 
**]**
branches.
Variables are assignment statements that assign values 
to particular variables using the  
**=**
operator, as in 
**Proto=Tcp**.
The variables that can be assigned are exactly the set of NFS specific
mount options listed in
**nfs**(5).

Sections are broken up into three basic categories:
Global options, Server options and Mount Point options.
.HP
**[ NFSMount_Global_Options ]**
- This statically named section
defines all of the global mount options that can be 
applied to every NFS mount.
.HP
**[ Server “Server_Name” ]**
- This section defines all the mount options that should 
be used on mounts to a particular NFS server. The 
_“Server_Name”_
strings needs to be surrounded by '“' and 
be an exact match of the server name used in the 
**mount**
command. 
.HP
**[ MountPoint “Mount_Point” ]**
- This section defines all the mount options that 
should be used on a particular mount point.
The 
_“Mount_Point”_
string needs to be surrounded by '“' and be an 
exact match of the mount point used in the 
**mount**
command.

<a name="examples"></a>

# Examples


These are some example lines of how sections and variables
are defined in the configuration file.

[ NFSMount_Global_Options ]  
    Proto=Tcp
.HP
The TCP/IPv4 protocol will be used on every NFS mount.
.HP
[ Server “nfsserver.foo.com” ]  
    rsize=32k  
    wsize=32k  
    proto=udp6
.HP
A 32k (32768 bytes) block size will be used as the read and write
size on all mounts to the 'nfsserver.foo.com' server.  UDP/IPv6
is the protocol to be used.
.HP

[ MountPoint “/export/home” ]  
    Background=True
.HP
All mounts to the '/export/home' export will be performed in
the background (i.e. done asynchronously).
.HP

<a name="files"></a>

# Files


* _/etc/nfsmount.conf_  
  Default NFS mount configuration file

<a name="see-also"></a>

# See Also

**nfs**(5),
**mount**(8),
