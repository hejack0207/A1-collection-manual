# ordchr(3am) - convert characters to strings and vice versa

Free Software Foundation, Feb 02 2018

```
@load "ordchr" 
 number = ord("A")
string = chr(65)
```

<a name="description"></a>

# Description

The
_ordchr_
extension adds two functions named
**ord()**.
and
**chr()**,
as follows.

* **ord()**  
  This function takes a string argument, and returns the
  numeric value of the first character in the string.
* **chr()**  
  This function takes a numeric argument and returns a string
  whose first character is that represented by the number.

These functions are inspired by the Pascal language functions
of the same name.



<a name="example"></a>

# Example

    @load "ordchr"
    ...
    printf("The numeric value of 'A' is %den", ord("A"))
    printf("The string value of 65 is %sen", chr(65))

<a name="see-also"></a>

# See Also

_GAWK: Effective AWK Programming_,
_filefuncs_(3am),
_fnmatch_(3am),
_fork_(3am),
_inplace_(3am),
_readdir_(3am),
_readfile_(3am),
_revoutput_(3am),
_rwarray_(3am),
_time_(3am).

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

