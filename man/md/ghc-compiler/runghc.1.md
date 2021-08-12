# runghc(1) - program to run Haskell programs without first having to compile them.

28 NOVEMBER 2007

```
runghc  [runghc|flags] [GHC|flags] module [program|flags]...

```

<a name="description"></a>

# Description

**runghc**
is considered a non-interactive interpreter and part of The Glasgow Haskell Compiler. 
**runghc**
is a compiler that automatically runs its results at the end.  


<a name="options"></a>

# Options


* the flags are:   
* **-f**  
  it tells runghc which GHC to use to run the program. If it is not given then runghc will search for GHC in the directories in the system search path. runghc -f /path/to/ghc
* **--**  
  runghc will try to work out where the boundaries between [runghc flags] and [GHC flags], and [GHC flags] and module are, but you can use a -- flag if it doesn't get it right. For example, runghc -- -fglasgow-exts Foo 
  means runghc won't try to use glasgow-exts as the path to GHC, but instead will pass the flag to GHC.
  

<a name="examples"></a>

# Examples


* **runghc foo**  

**runghc -f /path/to/ghc foo**

* **runghc -- -fglasgow-exts Foo**  
  

<a name="see-also"></a>

# See Also

**ghc**(1),
**ghci**(1).  


<a name="copyright"></a>

# Copyright

Copyright 2002, The University Court of the University of Glasgow. All rights reserved.


<a name="author"></a>

# Author

This manual page was written by Efrain Valles Pulgar &lt;[effie.jayx@gmail.com](mailto:effie.jayx@gmail.com)&gt;. This is free documentation; see the GNU 
General Public Licence version 2 or later for copying conditions. There is NO WARRANTY.

