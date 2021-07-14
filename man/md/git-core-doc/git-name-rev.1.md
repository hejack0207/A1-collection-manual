# git\-name\-rev(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-name-rev - Find symbolic names for given revs

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git name-rev [--tags] [--refs=<pattern>]
                   ( --all | --stdin | <commit-ish>... )
<synopsis>


```

<a name="description"></a>

# Description


Finds symbolic names suitable for human digestion for revisions given in any format parsable by _git rev-parse_.

<a name="options"></a>

# Options


--tags
Do not use branch names, but only tags to name the commits

--refs=&lt;pattern&gt;
Only use refs whose names match a given shell pattern. The pattern can be one of branch name, tag name or fully qualified ref name. If given multiple times, use refs whose names match any of the given shell patterns. Use
**--no-refs**
to clear any previous ref patterns given.

--exclude=&lt;pattern&gt;
Do not use any ref whose name matches a given shell pattern. The pattern can be one of branch name, tag name or fully qualified ref name. If given multiple times, a ref will be excluded when it matches any of the given patterns. When used together with --refs, a ref will be used as a match only when it matches at least one --refs pattern and does not match any --exclude patterns. Use
**--no-exclude**
to clear the list of exclude patterns.

--all
List all commits reachable from all refs

--stdin
Transform stdin by substituting all the 40-character SHA-1 hexes (say $hex) with "$hex ($rev_name)". When used with --name-only, substitute with "$rev_name", omitting $hex altogether. Intended for the scripter’s use.

--name-only
Instead of printing both the SHA-1 and the name, print only the name. If given with --tags the usual tag prefix of "tags/" is also omitted from the name, matching the output of
**git-describe**
more closely.

--no-undefined
Die with error code != 0 when a reference is undefined, instead of printing
**undefined**.

--always
Show uniquely abbreviated commit object as fallback.

<a name="examples"></a>

# Examples


Given a commit, find out where it is relative to the local refs. Say somebody wrote you about that fantastic commit 33db5f4d9027a10e477ccf054b2c1ab94f74c85a. Of course, you look into the commit, but that only tells you what happened, but not the context.

Enter _git name-rev_:

.if n \{.RS 4
.\}
    % git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
    33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99~940
.if n \{.RE
.\}


Now you are wiser, because you know that it happened 940 revisions before v0.99.

Another nice thing you can do is:

.if n \{.RS 4
.\}
    % git log | git name-rev --stdin
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
