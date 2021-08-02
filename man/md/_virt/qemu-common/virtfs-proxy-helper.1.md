# virtfs-proxy-helper.1(1)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

virtfs-proxy-helper - QEMU 9p virtfs proxy filesystem helper

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" virtfs-proxy-helper options
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Pass-through security model in \s-1QEMU\s0 9p server needs root privilege to do
few file operations (like chown, chmod to any mode/uid:gid).  There are two
issues in pass-through security model
.Sp
1) \s-1TOCTTOU\s0 vulnerability: Following symbolic links in the server could
provide access to files beyond 9p export path.
.Sp
2) Running \s-1QEMU\s0 with root privilege could be a security issue.
.Sp
To overcome above issues, following approach is used: A new filesystem
type 'proxy' is introduced. Proxy \s-1FS\s0 uses chroot + socket combination
for securing the vulnerability known with following symbolic links.
Intention of adding a new filesystem type is to allow qemu to run
in non-root mode, but doing privileged operations using socket \s-1IO.\s0
.Sp
Proxy helper(a stand alone binary part of qemu) is invoked with
root privileges. Proxy helper chroots into 9p export path and creates
a socket pair or a named socket based on the command line parameter.
\s-1QEMU\s0 and proxy helper communicate using this socket. \s-1QEMU\s0 proxy fs
driver sends filesystem request to proxy helper and receives the
response from it.
.Sp
The proxy helper is designed so that it can drop root privileges except
for the capabilities needed for doing filesystem operations.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The following options are supported:

* **-h**  
  .IX Item "-h"
  Display help and exit
* **-p|--path path**  
  .IX Item "-p|--path path"
  Path to export for proxy filesystem driver
* **-f|--fd socket-id**  
  .IX Item "-f|--fd socket-id"
  Use given file descriptor as socket descriptor for communicating with
  qemu proxy fs drier. Usually a helper like libvirt will create
  socketpair and pass one of the fds as parameter to -f|--fd
* **-s|--socket socket-file**  
  .IX Item "-s|--socket socket-file"
  Creates named socket file for communicating with qemu proxy fs driver
* **-u|--uid uid -g|--gid gid**  
  .IX Item "-u|--uid uid -g|--gid gid"
  uid:gid combination to give access to named socket file
* **-n|--nodaemon**  
  .IX Item "-n|--nodaemon"
  Run as a normal program. By default program will run in daemon mode

<a name="author"></a>

# Author

.IX Header "AUTHOR"
M. Mohan Kumar
