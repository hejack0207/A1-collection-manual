# revtwoway(3am) - Reverse strings sample two-way processor extension

Free Software Foundation, Feb 21 2018

```
@load "revtwoway" 

```
    BEGIN {
        cmd = "/magic/mirror"
        print "hello, world" |& cmd
        cmd |& getline result
        print result
        close(cmd)
    }

<a name="description"></a>

# Description

The
_revtwoway_
extension
adds a simple two-way processor that reverses the characters
in each line sent to it for reading back by the AWK program.
It's main purpose is to show how to write a two-way extension, although
it may also be mildly amusing.


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

