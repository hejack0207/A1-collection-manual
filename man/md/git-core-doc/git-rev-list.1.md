# git\-rev\-list(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-rev-list - Lists commit objects in reverse chronological order

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git rev-list [ --max-count=<number> ]
                 [ --skip=<number> ]
                 [ --max-age=<timestamp> ]
                 [ --min-age=<timestamp> ]
                 [ --sparse ]
                 [ --merges ]
                 [ --no-merges ]
                 [ --min-parents=<number> ]
                 [ --no-min-parents ]
                 [ --max-parents=<number> ]
                 [ --no-max-parents ]
                 [ --first-parent ]
                 [ --remove-empty ]
                 [ --full-history ]
                 [ --not ]
                 [ --all ]
                 [ --branches[=<pattern>] ]
                 [ --tags[=<pattern>] ]
                 [ --remotes[=<pattern>] ]
                 [ --glob=<glob-pattern> ]
                 [ --ignore-missing ]
                 [ --stdin ]
                 [ --quiet ]
                 [ --topo-order ]
                 [ --parents ]
                 [ --timestamp ]
                 [ --left-right ]
                 [ --left-only ]
                 [ --right-only ]
                 [ --cherry-mark ]
                 [ --cherry-pick ]
                 [ --encoding=<encoding> ]
                 [ --(author|committer|grep)=<pattern> ]
                 [ --regexp-ignore-case | -i ]
                 [ --extended-regexp | -E ]
                 [ --fixed-strings | -F ]
                 [ --date=<format>]
                 [ [ --objects | --objects-edge | --objects-edge-aggressive ]
                   [ --unpacked ]
                   [ --filter=<filter-spec> [ --filter-print-omitted ] ] ]
                 [ --missing=<missing-action> ]
                 [ --pretty | --header ]
                 [ --bisect ]
                 [ --bisect-vars ]
                 [ --bisect-all ]
                 [ --merge ]
                 [ --reverse ]
                 [ --walk-reflogs ]
                 [ --no-walk ] [ --do-walk ]
                 [ --count ]
                 [ --use-bitmap-index ]
                 <commit>... [ -- <paths>... ]
<synopsis>


```

<a name="description"></a>

# Description


List commits that are reachable by following the **parent** links from the given commit(s), but exclude commits that are reachable from the one(s) given with a _^_ in front of them. The output is given in reverse chronological order by default.

You can think of this as a set operation. Commits given on the command line form a set of commits that are reachable from any of them, and then commits reachable from any of the ones given with _^_ in front are subtracted from that set. The remaining commits are what comes out in the command’s output. Various other options and paths parameters can be used to further limit the result.

Thus, the following command:

.if n \{.RS 4
.\}
            $ git rev-list foo bar ^baz
.if n \{.RE
.\}


means "list all the commits which are reachable from _foo_ or _bar_, but not from _baz_".

A special notation "_&lt;commit1&gt;_.._&lt;commit2&gt;_" can be used as a short-hand for "^'&lt;commit1&gt;' _&lt;commit2&gt;_". For example, either of the following may be used interchangeably:

.if n \{.RS 4
.\}
            $ git rev-list origin..HEAD
            $ git rev-list HEAD ^origin
.if n \{.RE
.\}


Another special notation is "_&lt;commit1&gt;_..._&lt;commit2&gt;_" which is useful for merges. The resulting set of commits is the symmetric difference between the two operands. The following two commands are equivalent:

.if n \{.RS 4
.\}
            $ git rev-list A B --not $(git merge-base --all A B)
            $ git rev-list A...B
.if n \{.RE
.\}


_rev-list_ is a very essential Git command, since it provides the ability to build and traverse commit ancestry graphs. For this reason, it has a lot of different options that enables it to be used by commands as different as _git bisect_ and _git repack_.

<a name="options"></a>

# Options


<a name="commit-limiting"></a>

### Commit Limiting


Besides specifying a range of commits that should be listed using the special notations explained in the description, additional commit limiting may be applied.

Using more options generally further limits the output (e.g. **--since=&lt;date1&gt;** limits to commits newer than **&lt;date1&gt;**, and using it with **--grep=&lt;pattern&gt;** further limits to commits whose log message has a line that matches **&lt;pattern&gt;**), unless otherwise noted.

Note that these are applied before commit ordering and formatting options, such as **--reverse**.

-&lt;number&gt;, -n &lt;number&gt;, --max-count=&lt;number&gt;
Limit the number of commits to output.

--skip=&lt;number&gt;
Skip
_number_
commits before starting to show the commit output.

--since=&lt;date&gt;, --after=&lt;date&gt;
Show commits more recent than a specific date.

--until=&lt;date&gt;, --before=&lt;date&gt;
Show commits older than a specific date.

--max-age=&lt;timestamp&gt;, --min-age=&lt;timestamp&gt;
Limit the commits output to specified time range.

--author=&lt;pattern&gt;, --committer=&lt;pattern&gt;
Limit the commits output to ones with author/committer header lines that match the specified pattern (regular expression). With more than one
**--author=&lt;pattern&gt;**, commits whose author matches any of the given patterns are chosen (similarly for multiple
**--committer=&lt;pattern&gt;**).

--grep-reflog=&lt;pattern&gt;
Limit the commits output to ones with reflog entries that match the specified pattern (regular expression). With more than one
**--grep-reflog**, commits whose reflog message matches any of the given patterns are chosen. It is an error to use this option unless
**--walk-reflogs**
is in use.

--grep=&lt;pattern&gt;
Limit the commits output to ones with log message that matches the specified pattern (regular expression). With more than one
**--grep=&lt;pattern&gt;**, commits whose message matches any of the given patterns are chosen (but see
**--all-match**).

--all-match
Limit the commits output to ones that match all given
**--grep**, instead of ones that match at least one.

--invert-grep
Limit the commits output to ones with log message that do not match the pattern specified with
**--grep=&lt;pattern&gt;**.

-i, --regexp-ignore-case
Match the regular expression limiting patterns without regard to letter case.

--basic-regexp
Consider the limiting patterns to be basic regular expressions; this is the default.

-E, --extended-regexp
Consider the limiting patterns to be extended regular expressions instead of the default basic regular expressions.

-F, --fixed-strings
Consider the limiting patterns to be fixed strings (don’t interpret pattern as a regular expression).

-P, --perl-regexp
Consider the limiting patterns to be Perl-compatible regular expressions.

Support for these types of regular expressions is an optional compile-time dependency. If Git wasn’t compiled with support for them providing this option will cause it to die.

--remove-empty
Stop when a given path disappears from the tree.

--merges
Print only merge commits. This is exactly the same as
**--min-parents=2**.

--no-merges
Do not print commits with more than one parent. This is exactly the same as
**--max-parents=1**.

--min-parents=&lt;number&gt;, --max-parents=&lt;number&gt;, --no-min-parents, --no-max-parents
Show only commits which have at least (or at most) that many parent commits. In particular,
**--max-parents=1**
is the same as
**--no-merges**,
**--min-parents=2**
is the same as
**--merges**.
**--max-parents=0**
gives all root commits and
**--min-parents=3**
all octopus merges.

**--no-min-parents**
and
**--no-max-parents**
reset these limits (to no limit) again. Equivalent forms are
**--min-parents=0**
(any commit has 0 or more parents) and
**--max-parents=-1**
(negative numbers denote no upper limit).

--first-parent
Follow only the first parent commit upon seeing a merge commit. This option can give a better overview when viewing the evolution of a particular topic branch, because merges into a topic branch tend to be only about adjusting to updated upstream from time to time, and this option allows you to ignore the individual commits brought in to your history by such a merge. Cannot be combined with --bisect.

--not
Reverses the meaning of the
_^_
prefix (or lack thereof) for all following revision specifiers, up to the next
**--not**.

--all
Pretend as if all the refs in
**refs/**, along with
**HEAD**, are listed on the command line as
_&lt;commit&gt;_.

--branches[=&lt;pattern&gt;]
Pretend as if all the refs in
**refs/heads**
are listed on the command line as
_&lt;commit&gt;_. If
_&lt;pattern&gt;_
is given, limit branches to ones matching given shell glob. If pattern lacks
_?_,
<i>\*</i>, or
_[_,
_/*_
at the end is implied.

--tags[=&lt;pattern&gt;]
Pretend as if all the refs in
**refs/tags**
are listed on the command line as
_&lt;commit&gt;_. If
_&lt;pattern&gt;_
is given, limit tags to ones matching given shell glob. If pattern lacks
_?_,
<i>\*</i>, or
_[_,
_/*_
at the end is implied.

--remotes[=&lt;pattern&gt;]
Pretend as if all the refs in
**refs/remotes**
are listed on the command line as
_&lt;commit&gt;_. If
_&lt;pattern&gt;_
is given, limit remote-tracking branches to ones matching given shell glob. If pattern lacks
_?_,
<i>\*</i>, or
_[_,
_/*_
at the end is implied.

--glob=&lt;glob-pattern&gt;
Pretend as if all the refs matching shell glob
_&lt;glob-pattern&gt;_
are listed on the command line as
_&lt;commit&gt;_. Leading
_refs/_, is automatically prepended if missing. If pattern lacks
_?_,
<i>\*</i>, or
_[_,
_/*_
at the end is implied.

--exclude=&lt;glob-pattern&gt;
Do not include refs matching
_&lt;glob-pattern&gt;_
that the next
**--all**,
**--branches**,
**--tags**,
**--remotes**, or
**--glob**
would otherwise consider. Repetitions of this option accumulate exclusion patterns up to the next
**--all**,
**--branches**,
**--tags**,
**--remotes**, or
**--glob**
option (other options or arguments do not clear accumulated patterns).

The patterns given should not begin with
**refs/heads**,
**refs/tags**, or
**refs/remotes**
when applied to
**--branches**,
**--tags**, or
**--remotes**, respectively, and they must begin with
**refs/**
when applied to
**--glob**
or
**--all**. If a trailing
_/*_
is intended, it must be given explicitly.

--reflog
Pretend as if all objects mentioned by reflogs are listed on the command line as
**&lt;commit&gt;**.

--single-worktree
By default, all working trees will be examined by the following options when there are more than one (see
**git-worktree**(1)):
**--all**,
**--reflog**
and
**--indexed-objects**. This option forces them to examine the current working tree only.

--ignore-missing
Upon seeing an invalid object name in the input, pretend as if the bad input was not given.

--stdin
In addition to the
_&lt;commit&gt;_
listed on the command line, read them from the standard input. If a
**--**
separator is seen, stop reading commits and start reading paths to limit the result.

--quiet
Don’t print anything to standard output. This form is primarily meant to allow the caller to test the exit status to see if a range of objects is fully connected (or not). It is faster than redirecting stdout to
**/dev/null**
as the output does not have to be formatted.

--cherry-mark
Like
**--cherry-pick**
(see below) but mark equivalent commits with
**=**
rather than omitting them, and inequivalent ones with
**+**.

--cherry-pick
Omit any commit that introduces the same change as another commit on the “other side” when the set of commits are limited with symmetric difference.

For example, if you have two branches,
**A**
and
**B**, a usual way to list all commits on only one side of them is with
**--left-right**
(see the example below in the description of the
**--left-right**
option). However, it shows the commits that were cherry-picked from the other branch (for example, “3rd on b” may be cherry-picked from branch A). With this option, such pairs of commits are excluded from the output.

--left-only, --right-only
List only commits on the respective side of a symmetric difference, i.e. only those which would be marked
**&lt;**
resp.
**&gt;**
by
**--left-right**.

For example,
**--cherry-pick --right-only A...B**
omits those commits from
**B**
which are in
**A**
or are patch-equivalent to a commit in
**A**. In other words, this lists the
**+**
commits from
**git cherry A B**. More precisely,
**--cherry-pick --right-only --no-merges**
gives the exact list.

--cherry
A synonym for
**--right-only --cherry-mark --no-merges**; useful to limit the output to the commits on our side and mark those that have been applied to the other side of a forked history with
**git log --cherry upstream...mybranch**, similar to
**git cherry upstream mybranch**.

-g, --walk-reflogs
Instead of walking the commit ancestry chain, walk reflog entries from the most recent one to older ones. When this option is used you cannot specify commits to exclude (that is,
_^commit_,
_commit1..commit2_, and
_commit1...commit2_
notations cannot be used).

With
**--pretty**
format other than
**oneline**
(for obvious reasons), this causes the output to have two extra lines of information taken from the reflog. The reflog designator in the output may be shown as
**ref@{Nth}**
(where
**Nth**
is the reverse-chronological index in the reflog) or as
**ref@{timestamp}**
(with the timestamp for that entry), depending on a few rules:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  If the starting point is specified as
  **ref@{Nth}**, show the index format.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  If the starting point was specified as
  **ref@{now}**, show the timestamp format.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  If neither was used, but
  **--date**
  was given on the command line, show the timestamp in the format requested by
  **--date**.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  Otherwise, show the index format.

Under
**--pretty=oneline**, the commit message is prefixed with this information on the same line. This option cannot be combined with
**--reverse**. See also
**git-reflog**(1).

--merge
After a failed merge, show refs that touch files having a conflict and don’t exist on all heads to merge.

--boundary
Output excluded boundary commits. Boundary commits are prefixed with
**-**.

--use-bitmap-index
Try to speed up the traversal using the pack bitmap index (if one is available). Note that when traversing with
**--objects**, trees and blobs will not have their associated path printed.

--progress=&lt;header&gt;
Show progress reports on stderr as objects are considered. The
**&lt;header&gt;**
text will be printed with each progress update.

<a name="history-simplification"></a>

### History Simplification


Sometimes you are only interested in parts of the history, for example the commits modifying a particular &lt;path&gt;. But there are two parts of _History Simplification_, one part is selecting the commits and the other is how to do it, as there are various strategies to simplify the history.

The following options select the commits to be shown:

&lt;paths&gt;
Commits modifying the given &lt;paths&gt; are selected.

--simplify-by-decoration
Commits that are referred by some branch or tag are selected.

Note that extra commits can be shown to give a meaningful history.

The following options affect the way the simplification is performed:

Default mode
Simplifies the history to the simplest history explaining the final state of the tree. Simplest because it prunes some side branches if the end result is the same (i.e. merging branches with the same content)

--full-history
Same as the default mode, but does not prune some history.

--dense
Only the selected commits are shown, plus some to have a meaningful history.

--sparse
All commits in the simplified history are shown.

--simplify-merges
Additional option to
**--full-history**
to remove some needless merges from the resulting history, as there are no selected commits contributing to this merge.

--ancestry-path
When given a range of commits to display (e.g.
_commit1..commit2_
or
_commit2 ^commit1_), only display commits that exist directly on the ancestry chain between the
_commit1_
and
_commit2_, i.e. commits that are both descendants of
_commit1_, and ancestors of
_commit2_.

A more detailed explanation follows.

Suppose you specified **foo** as the &lt;paths&gt;. We shall call commits that modify **foo** !TREESAME, and the rest TREESAME. (In a diff filtered for **foo**, they look different and equal, respectively.)

In the following, we will always refer to the same example history to illustrate the differences between simplification settings. We assume that you are filtering for a file **foo** in this commit graph:

.if n \{.RS 4
.\}
              .-A---M---N---O---P---Q
             /     /   /   /   /   /
            I     B   C   D   E   Y
             e   /   /   /   /   /
              `-------------'   X
.if n \{.RE
.\}


The horizontal line of history A---Q is taken to be the first parent of each merge. The commits are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **I**
  is the initial commit, in which
  **foo**
  exists with contents “asdf”, and a file
  **quux**
  exists with contents “quux”. Initial commits are compared to an empty tree, so
  **I**
  is !TREESAME.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  In
  **A**,
  **foo**
  contains just “foo”.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **B**
  contains the same change as
  **A**. Its merge
  **M**
  is trivial and hence TREESAME to all parents.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **C**
  does not change
  **foo**, but its merge
  **N**
  changes it to “foobar”, so it is not TREESAME to any parent.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **D**
  sets
  **foo**
  to “baz”. Its merge
  **O**
  combines the strings from
  **N**
  and
  **D**
  to “foobarbaz”; i.e., it is not TREESAME to any parent.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **E**
  changes
  **quux**
  to “xyzzy”, and its merge
  **P**
  combines the strings to “quux xyzzy”.
  **P**
  is TREESAME to
  **O**, but not to
  **E**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **X**
  is an independent root commit that added a new file
  **side**, and
  **Y**
  modified it.
  **Y**
  is TREESAME to
  **X**. Its merge
  **Q**
  added
  **side**
  to
  **P**, and
  **Q**
  is TREESAME to
  **P**, but not to
  **Y**.

**rev-list** walks backwards through history, including or excluding commits based on whether **--full-history** and/or parent rewriting (via **--parents** or **--children**) are used. The following settings are available.

Default mode
Commits are included if they are not TREESAME to any parent (though this can be changed, see
**--sparse**
below). If the commit was a merge, and it was TREESAME to one parent, follow only that parent. (Even if there are several TREESAME parents, follow only one of them.) Otherwise, follow all parents.

This results in:

.if n \{.RS 4
.\}
              .-A---N---O
             /     /   /
            I---------D
.if n \{.RE
.\}

Note how the rule to only follow the TREESAME parent, if one is available, removed
**B**
from consideration entirely.
**C**
was considered via
**N**, but is TREESAME. Root commits are compared to an empty tree, so
**I**
is !TREESAME.

Parent/child relations are only visible with
**--parents**, but that does not affect the commits selected in default mode, so we have shown the parent lines.

--full-history without parent rewriting
This mode differs from the default in one point: always follow all parents of a merge, even if it is TREESAME to one of them. Even if more than one side of the merge has commits that are included, this does not imply that the merge itself is! In the example, we get

.if n \{.RS 4
.\}
            I  A  B  N  D  O  P  Q
.if n \{.RE
.\}

**M**
was excluded because it is TREESAME to both parents.
**E**,
**C**
and
**B**
were all walked, but only
**B**
was !TREESAME, so the others do not appear.

Note that without parent rewriting, it is not really possible to talk about the parent/child relationships between the commits, so we show them disconnected.

--full-history with parent rewriting
Ordinary commits are only included if they are !TREESAME (though this can be changed, see
**--sparse**
below).

Merges are always included. However, their parent list is rewritten: Along each parent, prune away commits that are not included themselves. This results in

.if n \{.RS 4
.\}
              .-A---M---N---O---P---Q
             /     /   /   /   /
            I     B   /   D   /
             e   /   /   /   /
              `-------------'
.if n \{.RE
.\}

Compare to
**--full-history**
without rewriting above. Note that
**E**
was pruned away because it is TREESAME, but the parent list of P was rewritten to contain
**E**'s parent
**I**. The same happened for
**C**
and
**N**, and
**X**,
**Y**
and
**Q**.

In addition to the above settings, you can change whether TREESAME affects inclusion:

--dense
Commits that are walked are included if they are not TREESAME to any parent.

--sparse
All commits that are walked are included.

Note that without
**--full-history**, this still simplifies merges: if one of the parents is TREESAME, we follow only that one, so the other sides of the merge are never walked.

--simplify-merges
First, build a history graph in the same way that
**--full-history**
with parent rewriting does (see above).

Then simplify each commit
**C**
to its replacement
**C'**
in the final history according to the following rules:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Set
  **C'**
  to
  **C**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Replace each parent
  **P**
  of
  **C'**
  with its simplification
  **P'**. In the process, drop parents that are ancestors of other parents or that are root commits TREESAME to an empty tree, and remove duplicates, but take care to never drop all parents that we are TREESAME to.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If after this parent rewriting,
  **C'**
  is a root or merge commit (has zero or &gt;1 parents), a boundary commit, or !TREESAME, it remains. Otherwise, it is replaced with its only parent.

The effect of this is best shown by way of comparing to
**--full-history**
with parent rewriting. The example turns into:

.if n \{.RS 4
.\}
              .-A---M---N---O
             /     /       /
            I     B       D
             e   /       /
              `---------'
.if n \{.RE
.\}

Note the major differences in
**N**,
**P**, and
**Q**
over
**--full-history**:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **N**'s parent list had
  **I**
  removed, because it is an ancestor of the other parent
  **M**. Still,
  **N**
  remained because it is !TREESAME.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **P**'s parent list similarly had
  **I**
  removed.
  **P**
  was then removed completely, because it had one parent and is TREESAME.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **Q**'s parent list had
  **Y**
  simplified to
  **X**.
  **X**
  was then removed, because it was a TREESAME root.
  **Q**
  was then removed completely, because it had one parent and is TREESAME.

Finally, there is a fifth simplification mode available:

--ancestry-path
Limit the displayed commits to those directly on the ancestry chain between the “from” and “to” commits in the given commit range. I.e. only display commits that are ancestor of the “to” commit and descendants of the “from” commit.

As an example use case, consider the following commit history:

.if n \{.RS 4
.\}
                D---E-------F
               /     e       e
              B---C---G---H---I---J
             /                     e
            A-------K---------------L--M
.if n \{.RE
.\}

A regular
_D..M_
computes the set of commits that are ancestors of
**M**, but excludes the ones that are ancestors of
**D**. This is useful to see what happened to the history leading to
**M**
since
**D**, in the sense that “what does
**M**
have that did not exist in
**D**”. The result in this example would be all the commits, except
**A**
and
**B**
(and
**D**
itself, of course).

When we want to find out what commits in
**M**
are contaminated with the bug introduced by
**D**
and need fixing, however, we might want to view only the subset of
_D..M_
that are actually descendants of
**D**, i.e. excluding
**C**
and
**K**. This is exactly what the
**--ancestry-path**
option does. Applied to the
_D..M_
range, it results in:

.if n \{.RS 4
.\}
                    E-------F
                     e       e
                      G---H---I---J
                                   e
                                    L--M
.if n \{.RE
.\}


The **--simplify-by-decoration** option allows you to view only the big picture of the topology of the history, by omitting commits that are not referenced by tags. Commits are marked as !TREESAME (in other words, kept after history simplification rules described above) if (1) they are referenced by tags, or (2) they change the contents of the paths given on the command line. All other commits are marked as TREESAME (subject to be simplified away).

<a name="bisection-helpers"></a>

### Bisection Helpers


--bisect
Limit output to the one commit object which is roughly halfway between included and excluded commits. Note that the bad bisection ref
**refs/bisect/bad**
is added to the included commits (if it exists) and the good bisection refs
**refs/bisect/good-***
are added to the excluded commits (if they exist). Thus, supposing there are no refs in
**refs/bisect/**, if

.if n \{.RS 4
.\}
            $ git rev-list --bisect foo ^bar ^baz
.if n \{.RE
.\}

outputs
_midpoint_, the output of the two commands

.if n \{.RS 4
.\}
            $ git rev-list foo ^midpoint
            $ git rev-list midpoint ^bar ^baz
.if n \{.RE
.\}

would be of roughly the same length. Finding the change which introduces a regression is thus reduced to a binary search: repeatedly generate and test new 'midpoint’s until the commit chain is of length one. Cannot be combined with --first-parent.

--bisect-vars
This calculates the same as
**--bisect**, except that refs in
**refs/bisect/**
are not used, and except that this outputs text ready to be eval’ed by the shell. These lines will assign the name of the midpoint revision to the variable
**bisect\_rev**, and the expected number of commits to be tested after
**bisect\_rev**
is tested to
**bisect\_nr**, the expected number of commits to be tested if
**bisect\_rev**
turns out to be good to
**bisect\_good**, the expected number of commits to be tested if
**bisect\_rev**
turns out to be bad to
**bisect\_bad**, and the number of commits we are bisecting right now to
**bisect\_all**.

--bisect-all
This outputs all the commit objects between the included and excluded commits, ordered by their distance to the included and excluded commits. Refs in
**refs/bisect/**
are not used. The farthest from them is displayed first. (This is the only one displayed by
**--bisect**.)

This is useful because it makes it easy to choose a good commit to test when you want to avoid to test some of them for some reason (they may not compile for example).

This option can be used along with
**--bisect-vars**, in this case, after all the sorted commit objects, there will be the same text as if
**--bisect-vars**
had been used alone.

<a name="commit-ordering"></a>

### Commit Ordering


By default, the commits are shown in reverse chronological order.

--date-order
Show no parents before all of its children are shown, but otherwise show commits in the commit timestamp order.

--author-date-order
Show no parents before all of its children are shown, but otherwise show commits in the author timestamp order.

--topo-order
Show no parents before all of its children are shown, and avoid showing commits on multiple lines of history intermixed.

For example, in a commit history like this:

.if n \{.RS 4
.\}
        ---1----2----4----7
            e              e
             3----5----6----8---
.if n \{.RE
.\}

where the numbers denote the order of commit timestamps,
**git rev-list**
and friends with
**--date-order**
show the commits in the timestamp order: 8 7 6 5 4 3 2 1.

With
**--topo-order**, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5 3 1); some older commits are shown before newer ones in order to avoid showing the commits from two parallel development track mixed together.

--reverse
Output the commits chosen to be shown (see Commit Limiting section above) in reverse order. Cannot be combined with
**--walk-reflogs**.

<a name="object-traversal"></a>

### Object Traversal


These options are mostly targeted for packing of Git repositories.

--objects
Print the object IDs of any object referenced by the listed commits.
**--objects foo ^bar**
thus means “send me all object IDs which I need to download if I have the commit object
_bar_
but not
_foo_”.

--in-commit-order
Print tree and blob ids in order of the commits. The tree and blob ids are printed after they are first referenced by a commit.

--objects-edge
Similar to
**--objects**, but also print the IDs of excluded commits prefixed with a “-” character. This is used by
**git-pack-objects**(1)
to build a “thin” pack, which records objects in deltified form based on objects contained in these excluded commits to reduce network traffic.

--objects-edge-aggressive
Similar to
**--objects-edge**, but it tries harder to find excluded commits at the cost of increased time. This is used instead of
**--objects-edge**
to build “thin” packs for shallow repositories.

--indexed-objects
Pretend as if all trees and blobs used by the index are listed on the command line. Note that you probably want to use
**--objects**, too.

--unpacked
Only useful with
**--objects**; print the object IDs that are not in packs.

--filter=&lt;filter-spec&gt;
Only useful with one of the
**--objects***; omits objects (usually blobs) from the list of printed objects. The
_&lt;filter-spec&gt;_
may be one of the following:

The form
_--filter=blob:none_
omits all blobs.

The form
_--filter=blob:limit=&lt;n&gt;[kmg]_
omits blobs larger than n bytes or units. n may be zero. The suffixes k, m, and g can be used to name units in KiB, MiB, or GiB. For example,
_blob:limit=1k_
is the same as
_blob:limit=1024_.

The form
_--filter=sparse:oid=&lt;blob-ish&gt;_
uses a sparse-checkout specification contained in the blob (or blob-expression)
_&lt;blob-ish&gt;_
to omit blobs that would not be not required for a sparse checkout on the requested refs.

The form
_--filter=sparse:path=&lt;path&gt;_
similarly uses a sparse-checkout specification contained in &lt;path&gt;.

The form
_--filter=tree:&lt;depth&gt;_
omits all blobs and trees whose depth from the root tree is &gt;= &lt;depth&gt; (minimum depth if an object is located at multiple depths in the commits traversed). &lt;depth&gt;=0 will not include any trees or blobs unless included explicitly in the command-line (or standard input when --stdin is used). &lt;depth&gt;=1 will include only the tree and blobs which are referenced directly by a commit reachable from &lt;commit&gt; or an explicitly-given object. &lt;depth&gt;=2 is like &lt;depth&gt;=1 while also including trees and blobs one more level removed from an explicitly-given commit or tree.

--no-filter
Turn off any previous
**--filter=**
argument.

--filter-print-omitted
Only useful with
**--filter=**; prints a list of the objects omitted by the filter. Object IDs are prefixed with a “~” character.

--missing=&lt;missing-action&gt;
A debug option to help with future "partial clone" development. This option specifies how missing objects are handled.

The form
_--missing=error_
requests that rev-list stop with an error if a missing object is encountered. This is the default action.

The form
_--missing=allow-any_
will allow object traversal to continue if a missing object is encountered. Missing objects will silently be omitted from the results.

The form
_--missing=allow-promisor_
is like
_allow-any_, but will only allow object traversal to continue for EXPECTED promisor missing objects. Unexpected missing objects will raise an error.

The form
_--missing=print_
is like
_allow-any_, but will also print a list of the missing objects. Object IDs are prefixed with a “?” character.

--exclude-promisor-objects
(For internal use only.) Prefilter object traversal at promisor boundary. This is used with partial clone. This is stronger than
**--missing=allow-promisor**
because it limits the traversal, rather than just silencing errors about missing objects.

--no-walk[=(sorted|unsorted)]
Only show the given commits, but do not traverse their ancestors. This has no effect if a range is specified. If the argument
**unsorted**
is given, the commits are shown in the order they were given on the command line. Otherwise (if
**sorted**
or no argument was given), the commits are shown in reverse chronological order by commit time. Cannot be combined with
**--graph**.

--do-walk
Overrides a previous
**--no-walk**.

<a name="commit-formatting"></a>

### Commit Formatting


Using these options, **git-rev-list**(1) will act similar to the more specialized family of commit log tools: **git-log**(1), **git-show**(1), and **git-whatchanged**(1)

--pretty[=&lt;format&gt;], --format=&lt;format&gt;
Pretty-print the contents of the commit logs in a given format, where
_&lt;format&gt;_
can be one of
_oneline_,
_short_,
_medium_,
_full_,
_fuller_,
_email_,
_raw_,
_format:&lt;string&gt;_
and
_tformat:&lt;string&gt;_. When
_&lt;format&gt;_
is none of the above, and has
_%placeholder_
in it, it acts as if
_--pretty=tformat:&lt;format&gt;_
were given.

See the "PRETTY FORMATS" section for some additional details for each format. When
_=&lt;format&gt;_
part is omitted, it defaults to
_medium_.

Note: you can specify the default pretty format in the repository configuration (see
**git-config**(1)).

--abbrev-commit
Instead of showing the full 40-byte hexadecimal commit object name, show only a partial prefix. Non default number of digits can be specified with "--abbrev=&lt;n&gt;" (which also modifies diff output, if it is displayed).

This should make "--pretty=oneline" a whole lot more readable for people using 80-column terminals.

--no-abbrev-commit
Show the full 40-byte hexadecimal commit object name. This negates
**--abbrev-commit**
and those options which imply it such as "--oneline". It also overrides the
**log.abbrevCommit**
variable.

--oneline
This is a shorthand for "--pretty=oneline --abbrev-commit" used together.

--encoding=&lt;encoding&gt;
The commit objects record the encoding used for the log message in their encoding header; this option can be used to tell the command to re-code the commit log message in the encoding preferred by the user. For non plumbing commands this defaults to UTF-8. Note that if an object claims to be encoded in
**X**
and we are outputting in
**X**, we will output the object verbatim; this means that invalid sequences in the original commit may be copied to the output.

--expand-tabs=&lt;n&gt;, --expand-tabs, --no-expand-tabs
Perform a tab expansion (replace each tab with enough spaces to fill to the next display column that is multiple of
_&lt;n&gt;_) in the log message before showing it in the output.
**--expand-tabs**
is a short-hand for
**--expand-tabs=8**, and
**--no-expand-tabs**
is a short-hand for
**--expand-tabs=0**, which disables tab expansion.

By default, tabs are expanded in pretty formats that indent the log message by 4 spaces (i.e.
_medium_, which is the default,
_full_, and
_fuller_).

--show-signature
Check the validity of a signed commit object by passing the signature to
**gpg --verify**
and show the output.

--relative-date
Synonym for
**--date=relative**.

--date=&lt;format&gt;
Only takes effect for dates shown in human-readable format, such as when using
**--pretty**.
**log.date**
config variable sets a default value for the log command’s
**--date**
option. By default, dates are shown in the original time zone (either committer’s or author’s). If
**-local**
is appended to the format (e.g.,
**iso-local**), the user’s local time zone is used instead.

**--date=relative**
shows dates relative to the current time, e.g. “2 hours ago”. The
**-local**
option has no effect for
**--date=relative**.

**--date=local**
is an alias for
**--date=default-local**.

**--date=iso**
(or
**--date=iso8601**) shows timestamps in a ISO 8601-like format. The differences to the strict ISO 8601 format are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a space instead of the
  **T**
  date/time delimiter

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a space between time and time zone

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  no colon between hours and minutes of the time zone

**--date=iso-strict**
(or
**--date=iso8601-strict**) shows timestamps in strict ISO 8601 format.

**--date=rfc**
(or
**--date=rfc2822**) shows timestamps in RFC 2822 format, often found in email messages.

**--date=short**
shows only the date, but not the time, in
**YYYY-MM-DD**
format.

**--date=raw**
shows the date as seconds since the epoch (1970-01-01 00:00:00 UTC), followed by a space, and then the timezone as an offset from UTC (a
**+**
or
**-**
with four digits; the first two are hours, and the second two are minutes). I.e., as if the timestamp were formatted with
**strftime("%s %z")**). Note that the
**-local**
option does not affect the seconds-since-epoch value (which is always measured in UTC), but does switch the accompanying timezone value.

**--date=human**
shows the timezone if the timezone does not match the current time-zone, and doesn’t print the whole date if that matches (ie skip printing year for dates that are "this year", but also skip the whole date itself if it’s in the last few days and we can just say what weekday it was). For older dates the hour and minute is also omitted.

**--date=unix**
shows the date as a Unix epoch timestamp (seconds since 1970). As with
**--raw**, this is always in UTC and therefore
**-local**
has no effect.

**--date=format:...**
feeds the format
**...**
to your system
**strftime**, except for %z and %Z, which are handled internally. Use
**--date=format:%c**
to show the date in your system locale’s preferred format. See the
**strftime**
manual for a complete list of format placeholders. When using
**-local**, the correct syntax is
**--date=format-local:...**.

**--date=default**
is the default format, and is similar to
**--date=rfc2822**, with a few exceptions:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  there is no comma after the day-of-week

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the time zone is omitted when the local time zone is used

--header
Print the contents of the commit in raw-format; each record is separated with a NUL character.

--parents
Print also the parents of the commit (in the form "commit parent..."). Also enables parent rewriting, see
_History Simplification_
above.

--children
Print also the children of the commit (in the form "commit child..."). Also enables parent rewriting, see
_History Simplification_
above.

--timestamp
Print the raw commit timestamp.

--left-right
Mark which side of a symmetric difference a commit is reachable from. Commits from the left side are prefixed with
**&lt;**
and those from the right with
**&gt;**. If combined with
**--boundary**, those commits are prefixed with
**-**.

For example, if you have this topology:

.if n \{.RS 4
.\}
                 y---b---b  branch B
                / e /
               /   .
              /   / e
             o---x---a---a  branch A
.if n \{.RE
.\}

you would get an output like this:

.if n \{.RS 4
.\}
            $ git rev-list --left-right --boundary --pretty=oneline A...B
    
            >bbbbbbb... 3rd on b
            >bbbbbbb... 2nd on b
            <aaaaaaa... 3rd on a
            <aaaaaaa... 2nd on a
            -yyyyyyy... 1st on b
            -xxxxxxx... 1st on a
.if n \{.RE
.\}


--graph
Draw a text-based graphical representation of the commit history on the left hand side of the output. This may cause extra lines to be printed in between commits, in order for the graph history to be drawn properly. Cannot be combined with
**--no-walk**.

This enables parent rewriting, see
_History Simplification_
above.

This implies the
**--topo-order**
option by default, but the
**--date-order**
option may also be specified.

--show-linear-break[=&lt;barrier&gt;]
When --graph is not used, all history branches are flattened which can make it hard to see that the two consecutive commits do not belong to a linear branch. This option puts a barrier in between them in that case. If
**&lt;barrier&gt;**
is specified, it is the string that will be shown instead of the default one.

--count
Print a number stating how many commits would have been listed, and suppress all other output. When used together with
**--left-right**, instead print the counts for left and right commits, separated by a tab. When used together with
**--cherry-mark**, omit patch equivalent commits from these counts and print the count for equivalent commits separated by a tab.

<a name="pretty-formats"></a>

# Pretty Formats


If the commit is a merge, and if the pretty-format is not _oneline_, _email_ or _raw_, an additional line is inserted before the _Author:_ line. This line begins with "Merge: " and the sha1s of ancestral commits are printed, separated by spaces. Note that the listed commits may not necessarily be the list of the **direct** parent commits if you have limited your view of history: for example, if you are only interested in changes related to a certain directory or file.

There are several built-in formats, and you can define additional formats by setting a pretty.&lt;name&gt; config option to either another format name, or a _format:_ string, as described below (see **git-config**(1)). Here are the details of the built-in formats:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _oneline_

.if n \{.RS 4
.\}
    <sha1> <title line>
.if n \{.RE
.\}

This is designed to be as compact as possible.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _short_

.if n \{.RS 4
.\}
    commit <sha1>
    Author: <author>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _medium_

.if n \{.RS 4
.\}
    commit <sha1>
    Author: <author>
    Date:   <author date>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _full_

.if n \{.RS 4
.\}
    commit <sha1>
    Author: <author>
    Commit: <committer>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _fuller_

.if n \{.RS 4
.\}
    commit <sha1>
    Author:     <author>
    AuthorDate: <author date>
    Commit:     <committer>
    CommitDate: <committer date>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _email_

.if n \{.RS 4
.\}
    From <sha1> <date>
    From: <author>
    Date: <author date>
    Subject: [PATCH] <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _raw_

The
_raw_
format shows the entire commit exactly as stored in the commit object. Notably, the SHA-1s are displayed in full, regardless of whether --abbrev or --no-abbrev are used, and
_parents_
information show the true parent commits, without taking grafts or history simplification into account. Note that this format affects the way commits are displayed, but not the way the diff is shown e.g. with
**git log --raw**. To get full object names in a raw diff format, use
**--no-abbrev**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _format:&lt;string&gt;_

The
_format:&lt;string&gt;_
format allows you to specify which information you want to show. It works a little bit like printf format, with the notable exception that you get a newline with
_%n_
instead of
_\en_.

E.g,
_format:"The author of %h was %an, %ar%nThe title was &gt;&gt;%s&lt;&lt;%n"_
would show something like this:

.if n \{.RS 4
.\}
    The author of fe6e0ee was Junio C Hamano, 23 hours ago
    The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
.if n \{.RE
.\}

The placeholders are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%H_: commit hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%h_: abbreviated commit hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%T_: tree hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%t_: abbreviated tree hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%P_: parent hashes

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%p_: abbreviated parent hashes

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%an_: author name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aN_: author name (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ae_: author email

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aE_: author email (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ad_: author date (format respects --date= option)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aD_: author date, RFC2822 style

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ar_: author date, relative

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%at_: author date, UNIX timestamp

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ai_: author date, ISO 8601-like format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aI_: author date, strict ISO 8601 format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cn_: committer name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cN_: committer name (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ce_: committer email

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cE_: committer email (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cd_: committer date (format respects --date= option)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cD_: committer date, RFC2822 style

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cr_: committer date, relative

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ct_: committer date, UNIX timestamp

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ci_: committer date, ISO 8601-like format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cI_: committer date, strict ISO 8601 format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%d_: ref names, like the --decorate option of
  **git-log**(1)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%D_: ref names without the " (", ")" wrapping.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%S_: ref name given on the command line by which the commit was reached (like
  **git log --source**), only works with
  **git log**

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%e_: encoding

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%s_: subject

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%f_: sanitized subject line, suitable for a filename

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%b_: body

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%B_: raw body (unwrapped subject and body)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GG_: raw verification message from GPG for a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%G?_: show "G" for a good (valid) signature, "B" for a bad signature, "U" for a good signature with unknown validity, "X" for a good signature that has expired, "Y" for a good signature made by an expired key, "R" for a good signature made by a revoked key, "E" if the signature cannot be checked (e.g. missing key) and "N" for no signature

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GS_: show the name of the signer for a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GK_: show the key used to sign a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GF_: show the fingerprint of the key used to sign a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GP_: show the fingerprint of the primary key whose subkey was used to sign a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gD_: reflog selector, e.g.,
  **refs/stash@{1}**
  or
  **refs/stash@{2 minutes ago**}; the format follows the rules described for the
  **-g**
  option. The portion before the
  **@**
  is the refname as given on the command line (so
  **git log -g refs/heads/master**
  would yield
  **refs/heads/master@{0}**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gd_: shortened reflog selector; same as
  **%gD**, but the refname portion is shortened for human readability (so
  **refs/heads/master**
  becomes just
  **master**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gn_: reflog identity name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gN_: reflog identity name (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ge_: reflog identity email

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gE_: reflog identity email (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gs_: reflog subject

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Cred_: switch color to red

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Cgreen_: switch color to green

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Cblue_: switch color to blue

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Creset_: reset color

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%C(...)_: color specification, as described under Values in the "CONFIGURATION FILE" section of
  **git-config**(1). By default, colors are shown only when enabled for log output (by
  **color.diff**,
  **color.ui**, or
  **--color**, and respecting the
  **auto**
  settings of the former if we are going to a terminal).
  **%C(auto,...)**
  is accepted as a historical synonym for the default (e.g.,
  **%C(auto,red)**). Specifying
  **%C(always,...)**
  will show the colors even when color is not otherwise enabled (though consider just using
  **--color=always**
  to enable color for the whole output, including this format and anything else git might color).
  **auto**
  alone (i.e.
  **%C(auto)**) will turn on auto coloring on the next placeholders until the color is switched again.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%m_: left (**&lt;**), right (**&gt;**) or boundary (**-**) mark

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%n_: newline

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%%_: a raw
  _%_

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%x00_: print a byte from a hex code

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%w([&lt;w&gt;[,&lt;i1&gt;[,&lt;i2&gt;]]])_: switch line wrapping, like the -w option of
  **git-shortlog**(1).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&lt;(&lt;N&gt;[,trunc|ltrunc|mtrunc])_: make the next placeholder take at least N columns, padding spaces on the right if necessary. Optionally truncate at the beginning (ltrunc), the middle (mtrunc) or the end (trunc) if the output is longer than N columns. Note that truncating only works correctly with N &gt;= 2.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&lt;|(&lt;N&gt;)_: make the next placeholder take at least until Nth columns, padding spaces on the right if necessary

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&gt;(&lt;N&gt;)_,
  _%&gt;|(&lt;N&gt;)_: similar to
  _%&lt;(&lt;N&gt;)_,
  _%&lt;|(&lt;N&gt;)_
  respectively, but padding spaces on the left

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&gt;&gt;(&lt;N&gt;)_,
  _%&gt;&gt;|(&lt;N&gt;)_: similar to
  _%&gt;(&lt;N&gt;)_,
  _%&gt;|(&lt;N&gt;)_
  respectively, except that if the next placeholder takes more spaces than given and there are spaces on its left, use those spaces

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&gt;&lt;(&lt;N&gt;)_,
  _%&gt;&lt;|(&lt;N&gt;)_: similar to
  _%&lt;(&lt;N&gt;)_,
  _%&lt;|(&lt;N&gt;)_
  respectively, but padding both sides (i.e. the text is centered)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  %(trailers[:options]): display the trailers of the body as interpreted by
  **git-interpret-trailers**(1). The
  **trailers**
  string may be followed by a colon and zero or more comma-separated options. If the
  **only**
  option is given, omit non-trailer lines from the trailer block. If the
  **unfold**
  option is given, behave as if interpret-trailer’s
  **--unfold**
  option was given. E.g.,
  **%(trailers:only,unfold)**
  to do both.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

Some placeholders may depend on other options given to the revision traversal engine. For example, the **%g*** reflog options will insert an empty string unless we are traversing reflog entries (e.g., by **git log -g**). The **%d** and **%D** placeholders will use the "short" decoration format if **--decorate** was not already provided on the command line.


If you add a **+** (plus sign) after _%_ of a placeholder, a line-feed is inserted immediately before the expansion if and only if the placeholder expands to a non-empty string.

If you add a **-** (minus sign) after _%_ of a placeholder, all consecutive line-feeds immediately preceding the expansion are deleted if and only if the placeholder expands to an empty string.

If you add a \` \` (space) after _%_ of a placeholder, a space is inserted immediately before the expansion if and only if the placeholder expands to a non-empty string.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _tformat:_

The
_tformat:_
format works exactly like
_format:_, except that it provides "terminator" semantics instead of "separator" semantics. In other words, each commit has the message terminator character (usually a newline) appended, rather than a separator placed between entries. This means that the final entry of a single-line format will be properly terminated with a new line, just as the "oneline" format does. For example:

.if n \{.RS 4
.\}
    $ git log -2 --pretty=format:%h 4da45bef e
      | perl -pe '$_ .= " -- NO NEWLINEen" unless /en/'
    4da45be
    7134973 -- NO NEWLINE
    
    $ git log -2 --pretty=tformat:%h 4da45bef e
      | perl -pe '$_ .= " -- NO NEWLINEen" unless /en/'
    4da45be
    7134973
.if n \{.RE
.\}

In addition, any unrecognized string that has a
**%**
in it is interpreted as if it has
**tformat:**
in front of it. For example, these two are equivalent:

.if n \{.RS 4
.\}
    $ git log -2 --pretty=tformat:%h 4da45bef
    $ git log -2 --pretty=%h 4da45bef
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
