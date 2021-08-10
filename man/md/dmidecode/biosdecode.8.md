# biosdecode(8) - \s-1BIOS\s0 information decoder

dmidecode, February 2007

```
biosdecode [OPTIONS]
```


<a name="description"></a>

# Description

**biosdecode**
parses the \s-1BIOS\s0 memory and prints information about all structures (or
entry points) it knows of. Currently known entry point types are:

* ·  
  \s-1SMBIOS\s0 (System Management \s-1BIOS\s0)  
  Use
  **dmidecode**
  for a more detailed output.
* ·  
  \s-1DMI\s0 (Desktop Management Interface, a legacy version of \s-1SMBIOS\s0)  
  Use
  **dmidecode**
  for a more detailed output.
* ·  
  \s-1SYSID\s0
* ·  
  \s-1PNP\s0 (Plug and Play)
* ·  
  \s-1ACPI\s0 (Advanced Configuration and Power Interface)
* ·  
  \s-1BIOS32\s0 (\s-1BIOS32\s0 Service Directory)
* ·  
  \s-1PIR\s0 (\s-1PCI\s0 \s-1IRQ\s0 Routing)
* ·  
  \s-132OS\s0 (\s-1BIOS32\s0 Extension, Compaq-specific)  
  See
  **ownership**
  for a Compaq ownership tag retrieval tool.
* ·  
  \s-1SNY\s0 (Sony-specific, not decoded)
* ·  
  \s-1VPD\s0 (Vital Product Data, IBM-specific)  
  Use
  **vpddecode**
  for a more detailed output.
* ·  
  \s-1FJKEYINF\s0 (Application Panel, Fujitsu-specific)
  

**biosdecode**
started its life as a part of
**dmidecode**
but as more entry point types were added, it was moved to a different
program.


<a name="options"></a>

# Options


* **-d**, **--dev-mem FILE**  
  Read memory from device **FILE** (default: **/dev/mem**)
* **  **  **--pir full**  
  Decode the details of the PCI IRQ routing table
* **-h**, **--help**  
  Display usage information and exit
* **-V**, **--version**  
  Display the version and exit
  

<a name="files"></a>

# Files

_/dev/mem_


<a name="bugs"></a>

# Bugs

Most of the time,
**biosdecode**
prints too much information (you don't really care about addresses)
or not enough (because it doesn't follow pointers and has no lookup
tables).


<a name="authors"></a>

# Authors

Alan Cox, Jean Delvare


<a name="see-also"></a>

# See Also

**dmidecode**(8),
**mem**(4),
**ownership**(8),
**vpddecode**(8)
