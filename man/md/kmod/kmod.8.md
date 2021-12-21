# kmod(8)

kmod, 01/08/2018

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

kmod - Program to manage Linux Kernel modules

<a name="synopsis"></a>

# Synopsis

```
.HP \w'kmod&nbsp;'u kmod [OPTIONS...] [COMMAND] [COMMAND_OPTIONS...]
```

<a name="description"></a>

# Description


**kmod**
is a multi-call binary which implements the programs used to control Linux Kernel modules. Most users will only run it using its other names.

<a name="options"></a>

# Options


**-V** **--version**
Show the program version and exit.

**-h** **--help**
Show the help message.

<a name="commands"></a>

# Commands


**help**
Show the help message.

**list**
List the currently loaded modules.

**static-nodes**
Output the static device nodes information provided by the modules of the currently running kernel version.

<a name="copyright"></a>

# Copyright


This manual page originally Copyright 2014, Marco dItri. Maintained by Lucas De Marchi and others.

<a name="see-also"></a>

# See Also


**lsmod**(8),
**rmmod**(8),
**insmod**(8),
**modinfo**(8),
**modprobe**(8),
**depmod**(8)

<a name="author"></a>

# Author


**Lucas De Marchi** &lt;[lucas.de.marchi@gmail.com](mailto:lucas.de.marchi@gmail.com)&gt;
Developer
