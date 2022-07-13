# grub-fstest(3)

Wed Feb 26 2014

**grub-fstest** — Debug tool for GRUB's filesystem driver.


<a name="synopsis"></a>

# Synopsis

```
grub-fstest [-c | --diskcount=NUM] [-C | --crypto] .RS 13 [-d | --debug=STRING] [-K | --zfs-key=FILE|prompt] .RE .RS 13 [-n | --length=NUM] [-r | --root=DEVICE_NAME] .RE .RS 13 [-s | --skip=NUM] [-u | --uncompress] [-v | --verbose] .RE .RS 13 IMAGE_PATH <blocklist FILE | cat FILE | .RE .RS 13 cmp FILE LOCAL | cp FILE LOCAL | crc FILE | .RE .RS 13 hex FILE | ls PATH | xnu_uuid DEVICE>
```


<a name="description"></a>

# Description

**grub-fstest** is a tool for testing GRUB's filesystem drivers.  You should not normally need to run this program.


<a name="options"></a>

# Options


* **--diskcount**=_NUM_  
  Specify the number of input files.
  
* **--crypto**  
  Mount cryptographic devices.
  
* **--debug**=_STRING_  
  Set debug environment variable.
  
* **--zfs-key**=_FILE_|_prompt_  
  Load ZFS cryptographic key.
  
* **--length**=_NUM_  
  Handle NUM bytes in output file.
  
* **--root**=_DEVICE\_NAME_  
  Set root device.
  
* **--skip**=_NUM_  
  Skip NUM bytes from output file.
  
* **--uncompress**  
  Uncompress data.
  
* **--verbose**  
  Print verbose messages.
  

<a name="commands"></a>

# Commands


* **blocklist** _FILE_  
  Display block list of _FILE_.
  
* **cat** _FILE_  
  Display _FILE_ on standard output.
  
* **cmp** _FILE_ _LOCAL_  
  Compare _FILE_ with local file _LOCAL_.
  
* **cp** _FILE_ _LOCAL_  
  Copy _FILE_ to local file _LOCAL_.
  
* **crc** _FILE_  
  Display the CRC-32 checksum of _FILE_.
  
* **hex** _FILE_  
  Display contents of _FILE_ in hexidecimal.
  
* **ls** _PATH_  
  List files at _PATH_.
  
* **xnu\_uuid** _DEVICE_  
  Display the XNU UUID of _DEVICE_.
  

<a name="see-also"></a>

# See Also

**info grub**
