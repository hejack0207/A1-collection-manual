# kexec(8) - directly boot into a new kernel

Linux, April 2006

```
/sbin/kexec [-v (--version)] [-f (--force)] [-x (--no-ifdown)] [-y (--no-sync)] [-l (--load)] [-p (--load-panic)] [-u (--unload)] [-e (--exec)] [-t (--type)] [--mem-min=addr] [--mem-max=addr]
```


<a name="description"></a>

# Description

**kexec**
is a system call that enables you to load and boot into another
kernel from the currently running kernel.
**kexec**
performs the function of the boot loader from within the kernel. The
primary difference between a standard system boot and a
**kexec**
boot is that the hardware initialization normally performed by the BIOS
or firmware (depending on architecture) is not performed during a
**kexec**
boot. This has the effect of reducing the time required for a reboot.

Make sure you have selected
**CONFIG_KEXEC=y**
when configuring the kernel. The
**CONFIG_KEXEC**
option enables the
**kexec**
system call.

<a name="usage"></a>

# Usage

Using
**kexec**
consists of

(1) loading the kernel to be rebooted to into memory, and
(2) actually rebooting to the pre-loaded kernel.

To load a kernel, the syntax is as follows:

**kexec**
-l&nbsp;_kernel-image_
--append=_command-line-options_
--initrd=_initrd-image_

where
_kernel-image_
is the kernel file that you intend to reboot to.

Insert the command-line parameters that must be passed to the new
kernel into
_command-line-options_.
Passing the exact contents of /proc/cmdline into
_command-line-options_
is the safest way to ensure that correct values are passed to the
rebooting kernel.

The optional
_initrd-image_
is the initrd image to be used during boot.

It's also possible to invoke
**kexec**
without an option parameter. In that case, kexec loads the specified
kernel and then invokes
**shutdown**(8).
If the shutdown scripts of your Linux distribution support
kexec-based rebooting, they then call
**kexec**
_-e_
just before actually rebooting the machine. That way, the machine does
a clean shutdown including all shutdown scripts.


<a name="example"></a>

# Example


For example, if the kernel image you want to reboot to is
**/boot/vmlinux**,
the contents of /proc/cmdline is
**root\=/dev/hda1**,
and the path to the initrd is
**/boot/initrd**,
then you would use the following command to load the kernel:

**kexec**
-l&nbsp;**/boot/vmlinux**
--append=**root=/dev/hda1**&nbsp;--initrd=**/boot/initrd**

After this kernel is loaded, it can be booted to at any time using the
command:

**kexec**&nbsp;-e


<a name="options"></a>

# Options


* **-d&nbsp;(--debug)**  
  Enable debugging messages.
* **-S&nbsp;(--status)**  
  Return 0 if the type (by default crash) is loaded. Can be used in conjuction
  with -l or -p to toggle the type. Note this option supersedes other options
  and it will
  **not&nbsp;load&nbsp;or&nbsp;unload&nbsp;the&nbsp;kernel.**
* **-e&nbsp;(--exec)**  
  Run the currently loaded kernel. Note that it will reboot into the loaded kernel without calling shutdown(8).
* **-f&nbsp;(--force)**  
  Force an immediate
  **kexec**
  call, do not call
  **shutdown**(8)
  (contrary to the default action without any option parameter). This option
  performs the same actions like executing
  _-l_
  and
  _-e_
  in one call.
* **-h&nbsp;(--help)**  
  Open a help file for
  **kexec**.
* **-i&nbsp;(--no-checks)**  
  Fast reboot, no memory integrity checks.
* **-l&nbsp;(--load)**_&nbsp;kernel_  
  Load the specified
  _kernel_
  into the current kernel.
* **-p&nbsp;(--load-panic)**  
  Load the new kernel for use on panic.
* **-t&nbsp;(--type=**_type_**)**  
  Specify that the new kernel is of this
  _type._
* **-s&nbsp;(--kexec-file-syscall)**  
  Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
* **-c&nbsp;(--kexec-syscall)**  
  Specify that the old KEXEC_LOAD syscall should be used exclusively (the default).
* **-a&nbsp;(--kexec-syscall-auto)**  
  Try the new KEXEC_FILE_LOAD syscall first and when it is not supported or the
  kernel does not understand the supplied image fall back to the old KEXEC_LOAD
  interface.
  
  There is no one single interface that always works.
  
  KEXEC_FILE_LOAD is required on systems that use locked-down secure boot to
  verify the kernel signature.  KEXEC_LOAD may be also disabled in the kernel
  configuration.
  
  KEXEC_LOAD is required for some kernel image formats and on architectures that
  do not implement KEXEC_FILE_LOAD.
* **-u&nbsp;(--unload)**  
  Unload the current
  **kexec**
  target kernel. If a capture kernel is being unloaded then specify -p with -u.
* **-v&nbsp;(--version)**  
  Return the version number of the installed utility.
* **-x&nbsp;(--no-ifdown)**  
  Shut down the running kernel, but restore the interface on reload.
* **-y&nbsp;(--no-sync)**  
  Shut down the running kernel, but skip syncing the filesystems.
* **--mem-min=**_addr_  
  Specify the lowest memory address
  _addr_
  to load code into.
* **--mem-max=**_addr_  
  Specify the highest memory address
  _addr_
  to load code into.
* **--entry=**_addr_  
  Specify the jump back address. (0 means it's not jump back or preserve context)
* **--load-preserve-context**  
  Load the new kernel and preserve context of current kernel during kexec.
* **--load-jump-back-helper**  
  Load a helper image to jump back to original kernel.
* **--reuseinitrd**  
  Reuse initrd from first boot.
* **--print-ckr-size**  
  Print crash kernel region size, if available.
  
  

<a name="supported-kernel-file-types-and-options"></a>

# Supported Kernel File Types and Options

**Beoboot-x86**

* **--args-elf**  
  Pass ELF boot notes.
* **--args-linux**  
  Pass Linux kernel style options.
* **--real-mode**  
  Use the kernel's real mode entry point.

**elf-x86**

* **--append=**_string_  
  Append
  _string_
  to the kernel command line.
* **--command-line=**_string_  
  Set the kernel command line to
  _string_.
* **--reuse-cmdline**  
  Use the command line from the running system. When a panic kernel is loaded, it
  strips the
  .I
  crashkernel
  parameter automatically. The
  _BOOT_IMAGE_
  parameter is also stripped.
* **--initrd=**_file_  
  Use
  _file_
  as the kernel's initial ramdisk.
* **--ramdisk=**_file_  
  Use
  _file_
  as the kernel's initial ramdisk.

**bzImage-x86**

* **--append=**_string_  
  Append
  _string_
  to the kernel command line.
* **--command-line=**_string_  
  Set the kernel command line to
  _string_.
* **--reuse-cmdline**  
  Use the command line from the running system. When a panic kernel is loaded, it
  strips the
  .I
  crashkernel
  parameter automatically. The
  _BOOT_IMAGE_
  parameter is also stripped.
* **--initrd=**_file_  
  Use
  _file_
  as the kernel's initial ramdisk.
* **--ramdisk=**_file_  
  Use
  _file_
  as the kernel's initial ramdisk.
* **--real-mode**  
  Use real-mode entry point.

**multiboot-x86**

* **--command-line=**_string_  
  Set the kernel command line to
  _string_.
* **--reuse-cmdline**  
  Use the command line from the running system. When a panic kernel is loaded, it
  strips the
  .I
  crashkernel
  parameter automatically. The
  _BOOT_IMAGE_
  parameter is also stripped.
* **--module=**_mod arg1 arg2 ..._  
  Load module
  _mod_
  with command-line arguments
  _arg1 arg2 ..._
  This parameter can be specified multiple times.


<a name="architecture-options"></a>

# Architecture Options


* **--console-serial**  
  Enable the serial console.
* **--console-vga**  
  Enable the VGA console.
* **--elf32-core-headers**  
  Prepare core headers in ELF32 format.
* **--elf64-core-headers**  
  Prepare core headers in ELF64 format.
* **--reset-vga**  
  Attempt to reset a standard VGA device.
* **--serial=**_port_  
  Specify the serial
  _port_
  for debug output.
* **--serial-baud=**_baud_rate_  
  Specify the
  _baud rate_
  of the serial port.
