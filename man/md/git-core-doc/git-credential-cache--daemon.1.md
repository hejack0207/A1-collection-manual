# git\-credential\-cac(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-credential-cache--daemon - Temporarily store user credentials in memory

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git credential-cache—daemon [--debug] <socket>
<synopsis>


```

<a name="description"></a>

# Description

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

You probably don’t want to invoke this command yourself; it is started automatically when you use **git-credential-cache**(1).


This command listens on the Unix domain socket specified by **&lt;socket&gt;** for **git-credential-cache** clients. Clients may store and retrieve credentials. Each credential is held for a timeout specified by the client; once no credentials are held, the daemon exits.

If the **--debug** option is specified, the daemon does not close its stderr stream, and may output extra diagnostics to it even after it has begun listening for clients.

<a name="git"></a>

# Git


Part of the **git**(1) suite
