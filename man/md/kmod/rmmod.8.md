# rmmod(8)

kmod, 01/08/2018

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

rmmod - Simple program to remove a module from the Linux Kernel

<a name="synopsis"></a>

# Synopsis

```
.HP \w'rmmod&nbsp;'u rmmod [-f] [-s] [-v] [modulename]
```

<a name="description"></a>

# Description


**rmmod**
is a trivial program to remove a module (when module unloading support is provided) from the kernel. Most users will want to use
**modprobe**(8)
with the
**-r**
option instead.

<a name="options"></a>

# Options


**-v**, **--verbose**
Print messages about what the program is doing. Usually
**rmmod**
prints messages only if something goes wrong.

**-f**, **--force**
This option can be extremely dangerous: it has no effect unless CONFIG_MODULE_FORCE_UNLOAD was set when the kernel was compiled. With this option, you can remove modules which are being used, or which are not designed to be removed, or have been marked as unsafe (see
**lsmod**(8)).

**-s**, **--syslog**
Send errors to syslog instead of standard error.

**-V** **--version**
Show version of program and exit.

<a name="copyright"></a>

# Copyright


This manual page originally Copyright 2002, Rusty Russell, IBM Corporation. Maintained by Jon Masters and others.

<a name="see-also"></a>

# See Also


**modprobe**(8),
**insmod**(8),
**lsmod**(8),
**modinfo**(8)
**depmod**(8)

<a name="authors"></a>

# Authors


**Jon Masters** &lt;[jcm@jonmasters.org](mailto:jcm@jonmasters.org)&gt;
Developer

**Lucas De Marchi** &lt;[lucas.de.marchi@gmail.com](mailto:lucas.de.marchi@gmail.com)&gt;
Developer
