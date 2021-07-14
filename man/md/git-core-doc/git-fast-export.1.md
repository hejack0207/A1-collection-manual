# git\-fast\-export(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-fast-export - Git data exporter

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git fast-export [<options>] | git fast-import
<synopsis>


```

<a name="description"></a>

# Description


This program dumps the given revisions in a form suitable to be piped into _git fast-import_.

You can use it as a human-readable bundle replacement (see **git-bundle**(1)), or as a kind of an interactive _git filter-branch_.

<a name="options"></a>

# Options


--progress=&lt;n&gt;
Insert
_progress_
statements every &lt;n&gt; objects, to be shown by
_git fast-import_
during import.

--signed-tags=(verbatim|warn|warn-strip|strip|abort)
Specify how to handle signed tags. Since any transformation after the export can change the tag names (which can also happen when excluding revisions) the signatures will not match.

When asking to
_abort_
(which is the default), this program will die when encountering a signed tag. With
_strip_, the tags will silently be made unsigned, with
_warn-strip_
they will be made unsigned but a warning will be displayed, with
_verbatim_, they will be silently exported and with
_warn_, they will be exported, but you will see a warning.

--tag-of-filtered-object=(abort|drop|rewrite)
Specify how to handle tags whose tagged object is filtered out. Since revisions and files to export can be limited by path, tagged objects may be filtered completely.

When asking to
_abort_
(which is the default), this program will die when encountering such a tag. With
_drop_
it will omit such tags from the output. With
_rewrite_, if the tagged object is a commit, it will rewrite the tag to tag an ancestor commit (via parent rewriting; see
**git-rev-list**(1))

-M, -C
Perform move and/or copy detection, as described in the
**git-diff**(1)
manual page, and use it to generate rename and copy commands in the output dump.

Note that earlier versions of this command did not complain and produced incorrect results if you gave these options.

--export-marks=&lt;file&gt;
Dumps the internal marks table to &lt;file&gt; when complete. Marks are written one per line as
**:markid SHA-1**. Only marks for revisions are dumped; marks for blobs are ignored. Backends can use this file to validate imports after they have been completed, or to save the marks table across incremental runs. As &lt;file&gt; is only opened and truncated at completion, the same path can also be safely given to --import-marks. The file will not be written if no new object has been marked/exported.

--import-marks=&lt;file&gt;
Before processing any input, load the marks specified in &lt;file&gt;. The input file must exist, must be readable, and must use the same format as produced by --export-marks.

Any commits that have already been marked will not be exported again. If the backend uses a similar --import-marks file, this allows for incremental bidirectional exporting of the repository by keeping the marks the same across runs.

--fake-missing-tagger
Some old repositories have tags without a tagger. The fast-import protocol was pretty strict about that, and did not allow that. So fake a tagger to be able to fast-import the output.

--use-done-feature
Start the stream with a
_feature done_
stanza, and terminate it with a
_done_
command.

--no-data
Skip output of blob objects and instead refer to blobs via their original SHA-1 hash. This is useful when rewriting the directory structure or history of a repository without touching the contents of individual files. Note that the resulting stream can only be used by a repository which already contains the necessary objects.

--full-tree
This option will cause fast-export to issue a "deleteall" directive for each commit followed by a full list of all files in the commit (as opposed to just listing the files which are different from the commit’s first parent).

--anonymize
Anonymize the contents of the repository while still retaining the shape of the history and stored tree. See the section on
**ANONYMIZING**
below.

--reference-excluded-parents
By default, running a command such as
**git fast-export master~5..master**
will not include the commit master~5 and will make master~4 no longer have master~5 as a parent (though both the old master~4 and new master~4 will have all the same files). Use --reference-excluded-parents to instead have the the stream refer to commits in the excluded range of history by their sha1sum. Note that the resulting stream can only be used by a repository which already contains the necessary parent commits.

--show-original-ids
Add an extra directive to the output for commits and blobs,
**original-oid &lt;SHA1SUM&gt;**. While such directives will likely be ignored by importers such as git-fast-import, it may be useful for intermediary filters (e.g. for rewriting commit messages which refer to older commits, or for stripping blobs by id).

--refspec
Apply the specified refspec to each ref exported. Multiple of them can be specified.

[&lt;git-rev-list-args&gt;...]
A list of arguments, acceptable to
_git rev-parse_
and
_git rev-list_, that specifies the specific objects and references to export. For example,
**master~10..master**
causes the current master reference to be exported along with all objects added since its 10th ancestor commit and (unless the --reference-excluded-parents option is specified) all files common to master~9 and master~10.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    $ git fast-export --all | (cd /empty/repository && git fast-import)
.if n \{.RE
.\}


This will export the whole repository and import it into the existing empty repository. Except for reencoding commits that are not in UTF-8, it would be a one-to-one mirror.

.if n \{.RS 4
.\}
    $ git fast-export master~5..master |
            sed "s|refs/heads/master|refs/heads/other|" |
            git fast-import
.if n \{.RE
.\}


This makes a new branch called _other_ from _master~5..master_ (i.e. if _master_ has linear history, it will take the last 5 commits).

Note that this assumes that none of the blobs and commit messages referenced by that revision range contains the string _refs/heads/master_.

<a name="anonymizing"></a>

# Anonymizing


If the **--anonymize** option is given, git will attempt to remove all identifying information from the repository while still retaining enough of the original tree and history patterns to reproduce some bugs. The goal is that a git bug which is found on a private repository will persist in the anonymized repository, and the latter can be shared with git developers to help solve the bug.

With this option, git will replace all refnames, paths, blob contents, commit and tag messages, names, and email addresses in the output with anonymized data. Two instances of the same string will be replaced equivalently (e.g., two commits with the same author will have the same anonymized author in the output, but bear no resemblance to the original author string). The relationship between commits, branches, and tags is retained, as well as the commit timestamps (but the commit messages and refnames bear no resemblance to the originals). The relative makeup of the tree is retained (e.g., if you have a root tree with 10 files and 3 trees, so will the output), but their names and the contents of the files will be replaced.

If you think you have found a git bug, you can start by exporting an anonymized stream of the whole repository:

.if n \{.RS 4
.\}
    $ git fast-export --anonymize --all >anon-stream
.if n \{.RE
.\}


Then confirm that the bug persists in a repository created from that stream (many bugs will not, as they really do depend on the exact repository contents):

.if n \{.RS 4
.\}
    $ git init anon-repo
    $ cd anon-repo
    $ git fast-import <../anon-stream
    $ ... test your bug ...
.if n \{.RE
.\}


If the anonymized repository shows the bug, it may be worth sharing **anon-stream** along with a regular bug report. Note that the anonymized stream compresses very well, so gzipping it is encouraged. If you want to examine the stream to see that it does not contain any private data, you can peruse it directly before sending. You may also want to try:

.if n \{.RS 4
.\}
    $ perl -pe 's/ed+/X/g' <anon-stream | sort -u | less
.if n \{.RE
.\}


which shows all of the unique lines (with numbers converted to "X", to collapse "User 0", "User 1", etc into "User X"). This produces a much smaller output, and it is usually easy to quickly confirm that there is no private data in the stream.

<a name="limitations"></a>

# Limitations


Since _git fast-import_ cannot tag trees, you will not be able to export the linux.git repository completely, as it contains a tag referencing a tree instead of a commit.

<a name="see-also"></a>

# See Also


**git-fast-import**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
