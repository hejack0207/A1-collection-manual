# insmod(8)

kmod, 01/08/2018

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

insmod - Simple program to insert a module into the Linux Kernel

<a name="synopsis"></a>

# Synopsis

```
.HP \w'insmod&nbsp;'u insmod [filename] [module&nbsp;options...]
```

<a name="description"></a>

# Description


**insmod**
is a trivial program to insert a module into the kernel. Most users will want to use
**modprobe**(8)
instead, which is more clever and can handle module dependencies.

Only the most general of error messages are reported: as the work of trying to link the module is now done inside the kernel, the
**dmesg**
usually gives more information about errors.

<a name="copyright"></a>

# Copyright


This manual page originally Copyright 2002, Rusty Russell, IBM Corporation. Maintained by Jon Masters and others.

<a name="see-also"></a>

# See Also


**modprobe**(8),
**rmmod**(8),
**lsmod**(8),
**modinfo**(8)
**depmod**(8)

<a name="authors"></a>

# Authors


**Jon Masters** &lt;[jcm@jonmasters.org](mailto:jcm@jonmasters.org)&gt;
Developer

**Lucas De Marchi** &lt;[lucas.de.marchi@gmail.com](mailto:lucas.de.marchi@gmail.com)&gt;
Developer
