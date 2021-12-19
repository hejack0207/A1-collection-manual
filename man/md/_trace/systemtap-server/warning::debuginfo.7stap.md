# warning::debuginfo(7stap) - systemtap missing-debuginfo warnings



<a name="description"></a>

# Description

For many symbolic probing operations, systemtap needs DWARF debuginfo for
the relevant binaries.  This often includes resolving function/statement
probes, or $context variables in related handlers.  DWARF debuginfo is
created by the compiler when using _CFLAGS -g_, and may
be found in the original binaries built during compilation, or may have
been split into separate files.  The
_SYSTEMTAP_DEBUGINFO_PATH_
environment variable affects where systemtap looks for these files.

If your operating system came from a distributor, check with them if
debuginfo packages or variants are available.  If your distributor does
not have debuginfo-equipped binaries at all, you may need to rebuild it.

Systemtap uses the 
_elfutils_
library to process ELF/DWARF files.  The version of elfutils used by systemtap
is the number after the slash in the 
_-V_
output:
.SAMPLE
% stap -V
Systemtap translator/driver (version 4.2/0.178, rpm 4.2-1.fc30)
Copyright (C) 2005-2019 Red Hat, Inc. and others
[...]
.ESAMPLE
This indicates systemtap version 4.2 with elfutils version 0.178.

New enough versions of elfutils (0.178+) enable systemtap to automatically
download correct debuginfo from servers run by you, your organization,
and/or someone on the public internet.  Try:
.SAMPLE
% export DEBUGINFOD_URLS=https://debuginfod.elfutils.org/
% export DEBUGINFOD_PROGRESS=1   # for progress messages, if you like
.ESAMPLE
and rerun systemtap.  It might just work.  If it doesn't, read on.


* kernel debuginfo  
  For scripts that target the kernel, systemtap may search for the
  _vmlinux_
  file created during its original build.  This is distinct from the
  boot-loader's compressed/stripped
  _vmlinuz_
  file, and much larger.  If you have a hand-built kernel, make sure
  it was built with the
  _CONFIG_DEBUG_INFO=y_
  option.  Some Linux distributions may include several kernel variants,
  including a confusingly named _kernel-debug_ (an alternative kernel,
  with its own _kernel-debug-debuginfo_ package), which is not the same
  thing as the _kernel-debuginfo_ (DWARF data for the base _kernel_).
  The
  _stap-prep_
  program can help install the right set.
  
* process debuginfo  
  For scripts that target user-space, systemtap may search for debuginfo.
  If you have hand-built binaries, use
  _CFLAGS=-g -O2_
  to compile them.
  
* minidebuginfo  
  On some systems, binaries may be compiled with a subset of debuginfo
  useful for function tracing and backtraces.  This 'Minidebuginfo' is
  a xz compressed section labeled .gnu_debugdata.  Support for
  minidebuginfo relies on elfutils version 0.156 or later.
  
* compressed debuginfo  
  On some systems, debuginfo may be available, but compressed into
  _.zdebug_*_
  sections.  Support for compressed debuginfo relies on elfutils
  version 0.153 or later.
  
* unnecessary debuginfo  
  In some cases, a script may be altered to avoid requiring debuginfo.
  For example, as script that uses
  _probe syscall.*_
  probes could try instead
  _probe nd_syscall.*_
  (for non-DWARF syscall): these work similarly, and use more intricate
  (fragile) tapset functions to extract system call arguments.  Another
  option is use of compiled-in instrumentation such as kernel tracepoints
  or user-space
  _&lt;sys/sdt.h&gt;_
  markers in libraries or executables, which do not require debuginfo.
  If debuginfo was required for resolving a complicated
  _$var-&gt;foo-&gt;bar_
  expression, it may be possible to use
  _@cast(var,"foo","foo.h")-&gt;foo-&gt;bar_
  to synthesize debuginfo for that type from a header file.
  

<a name="other-automation"></a>

# Other Automation


On some platforms, systemtap may advise what commands to run, in order
to download needed debuginfo.  Another possibility is to invoke systemtap
with the
_--download-debuginfo_
flag, which uses ABRT.
The
_stap-prep_
script included with systemtap may be able to download the
appropriate kernel debuginfo.  Another possibility is to install and
use a
_stap-server_
remote-compilation instance on a machine on your network, where
debuginfo and compilation resources can be centralized.  Try the
_stap --use-server_
option, in case such a server is already running.


<a name="see-also"></a>

# See Also

.nh
    gcc(1),
    stap(1),
    stappaths(7),
    stap-server(8),
    stap-prep(1),
    strip(1),
    warning::symbols(7stap),
    error::dwarf(7stap),
    error::reporting(7stap),
    error::contextvars(7stap),
    debuginfod(8),
    http://elfutils.org/,
    https://sourceware.org/elfutils/Debuginfod.html,
    http://fedoraproject.org/wiki/Features/MiniDebugInfo
