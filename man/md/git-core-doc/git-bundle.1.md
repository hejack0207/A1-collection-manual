# git\-bundle(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-bundle - Move objects and refs by archive

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git bundle create <file> <git-rev-list-args>
    git bundle verify <file>
    git bundle list-heads <file> [<refname>...]
    git bundle unbundle <file> [<refname>...]
<synopsis>


```

<a name="description"></a>

# Description


Some workflows require that one or more branches of development on one machine be replicated on another machine, but the two machines cannot be directly connected, and therefore the interactive Git protocols (git, ssh, http) cannot be used. This command provides support for _git fetch_ and _git pull_ to operate by packaging objects and references in an archive at the originating machine, then importing those into another repository using _git fetch_ and _git pull_ after moving the archive by some means (e.g., by sneakernet). As no direct connection between the repositories exists, the user must specify a basis for the bundle that is held by the destination repository: the bundle assumes that all objects in the basis are already in the destination repository.

<a name="options"></a>

# Options


create &lt;file&gt;
Used to create a bundle named
_file_. This requires the
_git-rev-list-args_
arguments to define the bundle contents.

verify &lt;file&gt;
Used to check that a bundle file is valid and will apply cleanly to the current repository. This includes checks on the bundle format itself as well as checking that the prerequisite commits exist and are fully linked in the current repository.
_git bundle_
prints a list of missing commits, if any, and exits with a non-zero status.

list-heads &lt;file&gt;
Lists the references defined in the bundle. If followed by a list of references, only references matching those given are printed out.

unbundle &lt;file&gt;
Passes the objects in the bundle to
_git index-pack_
for storage in the repository, then prints the names of all defined references. If a list of references is given, only references matching those in the list are printed. This command is really plumbing, intended to be called only by
_git fetch_.

&lt;git-rev-list-args&gt;
A list of arguments, acceptable to
_git rev-parse_
and
_git rev-list_
(and containing a named ref, see SPECIFYING REFERENCES below), that specifies the specific objects and references to transport. For example,
**master~10..master**
causes the current master reference to be packaged along with all objects added since its 10th ancestor commit. There is no explicit limit to the number of references and objects that may be packaged.

[&lt;refname&gt;...]
A list of references used to limit the references reported as available. This is principally of use to
_git fetch_, which expects to receive only those references asked for and not necessarily everything in the pack (in this case,
_git bundle_
acts like
_git fetch-pack_).

<a name="specifying-references"></a>

# Specifying References


_git bundle_ will only package references that are shown by _git show-ref_: this includes heads, tags, and remote heads. References such as **master~1** cannot be packaged, but are perfectly suitable for defining the basis. More than one reference may be packaged, and more than one basis can be specified. The objects packaged are those not contained in the union of the given bases. Each basis can be specified explicitly (e.g. **^master~10**), or implicitly (e.g. **master~10..master**, **--since=10.days.ago master**).

It is very important that the basis used be held by the destination. It is okay to err on the side of caution, causing the bundle file to contain objects already in the destination, as these are ignored when unpacking at the destination.

<a name="examples"></a>

# Examples


Assume you want to transfer the history from a repository R1 on machine A to another repository R2 on machine B. For whatever reason, direct connection between A and B is not allowed, but we can move data from A to B via some mechanism (CD, email, etc.). We want to update R2 with development made on the branch master in R1.

To bootstrap the process, you can first create a bundle that does not have any basis. You can use a tag to remember up to what commit you last processed, in order to make it easy to later update the other repository with an incremental bundle:

.if n \{.RS 4
.\}
    machineA$ cd R1
    machineA$ git bundle create file.bundle master
    machineA$ git tag -f lastR2bundle master
.if n \{.RE
.\}


Then you transfer file.bundle to the target machine B. Because this bundle does not require any existing object to be extracted, you can create a new repository on machine B by cloning from it:

.if n \{.RS 4
.\}
    machineB$ git clone -b master /home/me/tmp/file.bundle R2
.if n \{.RE
.\}


This will define a remote called "origin" in the resulting repository that lets you fetch and pull from the bundle. The $GIT_DIR/config file in R2 will have an entry like this:

.if n \{.RS 4
.\}
    [remote "origin"]
        url = /home/me/tmp/file.bundle
        fetch = refs/heads/*:refs/remotes/origin/*
.if n \{.RE
.\}


To update the resulting mine.git repository, you can fetch or pull after replacing the bundle stored at /home/me/tmp/file.bundle with incremental updates.

After working some more in the original repository, you can create an incremental bundle to update the other repository:

.if n \{.RS 4
.\}
    machineA$ cd R1
    machineA$ git bundle create file.bundle lastR2bundle..master
    machineA$ git tag -f lastR2bundle master
.if n \{.RE
.\}


You then transfer the bundle to the other machine to replace /home/me/tmp/file.bundle, and pull from it.

.if n \{.RS 4
.\}
    machineB$ cd R2
    machineB$ git pull
.if n \{.RE
.\}


If you know up to what commit the intended recipient repository should have the necessary objects, you can use that knowledge to specify the basis, giving a cut-off point to limit the revisions and objects that go in the resulting bundle. The previous example used the lastR2bundle tag for this purpose, but you can use any other options that you would give to the **git-log**(1) command. Here are more examples:

You can use a tag that is present in both:

.if n \{.RS 4
.\}
    $ git bundle create mybundle v1.0.0..master
.if n \{.RE
.\}


You can use a basis based on time:

.if n \{.RS 4
.\}
    $ git bundle create mybundle --since=10.days master
.if n \{.RE
.\}


You can use the number of commits:

.if n \{.RS 4
.\}
    $ git bundle create mybundle -10 master
.if n \{.RE
.\}


You can run **git-bundle verify** to see if you can extract from a bundle that was created with a basis:

.if n \{.RS 4
.\}
    $ git bundle verify mybundle
.if n \{.RE
.\}


This will list what commits you must have in order to extract from the bundle and will error out if you do not have them.

A bundle from a recipient repository’s point of view is just like a regular repository which it fetches or pulls from. You can, for example, map references when fetching:

.if n \{.RS 4
.\}
    $ git fetch mybundle master:localRef
.if n \{.RE
.\}


You can also see what references it offers:

.if n \{.RS 4
.\}
    $ git ls-remote mybundle
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
