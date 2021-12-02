# dbus\-uuidgen(1)

D\-Bus 1\&.12\&.20, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dbus-uuidgen - Utility to generate UUIDs

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dbus-uuidgen&nbsp;'u dbus-uuidgen [--version] [--ensure&nbsp;[=FILENAME]] [--get&nbsp;[=FILENAME]]

```


<a name="description"></a>

# Description


The
**dbus-uuidgen**
command generates or reads a universally unique ID.

Note that the D-Bus UUID has no relationship to RFC 4122 and does not generate UUIDs compatible with that spec. Many systems have a separate command for that (often called "uuidgen").

See
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]
for more information about D-Bus.

The primary usage of
**dbus-uuidgen**
is to run in the post-install script of a D-Bus package like this:

.if n \{.RS 4
.\}
      dbus-uuidgen --ensure
.if n \{.RE
.\}

This will ensure that /var/lib/dbus/machine-id exists and has the uuid in it. It wont overwrite an existing uuid, since this id should remain fixed for a single machine until the next reboot at least.

The important properties of the machine UUID are that 1) it remains unchanged until the next reboot and 2) it is different for any two running instances of the OS kernel. That is, if two processes see the same UUID, they should also see the same shared memory, UNIX domain sockets, local X displays, localhost.localdomain resolution, process IDs, and so forth.

If you run
**dbus-uuidgen**
with no options it just prints a new uuid made up out of thin air.

If you run it with --get, it prints the machine UUID by default, or the UUID in the specified file if you specify a file.

If you try to change an existing machine-id on a running system, it will probably result in bad things happening. Dont try to change this file. Also, don\*(Aqt make it the same on two different systems; it needs to be different anytime there are two different kernels running.

The UUID should be different on two different virtual machines, because there are two different kernels.

<a name="options"></a>

# Options


The following options are supported:

**--get[=FILENAME]**
If a filename is not given, defaults to localstatedir/lib/dbus/machine-id (localstatedir is usually /var). If this file exists and is valid, the uuid in the file is printed on stdout. Otherwise, the command exits with a nonzero status.

**--ensure[=FILENAME]**
If a filename is not given, defaults to localstatedir/lib/dbus/machine-id (localstatedir is usually /var). If this file exists then it will be validated, and a failure code returned if it contains the wrong thing. If the file does not exist, it will be created with a new uuid in it. On success, prints no output.

**--version**
Print the version of dbus-uuidgen

<a name="author"></a>

# Author


See
\m[blue]**http://www.freedesktop.org/software/dbus/doc/AUTHORS**\m[]

<a name="bugs"></a>

# Bugs


Please send bug reports to the D-Bus mailing list or bug tracker, see
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]
