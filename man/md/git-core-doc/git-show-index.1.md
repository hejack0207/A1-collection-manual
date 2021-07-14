# git\-show\-index(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-show-index - Show packed archive index

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git show-index
<synopsis>


```

<a name="description"></a>

# Description


Read the **.idx** file for a Git packfile (created with **git-pack-objects**(1) or **git-index-pack**(1)) from the standard input, and dump its contents. The output consists of one object per line, with each line containing two or three space-separated columns:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the first column is the offset in bytes of the object within the corresponding packfile

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the second column is the object id of the object

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  if the index version is 2 or higher, the third column contains the CRC32 of the object data

The objects are output in the order in which they are found in the index file, which should be (in a correctly constructed file) sorted by object id.

Note that you can get more information on a packfile by calling **git-verify-pack**(1). However, as this command considers only the index file itself, it’s both faster and more flexible.

<a name="git"></a>

# Git


Part of the **git**(1) suite
