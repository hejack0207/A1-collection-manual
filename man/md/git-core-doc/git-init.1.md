# git\-init(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-init - Create an empty Git repository or reinitialize an existing one

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git init [-q | --quiet] [--bare] [--template=<template_directory>]
              [--separate-git-dir <git dir>]
              [--shared[=<permissions>]] [directory]
<synopsis>


```

<a name="description"></a>

# Description


This command creates an empty Git repository - basically a **.git** directory with subdirectories for **objects**, **refs/heads**, **refs/tags**, and template files. An initial **HEAD** file that references the HEAD of the master branch is also created.

If the **$GIT\_DIR** environment variable is set then it specifies a path to use instead of **./.git** for the base of the repository.

If the object storage directory is specified via the **$GIT\_OBJECT\_DIRECTORY** environment variable then the sha1 directories are created underneath - otherwise the default **$GIT\_DIR/objects** directory is used.

Running _git init_ in an existing repository is safe. It will not overwrite things that are already there. The primary reason for rerunning _git init_ is to pick up newly added templates (or to move the repository to another place if --separate-git-dir is given).

<a name="options"></a>

# Options


-q, --quiet
Only print error and warning messages; all other output will be suppressed.

--bare
Create a bare repository. If
**GIT\_DIR**
environment is not set, it is set to the current working directory.

--template=&lt;template_directory&gt;
Specify the directory from which templates will be used. (See the "TEMPLATE DIRECTORY" section below.)

--separate-git-dir=&lt;git dir&gt;
Instead of initializing the repository as a directory to either
**$GIT\_DIR**
or
**./.git/**, create a text file there containing the path to the actual repository. This file acts as filesystem-agnostic Git symbolic link to the repository.

If this is reinitialization, the repository will be moved to the specified path.

--shared[=(false|true|umask|group|all|world|everybody|0xxx)]
Specify that the Git repository is to be shared amongst several users. This allows users belonging to the same group to push into that repository. When specified, the config variable "core.sharedRepository" is set so that files and directories under
**$GIT\_DIR**
are created with the requested permissions. When not specified, Git will use permissions reported by umask(2).

The option can have the following values, defaulting to
_group_
if no value is given:

_umask_ (or _false_)
Use permissions reported by umask(2). The default, when
**--shared**
is not specified.

_group_ (or _true_)
Make the repository group-writable, (and g+sx, since the git group may be not the primary group of all users). This is used to loosen the permissions of an otherwise safe umask(2) value. Note that the umask still applies to the other permission bits (e.g. if umask is
_0022_, using
_group_
will not remove read privileges from other (non-group) users). See
_0xxx_
for how to exactly specify the repository permissions.

_all_ (or _world_ or _everybody_)
Same as
_group_, but make the repository readable by all users.

_0xxx_
_0xxx_
is an octal number and each file will have mode
_0xxx_.
_0xxx_
will override users' umask(2) value (and not only loosen permissions as
_group_
and
_all_
does).
_0640_
will create a repository which is group-readable, but not group-writable or accessible to others.
_0660_
will create a repo that is readable and writable to the current user and group, but inaccessible to others.

By default, the configuration flag **receive.denyNonFastForwards** is enabled in shared repositories, so that you cannot force a non fast-forwarding push into it.

If you provide a _directory_, the command is run inside it. If this directory does not exist, it will be created.

<a name="template-directory"></a>

# Template Directory


Files and directories in the template directory whose name do not start with a dot will be copied to the **$GIT\_DIR** after it is created.

The template directory will be one of the following (in order):

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the argument given with the
  **--template**
  option;

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the contents of the
  **$GIT\_TEMPLATE\_DIR**
  environment variable;

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the
  **init.templateDir**
  configuration variable; or

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the default template directory:
  **/usr/share/git-core/templates**.

The default template directory includes some directory structure, suggested "exclude patterns" (see **gitignore**(5)), and sample hook files.

The sample hooks are all disabled by default. To enable one of the sample hooks rename it by removing its **.sample** suffix.

See **githooks**(5) for more general info on hook execution.

<a name="examples"></a>

# Examples


Start a new Git repository for an existing code base

.if n \{.RS 4
.\}
    $ cd /path/to/my/codebase
    $ git init      (1)
    $ git add .     (2)
    $ git commit    (3)
.if n \{.RE
.\}

**1. **Create a /path/to/my/codebase/.git directory.  
**2. **Add all existing files to the index.  
**3. **Record the pristine state as the first commit in the history.  

<a name="git"></a>

# Git


Part of the **git**(1) suite
