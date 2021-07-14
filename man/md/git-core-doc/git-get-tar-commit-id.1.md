# git\-get\-tar\-commi(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-get-tar-commit-id - Extract commit ID from an archive created using git-archive

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git get-tar-commit-id
<synopsis>


```

<a name="description"></a>

# Description


Read a tar archive created by _git archive_ from the standard input and extract the commit ID stored in it. It reads only the first 1024 bytes of input, thus its runtime is not influenced by the size of the tar archive very much.

If no commit ID is found, _git get-tar-commit-id_ quietly exists with a return code of 1. This can happen if the archive had not been created using _git archive_ or if the first parameter of _git archive_ had been a tree ID instead of a commit ID or tag.

<a name="git"></a>

# Git


Part of the **git**(1) suite
