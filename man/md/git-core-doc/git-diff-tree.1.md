# git\-diff\-tree(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-diff-tree - Compares the content and mode of blobs found via two tree objects

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git diff-tree [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
                  [-t] [-r] [-c | --cc] [--root] [<common diff options>]
                  <tree-ish> [<tree-ish>] [<path>...]
<synopsis>


```

<a name="description"></a>

# Description


Compares the content and mode of the blobs found via two tree objects.

If there is only one &lt;tree-ish&gt; given, the commit is compared with its parents (see --stdin below).

Note that _git diff-tree_ can use the tree encapsulated in a commit object.

<a name="options"></a>

# Options


-p, -u, --patch
Generate patch (see section on generating patches).

-s, --no-patch
Suppress diff output. Useful for commands like
**git show**
that show the patch by default, or to cancel the effect of
**--patch**.

-U&lt;n&gt;, --unified=&lt;n&gt;
Generate diffs with &lt;n&gt; lines of context instead of the usual three. Implies
**-p**.

--raw
Generate the diff in raw format. This is the default.

--patch-with-raw
Synonym for
**-p --raw**.

--indent-heuristic
Enable the heuristic that shifts diff hunk boundaries to make patches easier to read. This is the default.

--no-indent-heuristic
Disable the indent heuristic.

--minimal
Spend extra time to make sure the smallest possible diff is produced.

--patience
Generate a diff using the "patience diff" algorithm.

--histogram
Generate a diff using the "histogram diff" algorithm.

--anchored=&lt;text&gt;
Generate a diff using the "anchored diff" algorithm.

This option may be specified more than once.

If a line exists in both the source and destination, exists only once, and starts with this text, this algorithm attempts to prevent it from appearing as a deletion or addition in the output. It uses the "patience diff" algorithm internally.

--diff-algorithm={patience|minimal|histogram|myers}
Choose a diff algorithm. The variants are as follows:

**default**, **myers**
The basic greedy diff algorithm. Currently, this is the default.

**minimal**
Spend extra time to make sure the smallest possible diff is produced.

**patience**
Use "patience diff" algorithm when generating patches.

**histogram**
This algorithm extends the patience algorithm to "support low-occurrence common elements".

For instance, if you configured the
**diff.algorithm**
variable to a non-default value and want to use the default one, then you have to use
**--diff-algorithm=default**
option.

--stat[=&lt;width&gt;[,&lt;name-width&gt;[,&lt;count&gt;]]]
Generate a diffstat. By default, as much space as necessary will be used for the filename part, and the rest for the graph part. Maximum width defaults to terminal width, or 80 columns if not connected to a terminal, and can be overridden by
**&lt;width&gt;**. The width of the filename part can be limited by giving another width
**&lt;name-width&gt;**
after a comma. The width of the graph part can be limited by using
**--stat-graph-width=&lt;width&gt;**
(affects all commands generating a stat graph) or by setting
**diff.statGraphWidth=&lt;width&gt;**
(does not affect
**git format-patch**). By giving a third parameter
**&lt;count&gt;**, you can limit the output to the first
**&lt;count&gt;**
lines, followed by
**...**
if there are more.

These parameters can also be set individually with
**--stat-width=&lt;width&gt;**,
**--stat-name-width=&lt;name-width&gt;**
and
**--stat-count=&lt;count&gt;**.

--compact-summary
Output a condensed summary of extended header information such as file creations or deletions ("new" or "gone", optionally "+l" if it’s a symlink) and mode changes ("+x" or "-x" for adding or removing executable bit respectively) in diffstat. The information is put between the filename part and the graph part. Implies
**--stat**.

--numstat
Similar to
**--stat**, but shows number of added and deleted lines in decimal notation and pathname without abbreviation, to make it more machine friendly. For binary files, outputs two
**-**
instead of saying
**0 0**.

--shortstat
Output only the last line of the
**--stat**
format containing total number of modified files, as well as number of added and deleted lines.

--dirstat[=&lt;param1,param2,...&gt;]
Output the distribution of relative amount of changes for each sub-directory. The behavior of
**--dirstat**
can be customized by passing it a comma separated list of parameters. The defaults are controlled by the
**diff.dirstat**
configuration variable (see
**git-config**(1)). The following parameters are available:

**changes**
Compute the dirstat numbers by counting the lines that have been removed from the source, or added to the destination. This ignores the amount of pure code movements within a file. In other words, rearranging lines in a file is not counted as much as other changes. This is the default behavior when no parameter is given.

**lines**
Compute the dirstat numbers by doing the regular line-based diff analysis, and summing the removed/added line counts. (For binary files, count 64-byte chunks instead, since binary files have no natural concept of lines). This is a more expensive
**--dirstat**
behavior than the
**changes**
behavior, but it does count rearranged lines within a file as much as other changes. The resulting output is consistent with what you get from the other
**--*stat**
options.

**files**
Compute the dirstat numbers by counting the number of files changed. Each changed file counts equally in the dirstat analysis. This is the computationally cheapest
**--dirstat**
behavior, since it does not have to look at the file contents at all.

**cumulative**
Count changes in a child directory for the parent directory as well. Note that when using
**cumulative**, the sum of the percentages reported may exceed 100%. The default (non-cumulative) behavior can be specified with the
**noncumulative**
parameter.

&lt;limit&gt;
An integer parameter specifies a cut-off percent (3% by default). Directories contributing less than this percentage of the changes are not shown in the output.

Example: The following will count changed files, while ignoring directories with less than 10% of the total amount of changed files, and accumulating child directory counts in the parent directories:
**--dirstat=files,10,cumulative**.

--summary
Output a condensed summary of extended header information such as creations, renames and mode changes.

--patch-with-stat
Synonym for
**-p --stat**.

-z
When
**--raw**,
**--numstat**,
**--name-only**
or
**--name-status**
has been given, do not munge pathnames and use NULs as output field terminators.

Without this option, pathnames with "unusual" characters are quoted as explained for the configuration variable
**core.quotePath**
(see
**git-config**(1)).

--name-only
Show only names of changed files.

--name-status
Show only names and status of changed files. See the description of the
**--diff-filter**
option on what the status letters mean.

--submodule[=&lt;format&gt;]
Specify how differences in submodules are shown. When specifying
**--submodule=short**
the
_short_
format is used. This format just shows the names of the commits at the beginning and end of the range. When
**--submodule**
or
**--submodule=log**
is specified, the
_log_
format is used. This format lists the commits in the range like
**git-submodule**(1)
**summary**
does. When
**--submodule=diff**
is specified, the
_diff_
format is used. This format shows an inline diff of the changes in the submodule contents between the commit range. Defaults to
**diff.submodule**
or the
_short_
format if the config option is unset.

--color[=&lt;when&gt;]
Show colored diff.
**--color**
(i.e. without
_=&lt;when&gt;_) is the same as
**--color=always**.
_&lt;when&gt;_
can be one of
**always**,
**never**, or
**auto**.

--no-color
Turn off colored diff. It is the same as
**--color=never**.

--color-moved[=&lt;mode&gt;]
Moved lines of code are colored differently. The &lt;mode&gt; defaults to
_no_
if the option is not given and to
_zebra_
if the option with no mode is given. The mode must be one of:

no
Moved lines are not highlighted.

default
Is a synonym for
**zebra**. This may change to a more sensible mode in the future.

plain
Any line that is added in one location and was removed in another location will be colored with
_color.diff.newMoved_. Similarly
_color.diff.oldMoved_
will be used for removed lines that are added somewhere else in the diff. This mode picks up any moved line, but it is not very useful in a review to determine if a block of code was moved without permutation.

blocks
Blocks of moved text of at least 20 alphanumeric characters are detected greedily. The detected blocks are painted using either the
_color.diff.{old,new}Moved_
color. Adjacent blocks cannot be told apart.

zebra
Blocks of moved text are detected as in
_blocks_
mode. The blocks are painted using either the
_color.diff.{old,new}Moved_
color or
_color.diff.{old,new}MovedAlternative_. The change between the two colors indicates that a new block was detected.

dimmed-zebra
Similar to
_zebra_, but additional dimming of uninteresting parts of moved code is performed. The bordering lines of two adjacent blocks are considered interesting, the rest is uninteresting.
**dimmed\_zebra**
is a deprecated synonym.

--no-color-moved
Turn off move detection. This can be used to override configuration settings. It is the same as
**--color-moved=no**.

--color-moved-ws=&lt;modes&gt;
This configures how whitespace is ignored when performing the move detection for
**--color-moved**. These modes can be given as a comma separated list:

no
Do not ignore whitespace when performing move detection.

ignore-space-at-eol
Ignore changes in whitespace at EOL.

ignore-space-change
Ignore changes in amount of whitespace. This ignores whitespace at line end, and considers all other sequences of one or more whitespace characters to be equivalent.

ignore-all-space
Ignore whitespace when comparing lines. This ignores differences even if one line has whitespace where the other line has none.

allow-indentation-change
Initially ignore any whitespace in the move detection, then group the moved code blocks only into a block if the change in whitespace is the same per line. This is incompatible with the other modes.

--no-color-moved-ws
Do not ignore whitespace when performing move detection. This can be used to override configuration settings. It is the same as
**--color-moved-ws=no**.

--word-diff[=&lt;mode&gt;]
Show a word diff, using the &lt;mode&gt; to delimit changed words. By default, words are delimited by whitespace; see
**--word-diff-regex**
below. The &lt;mode&gt; defaults to
_plain_, and must be one of:

color
Highlight changed words using only colors. Implies
**--color**.

plain
Show words as
**[-removed-]**
and
**{+added+}**. Makes no attempts to escape the delimiters if they appear in the input, so the output may be ambiguous.

porcelain
Use a special line-based format intended for script consumption. Added/removed/unchanged runs are printed in the usual unified diff format, starting with a
**+**/**-**/\` \` character at the beginning of the line and extending to the end of the line. Newlines in the input are represented by a tilde
**~**
on a line of its own.

none
Disable word diff again.

Note that despite the name of the first mode, color is used to highlight the changed parts in all modes if enabled.

--word-diff-regex=&lt;regex&gt;
Use &lt;regex&gt; to decide what a word is, instead of considering runs of non-whitespace to be a word. Also implies
**--word-diff**
unless it was already enabled.

Every non-overlapping match of the &lt;regex&gt; is considered a word. Anything between these matches is considered whitespace and ignored(!) for the purposes of finding differences. You may want to append
**|[^[:space:]]**
to your regular expression to make sure that it matches all non-whitespace characters. A match that contains a newline is silently truncated(!) at the newline.

For example,
**--word-diff-regex=.**
will treat each character as a word and, correspondingly, show differences character by character.

The regex can also be set via a diff driver or configuration option, see
**gitattributes**(5)
or
**git-config**(1). Giving it explicitly overrides any diff driver or configuration setting. Diff drivers override configuration settings.

--color-words[=&lt;regex&gt;]
Equivalent to
**--word-diff=color**
plus (if a regex was specified)
**--word-diff-regex=&lt;regex&gt;**.

--no-renames
Turn off rename detection, even when the configuration file gives the default to do so.

--check
Warn if changes introduce conflict markers or whitespace errors. What are considered whitespace errors is controlled by
**core.whitespace**
configuration. By default, trailing whitespaces (including lines that consist solely of whitespaces) and a space character that is immediately followed by a tab character inside the initial indent of the line are considered whitespace errors. Exits with non-zero status if problems are found. Not compatible with --exit-code.

--ws-error-highlight=&lt;kind&gt;
Highlight whitespace errors in the
**context**,
**old**
or
**new**
lines of the diff. Multiple values are separated by comma,
**none**
resets previous values,
**default**
reset the list to
**new**
and
**all**
is a shorthand for
**old,new,context**. When this option is not given, and the configuration variable
**diff.wsErrorHighlight**
is not set, only whitespace errors in
**new**
lines are highlighted. The whitespace errors are colored with
**color.diff.whitespace**.

--full-index
Instead of the first handful of characters, show the full pre- and post-image blob object names on the "index" line when generating patch format output.

--binary
In addition to
**--full-index**, output a binary diff that can be applied with
**git-apply**.

--abbrev[=&lt;n&gt;]
Instead of showing the full 40-byte hexadecimal object name in diff-raw format output and diff-tree header lines, show only a partial prefix. This is independent of the
**--full-index**
option above, which controls the diff-patch output format. Non default number of digits can be specified with
**--abbrev=&lt;n&gt;**.

-B[&lt;n&gt;][/&lt;m&gt;], --break-rewrites[=[&lt;n&gt;][/&lt;m&gt;]]
Break complete rewrite changes into pairs of delete and create. This serves two purposes:

It affects the way a change that amounts to a total rewrite of a file not as a series of deletion and insertion mixed together with a very few lines that happen to match textually as the context, but as a single deletion of everything old followed by a single insertion of everything new, and the number
**m**
controls this aspect of the -B option (defaults to 60%).
**-B/70%**
specifies that less than 30% of the original should remain in the result for Git to consider it a total rewrite (i.e. otherwise the resulting patch will be a series of deletion and insertion mixed together with context lines).

When used with -M, a totally-rewritten file is also considered as the source of a rename (usually -M only considers a file that disappeared as the source of a rename), and the number
**n**
controls this aspect of the -B option (defaults to 50%).
**-B20%**
specifies that a change with addition and deletion compared to 20% or more of the file’s size are eligible for being picked up as a possible source of a rename to another file.

-M[&lt;n&gt;], --find-renames[=&lt;n&gt;]
Detect renames. If
**n**
is specified, it is a threshold on the similarity index (i.e. amount of addition/deletions compared to the file’s size). For example,
**-M90%**
means Git should consider a delete/add pair to be a rename if more than 90% of the file hasn’t changed. Without a
**%**
sign, the number is to be read as a fraction, with a decimal point before it. I.e.,
**-M5**
becomes 0.5, and is thus the same as
**-M50%**. Similarly,
**-M05**
is the same as
**-M5%**. To limit detection to exact renames, use
**-M100%**. The default similarity index is 50%.

-C[&lt;n&gt;], --find-copies[=&lt;n&gt;]
Detect copies as well as renames. See also
**--find-copies-harder**. If
**n**
is specified, it has the same meaning as for
**-M&lt;n&gt;**.

--find-copies-harder
For performance reasons, by default,
**-C**
option finds copies only if the original file of the copy was modified in the same changeset. This flag makes the command inspect unmodified files as candidates for the source of copy. This is a very expensive operation for large projects, so use it with caution. Giving more than one
**-C**
option has the same effect.

-D, --irreversible-delete
Omit the preimage for deletes, i.e. print only the header but not the diff between the preimage and
**/dev/null**. The resulting patch is not meant to be applied with
**patch**
or
**git apply**; this is solely for people who want to just concentrate on reviewing the text after the change. In addition, the output obviously lacks enough information to apply such a patch in reverse, even manually, hence the name of the option.

When used together with
**-B**, omit also the preimage in the deletion part of a delete/create pair.

-l&lt;num&gt;
The
**-M**
and
**-C**
options require O(n^2) processing time where n is the number of potential rename/copy targets. This option prevents rename/copy detection from running if the number of rename/copy targets exceeds the specified number.

--diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
Select only files that are Added (**A**), Copied (**C**), Deleted (**D**), Modified (**M**), Renamed (**R**), have their type (i.e. regular file, symlink, submodule, ...) changed (**T**), are Unmerged (**U**), are Unknown (**X**), or have had their pairing Broken (**B**). Any combination of the filter characters (including none) can be used. When
<b>\*</b>
(All-or-none) is added to the combination, all paths are selected if there is any file that matches other criteria in the comparison; if there is no file that matches other criteria, nothing is selected.

Also, these upper-case letters can be downcased to exclude. E.g.
**--diff-filter=ad**
excludes added and deleted paths.

Note that not all diffs can feature all types. For instance, diffs from the index to the working tree can never have Added entries (because the set of paths included in the diff is limited by what is in the index). Similarly, copied and renamed entries cannot appear if detection for those types is disabled.

-S&lt;string&gt;
Look for differences that change the number of occurrences of the specified string (i.e. addition/deletion) in a file. Intended for the scripter’s use.

It is useful when you’re looking for an exact block of code (like a struct), and want to know the history of that block since it first came into being: use the feature iteratively to feed the interesting block in the preimage back into
**-S**, and keep going until you get the very first version of the block.

Binary files are searched as well.

-G&lt;regex&gt;
Look for differences whose patch text contains added/removed lines that match &lt;regex&gt;.

To illustrate the difference between
**-S&lt;regex&gt; --pickaxe-regex**
and
**-G&lt;regex&gt;**, consider a commit with the following diff in the same file:

.if n \{.RS 4
.\}
    +    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
    ...
    -    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
.if n \{.RE
.\}

While
**git log -G"regexec\e(regexp"**
will show this commit,
**git log -S"regexec\e(regexp" --pickaxe-regex**
will not (because the number of occurrences of that string did not change).

Unless
**--text**
is supplied patches of binary files without a textconv filter will be ignored.

See the
_pickaxe_
entry in
**gitdiffcore**(7)
for more information.

--find-object=&lt;object-id&gt;
Look for differences that change the number of occurrences of the specified object. Similar to
**-S**, just the argument is different in that it doesn’t search for a specific string but for a specific object id.

The object can be a blob or a submodule commit. It implies the
**-t**
option in
**git-log**
to also find trees.

--pickaxe-all
When
**-S**
or
**-G**
finds a change, show all the changes in that changeset, not just the files that contain the change in &lt;string&gt;.

--pickaxe-regex
Treat the &lt;string&gt; given to
**-S**
as an extended POSIX regular expression to match.

-O&lt;orderfile&gt;
Control the order in which files appear in the output. This overrides the
**diff.orderFile**
configuration variable (see
**git-config**(1)). To cancel
**diff.orderFile**, use
**-O/dev/null**.

The output order is determined by the order of glob patterns in &lt;orderfile&gt;. All files with pathnames that match the first pattern are output first, all files with pathnames that match the second pattern (but not the first) are output next, and so on. All files with pathnames that do not match any pattern are output last, as if there was an implicit match-all pattern at the end of the file. If multiple pathnames have the same rank (they match the same pattern but no earlier patterns), their output order relative to each other is the normal order.

&lt;orderfile&gt; is parsed as follows:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Blank lines are ignored, so they can be used as separators for readability.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Lines starting with a hash ("**#**") are ignored, so they can be used for comments. Add a backslash ("**\e**") to the beginning of the pattern if it starts with a hash.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Each other line contains a single pattern.

Patterns have the same syntax and semantics as patterns used for fnmatch(3) without the FNM_PATHNAME flag, except a pathname also matches a pattern if removing any number of the final pathname components matches the pattern. For example, the pattern "**foo*bar**" matches "**fooasdfbar**" and "**foo/bar/baz/asdf**" but not "**foobarx**".

-R
Swap two inputs; that is, show differences from index or on-disk file to tree contents.

--relative[=&lt;path&gt;]
When run from a subdirectory of the project, it can be told to exclude changes outside the directory and show pathnames relative to it with this option. When you are not in a subdirectory (e.g. in a bare repository), you can name which subdirectory to make the output relative to by giving a &lt;path&gt; as an argument.

-a, --text
Treat all files as text.

--ignore-cr-at-eol
Ignore carriage-return at the end of line when doing a comparison.

--ignore-space-at-eol
Ignore changes in whitespace at EOL.

-b, --ignore-space-change
Ignore changes in amount of whitespace. This ignores whitespace at line end, and considers all other sequences of one or more whitespace characters to be equivalent.

-w, --ignore-all-space
Ignore whitespace when comparing lines. This ignores differences even if one line has whitespace where the other line has none.

--ignore-blank-lines
Ignore changes whose lines are all blank.

--inter-hunk-context=&lt;lines&gt;
Show the context between diff hunks, up to the specified number of lines, thereby fusing hunks that are close to each other. Defaults to
**diff.interHunkContext**
or 0 if the config option is unset.

-W, --function-context
Show whole surrounding functions of changes.

--exit-code
Make the program exit with codes similar to diff(1). That is, it exits with 1 if there were differences and 0 means no differences.

--quiet
Disable all output of the program. Implies
**--exit-code**.

--ext-diff
Allow an external diff helper to be executed. If you set an external diff driver with
**gitattributes**(5), you need to use this option with
**git-log**(1)
and friends.

--no-ext-diff
Disallow external diff drivers.

--textconv, --no-textconv
Allow (or disallow) external text conversion filters to be run when comparing binary files. See
**gitattributes**(5)
for details. Because textconv filters are typically a one-way conversion, the resulting diff is suitable for human consumption, but cannot be applied. For this reason, textconv filters are enabled by default only for
**git-diff**(1)
and
**git-log**(1), but not for
**git-format-patch**(1)
or diff plumbing commands.

--ignore-submodules[=&lt;when&gt;]
Ignore changes to submodules in the diff generation. &lt;when&gt; can be either "none", "untracked", "dirty" or "all", which is the default. Using "none" will consider the submodule modified when it either contains untracked or modified files or its HEAD differs from the commit recorded in the superproject and can be used to override any settings of the
_ignore_
option in
**git-config**(1)
or
**gitmodules**(5). When "untracked" is used submodules are not considered dirty when they only contain untracked content (but they are still scanned for modified content). Using "dirty" ignores all changes to the work tree of submodules, only changes to the commits stored in the superproject are shown (this was the behavior until 1.7.0). Using "all" hides all changes to submodules.

--src-prefix=&lt;prefix&gt;
Show the given source prefix instead of "a/".

--dst-prefix=&lt;prefix&gt;
Show the given destination prefix instead of "b/".

--no-prefix
Do not show any source or destination prefix.

--line-prefix=&lt;prefix&gt;
Prepend an additional prefix to every line of output.

--ita-invisible-in-index
By default entries added by "git add -N" appear as an existing empty file in "git diff" and a new file in "git diff --cached". This option makes the entry appear as a new file in "git diff" and non-existent in "git diff --cached". This option could be reverted with
**--ita-visible-in-index**. Both options are experimental and could be removed in future.

For more detailed explanation on these common options, see also **gitdiffcore**(7).

&lt;tree-ish&gt;
The id of a tree object.

&lt;path&gt;...
If provided, the results are limited to a subset of files matching one of the provided pathspecs.

-r
recurse into sub-trees

-t
show tree entry itself as well as subtrees. Implies -r.

--root
When
**--root**
is specified the initial commit will be shown as a big creation event. This is equivalent to a diff against the NULL tree.

--stdin
When
**--stdin**
is specified, the command does not take &lt;tree-ish&gt; arguments from the command line. Instead, it reads lines containing either two &lt;tree&gt;, one &lt;commit&gt;, or a list of &lt;commit&gt; from its standard input. (Use a single space as separator.)

When two trees are given, it compares the first tree with the second. When a single commit is given, it compares the commit with its parents. The remaining commits, when given, are used as if they are parents of the first commit.

When comparing two trees, the ID of both trees (separated by a space and terminated by a newline) is printed before the difference. When comparing commits, the ID of the first (or only) commit, followed by a newline, is printed.

The following flags further affect the behavior when comparing commits (but not trees).

-m
By default,
_git diff-tree --stdin_
does not show differences for merge commits. With this flag, it shows differences to that commit from all of its parents. See also
**-c**.

-s
By default,
_git diff-tree --stdin_
shows differences, either in machine-readable form (without
**-p**) or in patch form (with
**-p**). This output can be suppressed. It is only useful with
**-v**
flag.

-v
This flag causes
_git diff-tree --stdin_
to also show the commit message before the differences.

--pretty[=&lt;format&gt;], --format=&lt;format&gt;
Pretty-print the contents of the commit logs in a given format, where
_&lt;format&gt;_
can be one of
_oneline_,
_short_,
_medium_,
_full_,
_fuller_,
_email_,
_raw_,
_format:&lt;string&gt;_
and
_tformat:&lt;string&gt;_. When
_&lt;format&gt;_
is none of the above, and has
_%placeholder_
in it, it acts as if
_--pretty=tformat:&lt;format&gt;_
were given.

See the "PRETTY FORMATS" section for some additional details for each format. When
_=&lt;format&gt;_
part is omitted, it defaults to
_medium_.

Note: you can specify the default pretty format in the repository configuration (see
**git-config**(1)).

--abbrev-commit
Instead of showing the full 40-byte hexadecimal commit object name, show only a partial prefix. Non default number of digits can be specified with "--abbrev=&lt;n&gt;" (which also modifies diff output, if it is displayed).

This should make "--pretty=oneline" a whole lot more readable for people using 80-column terminals.

--no-abbrev-commit
Show the full 40-byte hexadecimal commit object name. This negates
**--abbrev-commit**
and those options which imply it such as "--oneline". It also overrides the
**log.abbrevCommit**
variable.

--oneline
This is a shorthand for "--pretty=oneline --abbrev-commit" used together.

--encoding=&lt;encoding&gt;
The commit objects record the encoding used for the log message in their encoding header; this option can be used to tell the command to re-code the commit log message in the encoding preferred by the user. For non plumbing commands this defaults to UTF-8. Note that if an object claims to be encoded in
**X**
and we are outputting in
**X**, we will output the object verbatim; this means that invalid sequences in the original commit may be copied to the output.

--expand-tabs=&lt;n&gt;, --expand-tabs, --no-expand-tabs
Perform a tab expansion (replace each tab with enough spaces to fill to the next display column that is multiple of
_&lt;n&gt;_) in the log message before showing it in the output.
**--expand-tabs**
is a short-hand for
**--expand-tabs=8**, and
**--no-expand-tabs**
is a short-hand for
**--expand-tabs=0**, which disables tab expansion.

By default, tabs are expanded in pretty formats that indent the log message by 4 spaces (i.e.
_medium_, which is the default,
_full_, and
_fuller_).

--notes[=&lt;treeish&gt;]
Show the notes (see
**git-notes**(1)) that annotate the commit, when showing the commit log message. This is the default for
**git log**,
**git show**
and
**git whatchanged**
commands when there is no
**--pretty**,
**--format**, or
**--oneline**
option given on the command line.

By default, the notes shown are from the notes refs listed in the
**core.notesRef**
and
**notes.displayRef**
variables (or corresponding environment overrides). See
**git-config**(1)
for more details.

With an optional
_&lt;treeish&gt;_
argument, use the treeish to find the notes to display. The treeish can specify the full refname when it begins with
**refs/notes/**; when it begins with
**notes/**,
**refs/**
and otherwise
**refs/notes/**
is prefixed to form a full name of the ref.

Multiple --notes options can be combined to control which notes are being displayed. Examples: "--notes=foo" will show only notes from "refs/notes/foo"; "--notes=foo --notes" will show both notes from "refs/notes/foo" and from the default notes ref(s).

--no-notes
Do not show notes. This negates the above
**--notes**
option, by resetting the list of notes refs from which notes are shown. Options are parsed in the order given on the command line, so e.g. "--notes --notes=foo --no-notes --notes=bar" will only show notes from "refs/notes/bar".

--show-notes[=&lt;treeish&gt;], --[no-]standard-notes
These options are deprecated. Use the above --notes/--no-notes options instead.

--show-signature
Check the validity of a signed commit object by passing the signature to
**gpg --verify**
and show the output.

--no-commit-id
_git diff-tree_
outputs a line with the commit ID when applicable. This flag suppressed the commit ID output.

-c
This flag changes the way a merge commit is displayed (which means it is useful only when the command is given one &lt;tree-ish&gt;, or
**--stdin**). It shows the differences from each of the parents to the merge result simultaneously instead of showing pairwise diff between a parent and the result one at a time (which is what the
**-m**
option does). Furthermore, it lists only files which were modified from all parents.

--cc
This flag changes the way a merge commit patch is displayed, in a similar way to the
**-c**
option. It implies the
**-c**
and
**-p**
options and further compresses the patch output by omitting uninteresting hunks whose the contents in the parents have only two variants and the merge result picks one of them without modification. When all hunks are uninteresting, the commit itself and the commit log message is not shown, just like in any other "empty diff" case.

--always
Show the commit itself and the commit log message even if the diff itself is empty.

<a name="pretty-formats"></a>

# Pretty Formats


If the commit is a merge, and if the pretty-format is not _oneline_, _email_ or _raw_, an additional line is inserted before the _Author:_ line. This line begins with "Merge: " and the sha1s of ancestral commits are printed, separated by spaces. Note that the listed commits may not necessarily be the list of the **direct** parent commits if you have limited your view of history: for example, if you are only interested in changes related to a certain directory or file.

There are several built-in formats, and you can define additional formats by setting a pretty.&lt;name&gt; config option to either another format name, or a _format:_ string, as described below (see **git-config**(1)). Here are the details of the built-in formats:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _oneline_

.if n \{.RS 4
.\}
    <sha1> <title line>
.if n \{.RE
.\}

This is designed to be as compact as possible.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _short_

.if n \{.RS 4
.\}
    commit <sha1>
    Author: <author>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _medium_

.if n \{.RS 4
.\}
    commit <sha1>
    Author: <author>
    Date:   <author date>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _full_

.if n \{.RS 4
.\}
    commit <sha1>
    Author: <author>
    Commit: <committer>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _fuller_

.if n \{.RS 4
.\}
    commit <sha1>
    Author:     <author>
    AuthorDate: <author date>
    Commit:     <committer>
    CommitDate: <committer date>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _email_

.if n \{.RS 4
.\}
    From <sha1> <date>
    From: <author>
    Date: <author date>
    Subject: [PATCH] <title line>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    <full commit message>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _raw_

The
_raw_
format shows the entire commit exactly as stored in the commit object. Notably, the SHA-1s are displayed in full, regardless of whether --abbrev or --no-abbrev are used, and
_parents_
information show the true parent commits, without taking grafts or history simplification into account. Note that this format affects the way commits are displayed, but not the way the diff is shown e.g. with
**git log --raw**. To get full object names in a raw diff format, use
**--no-abbrev**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _format:&lt;string&gt;_

The
_format:&lt;string&gt;_
format allows you to specify which information you want to show. It works a little bit like printf format, with the notable exception that you get a newline with
_%n_
instead of
_\en_.

E.g,
_format:"The author of %h was %an, %ar%nThe title was &gt;&gt;%s&lt;&lt;%n"_
would show something like this:

.if n \{.RS 4
.\}
    The author of fe6e0ee was Junio C Hamano, 23 hours ago
    The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
.if n \{.RE
.\}

The placeholders are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%H_: commit hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%h_: abbreviated commit hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%T_: tree hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%t_: abbreviated tree hash

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%P_: parent hashes

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%p_: abbreviated parent hashes

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%an_: author name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aN_: author name (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ae_: author email

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aE_: author email (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ad_: author date (format respects --date= option)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aD_: author date, RFC2822 style

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ar_: author date, relative

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%at_: author date, UNIX timestamp

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ai_: author date, ISO 8601-like format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%aI_: author date, strict ISO 8601 format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cn_: committer name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cN_: committer name (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ce_: committer email

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cE_: committer email (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cd_: committer date (format respects --date= option)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cD_: committer date, RFC2822 style

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cr_: committer date, relative

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ct_: committer date, UNIX timestamp

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ci_: committer date, ISO 8601-like format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%cI_: committer date, strict ISO 8601 format

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%d_: ref names, like the --decorate option of
  **git-log**(1)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%D_: ref names without the " (", ")" wrapping.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%S_: ref name given on the command line by which the commit was reached (like
  **git log --source**), only works with
  **git log**

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%e_: encoding

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%s_: subject

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%f_: sanitized subject line, suitable for a filename

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%b_: body

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%B_: raw body (unwrapped subject and body)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%N_: commit notes

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GG_: raw verification message from GPG for a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%G?_: show "G" for a good (valid) signature, "B" for a bad signature, "U" for a good signature with unknown validity, "X" for a good signature that has expired, "Y" for a good signature made by an expired key, "R" for a good signature made by a revoked key, "E" if the signature cannot be checked (e.g. missing key) and "N" for no signature

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GS_: show the name of the signer for a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GK_: show the key used to sign a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GF_: show the fingerprint of the key used to sign a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%GP_: show the fingerprint of the primary key whose subkey was used to sign a signed commit

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gD_: reflog selector, e.g.,
  **refs/stash@{1}**
  or
  **refs/stash@{2 minutes ago**}; the format follows the rules described for the
  **-g**
  option. The portion before the
  **@**
  is the refname as given on the command line (so
  **git log -g refs/heads/master**
  would yield
  **refs/heads/master@{0}**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gd_: shortened reflog selector; same as
  **%gD**, but the refname portion is shortened for human readability (so
  **refs/heads/master**
  becomes just
  **master**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gn_: reflog identity name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gN_: reflog identity name (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%ge_: reflog identity email

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gE_: reflog identity email (respecting .mailmap, see
  **git-shortlog**(1)
  or
  **git-blame**(1))

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%gs_: reflog subject

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Cred_: switch color to red

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Cgreen_: switch color to green

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Cblue_: switch color to blue

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%Creset_: reset color

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%C(...)_: color specification, as described under Values in the "CONFIGURATION FILE" section of
  **git-config**(1). By default, colors are shown only when enabled for log output (by
  **color.diff**,
  **color.ui**, or
  **--color**, and respecting the
  **auto**
  settings of the former if we are going to a terminal).
  **%C(auto,...)**
  is accepted as a historical synonym for the default (e.g.,
  **%C(auto,red)**). Specifying
  **%C(always,...)**
  will show the colors even when color is not otherwise enabled (though consider just using
  **--color=always**
  to enable color for the whole output, including this format and anything else git might color).
  **auto**
  alone (i.e.
  **%C(auto)**) will turn on auto coloring on the next placeholders until the color is switched again.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%m_: left (**&lt;**), right (**&gt;**) or boundary (**-**) mark

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%n_: newline

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%%_: a raw
  _%_

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%x00_: print a byte from a hex code

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%w([&lt;w&gt;[,&lt;i1&gt;[,&lt;i2&gt;]]])_: switch line wrapping, like the -w option of
  **git-shortlog**(1).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&lt;(&lt;N&gt;[,trunc|ltrunc|mtrunc])_: make the next placeholder take at least N columns, padding spaces on the right if necessary. Optionally truncate at the beginning (ltrunc), the middle (mtrunc) or the end (trunc) if the output is longer than N columns. Note that truncating only works correctly with N &gt;= 2.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&lt;|(&lt;N&gt;)_: make the next placeholder take at least until Nth columns, padding spaces on the right if necessary

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&gt;(&lt;N&gt;)_,
  _%&gt;|(&lt;N&gt;)_: similar to
  _%&lt;(&lt;N&gt;)_,
  _%&lt;|(&lt;N&gt;)_
  respectively, but padding spaces on the left

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&gt;&gt;(&lt;N&gt;)_,
  _%&gt;&gt;|(&lt;N&gt;)_: similar to
  _%&gt;(&lt;N&gt;)_,
  _%&gt;|(&lt;N&gt;)_
  respectively, except that if the next placeholder takes more spaces than given and there are spaces on its left, use those spaces

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _%&gt;&lt;(&lt;N&gt;)_,
  _%&gt;&lt;|(&lt;N&gt;)_: similar to
  _%&lt;(&lt;N&gt;)_,
  _%&lt;|(&lt;N&gt;)_
  respectively, but padding both sides (i.e. the text is centered)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  %(trailers[:options]): display the trailers of the body as interpreted by
  **git-interpret-trailers**(1). The
  **trailers**
  string may be followed by a colon and zero or more comma-separated options. If the
  **only**
  option is given, omit non-trailer lines from the trailer block. If the
  **unfold**
  option is given, behave as if interpret-trailer’s
  **--unfold**
  option was given. E.g.,
  **%(trailers:only,unfold)**
  to do both.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

Some placeholders may depend on other options given to the revision traversal engine. For example, the **%g*** reflog options will insert an empty string unless we are traversing reflog entries (e.g., by **git log -g**). The **%d** and **%D** placeholders will use the "short" decoration format if **--decorate** was not already provided on the command line.


If you add a **+** (plus sign) after _%_ of a placeholder, a line-feed is inserted immediately before the expansion if and only if the placeholder expands to a non-empty string.

If you add a **-** (minus sign) after _%_ of a placeholder, all consecutive line-feeds immediately preceding the expansion are deleted if and only if the placeholder expands to an empty string.

If you add a \` \` (space) after _%_ of a placeholder, a space is inserted immediately before the expansion if and only if the placeholder expands to a non-empty string.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _tformat:_

The
_tformat:_
format works exactly like
_format:_, except that it provides "terminator" semantics instead of "separator" semantics. In other words, each commit has the message terminator character (usually a newline) appended, rather than a separator placed between entries. This means that the final entry of a single-line format will be properly terminated with a new line, just as the "oneline" format does. For example:

.if n \{.RS 4
.\}
    $ git log -2 --pretty=format:%h 4da45bef e
      | perl -pe '$_ .= " -- NO NEWLINEen" unless /en/'
    4da45be
    7134973 -- NO NEWLINE
    
    $ git log -2 --pretty=tformat:%h 4da45bef e
      | perl -pe '$_ .= " -- NO NEWLINEen" unless /en/'
    4da45be
    7134973
.if n \{.RE
.\}

In addition, any unrecognized string that has a
**%**
in it is interpreted as if it has
**tformat:**
in front of it. For example, these two are equivalent:

.if n \{.RS 4
.\}
    $ git log -2 --pretty=tformat:%h 4da45bef
    $ git log -2 --pretty=%h 4da45bef
.if n \{.RE
.\}


<a name="raw-output-format"></a>

# Raw Output Format


The raw output format from "git-diff-index", "git-diff-tree", "git-diff-files" and "git diff --raw" are very similar.

These commands all compare two sets of things; what is compared differs:

git-diff-index &lt;tree-ish&gt;
compares the &lt;tree-ish&gt; and the files on the filesystem.

git-diff-index --cached &lt;tree-ish&gt;
compares the &lt;tree-ish&gt; and the index.

git-diff-tree [-r] &lt;tree-ish-1&gt; &lt;tree-ish-2&gt; [&lt;pattern&gt;...]
compares the trees named by the two arguments.

git-diff-files [&lt;pattern&gt;...]
compares the index and the files on the filesystem.

The "git-diff-tree" command begins its output by printing the hash of what is being compared. After that, all the commands print one output line per changed file.

An output line is formatted this way:

.if n \{.RS 4
.\}
    in-place edit  :100644 100644 bcd1234 0123456 M file0
    copy-edit      :100644 100644 abcd123 1234567 C68 file1 file2
    rename-edit    :100644 100644 abcd123 1234567 R86 file1 file3
    create         :000000 100644 0000000 1234567 A file4
    delete         :100644 000000 1234567 0000000 D file5
    unmerged       :000000 000000 0000000 0000000 U file6
.if n \{.RE
.\}


That is, from the left to the right:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  a colon.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  mode for "src"; 000000 if creation or unmerged.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  a space.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  mode for "dst"; 000000 if deletion or unmerged.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  a space.

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  sha1 for "src"; 0{40} if creation or unmerged.

.ie n \{\h'-04' 7.\h'+01'\c
.\}
.el \{.sp -1

*   7.  
  .\}
  a space.

.ie n \{\h'-04' 8.\h'+01'\c
.\}
.el \{.sp -1

*   8.  
  .\}
  sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".

.ie n \{\h'-04' 9.\h'+01'\c
.\}
.el \{.sp -1

*   9.  
  .\}
  a space.

.ie n \{\h'-04'10.\h'+01'\c
.\}
.el \{.sp -1

* 10.  
  .\}
  status, followed by optional "score" number.

.ie n \{\h'-04'11.\h'+01'\c
.\}
.el \{.sp -1

* 11.  
  .\}
  a tab or a NUL when
  **-z**
  option is used.

.ie n \{\h'-04'12.\h'+01'\c
.\}
.el \{.sp -1

* 12.  
  .\}
  path for "src"

.ie n \{\h'-04'13.\h'+01'\c
.\}
.el \{.sp -1

* 13.  
  .\}
  a tab or a NUL when
  **-z**
  option is used; only exists for C or R.

.ie n \{\h'-04'14.\h'+01'\c
.\}
.el \{.sp -1

* 14.  
  .\}
  path for "dst"; only exists for C or R.

.ie n \{\h'-04'15.\h'+01'\c
.\}
.el \{.sp -1

* 15.  
  .\}
  an LF or a NUL when
  **-z**
  option is used, to terminate the record.

Possible status letters are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A: addition of a file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  C: copy of a file into a new one

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  D: deletion of a file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  M: modification of the contents or mode of a file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  R: renaming of a file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  T: change in the type of the file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  U: file is unmerged (you must complete the merge before it can be committed)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  X: "unknown" change type (most probably a bug, please report it)

Status letters C and R are always followed by a score (denoting the percentage of similarity between the source and target of the move or copy). Status letter M may be followed by a score (denoting the percentage of dissimilarity) for file rewrites.

&lt;sha1&gt; is shown as all 0’s if a file is new on the filesystem and it is out of sync with the index.

Example:

.if n \{.RS 4
.\}
    :100644 100644 5be4a4a 0000000 M file.c
.if n \{.RE
.\}


Without the **-z** option, pathnames with "unusual" characters are quoted as explained for the configuration variable **core.quotePath** (see **git-config**(1)). Using **-z** the filename is output verbatim and the line is terminated by a NUL byte.

<a name="diff-format-for-merges"></a>

# Diff Format for Merges


"git-diff-tree", "git-diff-files" and "git-diff --raw" can take **-c** or **--cc** option to generate diff output also for merge commits. The output differs from the format described above in the following way:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  there is a colon for each parent

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  there are more "src" modes and "src" sha1

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  status is concatenated status characters for each parent

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  no optional "score" number

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  single path, only for "dst"

Example:

.if n \{.RS 4
.\}
    ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM       describe.c
.if n \{.RE
.\}


Note that _combined diff_ lists only files which were modified from all parents.

<a name="generating-patches-with-p"></a>

# Generating Patches with \-P


When "git-diff-index", "git-diff-tree", or "git-diff-files" are run with a **-p** option, "git diff" without the **--raw** option, or "git log" with the "-p" option, they do not produce the output described above; instead they produce a patch file. You can customize the creation of such patches via the **GIT\_EXTERNAL\_DIFF** and the **GIT\_DIFF\_OPTS** environment variables.

What the -p option produces is slightly different from the traditional diff format:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  It is preceded with a "git diff" header that looks like this:

.if n \{.RS 4
.\}
    diff --git a/file1 b/file2
.if n \{.RE
.\}

The
**a/**
and
**b/**
filenames are the same unless rename/copy is involved. Especially, even for a creation or a deletion,
**/dev/null**
is
_not_
used in place of the
**a/**
or
**b/**
filenames.

When rename/copy is involved,
**file1**
and
**file2**
show the name of the source file of the rename/copy and the name of the file that rename/copy produces, respectively.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  It is followed by one or more extended header lines:

.if n \{.RS 4
.\}
    old mode <mode>
    new mode <mode>
    deleted file mode <mode>
    new file mode <mode>
    copy from <path>
    copy to <path>
    rename from <path>
    rename to <path>
    similarity index <number>
    dissimilarity index <number>
    index <hash>..<hash> <mode>
.if n \{.RE
.\}

File modes are printed as 6-digit octal numbers including the file type and file permission bits.

Path names in extended headers do not include the
**a/**
and
**b/**
prefixes.

The similarity index is the percentage of unchanged lines, and the dissimilarity index is the percentage of changed lines. It is a rounded down integer, followed by a percent sign. The similarity index value of 100% is thus reserved for two equal files, while 100% dissimilarity means that no line from the old file made it into the new one.

The index line includes the SHA-1 checksum before and after the change. The &lt;mode&gt; is included if the file mode does not change; otherwise, separate lines indicate the old and the new mode.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Pathnames with "unusual" characters are quoted as explained for the configuration variable
  **core.quotePath**
  (see
  **git-config**(1)).

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  All the
  **file1**
  files in the output refer to files before the commit, and all the
  **file2**
  files refer to files after the commit. It is incorrect to apply each change to each file sequentially. For example, this patch will swap a and b:

.if n \{.RS 4
.\}
    diff --git a/a b/b
    rename from a
    rename to b
    diff --git a/b b/a
    rename from b
    rename to a
.if n \{.RE
.\}

<a name="combined-diff-format"></a>

# Combined Diff Format


Any diff-generating command can take the **-c** or **--cc** option to produce a _combined diff_ when showing a merge. This is the default format when showing merges with **git-diff**(1) or **git-show**(1). Note also that you can give the **-m** option to any of these commands to force generation of diffs with individual parents of a merge.

A _combined diff_ format looks like this:

.if n \{.RS 4
.\}
    diff --combined describe.c
    index fabadb8,cc95eb0..4866510
    --- a/describe.c
    +++ b/describe.c
    @@@ -98,20 -98,12 +98,20 @@@
            return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
      }
    
    - static void describe(char *arg)
     -static void describe(struct commit *cmit, int last_one)
    ++static void describe(char *arg, int last_one)
      {
     +      unsigned char sha1[20];
     +      struct commit *cmit;
            struct commit_list *list;
            static int initialized = 0;
            struct commit_name *n;
    
     +      if (get_sha1(arg, sha1) < 0)
     +              usage(describe_usage);
     +      cmit = lookup_commit_reference(sha1);
     +      if (!cmit)
     +              usage(describe_usage);
     +
            if (!initialized) {
                    initialized = 1;
                    for_each_ref(get_name);
.if n \{.RE
.\}



.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  It is preceded with a "git diff" header, that looks like this (when
  **-c**
  option is used):

.if n \{.RS 4
.\}
    diff --combined file
.if n \{.RE
.\}

or like this (when
**--cc**
option is used):

.if n \{.RS 4
.\}
    diff --cc file
.if n \{.RE
.\}

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  It is followed by one or more extended header lines (this example shows a merge with two parents):

.if n \{.RS 4
.\}
    index <hash>,<hash>..<hash>
    mode <mode>,<mode>..<mode>
    new file mode <mode>
    deleted file mode <mode>,<mode>
.if n \{.RE
.\}

The
**mode &lt;mode&gt;,&lt;mode&gt;..&lt;mode&gt;**
line appears only if at least one of the &lt;mode&gt; is different from the rest. Extended headers with information about detected contents movement (renames and copying detection) are designed to work with diff of two &lt;tree-ish&gt; and are not used by combined diff format.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  It is followed by two-line from-file/to-file header

.if n \{.RS 4
.\}
    --- a/file
    +++ b/file
.if n \{.RE
.\}

Similar to two-line header for traditional
_unified_
diff format,
**/dev/null**
is used to signal created or deleted files.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  Chunk header format is modified to prevent people from accidentally feeding it to
  **patch -p1**. Combined diff format was created for review of merge commit changes, and was not meant for apply. The change is similar to the change in the extended
  _index_
  header:

.if n \{.RS 4
.\}
    @@@ <from-file-range> <from-file-range> <to-file-range> @@@
.if n \{.RE
.\}

There are (number of parents + 1)
**@**
characters in the chunk header for combined diff format.

Unlike the traditional _unified_ diff format, which shows two files A and B with a single column that has **-** (minus — appears in A but removed in B), **+** (plus — missing in A but added to B), or **" "** (space — unchanged) prefix, this format compares two or more files file1, file2,... with one file X, and shows how X differs from each of fileN. One column for each of fileN is prepended to the output line to note how X’s line is different from it.

A **-** character in the column N means that the line appears in fileN but it does not appear in the result. A **+** character in the column N means that the line appears in the result, and fileN does not have that line (in other words, the line was added, from the point of view of that parent).

In the above example output, the function signature was changed from both files (hence two **-** removals from both file1 and file2, plus **++** to mean one line that was added does not appear in either file1 or file2). Also eight other lines are the same from file1 but do not appear in file2 (hence prefixed with **+**).

When shown by **git diff-tree -c**, it compares the parents of a merge commit with the merge result (i.e. file1..fileN are the parents). When shown by **git diff-files -c**, it compares the two unresolved merge parents with the working tree file (i.e. file1 is stage 2 aka "our version", file2 is stage 3 aka "their version").

<a name="other-diff-formats"></a>

# Other Diff Formats


The **--summary** option describes newly added, deleted, renamed and copied files. The **--stat** option adds diffstat(1) graph to the output. These options can be combined with other options, such as **-p**, and are meant for human consumption.

When showing a change that involves a rename or a copy, **--stat** output formats the pathnames compactly by combining common prefix and suffix of the pathnames. For example, a change that moves **arch/i386/Makefile** to **arch/x86/Makefile** while modifying 4 lines will be shown like this:

.if n \{.RS 4
.\}
    arch/{i386 => x86}/Makefile    |   4 +--
.if n \{.RE
.\}


The **--numstat** option gives the diffstat(1) information but is designed for easier machine consumption. An entry in **--numstat** output looks like this:

.if n \{.RS 4
.\}
    1       2       README
    3       1       arch/{i386 => x86}/Makefile
.if n \{.RE
.\}


That is, from left to right:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  the number of added lines;

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  a tab;

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  the number of deleted lines;

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  a tab;

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  pathname (possibly with rename/copy information);

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  a newline.

When **-z** output option is in effect, the output is formatted this way:

.if n \{.RS 4
.\}
    1       2       README NUL
    3       1       NUL arch/i386/Makefile NUL arch/x86/Makefile NUL
.if n \{.RE
.\}


That is:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  the number of added lines;

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  a tab;

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  the number of deleted lines;

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  a tab;

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  a NUL (only exists if renamed/copied);

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  pathname in preimage;

.ie n \{\h'-04' 7.\h'+01'\c
.\}
.el \{.sp -1

*   7.  
  .\}
  a NUL (only exists if renamed/copied);

.ie n \{\h'-04' 8.\h'+01'\c
.\}
.el \{.sp -1

*   8.  
  .\}
  pathname in postimage (only exists if renamed/copied);

.ie n \{\h'-04' 9.\h'+01'\c
.\}
.el \{.sp -1

*   9.  
  .\}
  a NUL.

The extra **NUL** before the preimage path in renamed case is to allow scripts that read the output to tell if the current record being read is a single-path record or a rename/copy record without reading ahead. After reading added and deleted lines, reading up to **NUL** would yield the pathname, but if that is **NUL**, the record will show two paths.

<a name="git"></a>

# Git


Part of the **git**(1) suite
