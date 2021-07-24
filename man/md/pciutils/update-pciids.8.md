# update-pciids(8) - download new version of the PCI ID list

pciutils-3.6.2, 12 August 2018

```
update-pciids [-q]
```


<a name="description"></a>

# Description

**update-pciids**
fetches the current version of the pci.ids file from the primary distribution
site and installs it.

This utility requires curl, wget or lynx to be installed. If gzip or bzip2
are available, it automatically downloads the compressed version of the list.


<a name="options"></a>

# Options


* **-q**  
  Be quiet and do not report anything except errors.
  

<a name="files"></a>

# Files


* **/usr/share/hwdata/pci.ids**  
  Here we install the new list.
  

<a name="see-also"></a>

# See Also

**lspci**(8),
**setpci**(8)


<a name="author"></a>

# Author

The PCI Utilities are maintained by Martin Mares &lt;[mj@ucw.cz](mailto:mj@ucw.cz)&gt;.
