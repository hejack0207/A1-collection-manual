# git\-sh\-i18n(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-sh-i18n - Git's i18n setup code for shell scripts

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    . "$(git --exec-path)/git-sh-i18n"
<synopsis>


```

<a name="description"></a>

# Description


This is not a command the end user would want to run. Ever. This documentation is meant for people who are studying the Porcelain-ish scripts and/or are writing new ones.

The 'git sh-i18n scriptlet is designed to be sourced (using **.**) by Git’s porcelain programs implemented in shell script. It provides wrappers for the GNU **gettext** and **eval\_gettext** functions accessible through the **gettext.sh** script, and provides pass-through fallbacks on systems without GNU gettext.

<a name="functions"></a>

# Functions


gettext
Currently a dummy fall-through function implemented as a wrapper around
**printf(1)**. Will be replaced by a real gettext implementation in a later version.

eval_gettext
Currently a dummy fall-through function implemented as a wrapper around
**printf(1)**
with variables expanded by the
**git-sh-i18n--envsubst**(1)
helper. Will be replaced by a real gettext implementation in a later version.

<a name="git"></a>

# Git


Part of the **git**(1) suite
