# grub-file(1) - Check if FILE is of specified type.

Web Feb 26 2014

```
grub-file (--is-i386-xen-pae-domu | --is-x86_64-xen-domu | .RS 11 --is-x86-xen-dom0 | --is-x86-multiboot | .RE .RS 11 --is-x86-multiboot2 | --is-arm-linux | --is-arm64-linux | .RE .RS 11 --is-ia64-linux | --is-mips-linux | --is-mipsel-linux | .RE .RS 11 --is-sparc64-linux | --is-powerpc-linux | --is-x86-linux | .RE .RS 11 --is-x86-linux32 | --is-x86-kfreebsd | --is-i386-kfreebsd | .RE .RS 11 --is-x86_64-kfreebsd | --is-x86-knetbsd | .RE .RS 11 --is-i386-knetbsd | --is-x86_64-knetbsd | --is-i386-efi | .RE .RS 11 --is-x86_64-efi | --is-ia64-efi | --is-arm64-efi | .RE .RS 11 --is-arm-efi | --is-hibernated-hiberfil | --is-x86_64-xnu | .RE .RS 11 --is-i386-xnu | --is-xnu-hibr | --is-x86-bios-bootsector) .RE .RS 11 FILE
```


<a name="description"></a>

# Description

**grub-file** is used to check if _FILE_ is of a specified type.


<a name="options"></a>

# Options


* --is-i386-xen-pae-domu  
  Check if FILE can be booted as i386 PAE Xen unprivileged guest kernel
  
* --is-x86_64-xen-domu  
  Check if FILE can be booted as x86_64 Xen unprivileged guest kernel
  
* --is-x86-xen-dom0  
  Check if FILE can be used as Xen x86 privileged guest kernel
  
* --is-x86-multiboot  
  Check if FILE can be used as x86 multiboot kernel
  
* --is-x86-multiboot2  
  Check if FILE can be used as x86 multiboot2 kernel
  
* --is-arm-linux  
  Check if FILE is ARM Linux
  
* --is-arm64-linux  
  Check if FILE is ARM64 Linux
  
* --is-ia64-linux  
  Check if FILE is IA64 Linux
  
* --is-mips-linux  
  Check if FILE is MIPS Linux
  
* --is-mipsel-linux  
  Check if FILE is MIPSEL Linux
  
* --is-sparc64-linux  
  Check if FILE is SPARC64 Linux
  
* --is-powerpc-linux  
  Check if FILE is POWERPC Linux
  
* --is-x86-linux  
  Check if FILE is x86 Linux
  
* --is-x86-linux32  
  Check if FILE is x86 Linux supporting 32-bit protocol
  
* --is-x86-kfreebsd  
  Check if FILE is x86 kFreeBSD
  
* --is-i386-kfreebsd  
  Check if FILE is i386 kFreeBSD
  
* --is-x86_64-kfreebsd  
  Check if FILE is x86_64 kFreeBSD
  
* --is-x86-knetbsd  
  Check if FILE is x86 kNetBSD
  
* --is-i386-knetbsd  
  Check if FILE is i386 kNetBSD
  
* --is-x86_64-knetbsd  
  Check if FILE is x86_64 kNetBSD
  
* --is-i386-efi  
  Check if FILE is i386 EFI file
  
* --is-x86_64-efi  
  Check if FILE is x86_64 EFI file
  
* --is-ia64-efi  
  Check if FILE is IA64 EFI file
  
* --is-arm64-efi  
  Check if FILE is ARM64 EFI file
  
* --is-arm-efi  
  Check if FILE is ARM EFI file
  
* --is-hibernated-hiberfil  
  Check if FILE is hiberfil.sys in hibernated state
  
* --is-x86_64-xnu  
  Check if FILE is x86_64 XNU (Mac OS X kernel)
  
* --is-i386-xnu  
  Check if FILE is i386 XNU (Mac OS X kernel)
  
* --is-xnu-hibr  
  Check if FILE is XNU (Mac OS X kernel) hibernated image
  
* --is-x86-bios-bootsector  
  Check if FILE is BIOS bootsector
  

<a name="see-also"></a>

# See Also

**info grub**
