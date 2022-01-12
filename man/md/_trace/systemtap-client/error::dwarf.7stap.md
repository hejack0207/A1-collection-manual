# error::dwarf(7stap) - dwarf debuginfo quality problems


<a name="description"></a>

# Description


Systemtap sometimes relies on ELF/DWARF debuginfo for programs being
instrumented to locate places to probe, or context variables to
read/write, just like a symbolic debugger does.  Even though
examination of the program's source code may show variables or lines
where probes may be desired, the compiler must preserve information
about them for systemtap (or a debugger such as gdb) to get pinpoint
access to the desired information.  If a script requires such data,
but the compiler did not preserve enough of it, pass-2 errors may
result.

Common conditions that trigger these problems include:


* debuginfo missing or mismatching  
  Sometimes debuginfo is installed, but does not match the binaries being
  probed.  See the _warning::debuginfo_ man page for more help for
  locating correct debuginfo.
  
* compiler version  
  Prior to GCC version 4.5, debuginfo quality was fairly limited.
  Often developers were advised to build their programs with 
  _-O0 -g_
  flags to disable optimization.  GCC version 4.5 introduced 
  a facility called "variable-tracking assignments" that allows it
  to generate high-quality debuginfo under full 
  _-O2 -g_
  optimization.  It is not perfect, but much better than before.
  Note that, due to another gcc bug (PR51358)
  _-O0 -g_
  can actually sometimes make debuginfo quality worse than for
  _-O2 -g_.
  
  Another related problem involves debuginfo quality for the
  prologue area of a function (PR15123), wherein a program
  compiled with CFLAGS=-mfentry (especially the kernel, for ftrace)
  may lack accurate debuginfo for the entry instructions for gcc
  prior to version 4.8.  If able, arrange to compile your programs
  with 
  _-grecord-gcc-switches_
  CFLAGS, and/or try rerunning systemtap with
  .nh
  _$PR15123_ASSUME_MFENTRY=1_.
  
* linux kbuild damaging debuginfo quality  
  An upstream kernel commit #2062afb4f804a put
  -fno-var-tracking-assignments into KCFLAGS, dramatically reducing
  debuginfo quality, which can cause debuginfo failures. The simplest
  fix is to **erase, excise, nay, eradicate** this line from the top
  level linux Makefile:
  
  .SAMPLE
  KBUILD_CFLAGS += [...] -fno-var-tracking-assignments [...]
  .ESAMPLE
  
* function inlining  
  Even modern gcc sometimes has problems with parameters for inlined functions.
  It may be necessary to change the script to probe at a slightly different place.
  Try a 
  _.statement()_ probe, instead of a _.function()_ probe,
  somewhere a few source lines into the body of the inlined function.  Or try
  putting a probe at the call site of the inlined function.  Or use the
  .nh
  _if @defined($var) { ... }_
  script language construct to test for the resolvability of the context
  variable before using it.
  
* instruction reordering  
  Heavily optimized code often smears the instructions from
  multiple source statements together.  This can leave systemtap with no place
  to choose to place a probe, especially a statement probe specified by line
  number.  Systemtap may advise to try a nearby line number, but these may
  not work well either.  Consider placing a probe by a statement wildcard
  or line number range.
  
* elfutils configuration  
  It is possible that the DWARF debuginfo being sought is available, but not in
  a format acceptable to the copy of elfutils used by systemtap.  For example,
  your copy of gcc might produce compressed debuginfo (_.zdebug\_*_ ELF
  sections or _.xz_ files) while your copy of elfutils might lack
  appropriate decompression capabilities.  Unfortunately, there is no easy
  way to tell if this is the problem.  If you're building your own copy
  of elfutils, ensure all decompression library headers/libraries are
  available at build time.
  
* debuginfo configuration  
  Some tools may generate debuginfo that is unsupported by systemtap, such
  as the linux kernel CONFIG_DEBUG_INFO_SPLIT (_.dwo_ files) option.
  Stick with plain ELF/DWARF (optinally split, Fedora-style), if possible.
  
  

<a name="alternatives"></a>

# Alternatives


In order to reduce reliance on ELF/DWARF debuginfo, consider the use of
statically compiled-in instrumentation, such as kernel tracepoints, or
_&lt;sys/sdt.h&gt;_
userspace markers.  Such instrumentation hook sites are relatively low
cost (just one NOP instruction for sdt.h), and nearly guarantee the
availability of parameter data and a reliable probe site,
all without reliance on debuginfo.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    http://dwarfstd.org/,
    http://sourceware.org/systemtap/wiki/TipContextVariables,
    http://gcc.gnu.org/wiki/Var_Tracking_Assignments,
    warning::debuginfo(7stap),
    warning::buildid(7stap),
    error::reporting(7stap)
