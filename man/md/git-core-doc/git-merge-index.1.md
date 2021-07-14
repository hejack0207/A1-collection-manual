# git\-merge\-index(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-merge-index - Run a merge for files needing merging

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git merge-index [-o] [-q] <merge-program> (-a | [--] <file>*)
<synopsis>


```

<a name="description"></a>

# Description


This looks up the &lt;file&gt;(s) in the index and, if there are any merge entries, passes the SHA-1 hash for those files as arguments 1, 2, 3 (empty argument if no file), and &lt;file&gt; as argument 4. File modes for the three files are passed as arguments 5, 6 and 7.

<a name="options"></a>

# Options


--
Do not interpret any more arguments as options.

-a
Run merge against all files in the index that need merging.

-o
Instead of stopping at the first failed merge, do all of them in one shot - continue with merging even when previous merges returned errors, and only return the error code after all the merges.

-q
Do not complain about a failed merge program (a merge program failure usually indicates conflicts during the merge). This is for porcelains which might want to emit custom messages.

If _git merge-index_ is called with multiple &lt;file&gt;s (or -a) then it processes them in turn only stopping if merge returns a non-zero exit code.

Typically this is run with a script calling Git’s imitation of the _merge_ command from the RCS package.

A sample script called _git merge-one-file_ is included in the distribution.

ALERT ALERT ALERT! The Git "merge object order" is different from the RCS _merge_ program merge object order. In the above ordering, the original is first. But the argument order to the 3-way merge program _merge_ is to have the original in the middle. Don’t ask me why.

Examples:

.if n \{.RS 4
.\}
    torvalds@ppc970:~/merge-test> git merge-index cat MM
    This is MM from the original tree.                    # original
    This is modified MM in the branch A.                  # merge1
    This is modified MM in the branch B.                  # merge2
    This is modified MM in the branch B.                  # current contents
.if n \{.RE
.\}

or

.if n \{.RS 4
.\}
    torvalds@ppc970:~/merge-test> git merge-index cat AA MM
    cat: : No such file or directory
    This is added AA in the branch A.
    This is added AA in the branch B.
    This is added AA in the branch B.
    fatal: merge program failed
.if n \{.RE
.\}

where the latter example shows how _git merge-index_ will stop trying to merge once anything has returned an error (i.e., **cat** returned an error for the AA file, because it didn’t exist in the original, and thus _git merge-index_ didn’t even try to merge the MM thing).

<a name="git"></a>

# Git


Part of the **git**(1) suite
