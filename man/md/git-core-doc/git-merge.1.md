# git\-merge(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-merge - Join two or more development histories together

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git merge [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
            [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
            [--[no-]allow-unrelated-histories]
            [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
    git merge --abort
    git merge --continue
<synopsis>


```

<a name="description"></a>

# Description


Incorporates changes from the named commits (since the time their histories diverged from the current branch) into the current branch. This command is used by _git pull_ to incorporate changes from another repository and can be used by hand to merge changes from one branch into another.

Assume the following history exists and the current branch is "**master**":

.if n \{.RS 4
.\}
              A---B---C topic
             /
        D---E---F---G master
.if n \{.RE
.\}


Then "**git merge topic**" will replay the changes made on the **topic** branch since it diverged from **master** (i.e., **E**) until its current commit (**C**) on top of **master**, and record the result in a new commit along with the names of the two parent commits and a log message from the user describing the changes.

.if n \{.RS 4
.\}
              A---B---C topic
             /         e
        D---E---F---G---H master
.if n \{.RE
.\}


The second syntax ("**git merge --abort**") can only be run after the merge has resulted in conflicts. _git merge --abort_ will abort the merge process and try to reconstruct the pre-merge state. However, if there were uncommitted changes when the merge started (and especially if those changes were further modified after the merge was started), _git merge --abort_ will in some cases be unable to reconstruct the original (pre-merge) changes. Therefore:

**Warning**: Running _git merge_ with non-trivial uncommitted changes is discouraged: while possible, it may leave you in a state that is hard to back out of in the case of a conflict.

The third syntax ("**git merge --continue**") can only be run after the merge has resulted in conflicts.

<a name="options"></a>

# Options


--commit, --no-commit
Perform the merge and commit the result. This option can be used to override --no-commit.

With --no-commit perform the merge but pretend the merge failed and do not autocommit, to give the user a chance to inspect and further tweak the merge result before committing.

--edit, -e, --no-edit
Invoke an editor before committing successful mechanical merge to further edit the auto-generated merge message, so that the user can explain and justify the merge. The
**--no-edit**
option can be used to accept the auto-generated message (this is generally discouraged). The
**--edit**
(or
**-e**) option is still useful if you are giving a draft message with the
**-m**
option from the command line and want to edit it in the editor.

Older scripts may depend on the historical behaviour of not allowing the user to edit the merge log message. They will see an editor opened when they run
**git merge**. To make it easier to adjust such scripts to the updated behaviour, the environment variable
**GIT\_MERGE\_AUTOEDIT**
can be set to
**no**
at the beginning of them.

--ff
When the merge resolves as a fast-forward, only update the branch pointer, without creating a merge commit. This is the default behavior.

--no-ff
Create a merge commit even when the merge resolves as a fast-forward. This is the default behaviour when merging an annotated (and possibly signed) tag that is not stored in its natural place in
_refs/tags/_
hierarchy.

--ff-only
Refuse to merge and exit with a non-zero status unless the current
**HEAD**
is already up to date or the merge can be resolved as a fast-forward.

-S[&lt;keyid&gt;], --gpg-sign[=&lt;keyid&gt;]
GPG-sign the resulting merge commit. The
**keyid**
argument is optional and defaults to the committer identity; if specified, it must be stuck to the option without a space.

--log[=&lt;n&gt;], --no-log
In addition to branch names, populate the log message with one-line descriptions from at most &lt;n&gt; actual commits that are being merged. See also
**git-fmt-merge-msg**(1).

With --no-log do not list one-line descriptions from the actual commits being merged.

--signoff, --no-signoff
Add Signed-off-by line by the committer at the end of the commit log message. The meaning of a signoff depends on the project, but it typically certifies that committer has the rights to submit this work under the same license and agrees to a Developer Certificate of Origin (see
\m[blue]**http://developercertificate.org/**\m[]
for more information).

With --no-signoff do not add a Signed-off-by line.

--stat, -n, --no-stat
Show a diffstat at the end of the merge. The diffstat is also controlled by the configuration option merge.stat.

With -n or --no-stat do not show a diffstat at the end of the merge.

--squash, --no-squash
Produce the working tree and index state as if a real merge happened (except for the merge information), but do not actually make a commit, move the
**HEAD**, or record
**$GIT\_DIR/MERGE\_HEAD**
(to cause the next
**git commit**
command to create a merge commit). This allows you to create a single commit on top of the current branch whose effect is the same as merging another branch (or more in case of an octopus).

With --no-squash perform the merge and commit the result. This option can be used to override --squash.

-s &lt;strategy&gt;, --strategy=&lt;strategy&gt;
Use the given merge strategy; can be supplied more than once to specify them in the order they should be tried. If there is no
**-s**
option, a built-in list of strategies is used instead (_git merge-recursive_
when merging a single head,
_git merge-octopus_
otherwise).

-X &lt;option&gt;, --strategy-option=&lt;option&gt;
Pass merge strategy specific option through to the merge strategy.

--verify-signatures, --no-verify-signatures
Verify that the tip commit of the side branch being merged is signed with a valid key, i.e. a key that has a valid uid: in the default trust model, this means the signing key has been signed by a trusted key. If the tip commit of the side branch is not signed with a valid key, the merge is aborted.

--summary, --no-summary
Synonyms to --stat and --no-stat; these are deprecated and will be removed in the future.

-q, --quiet
Operate quietly. Implies --no-progress.

-v, --verbose
Be verbose.

--progress, --no-progress
Turn progress on/off explicitly. If neither is specified, progress is shown if standard error is connected to a terminal. Note that not all merge strategies may support progress reporting.

--allow-unrelated-histories
By default,
**git merge**
command refuses to merge histories that do not share a common ancestor. This option can be used to override this safety when merging histories of two projects that started their lives independently. As that is a very rare occasion, no configuration variable to enable this by default exists and will not be added.

-m &lt;msg&gt;
Set the commit message to be used for the merge commit (in case one is created).

If
**--log**
is specified, a shortlog of the commits being merged will be appended to the specified message.

The
_git fmt-merge-msg_
command can be used to give a good default for automated
_git merge_
invocations. The automated message can include the branch description.

-F &lt;file&gt;, --file=&lt;file&gt;
Read the commit message to be used for the merge commit (in case one is created).

If
**--log**
is specified, a shortlog of the commits being merged will be appended to the specified message.

--[no-]rerere-autoupdate
Allow the rerere mechanism to update the index with the result of auto-conflict resolution if possible.

--abort
Abort the current conflict resolution process, and try to reconstruct the pre-merge state.

If there were uncommitted worktree changes present when the merge started,
_git merge --abort_
will in some cases be unable to reconstruct these changes. It is therefore recommended to always commit or stash your changes before running
_git merge_.

_git merge --abort_
is equivalent to
_git reset --merge_
when
**MERGE\_HEAD**
is present.

--continue
After a
_git merge_
stops due to conflicts you can conclude the merge by running
_git merge --continue_
(see "HOW TO RESOLVE CONFLICTS" section below).

&lt;commit&gt;...
Commits, usually other branch heads, to merge into our branch. Specifying more than one commit will create a merge with more than two parents (affectionately called an Octopus merge).

If no commit is given from the command line, merge the remote-tracking branches that the current branch is configured to use as its upstream. See also the configuration section of this manual page.

When
**FETCH\_HEAD**
(and no other commit) is specified, the branches recorded in the
**.git/FETCH\_HEAD**
file by the previous invocation of
**git fetch**
for merging are merged to the current branch.

<a name="pre-merge-checks"></a>

# Pre\-Merge Checks


Before applying outside changes, you should get your own work in good shape and committed locally, so it will not be clobbered if there are conflicts. See also **git-stash**(1). _git pull_ and _git merge_ will stop without doing anything when local uncommitted changes overlap with files that _git pull_/_git merge_ may need to update.

To avoid recording unrelated changes in the merge commit, _git pull_ and _git merge_ will also abort if there are any changes registered in the index relative to the **HEAD** commit. (Special narrow exceptions to this rule may exist depending on which merge strategy is in use, but generally, the index must match HEAD.)

If all named commits are already ancestors of **HEAD**, _git merge_ will exit early with the message "Already up to date."

<a name="fast-forward-merge"></a>

# Fast\-Forward Merge


Often the current branch head is an ancestor of the named commit. This is the most common case especially when invoked from _git pull_: you are tracking an upstream repository, you have committed no local changes, and now you want to update to a newer upstream revision. In this case, a new commit is not needed to store the combined history; instead, the **HEAD** (along with the index) is updated to point at the named commit, without creating an extra merge commit.

This behavior can be suppressed with the **--no-ff** option.

<a name="true-merge"></a>

# True Merge


Except in a fast-forward merge (see above), the branches to be merged must be tied together by a merge commit that has both of them as its parents.

A merged version reconciling the changes from all branches to be merged is committed, and your **HEAD**, index, and working tree are updated to it. It is possible to have modifications in the working tree as long as they do not overlap; the update will preserve them.

When it is not obvious how to reconcile the changes, the following happens:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  The
  **HEAD**
  pointer stays the same.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  The
  **MERGE\_HEAD**
  ref is set to point to the other branch head.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Paths that merged cleanly are updated both in the index file and in your working tree.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  For conflicting paths, the index file records up to three versions: stage 1 stores the version from the common ancestor, stage 2 from
  **HEAD**, and stage 3 from
  **MERGE\_HEAD**
  (you can inspect the stages with
  **git ls-files -u**). The working tree files contain the result of the "merge" program; i.e. 3-way merge results with familiar conflict markers
  **&lt;&lt;&lt;**
  **===**
  **&gt;&gt;&gt;**.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  No other changes are made. In particular, the local modifications you had before you started merge will stay the same and the index entries for them stay as they were, i.e. matching
  **HEAD**.

If you tried a merge which resulted in complex conflicts and want to start over, you can recover with **git merge --abort**.

<a name="merging-tag"></a>

# Merging Tag


When merging an annotated (and possibly signed) tag, Git always creates a merge commit even if a fast-forward merge is possible, and the commit message template is prepared with the tag message. Additionally, if the tag is signed, the signature check is reported as a comment in the message template. See also **git-tag**(1).

When you want to just integrate with the work leading to the commit that happens to be tagged, e.g. synchronizing with an upstream release point, you may not want to make an unnecessary merge commit.

In such a case, you can "unwrap" the tag yourself before feeding it to **git merge**, or pass **--ff-only** when you do not have any work on your own. e.g.

.if n \{.RS 4
.\}
    git fetch origin
    git merge v1.2.3^0
    git merge --ff-only v1.2.3
.if n \{.RE
.\}


<a name="how-conflicts-are-presented"></a>

# How Conflicts Are Presented


During a merge, the working tree files are updated to reflect the result of the merge. Among the changes made to the common ancestor’s version, non-overlapping ones (that is, you changed an area of the file while the other side left that area intact, or vice versa) are incorporated in the final result verbatim. When both sides made changes to the same area, however, Git cannot randomly pick one side over the other, and asks you to resolve it by leaving what both sides did to that area.

By default, Git uses the same style as the one used by the "merge" program from the RCS suite to present such a conflicted hunk, like this:

.if n \{.RS 4
.\}
    Here are lines that are either unchanged from the common
    ancestor, or cleanly resolved because only one side changed.
    <<<<<<< yours:sample.txt
    Conflict resolution is hard;
    let's go shopping.
    =======
    Git makes conflict resolution easy.
    >>>>>>> theirs:sample.txt
    And here is another line that is cleanly resolved or unmodified.
.if n \{.RE
.\}


The area where a pair of conflicting changes happened is marked with markers **&lt;&lt;&lt;&lt;&lt;&lt;&lt;**, **=======**, and **&gt;&gt;&gt;&gt;&gt;&gt;&gt;**. The part before the **=======** is typically your side, and the part afterwards is typically their side.

The default format does not show what the original said in the conflicting area. You cannot tell how many lines are deleted and replaced with Barbie’s remark on your side. The only thing you can tell is that your side wants to say it is hard and you’d prefer to go shopping, while the other side wants to claim it is easy.

An alternative style can be used by setting the "merge.conflictStyle" configuration variable to "diff3". In "diff3" style, the above conflict may look like this:

.if n \{.RS 4
.\}
    Here are lines that are either unchanged from the common
    ancestor, or cleanly resolved because only one side changed.
    <<<<<<< yours:sample.txt
    Conflict resolution is hard;
    let's go shopping.
    |||||||
    Conflict resolution is hard.
    =======
    Git makes conflict resolution easy.
    >>>>>>> theirs:sample.txt
    And here is another line that is cleanly resolved or unmodified.
.if n \{.RE
.\}


In addition to the **&lt;&lt;&lt;&lt;&lt;&lt;&lt;**, **=======**, and **&gt;&gt;&gt;&gt;&gt;&gt;&gt;** markers, it uses another **|||||||** marker that is followed by the original text. You can tell that the original just stated a fact, and your side simply gave in to that statement and gave up, while the other side tried to have a more positive attitude. You can sometimes come up with a better resolution by viewing the original.

<a name="how-to-resolve-conflicts"></a>

# How to Resolve Conflicts


After seeing a conflict, you can do two things:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Decide not to merge. The only clean-ups you need are to reset the index file to the
  **HEAD**
  commit to reverse 2. and to clean up working tree changes made by 2. and 3.;
  **git merge --abort**
  can be used for this.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Resolve the conflicts. Git will mark the conflicts in the working tree. Edit the files into shape and
  _git add_
  them to the index. Use
  _git commit_
  or
  _git merge --continue_
  to seal the deal. The latter command checks whether there is a (interrupted) merge in progress before calling
  _git commit_.

You can work through the conflict with a number of tools:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Use a mergetool.
  **git mergetool**
  to launch a graphical mergetool which will work you through the merge.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Look at the diffs.
  **git diff**
  will show a three-way diff, highlighting changes from both the
  **HEAD**
  and
  **MERGE\_HEAD**
  versions.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Look at the diffs from each branch.
  **git log --merge -p &lt;path&gt;**
  will show diffs first for the
  **HEAD**
  version and then the
  **MERGE\_HEAD**
  version.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Look at the originals.
  **git show :1:filename**
  shows the common ancestor,
  **git show :2:filename**
  shows the
  **HEAD**
  version, and
  **git show :3:filename**
  shows the
  **MERGE\_HEAD**
  version.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Merge branches
  **fixes**
  and
  **enhancements**
  on top of the current branch, making an octopus merge:

.if n \{.RS 4
.\}
    $ git merge fixes enhancements
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Merge branch
  **obsolete**
  into the current branch, using
  **ours**
  merge strategy:

.if n \{.RS 4
.\}
    $ git merge -s ours obsolete
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Merge branch
  **maint**
  into the current branch, but do not make a new commit automatically:

.if n \{.RS 4
.\}
    $ git merge --no-commit maint
.if n \{.RE
.\}

This can be used when you want to include further changes to the merge, or want to write your own merge commit message.

You should refrain from abusing this option to sneak substantial changes into a merge commit. Small fixups like bumping release/version name would be acceptable.

<a name="merge-strategies"></a>

# Merge Strategies


The merge mechanism (**git merge** and **git pull** commands) allows the backend _merge strategies_ to be chosen with **-s** option. Some strategies can also take their own options, which can be passed by giving **-X&lt;option&gt;** arguments to **git merge** and/or **git pull**.

resolve
This can only resolve two heads (i.e. the current branch and another branch you pulled from) using a 3-way merge algorithm. It tries to carefully detect criss-cross merge ambiguities and is considered generally safe and fast.

recursive
This can only resolve two heads using a 3-way merge algorithm. When there is more than one common ancestor that can be used for 3-way merge, it creates a merged tree of the common ancestors and uses that as the reference tree for the 3-way merge. This has been reported to result in fewer merge conflicts without causing mismerges by tests done on actual merge commits taken from Linux 2.6 kernel development history. Additionally this can detect and handle merges involving renames, but currently cannot make use of detected copies. This is the default merge strategy when pulling or merging one branch.

The
_recursive_
strategy can take the following options:

ours
This option forces conflicting hunks to be auto-resolved cleanly by favoring
_our_
version. Changes from the other tree that do not conflict with our side are reflected to the merge result. For a binary file, the entire contents are taken from our side.

This should not be confused with the
_ours_
merge strategy, which does not even look at what the other tree contains at all. It discards everything the other tree did, declaring
_our_
history contains all that happened in it.

theirs
This is the opposite of
_ours_; note that, unlike
_ours_, there is no
_theirs_
merge strategy to confuse this merge option with.

patience
With this option,
_merge-recursive_
spends a little extra time to avoid mismerges that sometimes occur due to unimportant matching lines (e.g., braces from distinct functions). Use this when the branches to be merged have diverged wildly. See also
**git-diff**(1)
**--patience**.

diff-algorithm=[patience|minimal|histogram|myers]
Tells
_merge-recursive_
to use a different diff algorithm, which can help avoid mismerges that occur due to unimportant matching lines (such as braces from distinct functions). See also
**git-diff**(1)
**--diff-algorithm**.

ignore-space-change, ignore-all-space, ignore-space-at-eol, ignore-cr-at-eol
Treats lines with the indicated type of whitespace change as unchanged for the sake of a three-way merge. Whitespace changes mixed with other changes to a line are not ignored. See also
**git-diff**(1)
**-b**,
**-w**,
**--ignore-space-at-eol**, and
**--ignore-cr-at-eol**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If
  _their_
  version only introduces whitespace changes to a line,
  _our_
  version is used;

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If
  _our_
  version introduces whitespace changes but
  _their_
  version includes a substantial change,
  _their_
  version is used;

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Otherwise, the merge proceeds in the usual way.

renormalize
This runs a virtual check-out and check-in of all three stages of a file when resolving a three-way merge. This option is meant to be used when merging branches with different clean filters or end-of-line normalization rules. See "Merging branches with differing checkin/checkout attributes" in
**gitattributes**(5)
for details.

no-renormalize
Disables the
**renormalize**
option. This overrides the
**merge.renormalize**
configuration variable.

no-renames
Turn off rename detection. This overrides the
**merge.renames**
configuration variable. See also
**git-diff**(1)
**--no-renames**.

find-renames[=&lt;n&gt;]
Turn on rename detection, optionally setting the similarity threshold. This is the default. This overrides the
_merge.renames_
configuration variable. See also
**git-diff**(1)
**--find-renames**.

rename-threshold=&lt;n&gt;
Deprecated synonym for
**find-renames=&lt;n&gt;**.

subtree[=&lt;path&gt;]
This option is a more advanced form of
_subtree_
strategy, where the strategy makes a guess on how two trees must be shifted to match with each other when merging. Instead, the specified path is prefixed (or stripped from the beginning) to make the shape of two trees to match.

octopus
This resolves cases with more than two heads, but refuses to do a complex merge that needs manual resolution. It is primarily meant to be used for bundling topic branch heads together. This is the default merge strategy when pulling or merging more than one branch.

ours
This resolves any number of heads, but the resulting tree of the merge is always that of the current branch head, effectively ignoring all changes from all other branches. It is meant to be used to supersede old development history of side branches. Note that this is different from the -Xours option to the
_recursive_
merge strategy.

subtree
This is a modified recursive strategy. When merging trees A and B, if B corresponds to a subtree of A, B is first adjusted to match the tree structure of A, instead of reading the trees at the same level. This adjustment is also done to the common ancestor tree.

With the strategies that use 3-way merge (including the default, _recursive_), if a change is made on both branches, but later reverted on one of the branches, that change will be present in the merged result; some people find this behavior confusing. It occurs because only the heads and the merge base are considered when performing a merge, not the individual commits. The merge algorithm therefore considers the reverted change as no change at all, and substitutes the changed version instead.

<a name="configuration"></a>

# Configuration


merge.conflictStyle
Specify the style in which conflicted hunks are written out to working tree files upon merge. The default is "merge", which shows a
**&lt;&lt;&lt;&lt;&lt;&lt;&lt;**
conflict marker, changes made by one side, a
**=======**
marker, changes made by the other side, and then a
**&gt;&gt;&gt;&gt;&gt;&gt;&gt;**
marker. An alternate style, "diff3", adds a
**|||||||**
marker and the original text before the
**=======**
marker.

merge.defaultToUpstream
If merge is called without any commit argument, merge the upstream branches configured for the current branch by using their last observed values stored in their remote-tracking branches. The values of the
**branch.&lt;current branch&gt;.merge**
that name the branches at the remote named by
**branch.&lt;current branch&gt;.remote**
are consulted, and then they are mapped via
**remote.&lt;remote&gt;.fetch**
to their corresponding remote-tracking branches, and the tips of these tracking branches are merged.

merge.ff
By default, Git does not create an extra merge commit when merging a commit that is a descendant of the current commit. Instead, the tip of the current branch is fast-forwarded. When set to
**false**, this variable tells Git to create an extra merge commit in such a case (equivalent to giving the
**--no-ff**
option from the command line). When set to
**only**, only such fast-forward merges are allowed (equivalent to giving the
**--ff-only**
option from the command line).

merge.verifySignatures
If true, this is equivalent to the --verify-signatures command line option. See
**git-merge**(1)
for details.

merge.branchdesc
In addition to branch names, populate the log message with the branch description text associated with them. Defaults to false.

merge.log
In addition to branch names, populate the log message with at most the specified number of one-line descriptions from the actual commits that are being merged. Defaults to false, and true is a synonym for 20.

merge.renameLimit
The number of files to consider when performing rename detection during a merge; if not specified, defaults to the value of diff.renameLimit. This setting has no effect if rename detection is turned off.

merge.renames
Whether and how Git detects renames. If set to "false", rename detection is disabled. If set to "true", basic rename detection is enabled. Defaults to the value of diff.renames.

merge.renormalize
Tell Git that canonical representation of files in the repository has changed over time (e.g. earlier commits record text files with CRLF line endings, but recent ones use LF line endings). In such a repository, Git can convert the data recorded in commits to a canonical form before performing a merge to reduce unnecessary conflicts. For more information, see section "Merging branches with differing checkin/checkout attributes" in
**gitattributes**(5).

merge.stat
Whether to print the diffstat between ORIG_HEAD and the merge result at the end of the merge. True by default.

merge.tool
Controls which merge tool is used by
**git-mergetool**(1). The list below shows the valid built-in values. Any other value is treated as a custom merge tool and requires that a corresponding mergetool.&lt;tool&gt;.cmd variable is defined.

merge.guitool
Controls which merge tool is used by
**git-mergetool**(1)
when the -g/--gui flag is specified. The list below shows the valid built-in values. Any other value is treated as a custom merge tool and requires that a corresponding mergetool.&lt;guitool&gt;.cmd variable is defined.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  araxis

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  bc

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  bc3

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  codecompare

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  deltawalker

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  diffmerge

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  diffuse

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ecmerge

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  emerge

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  examdiff

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  guiffy

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  gvimdiff

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  gvimdiff2

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  gvimdiff3

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  kdiff3

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  meld

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  opendiff

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  p4merge

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  tkdiff

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  tortoisemerge

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  vimdiff

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  vimdiff2

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  vimdiff3

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  winmerge

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  xxdiff

merge.verbosity
Controls the amount of output shown by the recursive merge strategy. Level 0 outputs nothing except a final error message if conflicts were detected. Level 1 outputs only conflicts, 2 outputs conflicts and file changes. Level 5 and above outputs debugging information. The default is level 2. Can be overridden by the
**GIT\_MERGE\_VERBOSITY**
environment variable.

merge.&lt;driver&gt;.name
Defines a human-readable name for a custom low-level merge driver. See
**gitattributes**(5)
for details.

merge.&lt;driver&gt;.driver
Defines the command that implements a custom low-level merge driver. See
**gitattributes**(5)
for details.

merge.&lt;driver&gt;.recursive
Names a low-level merge driver to be used when performing an internal merge between common ancestors. See
**gitattributes**(5)
for details.

branch.&lt;name&gt;.mergeOptions
Sets default options for merging into branch &lt;name&gt;. The syntax and supported options are the same as those of
_git merge_, but option values containing whitespace characters are currently not supported.

<a name="see-also"></a>

# See Also


**git-fmt-merge-msg**(1), **git-pull**(1), **gitattributes**(5), **git-reset**(1), **git-diff**(1), **git-ls-files**(1), **git-add**(1), **git-rm**(1), **git-mergetool**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
