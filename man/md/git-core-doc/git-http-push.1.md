# git\-http\-push(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-http-push - Push objects over HTTP/DAV to another repository

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git http-push [--all] [--dry-run] [--force] [--verbose] <url> <ref> [<ref>...]
<synopsis>


```

<a name="description"></a>

# Description


Sends missing objects to remote repository, and updates the remote branch.

**NOTE**: This command is temporarily disabled if your libcurl is older than 7.16, as the combination has been reported not to work and sometimes corrupts repository.

<a name="options"></a>

# Options


--all
Do not assume that the remote repository is complete in its current state, and verify all objects in the entire local ref’s history exist in the remote repository.

--force
Usually, the command refuses to update a remote ref that is not an ancestor of the local ref used to overwrite it. This flag disables the check. What this means is that the remote repository can lose commits; use it with care.

--dry-run
Do everything except actually send the updates.

--verbose
Report the list of objects being walked locally and the list of objects successfully sent to the remote repository.

-d, -D
Remove &lt;ref&gt; from remote repository. The specified branch cannot be the remote HEAD. If -d is specified the following other conditions must also be met:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Remote HEAD must resolve to an object that exists locally

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Specified branch resolves to an object that exists locally

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Specified branch is an ancestor of the remote HEAD

&lt;ref&gt;...
The remote refs to update.

<a name="specifying-the-refs"></a>

# Specifying the Refs


A _&lt;ref&gt;_ specification can be either a single pattern, or a pair of such patterns separated by a colon ":" (this means that a ref name cannot have a colon in it). A single pattern _&lt;name&gt;_ is just a shorthand for _&lt;name&gt;:&lt;name&gt;_.

Each pattern pair consists of the source side (before the colon) and the destination side (after the colon). The ref to be pushed is determined by finding a match that matches the source side, and where it is pushed is determined by using the destination side.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  It is an error if &lt;src&gt; does not match exactly one of the local refs.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If &lt;dst&gt; does not match any remote ref, either

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  it has to start with "refs/"; &lt;dst&gt; is used as the destination literally in this case.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  &lt;src&gt; == &lt;dst&gt; and the ref that matched the &lt;src&gt; must not exist in the set of remote refs; the ref matched &lt;src&gt; locally is used as the name of the destination.

Without ‘--force\`, the &lt;src&gt; ref is stored at the remote only if &lt;dst&gt; does not exist, or &lt;dst&gt; is a proper subset (i.e. an ancestor) of &lt;src&gt;. This check, known as "fast-forward check", is performed in order to avoid accidentally overwriting the remote ref and lose other peoples’ commits from there.

With **--force**, the fast-forward check is disabled for all refs.

Optionally, a &lt;ref&gt; parameter can be prefixed with a plus _+_ sign to disable the fast-forward check only on that ref.

<a name="git"></a>

# Git


Part of the **git**(1) suite
