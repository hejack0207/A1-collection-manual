# git\-multi\-pack\-in(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-multi-pack-index - Write and verify multi-pack-indexes

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git multi-pack-index [--object-dir=<dir>] <verb>
<synopsis>


```

<a name="description"></a>

# Description


Write or verify a multi-pack-index (MIDX) file.

<a name="options"></a>

# Options


--object-dir=&lt;dir&gt;
Use given directory for the location of Git objects. We check
**&lt;dir&gt;/packs/multi-pack-index**
for the current MIDX file, and
**&lt;dir&gt;/packs**
for the pack-files to index.

write
When given as the verb, write a new MIDX file to
**&lt;dir&gt;/packs/multi-pack-index**.

verify
When given as the verb, verify the contents of the MIDX file at
**&lt;dir&gt;/packs/multi-pack-index**.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Write a MIDX file for the packfiles in the current .git folder.

.if n \{.RS 4
.\}
    $ git multi-pack-index write
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Write a MIDX file for the packfiles in an alternate object store.

.if n \{.RS 4
.\}
    $ git multi-pack-index --object-dir <alt> write
.if n \{.RE
.\}


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Verify the MIDX file for the packfiles in the current .git folder.

.if n \{.RS 4
.\}
    $ git multi-pack-index verify
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


See \m[blue]**The Multi-Pack-Index Design Document**\m[]\s-2\u[1]\d\s+2 and \m[blue]**The Multi-Pack-Index Format**\m[]\s-2\u[2]\d\s+2 for more information on the multi-pack-index feature.

<a name="git"></a>

# Git


Part of the **git**(1) suite

<a name="notes"></a>

# Notes


*  1.  
  The Multi-Pack-Index Design Document
      file:///usr/share/doc/git/technical/multi-pack-index.html
*  2.  
  The Multi-Pack-Index Format
      file:///usr/share/doc/git/technical/pack-format.html
