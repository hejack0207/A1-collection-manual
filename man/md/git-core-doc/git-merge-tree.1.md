# git\-merge\-tree(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-merge-tree - Show three-way merge without touching index

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git merge-tree <base-tree> <branch1> <branch2>
<synopsis>


```

<a name="description"></a>

# Description


Reads three tree-ish, and output trivial merge results and conflicting stages to the standard output. This is similar to what three-way _git read-tree -m_ does, but instead of storing the results in the index, the command outputs the entries to the standard output.

This is meant to be used by higher level scripts to compute merge results outside of the index, and stuff the results back into the index. For this reason, the output from the command omits entries that match the &lt;branch1&gt; tree.

<a name="git"></a>

# Git


Part of the **git**(1) suite
