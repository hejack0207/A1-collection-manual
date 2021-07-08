# numastat(8)

Bill Gray, 1.0.0


**numastat** - Show per-NUMA-node memory statistics for processes and the operating system

<a name="syntax"></a>

# Syntax

```

 numastat

 numastat [-V]

 numastat [\<PID>|<pattern>...]

 numastat [-c] [-m] [-n] [-p <PID>|<pattern>] [-s[<node>]] [-v] [-z] [\<PID>|<pattern>...]

```

<a name="description"></a>

# Description


**numastat**
with no command options or arguments at all, displays per-node NUMA hit and
miss system statistics from the kernel memory allocator.  This default
**numastat** behavior is strictly compatible with the previous long-standing
**numastat** perl script, written by Andi Kleen.  The default **numastat**
statistics shows per-node numbers (in units of pages of memory) in these categories:

**numa_hit**
is memory successfully allocated on this node as intended.

**numa_miss**
is memory allocated on this node despite the process preferring some different node. Each
_numa_miss_
has a
_numa_foreign_
on another node.

**numa_foreign**
is memory intended for this node, but actually allocated on some different node.  Each
_numa_foreign_
has a
_numa_miss_
on another node.

**interleave_hit**
is interleaved memory successfully allocated on this node as intended.

**local_node**
is memory allocated on this node while a process was running on it.

**other_node**
is memory allocated on this node while a process was running on some other node.

Any supplied options or arguments with the **numastat** command will
significantly change both the content and the format of the display.  Specified
options will cause display units to change to megabytes of memory, and will
change other specific behaviors of **numastat** as described below.

Memory usage information reflects the resident pages on the system.

<a name="options"></a>

# Options



* **-c**  
  Minimize table display width by dynamically shrinking column widths based on
  data contents.  With this option, amounts of memory will be rounded to the
  nearest megabyte (rather than the usual display with two decimal places).
  Column width and inter-column spacing will be somewhat unpredictable with this
  option, but the more dense display will be very useful on systems with many
  NUMA nodes.
* **-m**  
  Show the meminfo-like system-wide memory usage information.  This option
  produces a per-node breakdown of memory usage information similar to that found
  in /proc/meminfo.
* **-n**  
  Show the original **numastat** statistics info.  This will show the same
  information as the default **numastat** behavior but the units will be megabytes of
  memory, and there will be other formatting and layout changes versus the
  original **numastat** behavior.
* **-p** &lt;**PID**&gt; or &lt;**pattern**&gt;  
  Show per-node memory allocation information for the specified PID or pattern.
  If the -p argument is only digits, it is assumed to be a numerical PID.  If
  the argument characters are not only digits, it is assumed to be a text
  fragment pattern to search for in process command lines.  For example,
  **numastat -p qemu** will attempt to find and show information for processes
  with "qemu" in the command line.  Any command line arguments remaining after
  **numastat** option flag processing is completed, are assumed to be
  additional &lt;**PID**&gt; or &lt;**pattern**&gt; process specifiers.  In this sense,
  the **-p** option flag is optional: **numastat qemu** is equivalent to
  **numastat -p qemu**
* **-s[&lt;node&gt;]**  
  Sort the table data in descending order before displaying it, so the biggest
  memory consumers are listed first.  With no specified &lt;node&gt;, the table will be
  sorted by the total column.  If the optional &lt;node&gt; argument is supplied, the
  data will be sorted by the &lt;node&gt; column.  Note that &lt;node&gt; must follow the
  **-s** immediately with no intermediate white space (e.g., numastat
  -s2). Because **-s** can allow an optional argument, it must always be
  the last option character in a compound option character string. For example,
  instead of **numastat -msc** (which probably will not work as you expect),
  use **numastat -mcs**
* **-v**  
  Make some reports more verbose.  In particular, process information for
  multiple processes will display detailed information for each process.
  Normally when per-node information for multiple processes is displayed, only
  the total lines are shown.
* **-V**  
  Display **numastat** version information and exit.
* **-z**  
  Skip display of table rows and columns of only zero valuess.  This can be used
  to greatly reduce the amount of uninteresting zero data on systems with many
  NUMA nodes.  Note that when rows or columns of zeros are still displayed with
  this option, that probably means there is at least one value in the row or
  column that is actually non-zero, but rounded to zero for display.

<a name="notes-"></a>

# Notes 

**numastat** attempts to fold each table display so it will be conveniently
readable on the output terminal.  Normally a terminal width of 80 characters is
assumed.  When the **resize** command is available, **numastat** attempts
to dynamically determine and fine tune the output tty width from **resize**
output.  If **numastat** output is not to a tty, very long output lines can
be produced, depending on how many NUMA nodes are present.  In all cases,
output width can be explicitly specified via the **NUMASTAT\_WIDTH**
environment variable.  For example, **NUMASTAT_WIDTH=100  numastat**.  On
systems with many NUMA nodes, **numastat -c -z ....** can be very helpful
to selectively reduce the amount of displayed information.

<a name="environment-variables"></a>

# Environment Variables



* NUMASTAT_WIDTH  

<a name="files"></a>

# Files


_/proc/*/numa\_maps_  
_/sys/devices/system/node/node*/meminfo_  
_/sys/devices/system/node/node*/numastat_

<a name="examples"></a>

# Examples

_numastat -c -z -m -n_  
_numastat -czs libvirt kvm qemu_  
_watch -n1 numastat_  
_watch -n1 --differences=cumulative numastat_

<a name="authors"></a>

# Authors


The original **numastat** perl script was written circa 2003 by Andi Kleen
&lt;[andi.kleen@intel.com](mailto:andi.kleen@intel.com)&gt;.  The current **numastat** program was written in 2012
by Bill Gray &lt;[bgray@redhat.com](mailto:bgray@redhat.com)&gt; to be compatible by default with the original,
and to add options to display per-node system memory usage and per-node process
memory allocation.

<a name="see-also"></a>

# See Also


**numactl**(8),
**set_mempolicy(**2),
**numa**(3)
