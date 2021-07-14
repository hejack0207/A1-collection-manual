# git\-http\-fetch(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-http-fetch - Download from a remote Git repository via HTTP

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git http-fetch [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
<synopsis>


```

<a name="description"></a>

# Description


Downloads a remote Git repository via HTTP.

This command always gets all objects. Historically, there were three options **-a**, **-c** and **-t** for choosing which objects to download. They are now silently ignored.

<a name="options"></a>

# Options


commit-id
Either the hash or the filename under [URL]/refs/ to pull.

-a, -c, -t
These options are ignored for historical reasons.

-v
Report what is downloaded.

-w &lt;filename&gt;
Writes the commit-id into the filename under $GIT_DIR/refs/&lt;filename&gt; on the local end after the transfer is complete.

--stdin
Instead of a commit id on the command line (which is not expected in this case),
_git http-fetch_
expects lines on stdin in the format

.if n \{.RS 4
.\}
    <commit-id>['et'<filename-as-in--w>]
.if n \{.RE
.\}

--recover
Verify that everything reachable from target is fetched. Used after an earlier fetch is interrupted.

<a name="git"></a>

# Git


Part of the **git**(1) suite
