# error::pass2(7stap) - systemtap pass-2 errors


<a name="description"></a>

# Description

Errors that occur during pass 2 (elaboration) can have a variety of causes.
Common types include:


* missing debuginfo  
  The script requires debuginfo to resolve a probe point, but could not
  find any.  See
  _error::dwarf_(7stap)
  and
  _warning::debuginfo_(7stap)
  for more details.
  
* unavailable probe point classes  
  Some types of probe points are only available on certain system versions,
  architectures, and configurations.  For example, user-space 
  _process.*_
  probes may require utrace or uprobes capability in the kernel for this
  architecture.
  
* unavailable probe points  
  Some probe points may be individually unavailable even when their class is
  fine.  For example,
  _kprobe.function("foobar")_
  may fail if function
  _foobar_
  does not exist in the kernel any more.  Debugging or symbol data may be absent for
  some types of 
  _.function_ or _.statement_
  probes; check for availability of debuginfo.  Try the
  _stap-prep_
  program to download possibly-required debuginfo.
  Use a wildcard parameter such as
  _stap -l 'kprobe.function("*foo*")'_
  to locate still-existing variants.  Use
  _!_ or _?_
  probe point suffixes to denote optional / preferred-alternatives, to let
  the working parts of a script continue.
  
* typos  
  There might be a spelling error in the probe point name ("sycsall" vs.
  "syscall").  Wildcard probes may not find a match at all in the
  tapsets.  Recheck the names using
  _stap -l PROBEPOINT_.
  Another common mistake is to use the
  _._
  operator instead of the correct 
  _-&gt;_
  when dereferencing context variable subfields or pointers:
  _$foo-&gt;bar-&gt;baz_
  even if in C one would say
  _foo-&gt;bar.baz_.
  
* unavailable context variables  
  Systemtap scripts often wish to refer to variables from the context of the
  probed programs using
  _$variable_
  notation.  These variables may not always be available, depending on versions
  of the compiler, debugging/optimization flags used, architecture, etc.  Use
  _stap -L PROBEPOINT_
  to list available context variables for given probes.  Use the
  _@defined()_
  expression to test for the resolvability of a context variable expression.
  Consider using the
  _stap --skip-badvars_
  option to silently replace misbehaving context variable expressions with zero.
  Experiment with the
  _stap --prologue-searching_
  option.
  
* module cache inconsistencies  
  Occasionally, the systemtap module cache ($HOME/.systemtap/cache) might 
  contain obsolete information from a prior system configuration/version,
  and produce false results as systemtap attempts to reuse it.  Retrying
  with
  _stap --poison-cache ..._
  forces new information to be generated.  
  **Note:**
  this should not happen and likely represents a systemtap bug.  Please
  report it.
  

<a name="gathering-more-information"></a>

# Gathering More Information

Increasing the verbosity of pass-2 with an option such as
_--vp 02_
can help pinpoint the problem.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    stap-prep(1),
    stapprobes(3stap),
    probe::*(3stap),
    error::dwarf(7stap),
    error::inode-uprobes(7stap),
    warning::debuginfo(7stap),
    error::reporting(7stap)
