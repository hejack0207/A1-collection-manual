# fnmatch(3am) - compare a string against a filename wildcard

Free Software Foundation, Feb 21 2018

```
@load "fnmatch" 
 result = fnmatch(pattern, string, flags)
```

<a name="description"></a>

# Description

The
_fnmatch_
extension provides an AWK interface to the
_fnmatch_(3)
routine.  It adds a single function named
**fnmatch()**,
one predefined variable
(**FNM_NOMATCH**),
and an array of flag values named
**FNM**.

The first argument is the filename wildcard to match, the second
is the filename string, and the third is either zero,
or the bitwise OR of one or more of the flags in the
**FNM**
array.

The return value is zero on success,
**FNM_NOMATCH**
if the string did not match the pattern, or
a different non-zero value if an error occurred.

The flags are follows:

* **FNM["CASEFOLD"]**  
  Corresponds to the
  **FNM_CASEFOLD**
  flag as defined in
  _fnmatch_(3).
* **FNM["FILE\_NAME"]**  
  Corresponds to the
  **FNM_FILE_NAME**
  flag as defined in
  _fnmatch_(3).
* **FNM["LEADING\_DIR"]**  
  Corresponds to the
  **FNM_LEADING_DIR**
  flag as defined in
  _fnmatch_(3).
* **FNM["NOESCAPE"]**  
  Corresponds to the
  **FNM_NOESCAPE**
  flag as defined in
  _fnmatch_(3).
* **FNM["PATHNAME"]**  
  Corresponds to the
  **FNM_PATHNAME**
  flag as defined in
  _fnmatch_(3).
* **FNM["PERIOD"]**  
  Corresponds to the
  **FNM_PERIOD**
  flag as defined in
  _fnmatch_(3).


<a name="notes"></a>

# Notes

Nothing prevents AWK code from changing the predefined
variable
**FNM_NOMATCH**,
but doing so may cause strange results.


<a name="example"></a>

# Example

    @load "fnmatch"
    ...
    flags = or(FNM["PERIOD"], FNM["NOESCAPE"])
    if (fnmatch("*.a", "foo.c", flags) == FNM_NOMATCH)
    	print "no match"

<a name="see-also"></a>

# See Also

_GAWK: Effective AWK Programming_,
_filefuncs_(3am),
_fork_(3am),
_inplace_(3am),
_ordchr_(3am),
_readdir_(3am),
_readfile_(3am),
_revoutput_(3am),
_rwarray_(3am),
_time_(3am).

_fnmatch_(3).

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

