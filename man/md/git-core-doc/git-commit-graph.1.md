# git\-commit\-graph(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-commit-graph - Write and verify Git commit-graph files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git commit-graph read [--object-dir <dir>]
    git commit-graph verify [--object-dir <dir>]
    git commit-graph write <options> [--object-dir <dir>]
<synopsis>


```

<a name="description"></a>

# Description


Manage the serialized commit-graph file.

<a name="options"></a>

# Options


--object-dir
Use given directory for the location of packfiles and commit-graph file. This parameter exists to specify the location of an alternate that only has the objects directory, not a full
**.git**
directory. The commit-graph file is expected to be at
**&lt;dir&gt;/info/commit-graph**
and the packfiles are expected to be in
**&lt;dir&gt;/pack**.

<a name="commands"></a>

# Commands


_write_
Write a commit-graph file based on the commits found in packfiles.

With the
**--stdin-packs**
option, generate the new commit graph by walking objects only in the specified pack-indexes. (Cannot be combined with
**--stdin-commits**
or
**--reachable**.)

With the
**--stdin-commits**
option, generate the new commit graph by walking commits starting at the commits specified in stdin as a list of OIDs in hex, one OID per line. (Cannot be combined with
**--stdin-packs**
or
**--reachable**.)

With the
**--reachable**
option, generate the new commit graph by walking commits starting at all refs. (Cannot be combined with
**--stdin-commits**
or
**--stdin-packs**.)

With the
**--append**
option, include all commits that are present in the existing commit-graph file.

_read_
Read the commit-graph file and output basic details about it. Used for debugging purposes.

_verify_
Read the commit-graph file and verify its contents against the object database. Used to check for corrupted data.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Write a commit-graph file for the packed commits in your local
  **.git**
  directory.

.if n \{.RS 4
.\}
    $ git commit-graph write
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Write a commit-graph file, extending the current commit-graph file using commits in
  **&lt;pack-index&gt;**.

.if n \{.RS 4
.\}
    $ echo <pack-index> | git commit-graph write --stdin-packs
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Write a commit-graph file containing all reachable commits.

.if n \{.RS 4
.\}
    $ git show-ref -s | git commit-graph write --stdin-commits
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Write a commit-graph file containing all commits in the current commit-graph file along with those reachable from
  **HEAD**.

.if n \{.RS 4
.\}
    $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Read basic information from the commit-graph file.

.if n \{.RS 4
.\}
    $ git commit-graph read
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
