# repoclosure(1) - redirecting to DNF repoclosure Plugin

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

Display a list of unresolved dependencies for repositories.

<a name="synopsis"></a>

# Synopsis

```

 dnf repoclosure [<options>]
```

<a name="description"></a>

# Description


_repoclosure_ is a program that reads package metadata from one or more repositories, checks all dependencies, and displays a list of packages with unresolved dependencies.

<a name="options"></a>

### Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--arch &lt;arch&gt;**</b>  
  Query only packages for specified architecture, can be specified multiple times (default is all
  compatible architectures with your system). To run repoclosure for arch incompatible with your
  system use **--forcearch=&lt;arch&gt;** option to change basearch.
* <b>**--best**</b>  
  Check only the newest packages per arch.
* <b>**--check &lt;repoid&gt;**</b>  
  Specify repo ids to check, can be specified multiple times (default is all enabled).
* <b>**--newest**</b>  
  Check only the newest packages in the repos.
* <b>**--pkg &lt;pkg-spec&gt;**</b>  
  Check closure for this package only.
* <b>**--repo &lt;repoid&gt;**</b>  
  Specify repo ids to query, can be specified multiple times (default is all enabled).
  .UNINDENT

<a name="examples"></a>

# Examples


Display list of unresolved dependencies for all enabled repositories:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoclosure
    .ft P
.UNINDENT
.UNINDENT

Display list of unresolved dependencies for rawhide repository and packages with architecture noarch and x86_64:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoclosure --repo rawhide --arch noarch --arch x86_64
    .ft P
.UNINDENT
.UNINDENT

Display list of unresolved dependencies for zmap package from rawhide repository:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoclosure --repo rawhide --pkg zmap
    .ft P
.UNINDENT
.UNINDENT

Display list of unresolved dependencies for myrepo, an add-on for the rawhide repository:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoclosure --repo rawhide --check myrepo
    .ft P
.UNINDENT
.UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

