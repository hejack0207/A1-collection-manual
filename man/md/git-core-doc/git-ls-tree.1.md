# git\-ls\-tree(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-ls-tree - List the contents of a tree object

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git ls-tree [-d] [-r] [-t] [-l] [-z]
                [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
                <tree-ish> [<path>...]
<synopsis>


```

<a name="description"></a>

# Description


Lists the contents of a given tree object, like what "/bin/ls -a" does in the current working directory. Note that:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the behaviour is slightly different from that of "/bin/ls" in that the
  _&lt;path&gt;_
  denotes just a list of patterns to match, e.g. so specifying directory name (without
  **-r**) will behave differently, and order of the arguments does not matter.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the behaviour is similar to that of "/bin/ls" in that the
  _&lt;path&gt;_
  is taken as relative to the current working directory. E.g. when you are in a directory
  _sub_
  that has a directory
  _dir_, you can run
  _git ls-tree -r HEAD dir_
  to list the contents of the tree (that is
  _sub/dir_
  in
  **HEAD**). You don’t want to give a tree that is not at the root level (e.g.
  **git ls-tree -r HEAD:sub dir**) in this case, as that would result in asking for
  _sub/sub/dir_
  in the
  **HEAD**
  commit. However, the current working directory can be ignored by passing --full-tree option.

<a name="options"></a>

# Options


&lt;tree-ish&gt;
Id of a tree-ish.

-d
Show only the named tree entry itself, not its children.

-r
Recurse into sub-trees.

-t
Show tree entries even when going to recurse them. Has no effect if
**-r**
was not passed.
**-d**
implies
**-t**.

-l, --long
Show object size of blob (file) entries.

-z
\e0 line termination on output and do not quote filenames. See OUTPUT FORMAT below for more information.

--name-only, --name-status
List only filenames (instead of the "long" output), one per line.

--abbrev[=&lt;n&gt;]
Instead of showing the full 40-byte hexadecimal object lines, show only a partial prefix. Non default number of digits can be specified with --abbrev=&lt;n&gt;.

--full-name
Instead of showing the path names relative to the current working directory, show the full path names.

--full-tree
Do not limit the listing to the current working directory. Implies --full-name.

[&lt;path&gt;...]
When paths are given, show them (note that this isn’t really raw pathnames, but rather a list of patterns to match). Otherwise implicitly uses the root level of the tree as the sole path argument.

<a name="output-format"></a>

# Output Format


.if n \{.RS 4
.\}
    <mode> SP <type> SP <object> TAB <file>
.if n \{.RE
.\}

This output format is compatible with what **--index-info --stdin** of _git update-index_ expects.

When the **-l** option is used, format changes to

.if n \{.RS 4
.\}
    <mode> SP <type> SP <object> SP <object size> TAB <file>
.if n \{.RE
.\}

Object size identified by &lt;object&gt; is given in bytes, and right-justified with minimum width of 7 characters. Object size is given only for blobs (file) entries; for other entries **-** character is used in place of size.

Without the **-z** option, pathnames with "unusual" characters are quoted as explained for the configuration variable **core.quotePath** (see **git-config**(1)). Using **-z** the filename is output verbatim and the line is terminated by a NUL byte.

<a name="git"></a>

# Git


Part of the **git**(1) suite
