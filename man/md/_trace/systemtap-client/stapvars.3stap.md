# stapvars(3stap) - systemtap variables


<a name="description"></a>

# Description

The following sections enumerate the public variables provided by
standard tapsets installed, (the installation path is show in the
stappaths (7) manual page).  Each variable is described with a
type, and its behavior/restrictions.
The syntax is the same as printed with the 
_stap_ option _-p2_.
Examples:


* example1:long  
  Variable "example1" contains an integer.
  
* example2:string [long]  
  Variable "example2" is an array of strings, indexed by integers.
  

<a name="argv"></a>

### ARGV



* argc:long  
  Contains the value of the  
  $#
  value: the number of command line arguments passed to the systemtap script.
  It is initialized with an implicit begin(-1) probe.
  
* argv:string [long]  
  Contains each command line argument as a string.  argv[1] will equal @1 if
  there was at least one command line argument.  Arguments beyond #32 are not
  transcribed, and produce a warning message within the begin(-1) probe that
  initializes this array.
  

<a name="null"></a>

### NULL



* NULL:long  
  Simply defined as the number 0.
  

<a name="files"></a>

# Files


* More files and their corresponding paths can be found in the stappaths (7) manual page.  
  

<a name="see-also"></a>

# See Also

.nh
    stap(1)
    stappaths(7)
