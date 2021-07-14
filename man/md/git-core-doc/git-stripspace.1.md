# git\-stripspace(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-stripspace - Remove unnecessary whitespace

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git stripspace [-s | --strip-comments]
    git stripspace [-c | --comment-lines]
<synopsis>


```

<a name="description"></a>

# Description


Read text, such as commit messages, notes, tags and branch descriptions, from the standard input and clean it in the manner used by Git.

With no arguments, this will:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  remove trailing whitespace from all lines

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  collapse multiple consecutive empty lines into one empty line

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  remove empty lines from the beginning and end of the input

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  add a missing
  _\en_
  to the last line if necessary.

In the case where the input consists entirely of whitespace characters, no output will be produced.

**NOTE**: This is intended for cleaning metadata, prefer the **--whitespace=fix** mode of **git-apply**(1) for correcting whitespace of patches or files in the repository.

<a name="options"></a>

# Options


-s, --strip-comments
Skip and remove all lines starting with comment character (default
_#_).

-c, --comment-lines
Prepend comment character and blank to each line. Lines will automatically be terminated with a newline. On empty lines, only the comment character will be prepended.

<a name="examples"></a>

# Examples


Given the following noisy input with _$_ indicating the end of a line:

.if n \{.RS 4
.\}
    |A brief introduction   $
    |   $
    |$
    |A new paragraph$
    |# with a commented-out line    $
    |explaining lots of stuff.$
    |$
    |# An old paragraph, also commented-out. $
    |      $
    |The end.$
    |  $
.if n \{.RE
.\}


Use _git stripspace_ with no arguments to obtain:

.if n \{.RS 4
.\}
    |A brief introduction$
    |$
    |A new paragraph$
    |# with a commented-out line$
    |explaining lots of stuff.$
    |$
    |# An old paragraph, also commented-out.$
    |$
    |The end.$
.if n \{.RE
.\}


Use _git stripspace --strip-comments_ to obtain:

.if n \{.RS 4
.\}
    |A brief introduction$
    |$
    |A new paragraph$
    |explaining lots of stuff.$
    |$
    |The end.$
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
