# time(3am) - time functions for gawk

Free Software Foundation, Nov 21 2019

```
@load "time" 
 time = gettimeofday()
ret = sleep(amount)
```

<a name="caution"></a>

# Caution

This extension is deprecated in favor of the
**timex**
extension in the
_gawkextlib_
project.  In the next major release of
_gawk_,
loading it will issue a warning.
It will be removed from the
_gawk_
distribution in the major release after the next one.

<a name="description"></a>

# Description

The
_time_
extension adds two functions named
**gettimeofday()**
and
**sleep()**,
as follows.

* **gettimeofday()**  
  This function returns the number of seconds since the Epoch
  as a floating-point value. It should have subsecond precision.
  It returns -1 upon error and sets
  **ERRNO**
  to indicate the problem.
* **sleep(**_seconds_**)**  
  This function attempts to sleep for the given amount of seconds, which
  may include a fractional portion.
  If
  _seconds_
  is negative, or the attempt to sleep fails,
  then it returns -1 and sets
  **ERRNO**.
  Otherwise, the function should return 0 after sleeping
  for the indicated amount of time.
  
  

<a name="example"></a>

# Example

    @load "time"
    ...
    printf "It is now %g seconds since the Epochen", gettimeofday()
    printf "Pausing for a while... " ; sleep(2.5) ; print "done"

<a name="see-also"></a>

# See Also

_GAWK: Effective AWK Programming_,
_filefuncs_(3am),
_fnmatch_(3am),
_fork_(3am),
_inplace_(3am),
_ordchr_(3am),
_readdir_(3am),
_readfile_(3am),
_revoutput_(3am),
_rwarray_(3am).

_gettimeofday_(2),
_nanosleep_(2),
_select_(2).

<a name="author"></a>

# Author

Arnold Robbins,
**[arnold@skeeve.com](mailto:arnold@skeeve.com)**.

<a name="copying-permissions"></a>

# Copying Permissions

Copyright © 2012, 2013, 2018,
Free Software Foundation, Inc.

Permission is granted to make and distribute verbatim copies of
this manual page provided the copyright notice and this permission
notice are preserved on all copies.

Permission is granted to copy and distribute modified versions of this
manual page under the conditions for verbatim copying, provided that
the entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

Permission is granted to copy and distribute translations of this
manual page into another language, under the above conditions for
modified versions, except that this permission notice may be stated in
a translation approved by the Foundation.

