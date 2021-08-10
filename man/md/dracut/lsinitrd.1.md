# lsinitrd(1)

dracut 050, 03/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

lsinitrd - tool to show the contents of an initramfs image

<a name="synopsis"></a>

# Synopsis

```

 lsinitrd [OPTION...] [<image> [<filename> [<filename> [...] ]]] 
 lsinitrd [OPTION...] -k <kernel-version>
```

<a name="description"></a>

# Description


lsinitrd shows the contents of an initramfs image. if &lt;image&gt; is omitted, then lsinitrd uses the default image _/boot/&lt;machine-id&gt;/&lt;kernel-version&gt;/initrd_ or _/boot/initramfs-&lt;kernel-version&gt;.img_.

<a name="options"></a>

# Options


**-h, --help**
print a help message and exit.

**-s, --size**
sort the contents of the initramfs by size.

**-f, --file**&nbsp;_&lt;filename&gt;_
print the contents of &lt;filename&gt;.

**-k, --kver**&nbsp;_&lt;kernel version&gt;_
inspect the initramfs of &lt;kernel version&gt;.

**-m, --mod**
list dracut modules included of the initramfs image.

**--unpack**
unpack the initramfs to the current directory, instead of displaying the contents. If optional filenames are given, will only unpack specified files, else the whole image will be unpacked. Won’t unpack anything from early cpio part.

**--unpackearly**
unpack the early microcode initramfs to the current directory, instead of displaying the contents. Same as --unpack, but only unpack files from early cpio part.

**-v, --verbose**
unpack verbosely

<a name="availability"></a>

# Availability


The lsinitrd command is part of the dracut package and is available from \m[blue]**https://dracut.wiki.kernel.org**\m[]

<a name="authors"></a>

# Authors


Harald Hoyer

Amerigo Wang

Nikoli

<a name="see-also"></a>

# See Also


**dracut**(8)
