# git\-gc(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-gc - Cleanup unnecessary files and optimize the local repository

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git gc [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
<synopsis>


```

<a name="description"></a>

# Description


Runs a number of housekeeping tasks within the current repository, such as compressing file revisions (to reduce disk space and increase performance), removing unreachable objects which may have been created from prior invocations of _git add_, packing refs, pruning reflog, rerere metadata or stale working trees. May also update ancillary indexes such as the commit-graph.

Users are encouraged to run this task on a regular basis within each repository to maintain good disk space utilization and good operating performance.

Some git commands may automatically run _git gc_; see the **--auto** flag below for details. If you know what you’re doing and all you want is to disable this behavior permanently without further considerations, just do:

.if n \{.RS 4
.\}
    $ git config --global gc.auto 0
.if n \{.RE
.\}


<a name="options"></a>

# Options


--aggressive
Usually
_git gc_
runs very quickly while providing good disk space utilization and performance. This option will cause
_git gc_
to more aggressively optimize the repository at the expense of taking much more time. The effects of this optimization are persistent, so this option only needs to be used occasionally; every few hundred changesets or so.

--auto
With this option,
_git gc_
checks whether any housekeeping is required; if not, it exits without performing any work. Some git commands run
**git gc --auto**
after performing operations that could create many loose objects. Housekeeping is required if there are too many loose objects or too many packs in the repository.

If the number of loose objects exceeds the value of the
**gc.auto**
configuration variable, then all loose objects are combined into a single pack using
**git repack -d -l**. Setting the value of
**gc.auto**
to 0 disables automatic packing of loose objects.

If the number of packs exceeds the value of
**gc.autoPackLimit**, then existing packs (except those marked with a
**.keep**
file or over
**gc.bigPackThreshold**
limit) are consolidated into a single pack by using the
**-A**
option of
_git repack_. If the amount of memory is estimated not enough for
**git repack**
to run smoothly and
**gc.bigPackThreshold**
is not set, the largest pack will also be excluded (this is the equivalent of running
**git gc**
with
**--keep-base-pack**). Setting
**gc.autoPackLimit**
to 0 disables automatic consolidation of packs.

If houskeeping is required due to many loose objects or packs, all other housekeeping tasks (e.g. rerere, working trees, reflog...) will be performed as well.

--prune=&lt;date&gt;
Prune loose objects older than date (default is 2 weeks ago, overridable by the config variable
**gc.pruneExpire**). --prune=all prunes loose objects regardless of their age and increases the risk of corruption if another process is writing to the repository concurrently; see "NOTES" below. --prune is on by default.

--no-prune
Do not prune any loose objects.

--quiet
Suppress all progress reports.

--force
Force
**git gc**
to run even if there may be another
**git gc**
instance running on this repository.

--keep-largest-pack
All packs except the largest pack and those marked with a
**.keep**
files are consolidated into a single pack. When this option is used,
**gc.bigPackThreshold**
is ignored.

<a name="configuration"></a>

# Configuration


The optional configuration variable **gc.reflogExpire** can be set to indicate how long historical entries within each branch’s reflog should remain available in this repository. The setting is expressed as a length of time, for example _90 days_ or _3 months_. It defaults to _90 days_.

The optional configuration variable **gc.reflogExpireUnreachable** can be set to indicate how long historical reflog entries which are not part of the current branch should remain available in this repository. These types of entries are generally created as a result of using **git commit --amend** or **git rebase** and are the commits prior to the amend or rebase occurring. Since these changes are not part of the current project most users will want to expire them sooner. This option defaults to _30 days_.

The above two configuration variables can be given to a pattern. For example, this sets non-default expiry values only to remote-tracking branches:

.if n \{.RS 4
.\}
    [gc "refs/remotes/*"]
            reflogExpire = never
            reflogExpireUnreachable = 3 days
.if n \{.RE
.\}


The optional configuration variable **gc.rerereResolved** indicates how long records of conflicted merge you resolved earlier are kept. This defaults to 60 days.

The optional configuration variable **gc.rerereUnresolved** indicates how long records of conflicted merge you have not resolved are kept. This defaults to 15 days.

The optional configuration variable **gc.packRefs** determines if _git gc_ runs _git pack-refs_. This can be set to "notbare" to enable it within all non-bare repos or it can be set to a boolean value. This defaults to true.

The optional configuration variable **gc.writeCommitGraph** determines if _git gc_ should run _git commit-graph write_. This can be set to a boolean value. This defaults to false.

The optional configuration variable **gc.aggressiveWindow** controls how much time is spent optimizing the delta compression of the objects in the repository when the --aggressive option is specified. The larger the value, the more time is spent optimizing the delta compression. See the documentation for the --window option in **git-repack**(1) for more details. This defaults to 250.

Similarly, the optional configuration variable **gc.aggressiveDepth** controls --depth option in **git-repack**(1). This defaults to 50.

The optional configuration variable **gc.pruneExpire** controls how old the unreferenced loose objects have to be before they are pruned. The default is "2 weeks ago".

Optional configuration variable **gc.worktreePruneExpire** controls how old a stale working tree should be before **git worktree prune** deletes it. Default is "3 months ago".

<a name="notes"></a>

# Notes


_git gc_ tries very hard not to delete objects that are referenced anywhere in your repository. In particular, it will keep not only objects referenced by your current set of branches and tags, but also objects referenced by the index, remote-tracking branches, refs saved by _git filter-branch_ in refs/original/, or reflogs (which may reference commits in branches that were later amended or rewound). If you are expecting some objects to be deleted and they aren’t, check all of those locations and decide whether it makes sense in your case to remove those references.

On the other hand, when _git gc_ runs concurrently with another process, there is a risk of it deleting an object that the other process is using but hasn’t created a reference to. This may just cause the other process to fail or may corrupt the repository if the other process later adds a reference to the deleted object. Git has two features that significantly mitigate this problem:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Any object with modification time newer than the
  **--prune**
  date is kept, along with everything reachable from it.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Most operations that add an object to the database update the modification time of the object if it is already present so that #1 applies.

However, these features fall short of a complete solution, so users who run commands concurrently have to live with some risk of corruption (which seems to be low in practice) unless they turn off automatic garbage collection with _git config gc.auto 0_.

<a name="hooks"></a>

# Hooks


The _git gc --auto_ command will run the _pre-auto-gc_ hook. See **githooks**(5) for more information.

<a name="see-also"></a>

# See Also


**git-prune**(1) **git-reflog**(1) **git-repack**(1) **git-rerere**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
