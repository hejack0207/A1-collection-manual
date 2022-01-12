# dbus\-cleanup\-socke(1)

D\-Bus 1\&.12\&.20, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dbus-cleanup-sockets - clean up leftover sockets in a directory

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dbus-cleanup-sockets&nbsp;'u dbus-cleanup-sockets [DIRECTORY]

```


<a name="description"></a>

# Description


The
**dbus-cleanup-sockets**
command cleans up unused D-Bus connection sockets. See
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]
for more information about the big picture.

If given no arguments,
**dbus-cleanup-sockets**
cleans up sockets in the standard default socket directory for the per-user-login-session message bus; this is usually /tmp. Optionally, you can pass a different directory on the command line.

On Linux, this program is essentially useless, because D-Bus defaults to using "abstract sockets" that exist only in memory and dont have a corresponding file in /tmp.

On most other flavors of UNIX, its possible for the socket files to leak when programs using D-Bus exit abnormally or without closing their D-Bus connections. Thus, it might be interesting to run dbus-cleanup-sockets in a cron job to mop up any leaked sockets. Or you can just ignore the leaked sockets, they aren\*(Aqt really hurting anything, other than cluttering the output of "ls /tmp"

<a name="author"></a>

# Author


dbus-cleanup-sockets was adapted by Havoc Pennington from linc-cleanup-sockets written by Michael Meeks.

<a name="bugs"></a>

# Bugs


Please send bug reports to the D-Bus mailing list or bug tracker, see
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]
