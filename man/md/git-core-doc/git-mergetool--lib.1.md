# git\-mergetool\-\-li(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-mergetool--lib - Common Git merge tool shell scriptlets

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool--lib"
<synopsis>


```

<a name="description"></a>

# Description


This is not a command the end user would want to run. Ever. This documentation is meant for people who are studying the Porcelain-ish scripts and/or are writing new ones.

The _git-mergetool--lib_ scriptlet is designed to be sourced (using **.**) by other shell scripts to set up functions for working with Git merge tools.

Before sourcing _git-mergetool--lib_, your script must set **TOOL\_MODE** to define the operation mode for the functions listed below. _diff_ and _merge_ are valid values.

<a name="functions"></a>

# Functions


get_merge_tool
returns a merge tool.

get_merge_tool_cmd
returns the custom command for a merge tool.

get_merge_tool_path
returns the custom path for a merge tool.

run_merge_tool
launches a merge tool given the tool name and a true/false flag to indicate whether a merge base is present.
_$MERGED_,
_$LOCAL_,
_$REMOTE_, and
_$BASE_
must be defined for use by the merge tool.

<a name="git"></a>

# Git


Part of the **git**(1) suite
