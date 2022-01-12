# vmtouch(8)

 , 2020-07-29

.if n .ad l
.nh

<a name="name"></a>

# Name

vmtouch - the Virtual Memory Toucher

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1     vmtouch [OPTIONS] ... FILES OR DIRECTORIES ... .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Portable file system cache diagnostics and control.

vmtouch opens every file provided on the command line and maps it into virtual memory with \f(CWmmap(2). The mappings are opened read-only. It recursively crawls any directories and does the same to all files it finds within them.

With no options, vmtouch will not read from (touch) any memory pages.  It will only use \f(CWmincore(2) to determine how many pages of each file are actually resident in memory. Before exiting, it will print a summary of the total pages encountered and how many were resident.

* -t  
  .IX Item "-t"
  Touch virtual memory pages. Reads a byte from each page of the file. If the page is not resident in memory, a page fault will be generated and the page will be read from disk into the file system's memory cache.
  .Sp
  Note: Although each page is guaranteed to have been brought into memory, the page might be evicted from memory by the time the vmtouch command completes.
* -e  
  .IX Item "-e"
  Evict the mapped pages from the file system cache. They will need to be read in from disk the next time they are accessed. This is the inverse of \f(CW`-t\*(C'.
  .Sp
  Note: Even if the eviction is successful, pages may be paged back into memory by the time the vmtouch command completes.
  .Sp
  Note: This option is not portable to all systems. See \s-1PORTABILITY\s0 below.
* -l  
  .IX Item "-l"
  Lock pages into physical memory. This option works the same as \f(CW`-t\*(C' except it calls \f(CWmlock(2) on all the memory mappings and doesn't close the descriptors when finished. At the end of the crawl, if successful, vmtouch will block indefinitely. The files will be locked in physical memory until the vmtouch process is killed.
  .Sp
  Note: While the vmtouch process is holding memory locks, any processes that access the locked pages will not cause non-resident page faults or address-translation faults although they may still cause \s-1TLB\s0 misses.
  .Sp
  Note: Because vmtouch holds file descriptors open it may reach the \f(CW`RLIMIT\_NOFILE\*(C' process file descriptor limit. In this case it will try to increase the descriptor limit which will only work if the process is run with root privileges. Similarly, root privileges are required to exceed the \f(CW\*(C\`RLIMIT\_MEMLOCK\*(C' limit. Even with root privileges, \f(CW\*(C\`-l\*(C' is limited by both the system file descriptor limit and the system limit on \*(L"wired memory\*(R".
* -L  
  .IX Item "-L"
  This option is the same as \f(CW`-l\*(C' except that it uses \f(CWmlockall(2) at the end of the crawl rather than individually \f(CWmlock(2)ing each file. Because of this, other unrelated pages belonging to the vmtouch process will also be locked in memory.
* -d  
  .IX Item "-d"
  Daemon mode. After performing the crawl, disassociate from the terminal and run in the background as a daemon. This option can only be used with the \f(CW`-l\*(C' or \f(CW\*(C\`-L\*(C' locking modes.
* -m &lt;max file size&gt;  
  .IX Item "-m &lt;max file size&gt;"
  Maximum file size to map into virtual memory. Files that are larger than this will be skipped. Examples: 4096, 4k, 100M, 1.5G. The default is 500M.
* -p &lt;size range&gt; or &lt;size&gt;  
  .IX Item "-p &lt;size range&gt; or &lt;size&gt;"
  Page mode. Maps the portion of the file specified by a range instead of the entire file. Size format same as for \f(CW`-m\*(C'. Omitted range start (end) value means start (end) of file. Single &lt;size&gt; value is equivalent to -&lt;size&gt;, i.e. map the first &lt;size&gt; bytes. Examples: 4k-50k, 100M-2G, -5M, -.
* -f  
  .IX Item "-f"
  Follow symbolic links. With this option, vmtouch will descend into symbolic links that point to directories and will touch regular files pointed to by symbolic links. Symbolic link loops are detected and issue warnings.
* -i &lt;pattern&gt;  
  .IX Item "-i &lt;pattern&gt;"
  Can be specified multiple times. Ignores files and directories that match any of the provided patterns. The pattern may include wildcards (remember to escape them from your shell). This option stops the crawl, so can be used to ignore directories and all their contents. Example: vmtouch -i .git -i '*.bak' .
* -I &lt;pattern&gt;  
  .IX Item "-I &lt;pattern&gt;"
  Can be specified multiple times. Only processes filenames matching one or more of the provided patterns. The pattern may include wildcards (remember to escape them from your shell). Example: vmtouch -I '*.c' -I '*.h' .
* -b &lt;list file&gt;  
  .IX Item "-b &lt;list file&gt;"
  The list of files/directories to crawl is read from the specified list file, which by default should be a newline-separated list, for example the output from the find command. If the list file is -\*(R" then this list is read from standard input. Example: find /usr/lib -type f | vmtouch -b -
* -0  
  .IX Item "-0"
  If -b (batch mode\*(R") is in effect, assume the list file is delimited with \s-1NUL\s0 bytes instead of newlines, for example the output from find -print0. This is useful in case your filenames contain newline characters themselves.
* -v  
  .IX Item "-v"
  Verbose mode. While crawling, print out every file being processed along with its total number of pages and the number of its pages that are currently resident in memory to standard output.
* -q  
  .IX Item "-q"
  Quiet mode. Suppress the end of crawl summary and all warnings that are normally printed to standard error. On success print nothing. Fatal errors print a single error message line to standard error.
* -h  
  .IX Item "-h"
  Normally, if multiple files both point to the same inode then vmtouch will ignore all but the first it finds so as to avoid double-counting their pages. This option overrides this behaviour and double-counts anyways.

<a name="portability"></a>

# Portability

.IX Header "PORTABILITY"
The page residency summaries depend on \f(CWmincore(2) which first appeared in 4.4BSD but is not present on all unix systems.

The \f(CW`-l\*(C' and \f(CW\*(C\`-L\*(C' locking options depends on \f(CWmlock(2) or \f(CWmlockall(2), both of which are specified by \s-1POSIX\s0.1b-1993, Real-Time Extensions.

The \f(CW`-e\*(C' page eviction option is the least portable. On Linux it uses \f(CWposix\_fadvise(2) with \f(CW\*(C\`POSIX\_FADV\_DONTNEED\*(C' advice to inform the kernel that the file should be evicted from the file system cache. \f(CWposix\_fadvise(2) is specified by \s-1POSIX.1-2003 TC1.\s0 On FreeBSD, the pages are invalidated with \f(CWmsync(2)'s \f(CW\*(C\`MS\_INVALIDATE\*(C' flag. \f(CWmsync(2) is specified by \s-1POSIX\s0.1b-1993, Real-Time Extensions, although this call is not required to remove pages from the file system cache. Some systems like OpenBSD 4.3 don't have \f(CWposix\_fadvise(2), don't evict the pages on an \f(CWmsync(2)/\f(CW\*(C\`MS\_INVALIDATE\*(C', and don't evict the pages with \f(CWmadvise(2)/\f(CW\*(C\`MADV\_DONTNEED\*(C' so \f(CW\*(C\`-e\*(C' isn't supported on those systems yet. Using \f(CW\*(C\`-e\*(C' on systems that don't yet support it is a fatal error.

<a name="supported-systems"></a>

# Supported Systems

.IX Header "SUPPORTED SYSTEMS"
All vmtouch features have been confirmed to work on the following systems:

* Linux 2.6+  
  .IX Item "Linux 2.6+"
* FreeBSD 4.X  
  .IX Item "FreeBSD 4.X"
* FreeBSD 7.X  
  .IX Item "FreeBSD 7.X"
* Solaris 10  
  .IX Item "Solaris 10"
* \s-1OS X 10\s0.x  
  .IX Item "OS X 10.x"
* HP-UX 11.31+patches (see below)  
  .IX Item "HP-UX 11.31+patches (see below)"

Systems that support everything except eviction:

* OpenBSD 4.3  
  .IX Item "OpenBSD 4.3"

CPUs that have been tested:

* x86  
  .IX Item "x86"
* amd64 (x86-64)  
  .IX Item "amd64 (x86-64)"
* \s-1SPARC\s0  
  .IX Item "SPARC"
* ARMv7  
  .IX Item "ARMv7"

We would like to support as many systems as possible so please send us any success reports, failure reports or patches. Thanks!

<a name="system-notes"></a>

# System Notes

.IX Header "SYSTEM NOTES"
Shane Seymour did the HP-UX port and says that either 32-bit or 64-bit binaries can be compiled (just use \f(CW`+DD64\*(C' for 64-bit). However, \f(CWmincore(2) was added to HP-UX 11.31 via patches and at least the following patches need to be installed: \s-1PHKL_38651, PHKL_38708, PHKL_38686, PHKL_38688,\s0 and \s-1PHCO_38658\s0 (or patches that supersede those ones).

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
Not all the following manual pages may exist in every unix dialect to which vmtouch has been ported.

**vmstat**\|(8), **touch**\|(1), **mmap**\|(2), **mincore**\|(2), **mlock**\|(2), **mlockall**\|(2), **msync**\|(2), **madvise**\|(2), **posix\_fadvise**\|(2)

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Written by Doug Hoyte &lt;[doug@hcsw.org](mailto:doug@hcsw.org)&gt;
