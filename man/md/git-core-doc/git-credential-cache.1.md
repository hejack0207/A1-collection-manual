# git\-credential\-cac(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-credential-cache - Helper to temporarily store passwords in memory

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git config credential.helper 'cache [<options>]'
<synopsis>


```

<a name="description"></a>

# Description


This command caches credentials in memory for use by future Git programs. The stored credentials never touch the disk, and are forgotten after a configurable timeout. The cache is accessible over a Unix domain socket, restricted to the current user by filesystem permissions.

You probably don’t want to invoke this command directly; it is meant to be used as a credential helper by other parts of Git. See **gitcredentials**(7) or **EXAMPLES** below.

<a name="options"></a>

# Options


--timeout &lt;seconds&gt;
Number of seconds to cache credentials (default: 900).

--socket &lt;path&gt;
Use
**&lt;path&gt;**
to contact a running cache daemon (or start a new cache daemon if one is not started). Defaults to
**$XDG\_CACHE\_HOME/git/credential/socket**
unless
**~/.git-credential-cache/**
exists in which case
**~/.git-credential-cache/socket**
is used instead. If your home directory is on a network-mounted filesystem, you may need to change this to a local filesystem. You must specify an absolute path.

<a name="controlling-the-daemon"></a>

# Controlling the Daemon


If you would like the daemon to exit early, forgetting all cached credentials before their timeout, you can issue an **exit** action:

.if n \{.RS 4
.\}
    git credential-cache exit
.if n \{.RE
.\}


<a name="examples"></a>

# Examples


The point of this helper is to reduce the number of times you must type your username or password. For example:

.if n \{.RS 4
.\}
    $ git config credential.helper cache
    $ git push http://example.com/repo.git
    Username: <type your username>
    Password: <type your password>
    
    [work for 5 more minutes]
    $ git push http://example.com/repo.git
    [your credentials are used automatically]
.if n \{.RE
.\}


You can provide options via the credential.helper configuration variable (this example drops the cache time to 5 minutes):

.if n \{.RS 4
.\}
    $ git config credential.helper 'cache --timeout=300'
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
