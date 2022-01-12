# stap(7) - systemtap configurable file paths



<a name="description"></a>

# Description

This manual page was generated for systemtap 4.5.
The following section will list the main paths in systemtap that are 
important to know and may be required to reference.

* /usr/share/systemtap/tapset/  
  The directory for the standard probe-alias / function tapset library,
  unless overridden by the
  _SYSTEMTAP_TAPSET_
  environment variable or the
  _XDG_DATA_DIRS_
  environment variable.
  These are described in the
  _stapprobes_(3stap),
  _probe::*_(3stap),
  and
  _function::*_(3stap)
  manual pages.
* /usr/share/systemtap/runtime/  
  The runtime sources, unless overridden by the
  _SYSTEMTAP_RUNTIME_
  environment variable.
* /usr/bin/staprun  
  The auxiliary program supervising module loading, interaction, and
  unloading.
* /etc/stap-exporter  
  The default directory to search for ***.stp** files, for exporting to HTTP.
* /usr/libexec/systemtap/stapio  
  The auxiliary program for module input and output handling.
* /usr/include/sys/sdt.h  
  Location of the &lt;sys/sdt.h&gt; headers.
* Kernel debuginfo Path: /usr/lib/debug/lib/modules/$(uname -r)/  
  The location of kernel debugging information when packaged into the
  _kernel-debuginfo_
  RPM, unless overridden by the
  _SYSTEMTAP_DEBUGINFO_PATH_
  environment variable.  The default value for this variable is
  _\+:.debug:/usr/lib/debug:build_.
  elfutils searches vmlinux in this path and it interprets the path as a base
  directory of which various subdirectories will be searched for finding debuginfo
  for the kernel, kernel modules, and user-space binaries.
  By default, systemtap will also look for vmlinux in these locations:
  
  .SAMPLE
  /boot/vmlinux-\`uname -r\` 
  /lib/modules/\`uname -r\`/vmlinux
  /lib/modules/\`uname -r\`/vmlinux.debug
  /lib/modules/\`uname -r\`/build/vmlinux
  /lib/modules/\`uname -r\`/.debug/vmlinux.debug
  /usr/lib/debug/lib/modules/\`uname -r\`/vmlinux.debug
  /var/cache/abrt-di/usr/debug/lib/modules/\`uname -r\`/
  /var/cache/abrt-di/usr/lib/debug/lib/modules/\`uname -r\`/vmlinux.debug

.ESAMPLE

*       
  Corresponding source files are usually located under /usr/src/debug/.
  Further file information on user-space applications can be determined per-basis using
  rpm -ql &lt;package&gt;-debuginfo. For supported user-space applications information please 
  visit the systemtap wiki.
  
  With elfutils version &gt;0.178, systemtap can automatically download
  debugging information from debuginfod servers.  You can try it by
  setting an environment variable or two:
  .SAMPLE
  export DEBUGINFOD_URLS=https://debuginfod.elfutils.org/
  export DEBUGINFOD_PROGRESS=1
  .ESAMPLE
  
* $HOME/.systemtap  
  Systemtap data directory for cached systemtap files, unless overridden
  by the
  _SYSTEMTAP_DIR_
  environment variable.
* /tmp/stapXXXXXX  
  Temporary directory for systemtap files, including translated C code
  and kernel object.
* /lib/modules/VERSION/build  
  The location of kernel module building infrastructure.
* /usr/share/doc/systemtap*/examples  
  Examples with greater detail can be found here. Each example comes with a .txt
  or .meta file explaining what the example, sample or demo does and how it is
  ordinarily run.  See also online at:
  .nh
  _https://sourceware.org/systemtap/examples/_
* $SYSTEMTAP_DIR/ssl/server  
  User's server-side SSL certificate database. If SYSTEMTAP_DIR is not
  set, the default is $HOME/.systemtap.
* $SYSTEMTAP_DIR/ssl/client  
  User's private client-side SSL certificate database. If SYSTEMTAP_DIR is not
  set, the default is $HOME/.systemtap.
* /etc/systemtap/ssl/client  
  Global client-side SSL certificate database.
* /etc/systemtap/staprun/  
  _staprun_\[aq]s trusted signer certificate database.
* /etc/sysconfig/stap-server  
  stap-server service global configuration file.
* /etc/sysconfig/stap-exporter  
  stap-exporter service global configuration file.
* /var/run/stap-server/  
  stap-server service default location of status files for running servers.
* /var/log/stap-server/log  
  stap-server service default log file.
  

<a name="see-also"></a>

# See Also

.nh
    stapprobes(3stap),
    staprun(8),
    stapvars(3stap),
    stapex(3stap),
    stap-server(8),
    awk(1),
    gdb(1)
    http://sourceware.org/elfutils/Debuginfod.html
    

<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**,**&lt;systemtap@sourceware.org&gt;**.
