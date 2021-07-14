# git\-prune\-packed(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-prune-packed - Remove extra objects that are already in pack files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git prune-packed [-n|--dry-run] [-q|--quiet]
<synopsis>


```

<a name="description"></a>

# Description


This program searches the **$GIT\_OBJECT\_DIRECTORY** for all objects that currently exist in a pack file as well as the independent object directories.

All such extra objects are removed.

A pack is a collection of objects, individually compressed, with delta compression applied, stored in a single file, with an associated index file.

Packs are used to reduce the load on mirror systems, backup engines, disk storage, etc.

<a name="options"></a>

# Options


-n, --dry-run
Don’t actually remove any objects, only show those that would have been removed.

-q, --quiet
Squelch the progress indicator.

<a name="see-also"></a>

# See Also


**git-pack-objects**(1) **git-repack**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
