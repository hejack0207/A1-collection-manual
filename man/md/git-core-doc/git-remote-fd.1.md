# git\-remote\-fd(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-remote-fd - Reflect smart transport stream back to caller

<a name="synopsis"></a>

# Synopsis

```

 "fd::<infd>[,<outfd>][/<anything>]" (as URL)
```

<a name="description"></a>

# Description


This helper uses specified file descriptors to connect to a remote Git server. This is not meant for end users but for programs and scripts calling git fetch, push or archive.

If only &lt;infd&gt; is given, it is assumed to be a bidirectional socket connected to remote Git server (git-upload-pack, git-receive-pack or git-upload-archive). If both &lt;infd&gt; and &lt;outfd&gt; are given, they are assumed to be pipes connected to a remote Git server (&lt;infd&gt; being the inbound pipe and &lt;outfd&gt; being the outbound pipe.

It is assumed that any handshaking procedures have already been completed (such as sending service request for git://) before this helper is started.

&lt;anything&gt; can be any string. It is ignored. It is meant for providing information to user in the URL in case that URL is displayed in some context.

<a name="environment-variables"></a>

# Environment Variables


GIT_TRANSLOOP_DEBUG
If set, prints debugging information about various reads/writes.

<a name="examples"></a>

# Examples


**git fetch fd::17 master**
Fetch master, using file descriptor #17 to communicate with git-upload-pack.

**git fetch fd::17/foo master**
Same as above.

**git push fd::7,8 master (as URL)**
Push master, using file descriptor #7 to read data from git-receive-pack and file descriptor #8 to write data to same service.

**git push fd::7,8/bar master**
Same as above.

<a name="see-also"></a>

# See Also


**gitremote-helpers**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
