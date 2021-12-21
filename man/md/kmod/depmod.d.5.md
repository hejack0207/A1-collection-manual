# depmod\&.d(5)

kmod, 01/08/2018

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

depmod.d - Configuration directory for depmod

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/depmod.d/*.conf 
 /etc/depmod.d/*.conf 
 /run/depmod.d/*.conf
```

<a name="description"></a>

# Description


The order in which modules are processed by the
**depmod**
command can be altered on a global or per-module basis. This is typically useful in cases where built-in kernel modules are complemented by custom built versions of the same and the user wishes to affect the priority of processing in order to override the module version supplied by the kernel.

The format of files under
depmod.d
is simple: one command per line, with blank lines and lines starting with #\*(Aq ignored (useful for adding comments). A \*(Aq\e\*(Aq at the end of a line causes it to continue on the next line, which makes the files a bit neater.

<a name="commands"></a>

# Commands


search _subdirectory..._
This allows you to specify the order in which /lib/modules (or other configured module location) subdirectories will be processed by
**depmod**. Directories are listed in order, with the highest priority given to the first listed directory and the lowest priority given to the last directory listed. The special keyword
**built-in**
refers to the standard module directories installed by the kernel. Another special keyword
**external**
refers to the list of external directories, defined by the
**external**
command.

By default, depmod will give a higher priority to a directory with the name
**updates**
using this built-in search string: "updates built-in" but more complex arrangements are possible and are used in several popular distributions.

override _modulename_ _kernelversion_ _modulesubdirectory_
This command allows you to override which version of a specific module will be used when more than one module sharing the same name is processed by the
**depmod**
command. It is possible to specify one kernel or all kernels using the * wildcard.
_modulesubdirectory_
is the name of the subdirectory under /lib/modules (or other module location) where the target module is installed.

For example, it is possible to override the priority of an updated test module called
**kmod**
by specifying the following command: "override kmod * extra". This will ensure that any matching module name installed under the
**extra**
subdirectory within /lib/modules (or other module location) will take priority over any likenamed module already provided by the kernel.

external _kernelversion_ _absolutemodulesdirectory..._
This specifies a list of directories, which will be checked according to the priorities in the
**search**
command. The order matters also, the first directory has the higher priority.

The
_kernelversion_
is a POSIX regular expression or * wildcard, like in the
**override**.

<a name="copyright"></a>

# Copyright


This manual page Copyright 2006-2010, Jon Masters, Red Hat, Inc.

<a name="see-also"></a>

# See Also


**depmod**(8)

<a name="authors"></a>

# Authors


**Jon Masters** &lt;[jcm@jonmasters.org](mailto:jcm@jonmasters.org)&gt;
Developer

**Robby Workman** &lt;[rworkman@slackware.com](mailto:rworkman@slackware.com)&gt;
Developer

**Lucas De Marchi** &lt;[lucas.de.marchi@gmail.com](mailto:lucas.de.marchi@gmail.com)&gt;
Developer
