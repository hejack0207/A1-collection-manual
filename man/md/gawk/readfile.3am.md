# readfile(3am) - return the entire contents of a file as a string

Free Software Foundation, Feb 02 2018

```
@load "readfile" 
 result = readfile("/some/path") 
 For making whole files be single records: 
 @load "readfile"
BEGIN { PROCINFO["readfile"] = 1 }
```

<a name="description"></a>

# Description

The
_readfile_
extension adds a single function named
**readfile()**.
The argument is the name of the file to read.
The return value is a string containing the entire contents of
the requested file.

Upon error, the function returns the empty string and sets
**ERRNO**.

In addition, it adds an input parser that is activated if
PROCINFO["readfile"]
exists.
When activated, each input file is returned in its entirety as \f(CW$0.
\f(CWRT is set to the null string.



<a name="example"></a>

# Example

    @load "readfile"
    ...
    contents = readfile("/path/to/file");
    if (contents == "" && ERRNO != "") {
        print("problem reading file", ERRNO) > "/dev/stderr"
        ...
    }

<a name="see-also"></a>

# See Also

_GAWK: Effective AWK Programming_,
_filefuncs_(3am),
_fnmatch_(3am),
_fork_(3am),
_inplace_(3am),
_ordchr_(3am),
_readdir_(3am),
_revoutput_(3am),
_rwarray_(3am),
_time_(3am).

<a name="author"></a>

# Author

Arnold Robbins,
**[arnold@skeeve.com](mailto:arnold@skeeve.com)**.

<a name="copying-permissions"></a>

# Copying Permissions

Copyright © 2012, 2013, 2014, 2018,
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

