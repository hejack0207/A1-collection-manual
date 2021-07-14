# git\-replace(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-replace - Create, list, delete refs to replace objects

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git replace [-f] <object> <replacement>
    git replace [-f] --edit <object>
    git replace [-f] --graft <commit> [<parent>...]
    git replace [-f] --convert-graft-file
    git replace -d <object>...
    git replace [--format=<format>] [-l [<pattern>]]
<synopsis>


```

<a name="description"></a>

# Description


Adds a _replace_ reference in **refs/replace/** namespace.

The name of the _replace_ reference is the SHA-1 of the object that is replaced. The content of the _replace_ reference is the SHA-1 of the replacement object.

The replaced object and the replacement object must be of the same type. This restriction can be bypassed using **-f**.

Unless **-f** is given, the _replace_ reference must not yet exist.

There is no other restriction on the replaced and replacement objects. Merge commits can be replaced by non-merge commits and vice versa.

Replacement references will be used by default by all Git commands except those doing reachability traversal (prune, pack transfer and fsck).

It is possible to disable use of replacement references for any command using the **--no-replace-objects** option just after _git_.

For example if commit _foo_ has been replaced by commit _bar_:

.if n \{.RS 4
.\}
    $ git --no-replace-objects cat-file commit foo
.if n \{.RE
.\}


shows information about commit _foo_, while:

.if n \{.RS 4
.\}
    $ git cat-file commit foo
.if n \{.RE
.\}


shows information about commit _bar_.

The **GIT\_NO\_REPLACE\_OBJECTS** environment variable can be set to achieve the same effect as the **--no-replace-objects** option.

<a name="options"></a>

# Options


-f, --force
If an existing replace ref for the same object exists, it will be overwritten (instead of failing).

-d, --delete
Delete existing replace refs for the given objects.

--edit &lt;object&gt;
Edit an object’s content interactively. The existing content for &lt;object&gt; is pretty-printed into a temporary file, an editor is launched on the file, and the result is parsed to create a new object of the same type as &lt;object&gt;. A replacement ref is then created to replace &lt;object&gt; with the newly created object. See
**git-var**(1)
for details about how the editor will be chosen.

--raw
When editing, provide the raw object contents rather than pretty-printed ones. Currently this only affects trees, which will be shown in their binary form. This is harder to work with, but can help when repairing a tree that is so corrupted it cannot be pretty-printed. Note that you may need to configure your editor to cleanly read and write binary data.

--graft &lt;commit&gt; [&lt;parent&gt;...]
Create a graft commit. A new commit is created with the same content as &lt;commit&gt; except that its parents will be [&lt;parent&gt;...] instead of &lt;commit&gt;'s parents. A replacement ref is then created to replace &lt;commit&gt; with the newly created commit. Use
**--convert-graft-file**
to convert a
**$GIT\_DIR/info/grafts**
file and use replace refs instead.

--convert-graft-file
Creates graft commits for all entries in
**$GIT\_DIR/info/grafts**
and deletes that file upon success. The purpose is to help users with transitioning off of the now-deprecated graft file.

-l &lt;pattern&gt;, --list &lt;pattern&gt;
List replace refs for objects that match the given pattern (or all if no pattern is given). Typing "git replace" without arguments, also lists all replace refs.

--format=&lt;format&gt;
When listing, use the specified &lt;format&gt;, which can be one of
_short_,
_medium_
and
_long_. When omitted, the format defaults to
_short_.

<a name="formats"></a>

# Formats


The following format are available:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _short_: &lt;replaced sha1&gt;

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _medium_: &lt;replaced sha1&gt; \(-&gt; &lt;replacement sha1&gt;

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _long_: &lt;replaced sha1&gt; (&lt;replaced type&gt;) \(-&gt; &lt;replacement sha1&gt; (&lt;replacement type&gt;)

<a name="creating-replacement-objects"></a>

# Creating Replacement Objects


**git-filter-branch**(1), **git-hash-object**(1) and **git-rebase**(1), among other git commands, can be used to create replacement objects from existing objects. The **--edit** option can also be used with _git replace_ to create a replacement object by editing an existing object.

If you want to replace many blobs, trees or commits that are part of a string of commits, you may just want to create a replacement string of commits and then only replace the commit at the tip of the target string of commits with the commit at the tip of the replacement string of commits.

<a name="bugs"></a>

# Bugs


Comparing blobs or trees that have been replaced with those that replace them will not work properly. And using **git reset --hard** to go back to a replaced commit will move the branch to the replacement commit instead of the replaced commit.

There may be other problems when using _git rev-list_ related to pending objects.

<a name="see-also"></a>

# See Also


**git-hash-object**(1) **git-filter-branch**(1) **git-rebase**(1) **git-tag**(1) **git-branch**(1) **git-commit**(1) **git-var**(1) **git**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
