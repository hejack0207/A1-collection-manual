# setcap(8) - set file capabilities

11 September 2018

```
setcap [-q] [-n <rootid>] [-v] {capabilities|-|-r} filename [ ... capabilitiesN fileN ]
```

<a name="description"></a>

# Description

In the absence of the
**-v**
(verify) option
**setcap**
sets the capabilities of each specified
_filename_
to the
_capabilities_
specified.  The optional
**-n &lt;rootid&gt;**
argument can be used to set the file capability for use only in a
namespace with this rootid owner. The
**-v**
option is used to verify that the specified capabilities are currently
associated with the file. If -v and -n are supplied, the
**-n &lt;rootid&gt;**
argument is also verified.

The
_capabilities_
are specified in the form described in
_cap_from_text_(3).

The special capability string,
**'-'**,
can be used to indicate that capabilities are read from the standard
input. In such cases, the capability set is terminated with a blank
line.

The special capability string,
**'-r'**,
is used to remove a capability set from a file. Note, setting an empty
capability set is
**not the same**
as removing it. An empty set can be used to guarantee a file is not
executed with privilege inspite of the fact that the prevailing
ambient+inheritable sets would otherwise bestow capabilities on
executed binaries.

The
**-q**
flag is used to make the program less verbose in its output.

<a name="exit-code"></a>

# Exit Code

The
**setcap**
program will exit with a 0 exit code if successful. On failure, the
exit code is 1.

<a name="see-also"></a>

# See Also

**cap_from_text**(3),
**cap_set_file**(3),
**getcap**(8)
