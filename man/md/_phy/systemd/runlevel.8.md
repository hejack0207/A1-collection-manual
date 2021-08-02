# runlevel(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

runlevel - Print previous and current SysV runlevel

<a name="synopsis"></a>

# Synopsis

```
.HP \w'runlevel&nbsp;'u runlevel [options...]
```

<a name="overview"></a>

# Overview


"Runlevels" are an obsolete way to start and stop groups of services used in SysV init. systemd provides a compatibility layer that maps runlevels to targets, and associated binaries like
**runlevel**. Nevertheless, only one runlevel can be "active" at a given time, while systemd can activate multiple targets concurrently, so the mapping to runlevels is confusing and only approximate. Runlevels should not be used in new code, and are mostly useful as a shorthand way to refer the matching systemd targets in kernel boot parameters.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Mapping between runlevels and systemd targets**
.TS
allbox tab(:);
lB lB.
T{
Runlevel
T}:T{
Target
T}
.T&
l l
l l
l l
l l
l l.
T{
0
T}:T{
poweroff.target
T}
T{
1
T}:T{
rescue.target
T}
T{
2, 3, 4
T}:T{
multi-user.target
T}
T{
5
T}:T{
graphical.target
T}
T{
6
T}:T{
reboot.target
T}
.TE


<a name="description"></a>

# Description


**runlevel**
prints the previous and current SysV runlevel if they are known.

The two runlevel characters are separated by a single space character. If a runlevel cannot be determined, N is printed instead. If neither can be determined, the word "unknown" is printed.

Unless overridden in the environment, this will check the utmp database for recent runlevel changes.

<a name="options"></a>

# Options


The following option is understood:

**--help**
Print a short help text and exit.

<a name="exit-status"></a>

# Exit Status


If one or both runlevels could be determined, 0 is returned, a non-zero failure code otherwise.

<a name="environment"></a>

# Environment


_$RUNLEVEL_
If
_$RUNLEVEL_
is set,
**runlevel**
will print this value as current runlevel and ignore utmp.

_$PREVLEVEL_
If
_$PREVLEVEL_
is set,
**runlevel**
will print this value as previous runlevel and ignore utmp.

<a name="files"></a>

# Files


/run/utmp
The utmp database
**runlevel**
reads the previous and current runlevel from.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.target**(5),
**systemctl**(1)
