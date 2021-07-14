# git\-credential\-sto(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-credential-store - Helper to store credentials on disk

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git config credential.helper 'store [<options>]'
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

Using this helper will store your passwords unencrypted on disk, protected only by filesystem permissions. If this is not an acceptable security tradeoff, try **git-credential-cache**(1), or find a helper that integrates with secure storage provided by your operating system.


This command stores credentials indefinitely on disk for use by future Git programs.

You probably don’t want to invoke this command directly; it is meant to be used as a credential helper by other parts of git. See **gitcredentials**(7) or **EXAMPLES** below.

<a name="options"></a>

# Options


--file=&lt;path&gt;
Use
**&lt;path&gt;**
to lookup and store credentials. The file will have its filesystem permissions set to prevent other users on the system from reading it, but will not be encrypted or otherwise protected. If not specified, credentials will be searched for from
**~/.git-credentials**
and
**$XDG\_CONFIG\_HOME/git/credentials**, and credentials will be written to
**~/.git-credentials**
if it exists, or
**$XDG\_CONFIG\_HOME/git/credentials**
if it exists and the former does not. See also
the section called “FILES”.

<a name="files"></a>

# Files


If not set explicitly with **--file**, there are two files where git-credential-store will search for credentials in order of precedence:

~/.git-credentials
User-specific credentials file.

$XDG_CONFIG_HOME/git/credentials
Second user-specific credentials file. If
_$XDG\_CONFIG\_HOME_
is not set or empty,
**$HOME/.config/git/credentials**
will be used. Any credentials stored in this file will not be used if
**~/.git-credentials**
has a matching credential as well. It is a good idea not to create this file if you sometimes use older versions of Git that do not support it.

For credential lookups, the files are read in the order given above, with the first matching credential found taking precedence over credentials found in files further down the list.

Credential storage will by default write to the first existing file in the list. If none of these files exist, **~/.git-credentials** will be created and written to.

When erasing credentials, matching credentials will be erased from all files.

<a name="examples"></a>

# Examples


The point of this helper is to reduce the number of times you must type your username or password. For example:

.if n \{.RS 4
.\}
    $ git config credential.helper store
    $ git push http://example.com/repo.git
    Username: <type your username>
    Password: <type your password>
    
    [several days later]
    $ git push http://example.com/repo.git
    [your credentials are used automatically]
.if n \{.RE
.\}


<a name="storage-format"></a>

# Storage Format


The **.git-credentials** file is stored in plaintext. Each credential is stored on its own line as a URL like:

.if n \{.RS 4
.\}
    https://user:pass@example.com
.if n \{.RE
.\}


When Git needs authentication for a particular URL context, credential-store will consider that context a pattern to match against each entry in the credentials file. If the protocol, hostname, and username (if we already have one) match, then the password is returned to Git. See the discussion of configuration in **gitcredentials**(7) for more information.

<a name="git"></a>

# Git


Part of the **git**(1) suite
