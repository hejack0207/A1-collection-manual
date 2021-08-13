# badblocks(8) - search a device for bad blocks

E2fsprogs version 1.45.6, March 2020

```
badblocks [ -svwnfBX ] [ -b block_size ] [ -c blocks_at_once ] [ -d read_delay_factor ] [ -e max_bad_blocks ] [ -i input_file ] [ -o output_file ] [ -p num_passes ] [ -t test_pattern ] device [ last_block ] [ first_block ]
```

<a name="description"></a>

# Description

**badblocks**
is used to search for bad blocks on a device (usually a disk partition).
_device_
is the special file corresponding to the device (e.g
_/dev/hdc1_).
_last_block_
is the last block to be checked; if it is not specified, the last block
on the device is used as a default.
_first_block_
is an optional parameter specifying the starting block number
for the test, which allows the testing to start in the middle of the
disk.  If it is not specified the first block on the disk is used as a default.

**Important note:**
If the output of
**badblocks**
is going to be fed to the
**e2fsck**
or
**mke2fs**
programs, it is important that the block size is properly specified,
since the block numbers which are generated are very dependent on the
block size in use by the filesystem.
For this reason, it is strongly recommended that
users
**not**
run
**badblocks**
directly, but rather use the
**-c**
option of the
**e2fsck**
and
**mke2fs**
programs.

<a name="options"></a>

# Options


* **-b**_ block_size_  
  Specify the size of blocks in bytes.  The default is 1024.
* **-c**_ number of blocks_  
  is the number of blocks which are tested at a time.  The default is 64.
* **-d**_ read delay factor_  
  This parameter, if passed and non-zero, will cause bad blocks to sleep
  between reads if there were no errors encountered in the read
  operation; the delay will be calculated as a percentage of the time it
  took for the read operation to be performed. In other words, a value of
  100 will cause each read to be delayed by the amount the previous read
  took, and a value of 200 by twice the amount.
* **-e**_ max bad block count_  
  Specify a maximum number of bad blocks before aborting the test.  The
  default is 0, meaning the test will continue until the end of the test
  range is reached.
* **-f**  
  Normally, badblocks will refuse to do a read/write or a non-destructive
  test on a device which is mounted, since either can cause the system to
  potentially crash and/or damage the filesystem even if it is mounted
  read-only.  This can be overridden using the
  **-f**
  flag, but should almost never be used --- if you think you're smarter
  than the
  **badblocks**
  program, you almost certainly aren't.  The only time when this option
  might be safe to use is if the /etc/mtab file is incorrect, and the device
  really isn't mounted.
* **-i**_ input_file_  
  Read a list of already existing known bad blocks.
  **Badblocks**
  will skip testing these blocks since they are known to be bad.  If
  _input_file_
  is specified as "-", the list will be read from the standard input.
  Blocks listed in this list will be omitted from the list of
  _new_
  bad blocks produced on the standard output or in the output file.
  The
  **-b**
  option of
  **dumpe2fs**(8)
  can be used to retrieve the list of blocks currently marked bad on
  an existing filesystem, in a format suitable for use with this option.
* **-n**  
  Use non-destructive read-write mode.  By default only a non-destructive
  read-only test is done.  This option must not be combined with the
  **-w**
  option, as they are mutually exclusive.
* **-o**_ output_file_  
  Write the list of bad blocks to the specified file.  Without this option,
  **badblocks**
  displays the list on its standard output.  The format of this file is suitable
  for use by the
  **-l**
  option in
  **e2fsck**(8)
  or
  **mke2fs**(8).
* **-p**_ num_passes_  
  Repeat scanning the disk until there are no new blocks discovered in
  num_passes consecutive scans of the disk.
  Default is 0, meaning
  **badblocks**
  will exit after the first pass.
* **-s**  
  Show the progress of the scan by writing out rough percentage completion
  of the current badblocks pass over the disk.  Note that badblocks may do
  multiple test passes over the disk, in particular if the
  **-p**
  or
  **-w**
  option is requested by the user.
* **-t**_ test_pattern_  
  Specify a test pattern to be read (and written) to disk blocks.   The
  _test_pattern_
  may either be a numeric value between 0 and ULONG_MAX-1 inclusive, or the word
  "random", which specifies that the block should be filled with a random
  bit pattern.
  For read/write (**-w**) and non-destructive (**-n**) modes,
  one or more test patterns may be specified by specifying the
  **-t**
  option for each test pattern desired.  For
  read-only mode only a single pattern may be specified and it may not be
  "random".  Read-only testing with a pattern assumes that the
  specified pattern has previously been written to the disk - if not, large
  numbers of blocks will fail verification.
  If multiple patterns
  are specified then all blocks will be tested with one pattern
  before proceeding to the next pattern.
* **-v**  
  Verbose mode.  Will write the number of read errors, write errors and data-
  corruptions to stderr.
* **-w**  
  Use write-mode test. With this option,
  **badblocks**
  scans for bad blocks by writing some patterns (0xaa, 0x55, 0xff, 0x00) on
  every block of the device, reading every block and comparing the contents.
  This option may not be combined with the
  **-n**
  option, as they are mutually exclusive.
* **-B**  
  Use buffered I/O and do not use Direct I/O, even if it is available.
* **-X**  
  Internal flag only to be used by
  **e2fsck**(8)
  and
  **mke2fs**(8).
  It bypasses the exclusive mode in-use device safety check.

<a name="warning"></a>

# Warning

Never use the
**-w**
option on a device containing an existing file system.
This option erases data!  If you want to do write-mode testing on
an existing file system, use the
**-n**
option instead.  It is slower, but it will preserve your data.

The
**-e**
option will cause badblocks to output a possibly incomplete list of
bad blocks. Therefore it is recommended to use it only when one wants
to know if there are any bad blocks at all on the device, and not when
the list of bad blocks is wanted.

<a name="author"></a>

# Author

**badblocks**
was written by Remy Card &lt;[Remy.Card@linux.org](mailto:Remy.Card@linux.org)&gt;.  Current maintainer is
Theodore Ts'o &lt;[tytso@alum.mit](mailto:tytso@alum.mit).edu&gt;.  Non-destructive read/write test
implemented by David Beattie &lt;[dbeattie@softhome.net](mailto:dbeattie@softhome.net)&gt;.

<a name="availability"></a>

# Availability

**badblocks**
is part of the e2fsprogs package and is available from
http://e2fsprogs.sourceforge.net.

<a name="see-also"></a>

# See Also

**e2fsck**(8),
**mke2fs**(8)
