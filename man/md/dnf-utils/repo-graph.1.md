# repo-graph(1) - redirecting to DNF repograph Plugin

4.0.22, Jun 15, 2021

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

Output a full package dependency graph in dot format.

<a name="synopsis"></a>

# Synopsis

```

 dnf repograph [<options>] dnf repo-graph [<options>]
```

<a name="description"></a>

# Description


_repograph_ is a program that generates a full package dependency list from a repository and outputs it in dot format.

<a name="options"></a>

### Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--repo &lt;repoid&gt;**</b>  
  Specify repo ids to query, can be specified multiple times (default is all enabled).
  .UNINDENT

<a name="examples"></a>

# Examples


Output dependency list from all enabled repositories:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repograph
    .ft P
.UNINDENT
.UNINDENT

Output dependency list from rawhide repository:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repograph --repoid rawhide
    .ft P
.UNINDENT
.UNINDENT

Output dependency list from rawhide and koji repository:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repo-graph --repoid rawhide --repoid koji
    .ft P
.UNINDENT
.UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

