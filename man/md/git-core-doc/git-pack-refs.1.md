# git\-pack\-refs(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-pack-refs - Pack heads and tags for efficient repository access

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git pack-refs [--all] [--no-prune]
<synopsis>


```

<a name="description"></a>

# Description


Traditionally, tips of branches and tags (collectively known as _refs_) were stored one file per ref in a (sub)directory under **$GIT\_DIR/refs** directory. While many branch tips tend to be updated often, most tags and some branch tips are never updated. When a repository has hundreds or thousands of tags, this one-file-per-ref format both wastes storage and hurts performance.

This command is used to solve the storage and performance problem by storing the refs in a single file, **$GIT\_DIR/packed-refs**. When a ref is missing from the traditional **$GIT\_DIR/refs** directory hierarchy, it is looked up in this file and used if found.

Subsequent updates to branches always create new files under **$GIT\_DIR/refs** directory hierarchy.

A recommended practice to deal with a repository with too many refs is to pack its refs with **--all** once, and occasionally run **git pack-refs**. Tags are by definition stationary and are not expected to change. Branch heads will be packed with the initial **pack-refs --all**, but only the currently active branch heads will become unpacked, and the next **pack-refs** (without **--all**) will leave them unpacked.

<a name="options"></a>

# Options


--all
The command by default packs all tags and refs that are already packed, and leaves other refs alone. This is because branches are expected to be actively developed and packing their tips does not help performance. This option causes branch tips to be packed as well. Useful for a repository with many branches of historical interests.

--no-prune
The command usually removes loose refs under
**$GIT\_DIR/refs**
hierarchy after packing them. This option tells it not to.

<a name="bugs"></a>

# Bugs


Older documentation written before the packed-refs mechanism was introduced may still say things like ".git/refs/heads/&lt;branch&gt; file exists" when it means "branch &lt;branch&gt; exists".

<a name="git"></a>

# Git


Part of the **git**(1) suite
