# cgroup_namespaces(7) - overview of Linux cgroup namespaces

Linux, 2017-09-15


<a name="description"></a>

# Description

For an overview of namespaces, see
**namespaces**(7).

Cgroup namespaces virtualize the view of a process's cgroups (see
**cgroups**(7))
as seen via
_/proc/[pid]/cgroup_
and
_/proc/[pid]/mountinfo_.

Each cgroup namespace has its own set of cgroup root directories.
These root directories are the base points for the relative
locations displayed in the corresponding records in the
_/proc/[pid]/cgroup_
file.
When a process creates a new cgroup namespace using
**clone**(2)
or
**unshare**(2)
with the
**CLONE_NEWCGROUP**
flag, it enters a new cgroup namespace in which its current
cgroups directories become the cgroup root directories
of the new namespace.
(This applies both for the cgroups version 1 hierarchies
and the cgroups version 2 unified hierarchy.)

When viewing
_/proc/[pid]/cgroup_,
the pathname shown in the third field of each record will be
relative to the reading process's root directory
for the corresponding cgroup hierarchy.
If the cgroup directory of the target process lies outside
the root directory of the reading process's cgroup namespace,
then the pathname will show
_../_
entries for each ancestor level in the cgroup hierarchy.

The following shell session demonstrates the effect of creating
a new cgroup namespace.
First, (as superuser) we create a child cgroup in the
_freezer_
hierarchy, and put the shell into that cgroup:

.in +4n
.EX
# **mkdir -p /sys/fs/cgroup/freezer/sub**
# **echo $$**                      # Show PID of this shell
30655
# **sh -c 'echo 30655 &gt; /sys/fs/cgroup/freezer/sub/cgroup.procs'**
# **cat /proc/self/cgroup | grep freezer**
7:freezer:/sub
.EE
.in

Next, we use
**unshare**(1)
to create a process running a new shell in new cgroup and mount namespaces:

.EX
.in +4n
# **unshare -Cm bash**
.in
.EE

We then inspect the
_/proc/[pid]/cgroup_
files of, respectively, the new shell process started by the
**unshare**(1)
command, a process that is in the original cgroup namespace
(_init_,
with PID 1), and a process in a sibling cgroup
(_sub2_):

.EX
.in +4n
$ **cat /proc/self/cgroup | grep freezer**
7:freezer:/
$ **cat /proc/1/cgroup | grep freezer**
7:freezer:/..
$ **cat /proc/20124/cgroup | grep freezer**
7:freezer:/../sub2
.in
.EE

From the output of the first command,
we see that the freezer cgroup membership of the new shell
(which is in the same cgroup as the initial shell)
is shown defined relative to the freezer cgroup root directory
that was established when the new cgroup namespace was created.
(In absolute terms,
the new shell is in the
_/sub_
freezer cgroup,
and the root directory of the freezer cgroup hierarchy
in the new cgroup namespace is also
_/sub_.
Thus, the new shell's cgroup membership is displayed as '/'.)

However, when we look in
_/proc/self/mountinfo_
we see the following anomaly:

.EX
.in +4n
# **cat /proc/self/mountinfo | grep freezer**
155 145 0:32 /.. /sys/fs/cgroup/freezer ...
.in
.EE

The fourth field of this line
(_/.._)
should show the
directory in the cgroup filesystem which forms the root of this mount.
Since by the definition of cgroup namespaces, the process's current
freezer cgroup directory became its root freezer cgroup directory,
we should see '/' in this field.
The problem here is that we are seeing a mount entry for the cgroup
filesystem corresponding to our initial shell process's cgroup namespace
(whose cgroup filesystem is indeed rooted in the parent directory of
_sub_).
We need to remount the freezer cgroup filesystem
inside this cgroup namespace, after which we see the expected results:

.EX
.in +4n
# **mount --make-rslave /**     # Don't propagate mount events
                            # to other namespaces
# **umount /sys/fs/cgroup/freezer**
# **mount -t cgroup -o freezer freezer /sys/fs/cgroup/freezer**
# **cat /proc/self/mountinfo | grep freezer**
155 145 0:32 / /sys/fs/cgroup/freezer rw,relatime ...
.in
.EE

Use of cgroup namespaces requires a kernel that is configured with the
**CONFIG_CGROUPS**
option.


<a name="conforming-to"></a>

# Conforming to

Namespaces are a Linux-specific feature.

<a name="notes"></a>

# Notes

Among the purposes served by the
virtualization provided by cgroup namespaces are the following:

* *  
  It prevents information leaks whereby cgroup directory paths outside of
  a container would otherwise be visible to processes in the container.
  Such leakages could, for example,
  reveal information about the container framework
  to containerized applications.
* *  
  It eases tasks such as container migration.
  The virtualization provided by cgroup namespaces
  allows containers to be isolated from knowledge of
  the pathnames of ancestor cgroups.
  Without such isolation, the full cgroup pathnames (displayed in
  _/proc/self/cgroups_)
  would need to be replicated on the target system when migrating a container;
  those pathnames would also need to be unique,
  so that they don't conflict with other pathnames on the target system.
* *  
  It allows better confinement of containerized processes,
  because it is possible to mount the container's cgroup filesystems such that
  the container processes can't gain access to ancestor cgroup directories.
  Consider, for example, the following scenario:
    * ·  
      We have a cgroup directory,
      _/cg/1_,
      that is owned by user ID 9000.
    * ·  
      We have a process,
      _X_,
      also owned by user ID 9000,
      that is namespaced under the cgroup
      _/cg/1/2_
      (i.e.,
      _X_
      was placed in a new cgroup namespace via
      **clone**(2)
      or
      **unshare**(2)
      with the
      **CLONE_NEWCGROUP**
      flag).
* In the absence of cgroup namespacing, because the cgroup directory
  _/cg/1_
  is owned (and writable) by UID 9000 and process
  _X_
  is also owned by user ID 9000, then process
  _X_
  would be able to modify the contents of cgroups files
  (i.e., change cgroup settings) not only in
  _/cg/1/2_
  but also in the ancestor cgroup directory
  _/cg/1_.
  Namespacing process
  _X_
  under the cgroup directory
  _/cg/1/2_,
  in combination with suitable mount operations
  for the cgroup filesystem (as shown above),
  prevents it modifying files in
  _/cg/1_,
  since it cannot even see the contents of that directory
  (or of further removed cgroup ancestor directories).
  Combined with correct enforcement of hierarchical limits,
  this prevents process
  _X_
  from escaping the limits imposed by ancestor cgroups.

<a name="see-also"></a>

# See Also

**unshare**(1),
**clone**(2),
**setns**(2),
**unshare**(2),
**proc**(5),
**cgroups**(7),
**credentials**(7),
**namespaces**(7),
**user_namespaces**(7)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
