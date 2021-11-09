# error::pass4(7stap) - systemtap pass-4 errors



<a name="description"></a>

# Description

Errors that occur during pass 4 (compilation) have generally only a few
causes:


* kernel or OS version changes  
  The systemtap runtime and embedded-C fragments in the tapset library
  are designed to be portable across a wide range of OS versions.  However,
  incompatibilities can occur when some OS changes occur, such as kernel
  modifications that change functions, types, or macros referenced 
  by systemtap.  Upstream (git://sourceware.org/git/systemtap.git) builds
  of systemtap are often quickly updated to include relevant fixes, so try
  getting or making an updated build.  Reworded: build systemtap from git
  for use with very young kernels.
  If the issue persists, report the problem to the systemtap developers.
  
* buggy embedded-C code  
  Embedded-C code in your own guru-mode script cannot be checked by systemtap,
  and is passed through verbatim to the compiler.  Errors in such snippets of
  code may be found during the pass-4 compiler invocation, though may be hard
  to identify by the compiler errors.
  
* incompatible embedded-C code  
  The interface standards between systemtap-generated code and embedded-C code
  occasionally change.  For example, before version 1.8, arguments were passed
  using macros
  _THIS-&gt;foo_ and _THIS-&gt;__retvalue_
  but from version 1.8 onward, using
  _STAP_ARG_foo_ and _STAP_RETVALUE_.
  Adjust your embedded-C code to current standards, or use the
  _stap --compatible=VERSION_
  option to make systemtap use a different one.
  
* compiler bugs and mysteries  
  Messages such as "internal compiler error" suggest compiler problems.  These
  should be reported to the compiler developers in the form of a preprocessed
  _.i_
  file, plus the compiler command line.  To gather relevant information, run
  .SAMPLE
  stap -k --vp 0003 -p4 ....
  .ESAMPLE
  Systemtap will report the saved temporary directory, and the compiler
  command line it attempted.  Go to the directory to find he main generated
  file
  _stap_NNNNN_src.c_.
  Force the compiler to produce a preprocessed file with:
  .SAMPLE
  make -C /lib/modules/\`uname -r\`/build M=\`pwd\` stap_NNNNN_src.i
  .ESAMPLE
  (note the
  _.i_
  suffix), and the compiler command line should be in the file
  _.stap_NNNNN_src.i.cmd_.
  

<a name="see-also"></a>

# See Also

.nh
    stap(1),
    error::reporting(7stap)
