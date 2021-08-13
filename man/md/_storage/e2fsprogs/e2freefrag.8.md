# e2freefrag(8) - report free space fragmentation information

E2fsprogs version 1.45.6, March 2020

```
e2freefrag [ -c chunk_kb ] [ -h ] filesys
```


<a name="description"></a>

# Description

**e2freefrag**
is used to report free space fragmentation on ext2/3/4 file systems.
_filesys_
is the filesystem device name (e.g.
_/dev/hdc1_, _/dev/md0_).
The
**e2freefrag**
program will scan the block bitmap information to check how many free blocks
are present as contiguous and aligned free space. The percentage of contiguous
free blocks of size and of alignment
_chunk_kb_
is reported.  It also displays the minimum/maximum/average free chunk size in
the filesystem, along with a histogram of all free chunks.  This information
can be used to gauge the level of free space fragmentation in the filesystem.

<a name="options"></a>

# Options


* **-c**_ chunk_kb_  
  If a chunk size is specified, then
  **e2freefrag**
  will print how many free chunks of size
  _chunk_kb_
  are available in units of kilobytes (Kb).  The chunk size must be a
  power of two and be larger than filesystem block size.
* **-h**  
  Print the usage of the program.

<a name="example"></a>

# Example

# e2freefrag /dev/vgroot/lvhome  
Device: /dev/vgroot/lvhome  
Blocksize: 4096 bytes  
Total blocks: 1504085  
Free blocks: 292995 (19.5%)  

Min. free extent: 4 KB  
Max. free extent: 24008 KB  
Avg. free extent: 252 KB  

HISTOGRAM OF FREE EXTENT SIZES:  
Extent Size Range :   Free extents   Free Blocks  Percent  
    4K...    8K- :           704           704     0.2%  
    8K...   16K- :           810          1979     0.7%  
   16K...   32K- :           843          4467     1.5%  
   32K...   64K- :           579          6263     2.1%  
   64K...  128K- :           493         11067     3.8%  
  128K...  256K- :           394         18097     6.2%  
  256K...  512K- :           281         25477     8.7%  
  512K... 1024K- :           253         44914    15.3%  
    1M...    2M- :           143         51897    17.7%  
    2M...    4M- :            73         50683    17.3%  
    4M...    8M- :            37         52417    17.9%  
    8M...   16M- :             7         19028     6.5%  
   16M...   32M- :             1          6002     2.0%

<a name="author"></a>

# Author

This version of e2freefrag was written by Rupesh Thakare, and modified by
Andreas Dilger &lt;[adilger@sun.com](mailto:adilger@sun.com)&gt;, and Kalpak Shah.

<a name="see-also"></a>

# See Also

_debugfs_(8),
_dumpe2fs_(8),
_e2fsck_(8)
