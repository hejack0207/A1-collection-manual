# git\-sh\-i18n\-\-env(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-sh-i18n--envsubst - Git's own envsubst(1) for i18n fallbacks

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    eval_gettext () {
            printf "%s" "$1" | (
                    export PATH $(git sh-i18n--envsubst --variables "$1");
                    git sh-i18n--envsubst "$1"
            )
    }
<synopsis>


```

<a name="description"></a>

# Description


This is not a command the end user would want to run. Ever. This documentation is meant for people who are studying the plumbing scripts and/or are writing new ones.

_git sh-i18n--envsubst_ is Git’s stripped-down copy of the GNU **envsubst(1)** program that comes with the GNU gettext package. It’s used internally by **git-sh-i18n**(1) to interpolate the variables passed to the **eval\_gettext** function.

No promises are made about the interface, or that this program won’t disappear without warning in the next version of Git. Don’t use it.

<a name="git"></a>

# Git


Part of the **git**(1) suite
