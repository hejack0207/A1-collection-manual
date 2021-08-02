# projects(5) - persistent project root definition


<a name="description"></a>

# Description

The
_/etc/projects_
file provides a mapping between numeric project identifiers and those directories
which are the roots of the quota tree.  Its format is simply:

    
    .in +5
    # comments are hash-prefixed
    # ...
    10:/export/cage
    42:/var/log
    .in -5

The
_/etc/projects_
file is optional, instead
**xfs_quota**(8)
can be used with the
**-p**
argument to specify a project root directly for each operation.


<a name="see-also"></a>

# See Also

**xfs_quota**(8),
**xfsctl**(3),
**projid**(5).
