# git\-mergetool(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-mergetool - Run merge conflict resolution tools to resolve merge conflicts

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git mergetool [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
<synopsis>


```

<a name="description"></a>

# Description


Use **git mergetool** to run one of several merge utilities to resolve merge conflicts. It is typically run after _git merge_.

If one or more &lt;file&gt; parameters are given, the merge tool program will be run to resolve differences on each file (skipping those without conflicts). Specifying a directory will include all unresolved files in that path. If no &lt;file&gt; names are specified, _git mergetool_ will run the merge tool program on every file with merge conflicts.

<a name="options"></a>

# Options


-t &lt;tool&gt;, --tool=&lt;tool&gt;
Use the merge resolution program specified by &lt;tool&gt;. Valid values include emerge, gvimdiff, kdiff3, meld, vimdiff, and tortoisemerge. Run
**git mergetool --tool-help**
for the list of valid &lt;tool&gt; settings.

If a merge resolution program is not specified,
_git mergetool_
will use the configuration variable
**merge.tool**. If the configuration variable
**merge.tool**
is not set,
_git mergetool_
will pick a suitable default.

You can explicitly provide a full path to the tool by setting the configuration variable
**mergetool.&lt;tool&gt;.path**. For example, you can configure the absolute path to kdiff3 by setting
**mergetool.kdiff3.path**. Otherwise,
_git mergetool_
assumes the tool is available in PATH.

Instead of running one of the known merge tool programs,
_git mergetool_
can be customized to run an alternative program by specifying the command line to invoke in a configuration variable
**mergetool.&lt;tool&gt;.cmd**.

When
_git mergetool_
is invoked with this tool (either through the
**-t**
or
**--tool**
option or the
**merge.tool**
configuration variable) the configured command line will be invoked with
**$BASE**
set to the name of a temporary file containing the common base for the merge, if available;
**$LOCAL**
set to the name of a temporary file containing the contents of the file on the current branch;
**$REMOTE**
set to the name of a temporary file containing the contents of the file to be merged, and
**$MERGED**
set to the name of the file to which the merge tool should write the result of the merge resolution.

If the custom merge tool correctly indicates the success of a merge resolution with its exit code, then the configuration variable
**mergetool.&lt;tool&gt;.trustExitCode**
can be set to
**true**. Otherwise,
_git mergetool_
will prompt the user to indicate the success of the resolution after the custom tool has exited.

--tool-help
Print a list of merge tools that may be used with
**--tool**.

-y, --no-prompt
Don’t prompt before each invocation of the merge resolution program. This is the default if the merge resolution program is explicitly specified with the
**--tool**
option or with the
**merge.tool**
configuration variable.

--prompt
Prompt before each invocation of the merge resolution program to give the user a chance to skip the path.

-g, --gui
When
_git-mergetool_
is invoked with the
**-g**
or
**--gui**
option the default merge tool will be read from the configured
**merge.guitool**
variable instead of
**merge.tool**.

--no-gui
This overrides a previous
**-g**
or
**--gui**
setting and reads the default merge tool will be read from the configured
**merge.tool**
variable.

-O&lt;orderfile&gt;
Process files in the order specified in the &lt;orderfile&gt;, which has one shell glob pattern per line. This overrides the
**diff.orderFile**
configuration variable (see
**git-config**(1)). To cancel
**diff.orderFile**, use
**-O/dev/null**.

<a name="temporary-files"></a>

# Temporary Files


**git mergetool** creates ***.orig** backup files while resolving merges. These are safe to remove once a file has been merged and its **git mergetool** session has completed.

Setting the **mergetool.keepBackup** configuration variable to **false** causes **git mergetool** to automatically remove the backup as files are successfully merged.

<a name="git"></a>

# Git


Part of the **git**(1) suite
