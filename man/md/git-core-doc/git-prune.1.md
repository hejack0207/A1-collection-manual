# git\-prune(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-prune - Prune all unreachable objects from the object database

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]
<synopsis>


```

<a name="description"></a>

# Description

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

In most cases, users should run _git gc_, which calls _git prune_. See the section "NOTES", below.


This runs _git fsck --unreachable_ using all the refs available in **refs/**, optionally with additional set of objects specified on the command line, and prunes all unpacked objects unreachable from any of these head objects from the object database. In addition, it prunes the unpacked objects that are also found in packs by running _git prune-packed_. It also removes entries from .git/shallow that are not reachable by any ref.

Note that unreachable, packed objects will remain. If this is not desired, see **git-repack**(1).

<a name="options"></a>

# Options


-n, --dry-run
Do not remove anything; just report what it would remove.

-v, --verbose
Report all removed objects.

--progress
Show progress.

--expire &lt;time&gt;
Only expire loose objects older than &lt;time&gt;.

--
Do not interpret any more arguments as options.

&lt;head&gt;...
In addition to objects reachable from any of our references, keep objects reachable from listed &lt;head&gt;s.

<a name="examples"></a>

# Examples


To prune objects not used by your repository or another that borrows from your repository via its **.git/objects/info/alternates**:

.if n \{.RS 4
.\}
    $ git prune $(cd ../another && git rev-parse --all)
.if n \{.RE
.\}


<a name="notes"></a>

# Notes


In most cases, users will not need to call _git prune_ directly, but should instead call _git gc_, which handles pruning along with many other housekeeping tasks.

For a description of which objects are considered for pruning, see _git fsck_'s --unreachable option.

<a name="see-also"></a>

# See Also


**git-fsck**(1), **git-gc**(1), **git-reflog**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
