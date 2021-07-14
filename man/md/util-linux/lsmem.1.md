# lsmem(1) - list the ranges of available memory with their online status

util-linux, October 2016

```
lsmem [options]
```

<a name="description"></a>

# Description

The **lsmem** command lists the ranges of available memory with their online
status. The listed memory blocks correspond to the memory block representation
in sysfs. The command also shows the memory block size and the amount of memory
in online and offline state.

The default output compatible with original implementation from s390-tools, but
it's strongly recommended to avoid using default outputs in your scripts.
Always explicitly define expected columns by using the **--output** option
together with a columns list in environments where a stable output is required.

The **lsmem** command lists a new memory range always when the current memory
block distinguish from the previous block by some output column.  This default
behavior is possible to override by the **--split** option (e.g. lsmem
--split=ZONES).  The special word "none" may be used to ignore all
differences between memory blocks and to create as large as possible continuous
ranges.  The opposite semantic is **--all** to list individual memory
blocks.

Note that some output columns may provide inaccurate information if a split policy
forces **lsmem** to ignore differences in some attributes. For example if you
merge removable and non-removable memory blocks to the one range than all
the range will be marked as non-removable on **lsmem** output.

Not all columns are supported on all systems.  If an unsupported column is
specified, **lsmem** prints the column but does not provide any data for it.

Use the **--help** option to see the columns description.


<a name="options"></a>

# Options


* **-a**, **--all**  
  List each individual memory block, instead of combining memory blocks with
  similar attributes.
* **-b**,** --bytes**  
  Print the SIZE column in bytes rather than in a human-readable format.
* **-h**, **--help**  
  Display help text and exit.
* **-J**,** --json**  
  Use JSON output format.
* **-n**,** --noheadings**  
  Do not print a header line.
* **-o**,** --output **_list_  
  Specify which output columns to print.  Use **--help**
  to get a list of all supported columns.
  The default list of columns may be extended if _list_ is
  specified in the format **+list** (e.g. **lsmem -o +NODE**).
* **--output-all**  
  Output all available columns.
* **-P**,** --pairs**  
  Produce output in the form of key="value" pairs.
  All potentially unsafe characters are hex-escaped (\\x&lt;code&gt;).
* **-r**,** --raw**  
  Produce output in raw format.  All potentially unsafe characters are hex-escaped
  (\\x&lt;code&gt;).
* **-S**,** --split **_list_  
  Specify which columns (attributes) use to split memory blocks to ranges.  The
  supported columns are STATE, REMOVABLE, NODE and ZONES, or "none". The another columns are
  silently ignored. For more details see DESCRIPTION above.
* **-s**,** --sysroot **_directory_  
  Gather memory data for a Linux instance other than the instance from which the
  **lsmem** command is issued.  The specified _directory_ is the system
  root of the Linux instance to be inspected.
* **-V**, **--version**  
  Display version information and exit.
* **--summary**[=_when_]  
  This option controls summary lines output.  The optional argument _when_ can be
  **never**, **always** or **only**.  If the _when_ argument is
  omitted, it defaults to **"only"**. The summary output is suppressed for
  **--raw**, **--pairs** and **--json**.

<a name="author"></a>

# Author

**lsmem**
was originally written by Gerald Schaefer for s390-tools in Perl. The C version
for util-linux was written by Clemens von Mann, Heiko Carstens and Karel Zak.

<a name="see-also"></a>

# See Also

**chmem**(8)

<a name="availability"></a>

# Availability

The **lsmem** command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
