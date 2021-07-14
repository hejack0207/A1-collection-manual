# git\-count\-objects(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-count-objects - Count unpacked number of objects and their disk consumption

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git count-objects [-v] [-H | --human-readable]
<synopsis>


```

<a name="description"></a>

# Description


This counts the number of unpacked object files and disk space consumed by them, to help you decide when it is a good time to repack.

<a name="options"></a>

# Options


-v, --verbose
Report in more detail:

count: the number of loose objects

size: disk space consumed by loose objects, in KiB (unless -H is specified)

in-pack: the number of in-pack objects

size-pack: disk space consumed by the packs, in KiB (unless -H is specified)

prune-packable: the number of loose objects that are also present in the packs. These objects could be pruned using
**git prune-packed**.

garbage: the number of files in object database that are neither valid loose objects nor valid packs

size-garbage: disk space consumed by garbage files, in KiB (unless -H is specified)

alternate: absolute path of alternate object databases; may appear multiple times, one line per path. Note that if the path contains non-printable characters, it may be surrounded by double-quotes and contain C-style backslashed escape sequences.

-H, --human-readable
Print sizes in human readable format

<a name="git"></a>

# Git


Part of the **git**(1) suite
