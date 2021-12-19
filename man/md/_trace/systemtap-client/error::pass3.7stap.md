# error::pass3(7stap) - systemtap pass-3 errors


<a name="description"></a>

# Description

Errors during pass 3 (translation) occur only rarely.  


* unsupported code generation  
  Some script language constructs are not available in every
  probe point.  For example, the 
  _@perf()_
  counter-reading function may only be used in 
  _process.*_
  probes.
  

<a name="gathering-more-information"></a>

# Gathering More Information

Increasing the verbosity of pass-3 with an option such as
_--vp 002_
may help pinpoint the problem.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    stapprobes(3stap)
    error::reporting(7stap)
