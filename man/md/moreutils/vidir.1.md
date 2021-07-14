# vidir(1)

moreutils, 2015-07-13

.if n .ad l
.nh

<a name="name"></a>

# Name

vidir - edit directory

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" vidir [--verbose] [directory|file|-] ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
vidir allows editing of the contents of a directory in a text editor. If no
directory is specified, the current directory is edited.

When editing a directory, each item in the directory will appear on its own
numbered line. These numbers are how vidir keeps track of what items are
changed. Delete lines to remove files from the directory, or
edit filenames to rename files. You can also switch pairs of numbers to
swap filenames.

Note that if -\*(R" is specified as the directory to edit, it reads a list of
filenames from stdin and displays those for editing. Alternatively, a list
of files can be specified on the command line.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -v, --verbose  
  .IX Item "-v, --verbose"
  Verbosely display the actions taken by the program.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

* vidir  
  .IX Item "vidir"
* vidir *.jpeg  
  .IX Item "vidir *.jpeg"
  Typical uses.
* find | vidir -  
  .IX Item "find | vidir -"
  Edit subdirectory contents too. To delete subdirectories,
  delete all their contents and the subdirectory itself in the editor.
* find -type f | vidir -  
  .IX Item "find -type f | vidir -"
  Edit all files under the current directory and subdirectories.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"

* \s-1EDITOR\s0  
  .IX Item "EDITOR"
  Editor to use.
* \s-1VISUAL\s0  
  .IX Item "VISUAL"
  Also supported to determine what editor to use.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright 2006 by Joey Hess &lt;[id@joeyh.name](mailto:id@joeyh.name)&gt;

Licensed under the \s-1GNU GPL.\s0
