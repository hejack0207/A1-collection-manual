# git\-mktag(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-mktag - Creates a tag object

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git mktag
<synopsis>


```

<a name="description"></a>

# Description


Reads a tag contents on standard input and creates a tag object that can also be used to sign other objects.

The output is the new tag’s &lt;object&gt; identifier.

<a name="tag-format"></a>

# Tag Format


A tag signature file, to be fed to this command’s standard input, has a very simple fixed format: four lines of

.if n \{.RS 4
.\}
    object <sha1>
    type <typename>
    tag <tagname>
    tagger <tagger>
.if n \{.RE
.\}

followed by some _optional_ free-form message (some tags created by older Git may not have **tagger** line). The message, when exists, is separated by a blank line from the header. The message part may contain a signature that Git itself doesn’t care about, but that can be verified with gpg.

<a name="git"></a>

# Git


Part of the **git**(1) suite
