# modinfo(8)

kmod, 01/08/2018

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

modinfo - Show information about a Linux Kernel module

<a name="synopsis"></a>

# Synopsis

```
.HP \w'modinfo&nbsp;'u modinfo [-0] [-F&nbsp;field] [-k&nbsp;kernel] [modulename|filename...] .HP \w'modinfo&nbsp;-V&nbsp;'u modinfo -V .HP \w'modinfo&nbsp;-h&nbsp;'u modinfo -h
```

<a name="description"></a>

# Description


**modinfo**
extracts information from the Linux Kernel modules given on the command line. If the module name is not a filename, then the
/lib/modules/_version_
directory is searched, as is also done by
**modprobe**(8)
when loading kernel modules.

**modinfo**
by default lists each attribute of the module in form
_fieldname_
:
_value_, for easy reading. The filename is listed the same way (although its not really an attribute).

This version of
**modinfo**
can understand modules of any Linux Kernel architecture.

<a name="options"></a>

# Options


**-V**, **--version**
Print the modinfo version.

**-F**, **--field**
Only print this field value, one per line. This is most useful for scripts. Field names are case-insensitive. Common fields (which may not be in every module) include
author,
description,
license,
parm,
depends, and
alias. There are often multiple
parm,
alias
and
depends
fields. The special field
filename
lists the filename of the module.

**-b ****basedir**, **--basedir ****basedir**
Root directory for modules,
/
by default.

**-k ****kernel**
Provide information about a kernel other than the running one. This is particularly useful for distributions needing to extract information from a newly installed (but not yet running) set of kernel modules. For example, you wish to find which firmware files are needed by various modules in a new kernel for which you must make an initrd/initramfs image prior to booting.

**-0**, **--null**
Use the ASCII zero character to separate field values, instead of a new line. This is useful for scripts, since a new line can theoretically appear inside a field.

**-a** **--author**, **-d** **--description**, **-l** **--license**, **-p** **--parameters**, **-n** **--filename**
These are shortcuts for the
**--field**
flags
author,
description,
license,
parm
and
filename
arguments, to ease the transition from the old modutils
**modinfo**.

<a name="copyright"></a>

# Copyright


This manual page originally Copyright 2003, Rusty Russell, IBM Corporation. Maintained by Jon Masters and others.

<a name="see-also"></a>

# See Also


**modprobe**(8)

<a name="authors"></a>

# Authors


**Jon Masters** &lt;[jcm@jonmasters.org](mailto:jcm@jonmasters.org)&gt;
Developer

**Lucas De Marchi** &lt;[lucas.de.marchi@gmail.com](mailto:lucas.de.marchi@gmail.com)&gt;
Developer
