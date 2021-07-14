# git\-mktree(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-mktree - Build a tree-object from ls-tree formatted text

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git mktree [-z] [--missing] [--batch]
<synopsis>


```

<a name="description"></a>

# Description


Reads standard input in non-recursive **ls-tree** output format, and creates a tree object. The order of the tree entries is normalized by mktree so pre-sorting the input is not required. The object name of the tree object built is written to the standard output.

<a name="options"></a>

# Options


-z
Read the NUL-terminated
**ls-tree -z**
output instead.

--missing
Allow missing objects. The default behaviour (without this option) is to verify that each tree entry’s sha1 identifies an existing object. This option has no effect on the treatment of gitlink entries (aka "submodules") which are always allowed to be missing.

--batch
Allow building of more than one tree object before exiting. Each tree is separated by as single blank line. The final new-line is optional. Note - if the
**-z**
option is used, lines are terminated with NUL.

<a name="git"></a>

# Git


Part of the **git**(1) suite
