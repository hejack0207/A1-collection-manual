# error::pass1(7stap) - systemtap pass-1 errors


<a name="description"></a>

# Description

Errors that occur during pass 1 (parsing) usually mean
a basic syntax error of some sort occurred in the systemtap script.
There are several classes of problems possible:


* plain syntax error  
  The systemtap script parser detects a large variety of errors, such as
  missing operands, bad punctuation.  It tries to list what kinds of tokens
  it was expecting to see, and will show the region of the source code with
  the problem.  Please review the 
  _stap_(1)
  man page and/or the tutorial, to correct the script's syntax.
  
* grammar ambiguities  
  There is at least one known ambiguity in the systemtap grammar.  It relates
  to the optionality of 
  _;_
  (semicolon) separators between statements, and the
  _++_ and _--_
  increment/decrement operators.  If the parser indicates an error, consider
  adding some explicit
  _;_
  separators between nearby statements and try again.
  
* missing command line arguments  
  A systemtap script that uses the 
  _$N_ and _@N_
  constructs for substituting in command-line options may fail if not
  enough options were given on the stap command line.
  
* compatibility changes  
  Some versions of systemtap have changed the language incompatibly,
  for example by adding the try/catch keywords for exception handling.
  In such cases, rerun systemtap with the
  _--compatibility=VERSION_
  option, substituting the last systemtap version where your script
  was known to work.  You may also check the release-history NEWS file
  for compatibility changes.
  

<a name="gathering-more-information"></a>

# Gathering More Information

Increasing the verbosity of pass-1 with an option such as
_--vp 1_
can help pinpoint the problem.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    error::reporting(7stap)
