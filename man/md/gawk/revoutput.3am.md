# revoutput(3am) - Reverse output strings sample extension

Free Software Foundation, Feb 21 2018

```
@load "revoutput" 
 BEGIN { REVOUT = 1 }    # Reverse all output strings
```

<a name="description"></a>

# Description

The
_revoutput_
extension
adds a simple output wrapper that reverses the characters in each output
line.
It's main purpose is to show how to write an output wrapper, although
it may be mildly amusing for the unwary.


<a name="example"></a>

# Example

    @load "revoutput"
    
    BEGIN {
        REVOUT = 1
        print "hello, world" > "/dev/stdout"
    }

The output from this program is:

    dlrow ,olleh

<a name="bugs"></a>

# Bugs

This extension does not affect the default standard output.

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

