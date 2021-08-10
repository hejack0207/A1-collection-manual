# dracut\&.modules(7)

dracut 050, 03/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dracut.modules - dracut modules

<a name="description"></a>

# Description


dracut uses a modular system to build and extend the initramfs image. All modules are located in _/usr/lib/dracut/modules.d_ or in _&lt;git-src&gt;/modules.d_. The most basic dracut module is _99base_. In _99base_ the initial shell script init is defined, which gets run by the kernel after initramfs loading. Although you can replace init with your own version of _99base_, this is not encouraged. Instead you should use, if possible, the hooks of dracut. All hooks, and the point of time in which they are executed, are described in the section called “BOOT PROCESS STAGES”.

The main script, which creates the initramfs is dracut itself. It parses all arguments and sets up the directory, in which everything is installed. It then executes all check, install, installkernel scripts found in the modules, which are to be processed. After everything is installed, the install directory is archived and compressed to the final initramfs image. All helper functions used by check, install and installkernel are found in in the file _dracut-functions_. These shell functions are available to all module installer (install, installkernel) scripts, without the need to source _dracut-functions_.

A module can check the preconditions for install and installkernel with the check script. Also dependencies can be expressed with check. If a module passed check, install and installkernel will be called to install all of the necessary files for the module. To split between kernel and non-kernel parts of the installation, all kernel module related parts have to be in installkernel. All other files found in a module directory are module specific and mostly are hook scripts and udev rules.

<a name="boot-process-stages"></a>

# Boot Process Stages


dracut modules can insert custom script at various points, to control the boot process. These hooks are plain directories containing shell scripts ending with ".sh", which are sourced by init. Common used functions are in _dracut-lib.sh_, which can be sourced by any script.

<a name="hook-cmdline"></a>

### Hook: cmdline


The _cmdline_ hook is a place to insert scripts to parse the kernel command line and prepare the later actions, like setting up udev rules and configuration files.

In this hook the most important environment variable is defined: root. The second one is rootok, which indicates, that a module claimed to be able to parse the root defined. So for example, **root=**_iscsi:...._ will be claimed by the iscsi dracut module, which then sets rootok.

<a name="hook-pre-udev"></a>

### Hook: pre\-udev


This hook is executed right after the cmdline hook and a check if root and rootok were set. Here modules can take action with the final root, and before udev has been run.

<a name="start-udev"></a>

### Start Udev


Now udev is started and the logging for udev is setup.

<a name="hook-pre-trigger"></a>

### Hook: pre\-trigger


In this hook, you can set udev environment variables with **udevadm control --property=KEY=****value** or control the further execution of udev with udevadm.

<a name="trigger-udev"></a>

### Trigger Udev


udev is triggered by calling udevadm trigger, which sends add events for all devices and subsystems.

<a name="main-loop"></a>

### Main Loop


In the main loop of dracut loops until udev has settled and all scripts in _initqueue/finished_ returned true. In this loop there are three hooks, where scripts can be inserted by calling /sbin/initqueue.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Initqueue**

This hook gets executed every time a script is inserted here, regardless of the udev state.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Initqueue settled**

This hooks (initqueue/settled) gets executed every time udev has settled.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Initqueue timeout**

This hooks (initqueue/timeout) gets executed, when the main loop counter becomes half of the rd.retry counter.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Initqueue finished**

This hook (initqueue/finished) is called after udev has settled and if all scripts herein return 0 the main loop will be ended. Arbitrary scripts can be added here, to loop in the initqueue until something happens, which a dracut module wants to wait for.

<a name="hook-pre-mount"></a>

### Hook: pre\-mount


Before the root device is mounted all scripts in the hook pre-mount are executed. In some cases (e.g. NFS) the real root device is already mounted, though.

<a name="hook-mount"></a>

### Hook: mount


This hook is mainly to mount the real root device.

<a name="hook-pre-pivot"></a>

### Hook: pre\-pivot


This hook is called before cleanup hook, This is a good place for actions other than cleanups which need to be called before pivot.

<a name="hook-cleanup"></a>

### Hook: cleanup


This hook is the last hook and is called before init finally switches root to the real root device. This is a good place to clean up and kill processes not needed anymore.

<a name="cleanup-and-switch_root"></a>

### Cleanup and switch_root


Init (or systemd) kills all udev processes, cleans up the environment, sets up the arguments for the real init process and finally calls switch_root. switch_root removes the whole filesystem hierarchy of the initramfs, chroot()s to the real root device and calls /sbin/init with the specified arguments.

To ensure all files in the initramfs hierarchy can be removed, all processes still running from the initramfs should not have any open file descriptors left.

<a name="network-infrastructure"></a>

# Network Infrastructure


FIXME

<a name="writing-a-module"></a>

# Writing a Module


A simple example module is _96insmodpost_, which modprobes a kernel module after udev has settled and the basic device drivers have been loaded.

All module installation information is in the file module-setup.sh.

First we create a check() function, which just exits with 0 indicating that this module should be included by default.

check():

.if n \{.RS 4
.\}
    return 0
.if n \{.RE
.\}

The we create the install() function, which installs a cmdline hook with priority number 20 called _parse-insmodpost.sh_. It also installs the _insmodpost.sh_ script in _/sbin_.

install():

.if n \{.RS 4
.\}
    inst_hook cmdline 20 "$moddir/parse-insmodpost.sh"
    inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
.if n \{.RE
.\}

The _parse-instmodpost.sh_ parses the kernel command line for a argument rd.driver.post, blacklists the module from being autoloaded and installs the hook _insmodpost.sh_ in the _initqueue/settled_.

_parse-insmodpost.sh_:

.if n \{.RS 4
.\}
    for p in $(getargs rd.driver.post=); do
        echo "blacklist $p" >> /etc/modprobe.d/initramfsblacklist.conf
        _do_insmodpost=1
    done
    
    [ -n "$_do_insmodpost" ] && /sbin/initqueue --settled --unique --onetime /sbin/insmodpost.sh
    unset _do_insmodpost
.if n \{.RE
.\}

_insmodpost.sh_, which is called in the _initqueue/settled_ hook will just modprobe the kernel modules specified in all rd.driver.post kernel command line parameters. It runs after udev has settled and is only called once (--onetime).

_insmodpost.sh_:

.if n \{.RS 4
.\}
    . /lib/dracut-lib.sh
    
    for p in $(getargs rd.driver.post=); do
        modprobe $p
    done
.if n \{.RE
.\}

<a name="module-setupsh-check"></a>

### module\-setup\&.sh: check()


_check()_ is called by dracut to evaluate the inclusion of a dracut module in the initramfs.

$hostonly
If the $hostonly variable is set, then the module check() function should be in "hostonly" mode, which means, that the check() should only return 0, if the module is really needed to boot this specific host.

check() should return with:

0
Include the dracut module in the initramfs.

1
Do not include the dracut module. The requirements are not fulfilled (missing tools, etc.)

255
Only include the dracut module, if another module requires it or if explicitly specified in the config file or on the argument list.

<a name="module-setupsh-depends"></a>

### module\-setup\&.sh: depends()


The function depends() should echo all other dracut module names the module depends on.

<a name="module-setupsh-cmdline"></a>

### module\-setup\&.sh: cmdline()


This function should print the kernel command line options needed to boot the current machine setup. It should start with a space and should not print a newline.

<a name="module-setupsh-install"></a>

### module\-setup\&.sh: install()


The install() function is called to install everything non-kernel related. To install binaries, scripts, and other files, you can use the functions mentioned in [creation].

To address a file in the current module directory, use the variable "$moddir".

<a name="module-setupsh-installkernel"></a>

### module\-setup\&.sh: installkernel()


In installkernel() all kernel related files should be installed. You can use all of the functions mentioned in [creation] to install files.

<a name="creation-functions"></a>

### Creation Functions


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**inst_multiple [-o] &lt;file&gt; [ &lt;file&gt; ...]**

installs multiple binaries and files. If executables are specified without a path, dracut will search the path PATH=/usr/sbin:/sbin:/usr/bin:/bin for the binary. If the option "-o" is given as the first parameter, a missing file does not lead to an error.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**inst &lt;src&gt; [&lt;dst&gt;]**

installs _one_ file &lt;src&gt; either to the same place in the initramfs or to an optional &lt;dst&gt;. inst with more than two arguments is treated the same as inst_multiple, all arguments are treated as files to install and none as install destinations.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**inst_hook &lt;hookdir&gt; &lt;prio&gt; &lt;src&gt;**

installs an executable/script &lt;src&gt; in the dracut hook &lt;hookdir&gt; with priority &lt;prio&gt;.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**inst_rules &lt;udevrule&gt; [ &lt;udevrule&gt; ...]**

installs one or more udev rules. Non-existant udev rules are reported, but do not let dracut fail.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**instmods &lt;kernelmodule&gt; [ &lt;kernelmodule&gt; ... ]**

instmods should be used only in the installkernel() function.

instmods installs one or more kernel modules in the initramfs. &lt;kernelmodule&gt; can also be a whole subsystem, if prefixed with a "=", like "=drivers/net/team".

instmods will not install the kernel module, if $hostonly is set and the kernel module is not currently needed by any /sys/**...**/uevent MODALIAS. To install a kernel module regardless of the hostonly mode use the form:

.if n \{.RS 4
.\}
    hostonly=*(Aq instmods <kernelmodule>
.if n \{.RE
.\}

<a name="initramfs-functions"></a>

### Initramfs Functions


FIXME

<a name="network-modules"></a>

### Network Modules


FIXME

<a name="author"></a>

# Author


Harald Hoyer

<a name="see-also"></a>

# See Also


**dracut**(8)
