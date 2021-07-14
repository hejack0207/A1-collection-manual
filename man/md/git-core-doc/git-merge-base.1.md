# git\-merge\-base(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-merge-base - Find as good common ancestors as possible for a merge

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git merge-base [-a|--all] <commit> <commit>...
    git merge-base [-a|--all] --octopus <commit>...
    git merge-base --is-ancestor <commit> <commit>
    git merge-base --independent <commit>...
    git merge-base --fork-point <ref> [<commit>]
<synopsis>


```

<a name="description"></a>

# Description


_git merge-base_ finds best common ancestor(s) between two commits to use in a three-way merge. One common ancestor is _better_ than another common ancestor if the latter is an ancestor of the former. A common ancestor that does not have any better common ancestor is a _best common ancestor_, i.e. a _merge base_. Note that there can be more than one merge base for a pair of commits.

<a name="operation-modes"></a>

# Operation Modes


As the most common special case, specifying only two commits on the command line means computing the merge base between the given two commits.

More generally, among the two commits to compute the merge base from, one is specified by the first commit argument on the command line; the other commit is a (possibly hypothetical) commit that is a merge across all the remaining commits on the command line.

As a consequence, the _merge base_ is not necessarily contained in each of the commit arguments if more than two commits are specified. This is different from **git-show-branch**(1) when used with the **--merge-base** option.

--octopus
Compute the best common ancestors of all supplied commits, in preparation for an n-way merge. This mimics the behavior of
_git show-branch --merge-base_.

--independent
Instead of printing merge bases, print a minimal subset of the supplied commits with the same ancestors. In other words, among the commits given, list those which cannot be reached from any other. This mimics the behavior of
_git show-branch --independent_.

--is-ancestor
Check if the first &lt;commit&gt; is an ancestor of the second &lt;commit&gt;, and exit with status 0 if true, or with status 1 if not. Errors are signaled by a non-zero status that is not 1.

--fork-point
Find the point at which a branch (or any history that leads to &lt;commit&gt;) forked from another branch (or any reference) &lt;ref&gt;. This does not just look for the common ancestor of the two commits, but also takes into account the reflog of &lt;ref&gt; to see if the history leading to &lt;commit&gt; forked from an earlier incarnation of the branch &lt;ref&gt; (see discussion on this mode below).

<a name="options"></a>

# Options


-a, --all
Output all merge bases for the commits, instead of just one.

<a name="discussion"></a>

# Discussion


Given two commits _A_ and _B_, **git merge-base A B** will output a commit which is reachable from both _A_ and _B_ through the parent relationship.

For example, with this topology:

.if n \{.RS 4
.\}
             o---o---o---B
            /
    ---o---1---o---o---o---A
.if n \{.RE
.\}

the merge base between _A_ and _B_ is _1_.

Given three commits _A_, _B_ and _C_, **git merge-base A B C** will compute the merge base between _A_ and a hypothetical commit _M_, which is a merge between _B_ and _C_. For example, with this topology:

.if n \{.RS 4
.\}
           o---o---o---o---C
          /
         /   o---o---o---B
        /   /
    ---2---1---o---o---o---A
.if n \{.RE
.\}

the result of **git merge-base A B C** is _1_. This is because the equivalent topology with a merge commit _M_ between _B_ and _C_ is:

.if n \{.RS 4
.\}
           o---o---o---o---o
          /                 e
         /   o---o---o---o---M
        /   /
    ---2---1---o---o---o---A
.if n \{.RE
.\}

and the result of **git merge-base A M** is _1_. Commit _2_ is also a common ancestor between _A_ and _M_, but _1_ is a better common ancestor, because _2_ is an ancestor of _1_. Hence, _2_ is not a merge base.

The result of **git merge-base --octopus A B C** is _2_, because _2_ is the best common ancestor of all commits.

When the history involves criss-cross merges, there can be more than one _best_ common ancestor for two commits. For example, with this topology:

.if n \{.RS 4
.\}
    ---1---o---A
        e /
         X
        / e
    ---2---o---o---B
.if n \{.RE
.\}

both _1_ and _2_ are merge-bases of A and B. Neither one is better than the other (both are _best_ merge bases). When the **--all** option is not given, it is unspecified which best one is output.

A common idiom to check "fast-forward-ness" between two commits A and B is (or at least used to be) to compute the merge base between A and B, and check if it is the same as A, in which case, A is an ancestor of B. You will see this idiom used often in older scripts.

.if n \{.RS 4
.\}
    A=$(git rev-parse --verify A)
    if test "$A" = "$(git merge-base A B)"
    then
            ... A is an ancestor of B ...
    fi
.if n \{.RE
.\}

In modern git, you can say this in a more direct way:

.if n \{.RS 4
.\}
    if git merge-base --is-ancestor A B
    then
            ... A is an ancestor of B ...
    fi
.if n \{.RE
.\}

instead.

<a name="discussion-on-fork-point-mode"></a>

# Discussion on Fork\-Point Mode


After working on the **topic** branch created with **git checkout -b topic origin/master**, the history of remote-tracking branch **origin/master** may have been rewound and rebuilt, leading to a history of this shape:

.if n \{.RS 4
.\}
                     o---B2
                    /
    ---o---o---B1--o---o---o---B (origin/master)
            e
             B0
              e
               D0---D1---D (topic)
.if n \{.RE
.\}

where **origin/master** used to point at commits B0, B1, B2 and now it points at B, and your **topic** branch was started on top of it back when **origin/master** was at B0, and you built three commits, D0, D1, and D, on top of it. Imagine that you now want to rebase the work you did on the topic on top of the updated origin/master.

In such a case, **git merge-base origin/master topic** would return the parent of B0 in the above picture, but B0^..D is **not** the range of commits you would want to replay on top of B (it includes B0, which is not what you wrote; it is a commit the other side discarded when it moved its tip from B0 to B1).

**git merge-base --fork-point origin/master topic** is designed to help in such a case. It takes not only B but also B0, B1, and B2 (i.e. old tips of the remote-tracking branches your repository’s reflog knows about) into account to see on which commit your topic branch was built and finds B0, allowing you to replay only the commits on your topic, excluding the commits the other side later discarded.

Hence

.if n \{.RS 4
.\}
    $ fork_point=$(git merge-base --fork-point origin/master topic)
.if n \{.RE
.\}

will find B0, and

.if n \{.RS 4
.\}
    $ git rebase --onto origin/master $fork_point topic
.if n \{.RE
.\}

will replay D0, D1 and D on top of B to create a new history of this shape:

.if n \{.RS 4
.\}
                     o---B2
                    /
    ---o---o---B1--o---o---o---B (origin/master)
            e                   e
             B0                  D0'--D1'--D' (topic - updated)
              e
               D0---D1---D (topic - old)
.if n \{.RE
.\}

A caveat is that older reflog entries in your repository may be expired by **git gc**. If B0 no longer appears in the reflog of the remote-tracking branch **origin/master**, the **--fork-point** mode obviously cannot find it and fails, avoiding to give a random and useless result (such as the parent of B0, like the same command without the **--fork-point** option gives).

Also, the remote-tracking branch you use the **--fork-point** mode with must be the one your topic forked from its tip. If you forked from an older commit than the tip, this mode would not find the fork point (imagine in the above sample history B0 did not exist, origin/master started at B1, moved to B2 and then B, and you forked your topic at origin/master^ when origin/master was B1; the shape of the history would be the same as above, without B0, and the parent of B1 is what **git merge-base origin/master topic** correctly finds, but the **--fork-point** mode will not, because it is not one of the commits that used to be at the tip of origin/master).

<a name="see-also"></a>

# See Also


**git-rev-list**(1), **git-show-branch**(1), **git-merge**(1)

<a name="git"></a>

# Git


Part of the **git**(1) suite
