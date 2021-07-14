# git\-fmt\-merge\-msg(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-fmt-merge-msg - Produce a merge commit message

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log]
    git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] -F <file>
<synopsis>


```

<a name="description"></a>

# Description


Takes the list of merged objects on stdin and produces a suitable commit message to be used for the merge commit, usually to be passed as the _&lt;merge-message&gt;_ argument of _git merge_.

This command is intended mostly for internal use by scripts automatically invoking _git merge_.

<a name="options"></a>

# Options


--log[=&lt;n&gt;]
In addition to branch names, populate the log message with one-line descriptions from the actual commits that are being merged. At most &lt;n&gt; commits from each merge parent will be used (20 if &lt;n&gt; is omitted). This overrides the
**merge.log**
configuration variable.

--no-log
Do not list one-line descriptions from the actual commits being merged.

--[no-]summary
Synonyms to --log and --no-log; these are deprecated and will be removed in the future.

-m &lt;message&gt;, --message &lt;message&gt;
Use &lt;message&gt; instead of the branch names for the first line of the log message. For use with
**--log**.

-F &lt;file&gt;, --file &lt;file&gt;
Take the list of merged objects from &lt;file&gt; instead of stdin.

<a name="configuration"></a>

# Configuration


merge.branchdesc
In addition to branch names, populate the log message with the branch description text associated with them. Defaults to false.

merge.log
In addition to branch names, populate the log message with at most the specified number of one-line descriptions from the actual commits that are being merged. Defaults to false, and true is a synonym for 20.

merge.summary
Synonym to
**merge.log**; this is deprecated and will be removed in the future.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    $ git fetch origin master
    $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
.if n \{.RE
.\}


Print a log message describing a merge of the "master" branch from the "origin" remote.

<a name="see-also"></a>

# See Also


**git-merge**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
