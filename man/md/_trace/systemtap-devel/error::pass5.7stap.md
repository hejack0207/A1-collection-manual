# error::pass5(7stap) - systemtap pass-5 errors


<a name="description"></a>

# Description

Errors that occur during pass 5 (execution) can have a variety of causes.


* exceptional events during script execution  
  The systemtap translator and runtime include numerous error checks
  that aim to protect the systems and the users from mistakes or
  transient conditions.  The script may deliberately call the
  _error()_
  tapset function to signal a problem.  Some memory needed for
  accessing
  _$context_
  variables may be temporarily unavailable.  Consider using the 
  _try_/_catch_
  construct to wrap script fragments in exception-handling code.
  Consider using the
  _stap --suppress-handler-errors_
  or
  _stap --skip-badvars_
  option.
  
* resource exhaustion  
  One of several types of space or time resource limits may be
  exceeded by the script, including system overload, too many tuples
  to be stored in an array, etc.  Some of the error messages identify
  the constraint by macro name, which may be individually raised.
  Consider using the 
  _stap --suppress-handler-errors_
  and/or
  _stap -g --suppress-time-limits_
  options.  Extend or disable individual resource limits using the
  _stap -DSOME_LIMIT=NNNN_
  option.  The
  _stap -t_
  option may identify those probes that are taking too long.
  
  
* remote execution server problems  
  If you use the 
  _stap --remote_
  option to direct a systemtap script to be executed somewhere else,
  ensure that an SSH connection may be made to the remote host, and
  that it has the current systemtap runtime installed & available.
  
* installation/permission problems  
  It is possible that your copy of systemtap was not correctly
  installed.  For example, the
  _/usr/bin/staprun_
  program may lack the necessary setuid permissions, or your invoking
  userid might not have sufficient privileges (root, or
  _stapusr_
  and related group memberships).  Environment
  variables may interfere with locating
  _/usr/libexec/.../stapio_.
  
* security configuration  
  SecureBoot or other module signing machinery may be in effect,
  preventing **.ko** module loading.  A local or remote
  _stap-server_
  service would be necessary to securely manage keys.  This situation
  is detected automatically on most kernels, but on some, the
  _SYSTEMTAP_SIGN_
  environment varible may have to be set to trigger this extra
  signing-related processing.
  
  The normal kernel-module based systemtap backend may be more than
  your script requires.  Try
  .nh
  _stap&nbsp;--runtime=bpf _and/or_ stap&nbsp;--runtime=dyninst_
  backends.  Though they have inherent limitations, they operate
  with lesser privileges and perceived risks.
  
  It may be possible to disable secure/lockdown measures temporarily
  with the SysRQ+x keystroke, or permanently with
  .nh
  _sudo&nbsp;mokutil&nbsp;--disable-validation_
  and a reboot.
  
* errors from target program  
  The program invoked by the
  _stap -c CMD_
  option may exit with a non-zero code.
  
* uncaught exceptions in the target program  
  When using
  _--runtime=dyninst_
  you may encounter an issue where the target program aborts with a
  message like "terminate called after throwing an instance
  of 'foo_exception'".  This is unfortunately a limitation of Dyninst,
  which sometimes prevents exceptions from properly unwinding through
  instrumented code.
  
  

<a name="gathering-more-information"></a>

# Gathering More Information

Increasing the verbosity of pass-5
with an option such as
_--vp 00001_
can help pinpoint the problem.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    http://sourceware.org/systemtap/wiki/TipExhaustedResourceErrors,
    error::fault(7stap),
    error::reporting(7stap)
