# fork(3am) - basic process management

Free Software Foundation, Feb 02 2018

```
@load "fork" 
 pid = fork() 
 ret = waitpid(pid) 
 ret = wait();
```

<a name="description"></a>

# Description

The
_fork_
extension adds three functions, as follows.

* **fork()**  
  This function creates a new process. The return value is the zero
  in the child and the process-id number of the child in the parent,
  or -1 upon error. In the latter case,
  **ERRNO**
  indicates the problem.
  In the child, **PROCINFO["pid"]** and **PROCINFO["ppid"]**
  are updated to reflect the correct values.
* **waitpid()**  
  This function takes a numeric argument, which is the process-id to
  wait for. The return value is that of the
  _waitpid_(2)
  system call.
* **wait()**  
  This function waits for the first child to die.
  The return value is that of the
  _wait_(2)
  system call.
  

<a name="bugs"></a>

# Bugs

There is no corresponding
**exec()**
function.

The interfaces could be enhanced to provide more facilities,
including pulling out the various bits of the return status.

<a name="example"></a>

# Example

    @load "fork"
    ...
    if ((pid = fork()) == 0)
        print "hello from the child"
    else
        print "hello from the parent"

<a name="see-also"></a>

# See Also

_GAWK: Effective AWK Programming_,
_filefuncs_(3am),
_fnmatch_(3am),
_inplace_(3am),
_ordchr_(3am),
_readdir_(3am),
_readfile_(3am),
_revoutput_(3am),
_rwarray_(3am),
_time_(3am).

_fork_(2),
_wait_(2),
_waitpid_(2).

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

