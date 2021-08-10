# mkinitrd(8)

dracut 050, 03/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

mkinitrd - is a compat wrapper, which calls dracut to generate an initramfs

<a name="synopsis"></a>

# Synopsis

```

 mkinitrd [OPTION...] [<initrd-image>] <kernel-version>
```

<a name="description"></a>

# Description


mkinitrd creates an initramfs image &lt;initrd-image&gt; for the kernel with version &lt;kernel-version&gt; by calling "dracut".
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Important**
.ps -1  

If a more fine grained control over the resulting image is needed, "dracut" should be called directly.


<a name="options"></a>

# Options


**--version**
print info about the version

**-v, --verbose**
increase verbosity level

**-f, --force**
overwrite existing initramfs file.

***--image-version**
append the kernel version to the target image &lt;initrd-image&gt;-&lt;kernel-version&gt;.

**--with=&lt;module&gt;**
add the kernel module &lt;module&gt; to the initramfs.

**--preload=&lt;module&gt;**
preload the kernel module &lt;module&gt; in the initramfs before any other kernel modules are loaded. This can be used to ensure a certain device naming, which should in theory be avoided and the use of symbolic links in /dev is encouraged.

**--nocompress**
do not compress the resulting image.

**--help**
print a help message and exit.

<a name="availability"></a>

# Availability


The mkinitrd command is part of the dracut package and is available from \m[blue]**https://dracut.wiki.kernel.org**\m[]

<a name="authors"></a>

# Authors


Harald Hoyer

<a name="see-also"></a>

# See Also


**dracut**(8)
