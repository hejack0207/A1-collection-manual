# git\-merge\-file(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-merge-file - Run a three-way file merge

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git merge-file [-L <current-name> [-L <base-name> [-L <other-name>]]]
            [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
            [--[no-]diff3] <current-file> <base-file> <other-file>
<synopsis>


```

<a name="description"></a>

# Description


_git merge-file_ incorporates all changes that lead from the **&lt;base-file&gt;** to **&lt;other-file&gt;** into **&lt;current-file&gt;**. The result ordinarily goes into **&lt;current-file&gt;**. _git merge-file_ is useful for combining separate changes to an original. Suppose **&lt;base-file&gt;** is the original, and both **&lt;current-file&gt;** and **&lt;other-file&gt;** are modifications of **&lt;base-file&gt;**, then _git merge-file_ combines both changes.

A conflict occurs if both **&lt;current-file&gt;** and **&lt;other-file&gt;** have changes in a common segment of lines. If a conflict is found, _git merge-file_ normally outputs a warning and brackets the conflict with lines containing &lt;&lt;&lt;&lt;&lt;&lt;&lt; and &gt;&gt;&gt;&gt;&gt;&gt;&gt; markers. A typical conflict will look like this:

.if n \{.RS 4
.\}
    <<<<<<< A
    lines in file A
    =======
    lines in file B
    >>>>>>> B
.if n \{.RE
.\}

If there are conflicts, the user should edit the result and delete one of the alternatives. When **--ours**, **--theirs**, or **--union** option is in effect, however, these conflicts are resolved favouring lines from **&lt;current-file&gt;**, lines from **&lt;other-file&gt;**, or lines from both respectively. The length of the conflict markers can be given with the **--marker-size** option.

The exit value of this program is negative on error, and the number of conflicts otherwise (truncated to 127 if there are more than that many conflicts). If the merge was clean, the exit value is 0.

_git merge-file_ is designed to be a minimal clone of RCS _merge_; that is, it implements all of RCS _merge_'s functionality which is needed by **git**(1).

<a name="options"></a>

# Options


-L &lt;label&gt;
This option may be given up to three times, and specifies labels to be used in place of the corresponding file names in conflict reports. That is,
**git merge-file -L x -L y -L z a b c**
generates output that looks like it came from files x, y and z instead of from files a, b and c.

-p
Send results to standard output instead of overwriting
**&lt;current-file&gt;**.

-q
Quiet; do not warn about conflicts.

--diff3
Show conflicts in "diff3" style.

--ours, --theirs, --union
Instead of leaving conflicts in the file, resolve conflicts favouring our (or their or both) side of the lines.

<a name="examples"></a>

# Examples


**git merge-file README.my README README.upstream**
combines the changes of README.my and README.upstream since README, tries to merge them and writes the result into README.my.

**git merge-file -L a -L b -L c tmp/a123 tmp/b234 tmp/c345**
merges tmp/a123 and tmp/c345 with the base tmp/b234, but uses labels
**a**
and
**c**
instead of
**tmp/a123**
and
**tmp/c345**.

<a name="git"></a>

# Git


Part of the **git**(1) suite
