# rwarray(3am) - write and read gawk arrays to/from files

Free Software Foundation, Feb 02 2018

```
@load "rwarray" 
 ret = writea(file, array)
ret = reada(file, array)
```

<a name="description"></a>

# Description

The
_rwarray_
extension adds two functions named
**writea()**.
and
**reada()**,
as follows.

* **writea()**  
  This function takes a string argument, which is the name of the
  file to which dump the array, and the array itself as the second
  argument.
  **writea()**
  understands multidimensional arrays.
  It returns one on success, or zero upon failure.
* **reada()**  
  is the inverse of
  **writea()**;
  it reads the file named as its first argument, filling in
  the array named as the second argument. It clears the array
  first.
  Here too, the return value is one on success and zero upon failure.

<a name="notes"></a>

# Notes

The array created by
**reada()**
is identical to that written by
**writea()**
in the sense that the contents are the same. However, due
to implementation issues, the array traversal order of the recreated
array will likely be different from that of the original array.
As array traversal order in AWK is by default undefined, this is
not (technically) a problem.  If you need to guarantee a particular
traversal order, use the array sorting features in
_gawk_
to do so.

The file contains binary data.  All integral values are written
in network byte order.
However, double precision floating-point values are written as
native binary data.  Thus, arrays containing only string data
can theoretically be dumped on systems with one byte order and
restored on systems with a different one, but this has not been tried.


<a name="example"></a>

# Example

    @load "rwarray"
    ...
    ret = writea("arraydump.bin", array)
    ...
    ret = reada("arraydump.bin", array)

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

