# grubby(8) - command line tool for configuring grub and zipl

Wed Apr 29 2020

```
grubby [--add-kernel=kernel-path] [--args=args]        [--bad-image-okay] [--config-file=path] [--copy-default]        [--default-kernel] [--default-index] [--default-title]        [--env=path] [--grub2] [--info=kernel-path]        [--initrd=initrd-path] [--extra-initrd=initrd-path]        [--make-default] [--remove-args=args]        [--remove-kernel=kernel-path] [--set-default=kernel-path]        [--set-default-index=\fientry-index] [--title=\fentry-title]        [--update-kernel=kernel-path] [--zipl] [--bls-directory=path]
```


<a name="description"></a>

# Description

**grubby** is a command line tool for updating and displaying information
about the configuration files for the **grub2** and **zipl** boot loaders.
It is primarily designed to be used from scripts which install new kernels and
need to find information about the current boot environment.

On BIOS-based Intel x86 platforms, **grub2** is the default bootloader and
the configuration file is in **/boot/grub2/grub.cfg**. On UEFI-based Intel
x86 platforms, **grub2** is the default bootloader, and the configuration
file is in **/boot/efi/EFI/redhat/grub.cfg**. On PowerPC platforms, systems
based on Power8 and Power9 support **grub2** as a bootloader and use a
configuration stored in **/boot/grub2/grub.cfg**. On s390x platforms the
**zipl** bootloader use a default configuration in **/etc/zipl.conf**.

All bootloaders define the boot entries as individual configuration fragments
that are stored by default in **/boot/loader/entries**. The format for the
config files is specified at **https://systemd.io/BOOT\_LOADER\_SPECIFICATION**.
The **grubby** tool is used to update and display the configuration defined
in the BootLoaderSpec fragment files.

There are a number of ways to specify the kernel used for **--info**,
**--remove-kernel**, and **--update-kernel**. Specificying **DEFAULT**
or **ALL** selects the default entry and all of the entries, respectively.
Also, the title of a boot entry may be specified by using **TITLE=title**
as the argument; all entries with that title are used.


<a name="options"></a>

# Options


* **--add-kernel**=_kernel-path_  
  Add a new boot entry for the kernel located at _kernel-path_.
  
* **--args**=_kernel-args_  
  When a new kernel is added, this specifies the command line arguments
  which should be passed to the kernel by default (note they are merged
  with the arguments of the default entry if **--copy-default** is used).
  When **--update-kernel** is used, this specifies new arguments to add
  to the argument list. Multiple, space separated arguments may be used. If
  an argument already exists the new value replaces the old values. The
  **root=** kernel argument gets special handling if the configuration
  file has special handling for specifying the root filesystem.
  
* **--bad-image-okay**  
  When **grubby** is looking for an entry to use for something (such
  as a default boot entry) it uses sanity checks, such as ensuring that
  the kernel exists in the filesystem, to make sure entries that obviously
  won't work aren't selected. This option overrides that behavior, and is
  designed primarily for testing.
  
* **--config-file**=_path_  
  Use _path_ as the configuration file rather then the default.
  
* **--copy-default**  
  **grubby** will copy as much information (such as kernel arguments and
  root device) as possible from the current default kernel. The kernel path
  and initrd path will never be copied.
  
* **--default-kernel**  
  Display the full path to the current default kernel and exit.
  
* **--default-index**  
  Display the numeric index of the current default boot entry and exit.
  
* **--default-title**  
  Display the title of the current default boot entry and exit.
  
* **--env**=_path_  
  Use _path_ as the grub2 environment block file rather then the default path.
  
* **--grub2**  
  Configure **grub2** bootloader.
  
* **--info**=_kernel-path_  
  Display information on all boot entries which match _kernel-path_. If
  _kernel-path_ is **DEFAULT**, then information on the default kernel
  is displayed. If _kernel-path_ is **ALL**, then information on all boot
  entries are displayed.
  
* **--initrd**=_initrd-path_  
  Use _initrd-path_ as the path to an initial ram disk for a new kernel
  being added.
  
* **--extrainitrd**=_initrd-path_  
  Use _initrd-path_ as the path to an auxiliary init ram disk image to be
  added to the boot entry.
  
* **--make-default**  
  Make the new kernel entry being added the default entry.
  
* **--remove-args**=_kernel-args_  
  The arguments specified by _kernel-args_ are removed from the kernels
  specified by **--update-kernel**. The **root** argument gets special
  handling for configuration files that support separate root filesystem
  configuration.
  
* **--remove-kernel**=_kernel-path_  
  Removes all boot entries which match _kernel-path_. This may be used
  along with --add-kernel, in which case the new kernel being added will
  never be removed.
  
* **--set-default**=_kernel-path_  
  The first entry which boots the specified kernel is made the default
  boot entry.
  
* **--set-default-index**=_entry-index_  
  Makes the given entry number the default boot entry.
  
* **--title**=_entry-title_  
  When a new kernel entry is added _entry-title_ is used as the title
  for the entry.
  
* **--update-kernel**=_kernel-path_  
  The entries for kernels matching kernel-path are updated. Currently
  the only items that can be updated is the kernel argument list, which is
  modified via the **--args** and **--remove-args** options. If the
  **ALL** argument is used the variable ** GRUB\_CMDLINE\_LINUX** in
  **/etc/default/grub** is updated with the latest kernel argument list,
  unless the **--no-etc-grub-update** option is used.
  
* **--zipl**  
  Configure **zipl** bootloader.
  
* **--bls-directory**=_path_  
  Use _path_ as the directory for the BootLoaderSpec config files rather
  than the default **/boot/loader/entries**.
  
* **--no-etc-grub-update**  
  Makes grubby to not update the **GRUB\_CMDLINE\_LINUX** variable in
  **/etc/default/grub** when the **--update-kernel** option is
  used with the **ALL** argument.
  

<a name="see-also"></a>

# See Also

**zipl**(8),
**mkinitrd**(8),
**kernel-install**(8)


<a name="authors"></a>

# Authors

    Erik Troan
    Jeremy Katz
    Peter Jones
    Javier Martinez
