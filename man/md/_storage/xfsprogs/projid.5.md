# projid(5) - the project name mapping file


<a name="description"></a>

# Description

The
_/etc/projid_
file provides a mapping between numeric project identifiers and a
simple human readable name (similar relationship to the one that
exists between usernames and uids).
Its format is simply:
    
    .in +5
    # comments are hash-prefixed
    # ...
    cage:10
    logfiles:42
    
    .in -5


This file is optional, if a project identifier cannot be mapped to
a name, it will be parsed and displayed as a numeric value.


<a name="see-also"></a>

# See Also

**xfs_quota**(8),
**xfsctl**(3),
**projects**(5).
