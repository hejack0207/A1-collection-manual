# warning::symbols(7stap) - systemtap missing-symbols warnings



<a name="description"></a>

# Description


For some probing operations, where DWARF debugging data is not available,
systemtap needs ELF symbols for the relevant binaries.  This allows at
least probe addresses to be calculated, some variables resolved, and with
@cast() and headers, maybe even some types.


* kernel symbol table  
  Systemtap may need a linux-build style **System.map** file to find
  addresses of kernel functions/data.  It may be possible to create it
  by hand:
  .SAMPLE
  % su
  # cp /proc/kallsyms /boot/System.map-\`uname -r\`
  or
  # nm /lib/modules/\`uname -r\`/build/vmlinux &gt; /boot/System.map-\`uname -r\`
  .ESAMPLE
  
* minisymbols  
  On some systems, binaries may be compiled with a subset of symbols
  useful for function tracing and backtraces.  This 'Minisymbols' is
  a xz compressed section labeled .gnu_debugdata.  Support for
  minisymbols relies on elfutils version 0.156 or later.
  
* compressed symbols  
  On some systems, symbols may be available, but compressed into
  _.zdebug_*_
  sections.  Support for compressed symbols relies on elfutils
  version 0.153 or later.
  

<a name="see-also"></a>

# See Also

.nh
    stap(1),
    stappaths(7),
    strip(1),
    warning::debuginfo(7stap),
    error::dwarf(7stap),
    error::reporting(7stap),
    http://fedoraproject.org/wiki/Features/MiniDebugInfo
