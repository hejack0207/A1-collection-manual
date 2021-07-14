# git\-pack\-redundant(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-pack-redundant - Find redundant pack files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git pack-redundant [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
<synopsis>


```

<a name="description"></a>

# Description


This program computes which packs in your repository are redundant. The output is suitable for piping to **xargs rm** if you are in the root of the repository.

_git pack-redundant_ accepts a list of objects on standard input. Any objects given will be ignored when checking which packs are required. This makes the following command useful when wanting to remove packs which contain unreachable objects.

git fsck --full --unreachable | cut -d ' ' -f3 | \e git pack-redundant --all | xargs rm

<a name="options"></a>

# Options


--all
Processes all packs. Any filenames on the command line are ignored.

--alt-odb
Don’t require objects present in packs from alternate object directories to be present in local packs.

--verbose
Outputs some statistics to stderr. Has a small performance penalty.

<a name="see-also"></a>

# See Also


**git-pack-objects**(1) **git-repack**(1) **git-prune-packed**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
