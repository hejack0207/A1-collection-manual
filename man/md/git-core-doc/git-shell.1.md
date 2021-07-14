# git\-shell(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-shell - Restricted login shell for Git-only SSH access

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    chsh -s $(command -v git-shell) <user>
    git clone <user>@localhost:/path/to/repo.git
    ssh <user>@localhost
<synopsis>


```

<a name="description"></a>

# Description


This is a login shell for SSH accounts to provide restricted Git access. It permits execution only of server-side Git commands implementing the pull/push functionality, plus custom commands present in a subdirectory named **git-shell-commands** in the user’s home directory.

<a name="commands"></a>

# Commands


_git shell_ accepts the following commands after the **-c** option:

_git receive-pack &lt;argument&gt;_, _git upload-pack &lt;argument&gt;_, _git upload-archive &lt;argument&gt;_
Call the corresponding server-side command to support the client’s
_git push_,
_git fetch_, or
_git archive --remote_
request.

_cvs server_
Imitate a CVS server. See
**git-cvsserver**(1).

If a **~/git-shell-commands** directory is present, _git shell_ will also handle other, custom commands by running "**git-shell-commands/&lt;command&gt; &lt;arguments&gt;**" from the user’s home directory.

<a name="interactive-use"></a>

# Interactive Use


By default, the commands above can be executed only with the **-c** option; the shell is not interactive.

If a **~/git-shell-commands** directory is present, _git shell_ can also be run interactively (with no arguments). If a **help** command is present in the **git-shell-commands** directory, it is run to provide the user with an overview of allowed actions. Then a "git&gt; " prompt is presented at which one can enter any of the commands from the **git-shell-commands** directory, or **exit** to close the connection.

Generally this mode is used as an administrative interface to allow users to list repositories they have access to, create, delete, or rename repositories, or change repository descriptions and permissions.

If a **no-interactive-login** command exists, then it is run and the interactive shell is aborted.

<a name="examples"></a>

# Examples


To disable interactive logins, displaying a greeting instead:

.if n \{.RS 4
.\}
    $ chsh -s /usr/bin/git-shell
    $ mkdir $HOME/git-shell-commands
    $ cat >$HOME/git-shell-commands/no-interactive-login <<eEOF
    #!/bin/sh
    printf '%sen' "Hi $USER! You've successfully authenticated, but I do not"
    printf '%sen' "provide interactive shell access."
    exit 128
    EOF
    $ chmod +x $HOME/git-shell-commands/no-interactive-login
.if n \{.RE
.\}


To enable git-cvsserver access (which should generally have the **no-interactive-login** example above as a prerequisite, as creating the git-shell-commands directory allows interactive logins):

.if n \{.RS 4
.\}
    $ cat >$HOME/git-shell-commands/cvs <<eEOF
    if ! test $# = 1 && test "$1" = "server"
    then
            echo >&2 "git-cvsserver only handles e"servere""
            exit 1
    fi
    exec git cvsserver server
    EOF
    $ chmod +x $HOME/git-shell-commands/cvs
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


ssh(1), **git-daemon**(1), contrib/git-shell-commands/README

<a name="git"></a>

# Git


Part of the **git**(1) suite
