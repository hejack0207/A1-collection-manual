# git\-remote(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-remote - Manage set of tracked repositories

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git remote [-v | --verbose]
    git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
    git remote rename <old> <new>
    git remote remove <name>
    git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
    git remote set-branches [--add] <name> <branch>...
    git remote get-url [--push] [--all] <name>
    git remote set-url [--push] <name> <newurl> [<oldurl>]
    git remote set-url --add [--push] <name> <newurl>
    git remote set-url --delete [--push] <name> <url>
    git remote [-v | --verbose] show [-n] <name>...
    git remote prune [-n | --dry-run] <name>...
    git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]
<synopsis>


```

<a name="description"></a>

# Description


Manage the set of repositories ("remotes") whose branches you track.

<a name="options"></a>

# Options


-v, --verbose
Be a little more verbose and show remote url after name. NOTE: This must be placed between
**remote**
and
**subcommand**.

<a name="commands"></a>

# Commands


With no arguments, shows a list of existing remotes. Several subcommands are available to perform operations on the remotes.

_add_
Adds a remote named &lt;name&gt; for the repository at &lt;url&gt;. The command
**git fetch &lt;name&gt;**
can then be used to create and update remote-tracking branches &lt;name&gt;/&lt;branch&gt;.

With
**-f**
option,
**git fetch &lt;name&gt;**
is run immediately after the remote information is set up.

With
**--tags**
option,
**git fetch &lt;name&gt;**
imports every tag from the remote repository.

With
**--no-tags**
option,
**git fetch &lt;name&gt;**
does not import tags from the remote repository.

By default, only tags on fetched branches are imported (see
**git-fetch**(1)).

With
**-t &lt;branch&gt;**
option, instead of the default glob refspec for the remote to track all branches under the
**refs/remotes/&lt;name&gt;/**
namespace, a refspec to track only
**&lt;branch&gt;**
is created. You can give more than one
**-t &lt;branch&gt;**
to track multiple branches without grabbing all branches.

With
**-m &lt;master&gt;**
option, a symbolic-ref
**refs/remotes/&lt;name&gt;/HEAD**
is set up to point at remote’s
**&lt;master&gt;**
branch. See also the set-head command.

When a fetch mirror is created with
**--mirror=fetch**, the refs will not be stored in the
_refs/remotes/_
namespace, but rather everything in
_refs/_
on the remote will be directly mirrored into
_refs/_
in the local repository. This option only makes sense in bare repositories, because a fetch would overwrite any local commits.

When a push mirror is created with
**--mirror=push**, then
**git push**
will always behave as if
**--mirror**
was passed.

_rename_
Rename the remote named &lt;old&gt; to &lt;new&gt;. All remote-tracking branches and configuration settings for the remote are updated.

In case &lt;old&gt; and &lt;new&gt; are the same, and &lt;old&gt; is a file under
**$GIT\_DIR/remotes**
or
**$GIT\_DIR/branches**, the remote is converted to the configuration file format.

_remove_, _rm_
Remove the remote named &lt;name&gt;. All remote-tracking branches and configuration settings for the remote are removed.

_set-head_
Sets or deletes the default branch (i.e. the target of the symbolic-ref
**refs/remotes/&lt;name&gt;/HEAD**) for the named remote. Having a default branch for a remote is not required, but allows the name of the remote to be specified in lieu of a specific branch. For example, if the default branch for
**origin**
is set to
**master**, then
**origin**
may be specified wherever you would normally specify
**origin/master**.

With
**-d**
or
**--delete**, the symbolic ref
**refs/remotes/&lt;name&gt;/HEAD**
is deleted.

With
**-a**
or
**--auto**, the remote is queried to determine its
**HEAD**, then the symbolic-ref
**refs/remotes/&lt;name&gt;/HEAD**
is set to the same branch. e.g., if the remote
**HEAD**
is pointed at
**next**, "**git remote set-head origin -a**" will set the symbolic-ref
**refs/remotes/origin/HEAD**
to
**refs/remotes/origin/next**. This will only work if
**refs/remotes/origin/next**
already exists; if not it must be fetched first.

Use
**&lt;branch&gt;**
to set the symbolic-ref
**refs/remotes/&lt;name&gt;/HEAD**
explicitly. e.g., "git remote set-head origin master" will set the symbolic-ref
**refs/remotes/origin/HEAD**
to
**refs/remotes/origin/master**. This will only work if
**refs/remotes/origin/master**
already exists; if not it must be fetched first.

_set-branches_
Changes the list of branches tracked by the named remote. This can be used to track a subset of the available remote branches after the initial setup for a remote.

The named branches will be interpreted as if specified with the
**-t**
option on the
_git remote add_
command line.

With
**--add**, instead of replacing the list of currently tracked branches, adds to that list.

_get-url_
Retrieves the URLs for a remote. Configurations for
**insteadOf**
and
**pushInsteadOf**
are expanded here. By default, only the first URL is listed.

With
**--push**, push URLs are queried rather than fetch URLs.

With
**--all**, all URLs for the remote will be listed.

_set-url_
Changes URLs for the remote. Sets first URL for remote &lt;name&gt; that matches regex &lt;oldurl&gt; (first URL if no &lt;oldurl&gt; is given) to &lt;newurl&gt;. If &lt;oldurl&gt; doesn’t match any URL, an error occurs and nothing is changed.

With
**--push**, push URLs are manipulated instead of fetch URLs.

With
**--add**, instead of changing existing URLs, new URL is added.

With
**--delete**, instead of changing existing URLs, all URLs matching regex &lt;url&gt; are deleted for remote &lt;name&gt;. Trying to delete all non-push URLs is an error.

Note that the push URL and the fetch URL, even though they can be set differently, must still refer to the same place. What you pushed to the push URL should be what you would see if you immediately fetched from the fetch URL. If you are trying to fetch from one place (e.g. your upstream) and push to another (e.g. your publishing repository), use two separate remotes.

_show_
Gives some information about the remote &lt;name&gt;.

With
**-n**
option, the remote heads are not queried first with
**git ls-remote &lt;name&gt;**; cached information is used instead.

_prune_
Deletes stale references associated with &lt;name&gt;. By default, stale remote-tracking branches under &lt;name&gt; are deleted, but depending on global configuration and the configuration of the remote we might even prune local tags that haven’t been pushed there. Equivalent to
**git fetch --prune &lt;name&gt;**, except that no new references will be fetched.

See the PRUNING section of
**git-fetch**(1)
for what it’ll prune depending on various configuration.

With
**--dry-run**
option, report what branches will be pruned, but do not actually prune them.

_update_
Fetch updates for remotes or remote groups in the repository as defined by remotes.&lt;group&gt;. If neither group nor remote is specified on the command line, the configuration parameter remotes.default will be used; if remotes.default is not defined, all remotes which do not have the configuration parameter remote.&lt;name&gt;.skipDefaultUpdate set to true will be updated. (See
**git-config**(1)).

With
**--prune**
option, run pruning against all the remotes that are updated.

<a name="discussion"></a>

# Discussion


The remote configuration is achieved using the **remote.origin.url** and **remote.origin.fetch** configuration variables. (See **git-config**(1)).

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Add a new remote, fetch, and check out a branch from it

.if n \{.RS 4
.\}
    $ git remote
    origin
    $ git branch -r
      origin/HEAD -> origin/master
      origin/master
    $ git remote add staging git://git.kernel.org/.../gregkh/staging.git
    $ git remote
    origin
    staging
    $ git fetch staging
    ...
    From git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
     * [new branch]      master     -> staging/master
     * [new branch]      staging-linus -> staging/staging-linus
     * [new branch]      staging-next -> staging/staging-next
    $ git branch -r
      origin/HEAD -> origin/master
      origin/master
      staging/master
      staging/staging-linus
      staging/staging-next
    $ git checkout -b staging staging/master
    ...
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Imitate
  _git clone_
  but track only selected branches

.if n \{.RS 4
.\}
    $ mkdir project.git
    $ cd project.git
    $ git init
    $ git remote add -f -t master -m master origin git://example.com/git.git/
    $ git merge origin
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**git-fetch**(1) **git-branch**(1) **git-config**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
