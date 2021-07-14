# git\-checkout(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-checkout - Switch branches or restore working tree files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git checkout [-q] [-f] [-m] [<branch>]
    git checkout [-q] [-f] [-m] --detach [<branch>]
    git checkout [-q] [-f] [-m] [--detach] <commit>
    git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
    git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
    git checkout [<tree-ish>] [--] <pathspec>...
    git checkout (-p|--patch) [<tree-ish>] [--] [<paths>...]
<synopsis>


```

<a name="description"></a>

# Description


Updates files in the working tree to match the version in the index or the specified tree. If no paths are given, _git checkout_ will also update **HEAD** to set the specified branch as the current branch.

_git checkout_ &lt;branch&gt;
To prepare for working on &lt;branch&gt;, switch to it by updating the index and the files in the working tree, and by pointing HEAD at the branch. Local modifications to the files in the working tree are kept, so that they can be committed to the &lt;branch&gt;.

If &lt;branch&gt; is not found but there does exist a tracking branch in exactly one remote (call it &lt;remote&gt;) with a matching name, treat as equivalent to

.if n \{.RS 4
.\}
    $ git checkout -b <branch> --track <remote>/<branch>
.if n \{.RE
.\}

If the branch exists in multiple remotes and one of them is named by the
**checkout.defaultRemote**
configuration variable, we’ll use that one for the purposes of disambiguation, even if the
**&lt;branch&gt;**
isn’t unique across all remotes. Set it to e.g.
**checkout.defaultRemote=origin**
to always checkout remote branches from there if
**&lt;branch&gt;**
is ambiguous but exists on the
_origin_
remote. See also
**checkout.defaultRemote**
in
**git-config**(1).

You could omit &lt;branch&gt;, in which case the command degenerates to "check out the current branch", which is a glorified no-op with rather expensive side-effects to show only the tracking information, if exists, for the current branch.

_git checkout_ -b|-B &lt;new_branch&gt; [&lt;start point&gt;]
Specifying
**-b**
causes a new branch to be created as if
**git-branch**(1)
were called and then checked out. In this case you can use the
**--track**
or
**--no-track**
options, which will be passed to
_git branch_. As a convenience,
**--track**
without
**-b**
implies branch creation; see the description of
**--track**
below.

If
**-B**
is given, &lt;new_branch&gt; is created if it doesn’t exist; otherwise, it is reset. This is the transactional equivalent of

.if n \{.RS 4
.\}
    $ git branch -f <branch> [<start point>]
    $ git checkout <branch>
.if n \{.RE
.\}

that is to say, the branch is not reset/created unless "git checkout" is successful.

_git checkout_ --detach [&lt;branch&gt;], _git checkout_ [--detach] &lt;commit&gt;
Prepare to work on top of &lt;commit&gt;, by detaching HEAD at it (see "DETACHED HEAD" section), and updating the index and the files in the working tree. Local modifications to the files in the working tree are kept, so that the resulting working tree will be the state recorded in the commit plus the local modifications.

When the &lt;commit&gt; argument is a branch name, the
**--detach**
option can be used to detach HEAD at the tip of the branch (**git checkout &lt;branch&gt;**
would check out that branch without detaching HEAD).

Omitting &lt;branch&gt; detaches HEAD at the tip of the current branch.

_git checkout_ [&lt;tree-ish&gt;] [--] &lt;pathspec&gt;...
Overwrite paths in the working tree by replacing with the contents in the index or in the &lt;tree-ish&gt; (most often a commit). When a &lt;tree-ish&gt; is given, the paths that match the &lt;pathspec&gt; are updated both in the index and in the working tree.

The index may contain unmerged entries because of a previous failed merge. By default, if you try to check out such an entry from the index, the checkout operation will fail and nothing will be checked out. Using
**-f**
will ignore these unmerged entries. The contents from a specific side of the merge can be checked out of the index by using
**--ours**
or
**--theirs**. With
**-m**, changes made to the working tree file can be discarded to re-create the original conflicted merge result.

_git checkout_ (-p|--patch) [&lt;tree-ish&gt;] [--] [&lt;pathspec&gt;...]
This is similar to the "check out paths to the working tree from either the index or from a tree-ish" mode described above, but lets you use the interactive interface to show the "diff" output and choose which hunks to use in the result. See below for the description of
**--patch**
option.

<a name="options"></a>

# Options


-q, --quiet
Quiet, suppress feedback messages.

--[no-]progress
Progress status is reported on the standard error stream by default when it is attached to a terminal, unless
**--quiet**
is specified. This flag enables progress reporting even if not attached to a terminal, regardless of
**--quiet**.

-f, --force
When switching branches, proceed even if the index or the working tree differs from HEAD. This is used to throw away local changes.

When checking out paths from the index, do not fail upon unmerged entries; instead, unmerged entries are ignored.

--ours, --theirs
When checking out paths from the index, check out stage #2 (_ours_) or #3 (_theirs_) for unmerged paths.

Note that during
**git rebase**
and
**git pull --rebase**,
_ours_
and
_theirs_
may appear swapped;
**--ours**
gives the version from the branch the changes are rebased onto, while
**--theirs**
gives the version from the branch that holds your work that is being rebased.

This is because
**rebase**
is used in a workflow that treats the history at the remote as the shared canonical one, and treats the work done on the branch you are rebasing as the third-party work to be integrated, and you are temporarily assuming the role of the keeper of the canonical history during the rebase. As the keeper of the canonical history, you need to view the history from the remote as
**ours**
(i.e. "our shared canonical history"), while what you did on your side branch as
**theirs**
(i.e. "one contributor’s work on top of it").

-b &lt;new_branch&gt;
Create a new branch named &lt;new_branch&gt; and start it at &lt;start_point&gt;; see
**git-branch**(1)
for details.

-B &lt;new_branch&gt;
Creates the branch &lt;new_branch&gt; and start it at &lt;start_point&gt;; if it already exists, then reset it to &lt;start_point&gt;. This is equivalent to running "git branch" with "-f"; see
**git-branch**(1)
for details.

-t, --track
When creating a new branch, set up "upstream" configuration. See "--track" in
**git-branch**(1)
for details.

If no
**-b**
option is given, the name of the new branch will be derived from the remote-tracking branch, by looking at the local part of the refspec configured for the corresponding remote, and then stripping the initial part up to the "*". This would tell us to use "hack" as the local branch when branching off of "origin/hack" (or "remotes/origin/hack", or even "refs/remotes/origin/hack"). If the given name has no slash, or the above guessing results in an empty name, the guessing is aborted. You can explicitly give a name with
**-b**
in such a case.

--no-track
Do not set up "upstream" configuration, even if the branch.autoSetupMerge configuration variable is true.

-l
Create the new branch’s reflog; see
**git-branch**(1)
for details.

--detach
Rather than checking out a branch to work on it, check out a commit for inspection and discardable experiments. This is the default behavior of "git checkout &lt;commit&gt;" when &lt;commit&gt; is not a branch name. See the "DETACHED HEAD" section below for details.

--orphan &lt;new_branch&gt;
Create a new
_orphan_
branch, named &lt;new_branch&gt;, started from &lt;start_point&gt; and switch to it. The first commit made on this new branch will have no parents and it will be the root of a new history totally disconnected from all the other branches and commits.

The index and the working tree are adjusted as if you had previously run "git checkout &lt;start_point&gt;". This allows you to start a new history that records a set of paths similar to &lt;start_point&gt; by easily running "git commit -a" to make the root commit.

This can be useful when you want to publish the tree from a commit without exposing its full history. You might want to do this to publish an open source branch of a project whose current tree is "clean", but whose full history contains proprietary or otherwise encumbered bits of code.

If you want to start a disconnected history that records a set of paths that is totally different from the one of &lt;start_point&gt;, then you should clear the index and the working tree right after creating the orphan branch by running "git rm -rf ." from the top level of the working tree. Afterwards you will be ready to prepare your new files, repopulating the working tree, by copying them from elsewhere, extracting a tarball, etc.

--ignore-skip-worktree-bits
In sparse checkout mode,
**git checkout -- &lt;paths&gt;**
would update only entries matched by &lt;paths&gt; and sparse patterns in $GIT_DIR/info/sparse-checkout. This option ignores the sparse patterns and adds back any files in &lt;paths&gt;.

-m, --merge
When switching branches, if you have local modifications to one or more files that are different between the current branch and the branch to which you are switching, the command refuses to switch branches in order to preserve your modifications in context. However, with this option, a three-way merge between the current branch, your working tree contents, and the new branch is done, and you will be on the new branch.

When a merge conflict happens, the index entries for conflicting paths are left unmerged, and you need to resolve the conflicts and mark the resolved paths with
**git add**
(or
**git rm**
if the merge should result in deletion of the path).

When checking out paths from the index, this option lets you recreate the conflicted merge in the specified paths.

--conflict=&lt;style&gt;
The same as --merge option above, but changes the way the conflicting hunks are presented, overriding the merge.conflictStyle configuration variable. Possible values are "merge" (default) and "diff3" (in addition to what is shown by "merge" style, shows the original contents).

-p, --patch
Interactively select hunks in the difference between the &lt;tree-ish&gt; (or the index, if unspecified) and the working tree. The chosen hunks are then applied in reverse to the working tree (and if a &lt;tree-ish&gt; was specified, the index).

This means that you can use
**git checkout -p**
to selectively discard edits from your current working tree. See the “Interactive Mode” section of
**git-add**(1)
to learn how to operate the
**--patch**
mode.

--ignore-other-worktrees
**git checkout**
refuses when the wanted ref is already checked out by another worktree. This option makes it check the ref out anyway. In other words, the ref can be held by more than one worktree.

--[no-]recurse-submodules
Using --recurse-submodules will update the content of all initialized submodules according to the commit recorded in the superproject. If local modifications in a submodule would be overwritten the checkout will fail unless
**-f**
is used. If nothing (or --no-recurse-submodules) is used, the work trees of submodules will not be updated. Just like
**git-submodule**(1), this will detach the submodules HEAD.

--no-guess
Do not attempt to create a branch if a remote tracking branch of the same name exists.

&lt;branch&gt;
Branch to checkout; if it refers to a branch (i.e., a name that, when prepended with "refs/heads/", is a valid ref), then that branch is checked out. Otherwise, if it refers to a valid commit, your HEAD becomes "detached" and you are no longer on any branch (see below for details).

You can use the
**"@{-N}"**
syntax to refer to the N-th last branch/commit checked out using "git checkout" operation. You may also specify
**-**
which is synonymous to
**"@{-1}"**.

As a special case, you may use
**"A...B"**
as a shortcut for the merge base of
**A**
and
**B**
if there is exactly one merge base. You can leave out at most one of
**A**
and
**B**, in which case it defaults to
**HEAD**.

&lt;new_branch&gt;
Name for the new branch.

&lt;start_point&gt;
The name of a commit at which to start the new branch; see
**git-branch**(1)
for details. Defaults to HEAD.

&lt;tree-ish&gt;
Tree to checkout from (when paths are given). If not specified, the index will be used.

<a name="detached-head"></a>

# Detached Head


HEAD normally refers to a named branch (e.g. _master_). Meanwhile, each branch refers to a specific commit. Let’s look at a repo with three commits, one of them tagged, and with branch _master_ checked out:

.if n \{.RS 4
.\}
               HEAD (refers to branch 'master')
                |
                v
    a---b---c  branch 'master' (refers to commit 'c')
        ^
        |
      tag 'v2.0' (refers to commit 'b')
.if n \{.RE
.\}


When a commit is created in this state, the branch is updated to refer to the new commit. Specifically, _git commit_ creates a new commit _d_, whose parent is commit _c_, and then updates branch _master_ to refer to new commit _d_. HEAD still refers to branch _master_ and so indirectly now refers to commit _d_:

.if n \{.RS 4
.\}
    $ edit; git add; git commit
    
                   HEAD (refers to branch 'master')
                    |
                    v
    a---b---c---d  branch 'master' (refers to commit 'd')
        ^
        |
      tag 'v2.0' (refers to commit 'b')
.if n \{.RE
.\}


It is sometimes useful to be able to checkout a commit that is not at the tip of any named branch, or even to create a new commit that is not referenced by a named branch. Let’s look at what happens when we checkout commit _b_ (here we show two ways this may be done):

.if n \{.RS 4
.\}
    $ git checkout v2.0  # or
    $ git checkout master^^
    
       HEAD (refers to commit 'b')
        |
        v
    a---b---c---d  branch 'master' (refers to commit 'd')
        ^
        |
      tag 'v2.0' (refers to commit 'b')
.if n \{.RE
.\}


Notice that regardless of which checkout command we use, HEAD now refers directly to commit _b_. This is known as being in detached HEAD state. It means simply that HEAD refers to a specific commit, as opposed to referring to a named branch. Let’s see what happens when we create a commit:

.if n \{.RS 4
.\}
    $ edit; git add; git commit
    
         HEAD (refers to commit 'e')
          |
          v
          e
         /
    a---b---c---d  branch 'master' (refers to commit 'd')
        ^
        |
      tag 'v2.0' (refers to commit 'b')
.if n \{.RE
.\}


There is now a new commit _e_, but it is referenced only by HEAD. We can of course add yet another commit in this state:

.if n \{.RS 4
.\}
    $ edit; git add; git commit
    
             HEAD (refers to commit 'f')
              |
              v
          e---f
         /
    a---b---c---d  branch 'master' (refers to commit 'd')
        ^
        |
      tag 'v2.0' (refers to commit 'b')
.if n \{.RE
.\}


In fact, we can perform all the normal Git operations. But, let’s look at what happens when we then checkout master:

.if n \{.RS 4
.\}
    $ git checkout master
    
                   HEAD (refers to branch 'master')
          e---f     |
         /          v
    a---b---c---d  branch 'master' (refers to commit 'd')
        ^
        |
      tag 'v2.0' (refers to commit 'b')
.if n \{.RE
.\}


It is important to realize that at this point nothing refers to commit _f_. Eventually commit _f_ (and by extension commit _e_) will be deleted by the routine Git garbage collection process, unless we create a reference before that happens. If we have not yet moved away from commit _f_, any of these will create a reference to it:

.if n \{.RS 4
.\}
    $ git checkout -b foo   (1)
    $ git branch foo        (2)
    $ git tag foo           (3)
.if n \{.RE
.\}


**1. **creates a new branch
_foo_, which refers to commit
_f_, and then updates HEAD to refer to branch
_foo_. In other words, we’ll no longer be in detached HEAD state after this command.  
**2. **similarly creates a new branch
_foo_, which refers to commit
_f_, but leaves HEAD detached.  
**3. **creates a new tag
_foo_, which refers to commit
_f_, leaving HEAD detached.  

If we have moved away from commit _f_, then we must first recover its object name (typically by using git reflog), and then we can create a reference to it. For example, to see the last two commits to which HEAD referred, we can use either of these commands:

.if n \{.RS 4
.\}
    $ git reflog -2 HEAD # or
    $ git log -g -2 HEAD
.if n \{.RE
.\}


<a name="argument-disambiguation"></a>

# Argument Disambiguation


When there is only one argument given and it is not **--** (e.g. "git checkout abc"), and when the argument is both a valid **&lt;tree-ish&gt;** (e.g. a branch "abc" exists) and a valid **&lt;pathspec&gt;** (e.g. a file or a directory whose name is "abc" exists), Git would usually ask you to disambiguate. Because checking out a branch is so common an operation, however, "git checkout abc" takes "abc" as a **&lt;tree-ish&gt;** in such a situation. Use **git checkout -- &lt;pathspec&gt;** if you want to checkout these paths out of the index.

<a name="examples"></a>

# Examples


.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  The following sequence checks out the
  **master**
  branch, reverts the
  **Makefile**
  to two revisions back, deletes hello.c by mistake, and gets it back from the index.

.if n \{.RS 4
.\}
    $ git checkout master             (1)
    $ git checkout master~2 Makefile  (2)
    $ rm -f hello.c
    $ git checkout hello.c            (3)
.if n \{.RE
.\}

**1. **switch branch  
**2. **take a file out of another commit  
**3. **restore hello.c from the index

If you want to check out
_all_
C source files out of the index, you can say

.if n \{.RS 4
.\}
    $ git checkout -- '*.c'
.if n \{.RE
.\}

Note the quotes around
***.c**. The file
**hello.c**
will also be checked out, even though it is no longer in the working tree, because the file globbing is used to match entries in the index (not in the working tree by the shell).

If you have an unfortunate branch that is named
**hello.c**, this step would be confused as an instruction to switch to that branch. You should instead write:

.if n \{.RS 4
.\}
    $ git checkout -- hello.c
.if n \{.RE
.\}
  

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  After working in the wrong branch, switching to the correct branch would be done using:

.if n \{.RS 4
.\}
    $ git checkout mytopic
.if n \{.RE
.\}

However, your "wrong" branch and correct "mytopic" branch may differ in files that you have modified locally, in which case the above checkout would fail like this:

.if n \{.RS 4
.\}
    $ git checkout mytopic
    error: You have local changes to 'frotz'; not switching branches.
.if n \{.RE
.\}

You can give the
**-m**
flag to the command, which would try a three-way merge:

.if n \{.RS 4
.\}
    $ git checkout -m mytopic
    Auto-merging frotz
.if n \{.RE
.\}

After this three-way merge, the local modifications are
_not_
registered in your index file, so
**git diff**
would show you what changes you made since the tip of the new branch.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  When a merge conflict happens during switching branches with the
  **-m**
  option, you would see something like this:

.if n \{.RS 4
.\}
    $ git checkout -m mytopic
    Auto-merging frotz
    ERROR: Merge conflict in frotz
    fatal: merge program failed
.if n \{.RE
.\}

At this point,
**git diff**
shows the changes cleanly merged as in the previous example, as well as the changes in the conflicted files. Edit and resolve the conflict and mark it resolved with
**git add**
as usual:

.if n \{.RS 4
.\}
    $ edit frotz
    $ git add frotz
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
