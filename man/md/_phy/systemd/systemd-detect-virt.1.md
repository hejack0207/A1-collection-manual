# systemd\-detect\-virt(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-detect-virt - Detect execution in a virtualized environment

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-detect-virt&nbsp;'u systemd-detect-virt [OPTIONS...]
```

<a name="description"></a>

# Description


**systemd-detect-virt**
detects execution in a virtualized environment. It identifies the virtualization technology and can distinguish full machine virtualization from container virtualization.
systemd-detect-virt
exits with a return value of 0 (success) if a virtualization technology is detected, and non-zero (error) otherwise. By default, any type of virtualization is detected, and the options
**--container**
and
**--vm**
can be used to limit what types of virtualization are detected.

When executed without
**--quiet**
will print a short identifier for the detected virtualization technology. The following technologies are currently identified:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Known virtualization technologies (both VM, i.e. full hardware virtualization, and container, i.e. shared kernel virtualization)**
.TS
allbox tab(:);
lB lB lB.
T{
Type
T}:T{
ID
T}:T{
Product
T}
.T&
lt l l
^ l l
^ l l
^ l l
^ l l
^ l l
^ l l
^ l l
^ l l
^ l l
^ l l
^ l l
lt l l
^ l l
^ l l
^ l l
^ l l
^ l l.
T{
VM
T}:T{
_qemu_
T}:T{
QEMU software virtualization, without KVM
T}
:T{
_kvm_
T}:T{
Linux KVM kernel virtual machine, with whatever software, except Oracle Virtualbox
T}
:T{
_zvm_
T}:T{
s390 z/VM
T}
:T{
_vmware_
T}:T{
VMware Workstation or Server, and related products
T}
:T{
_microsoft_
T}:T{
Hyper-V, also known as Viridian or Windows Server Virtualization
T}
:T{
_oracle_
T}:T{
Oracle VM VirtualBox (historically marketed by innotek and Sun Microsystems), for legacy and KVM hypervisor
T}
:T{
_xen_
T}:T{
Xen hypervisor (only domU, not dom0)
T}
:T{
_bochs_
T}:T{
Bochs Emulator
T}
:T{
_uml_
T}:T{
User-mode Linux
T}
:T{
_parallels_
T}:T{
Parallels Desktop, Parallels Server
T}
:T{
_bhyve_
T}:T{
bhyve, FreeBSD hypervisor
T}
:T{
_qnx_
T}:T{
QNX hypervisor
T}
T{
Container
T}:T{
_openvz_
T}:T{
OpenVZ/Virtuozzo
T}
:T{
_lxc_
T}:T{
Linux container implementation by LXC
T}
:T{
_lxc-libvirt_
T}:T{
Linux container implementation by libvirt
T}
:T{
_systemd-nspawn_
T}:T{
systemds minimal container implementation, see **systemd-nspawn**(1)
T}
:T{
_docker_
T}:T{
Docker container manager
T}
:T{
_rkt_
T}:T{
rkt app container runtime
T}
.TE


If multiple virtualization solutions are used, only the "innermost" is detected and identified. That means if both machine and container virtualization are used in conjunction, only the latter will be identified (unless
**--vm**
is passed).

<a name="options"></a>

# Options


The following options are understood:

**-c**, **--container**
Only detects container virtualization (i.e. shared kernel virtualization).

**-v**, **--vm**
Only detects hardware virtualization).

**-r**, **--chroot**
Detect whether invoked in a
**chroot**(2)
environment. In this mode, no output is written, but the return value indicates whether the process was invoked in a
**chroot()**
environment or not.

**--private-users**
Detect whether invoked in a user namespace. In this mode, no output is written, but the return value indicates whether the process was invoked inside of a user namespace or not. See
**user\_namespaces**(7)
for more information.

**-q**, **--quiet**
Suppress output of the virtualization technology identifier.

**--list**
Output all currently known and detectable container and VM environments.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="exit-status"></a>

# Exit Status


If a virtualization technology is detected, 0 is returned, a non-zero code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-nspawn**(1),
**chroot**(2),
**namespaces**(7)
