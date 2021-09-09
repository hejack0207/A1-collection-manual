# repodiff(1) - redirecting to DNF repodiff Plugin

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

Display a list of differences between two or more repositories

<a name="synopsis"></a>

# Synopsis

```

 dnf repodiff [<options>]
```

<a name="description"></a>

# Description


_repodiff_ is a program which will list differences between two sets of repositories.  Note that by default only source packages are compared.

<a name="options"></a>

### Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--repo-old=&lt;repoid&gt;, -o &lt;repoid&gt;**</b>  
  Add a **&lt;repoid&gt;** as an old repository. It is possible to be used in conjunction with **--repofrompath** option. Can be specified multiple times.
* <b>**--repo-new=&lt;repoid&gt;, -n &lt;repoid&gt;**</b>  
  Add a **&lt;repoid&gt;** as a new repository. Can be specified multiple times.
* <b>**--archlist=&lt;arch&gt;, -a &lt;arch&gt;**</b>  
  Add architectures to change the default from just comparing source packages. Note that you can use a wildcard "*" for all architectures. Can be specified multiple times.
* <b>**--size, -s**</b>  
  Output additional data about the size of the changes.
* <b>**--compare-arch**</b>  
  Normally packages are just compared based on their name, this flag makes the comparison also use the arch. So foo.noarch and foo.x86_64 are considered to be a different packages.
* <b>**--simple**</b>  
  Output a simple one line message for modified packages.
* <b>**--downgrade**</b>  
  Split the data for modified packages between upgraded and downgraded packages.
  .UNINDENT

<a name="examples"></a>

# Examples


Compare source pkgs in two local repos:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repodiff --repofrompath=o,/tmp/repo-old --repofrompath=n,/tmp/repo-new --repo-old=o --repo-new=n
    .ft P
.UNINDENT
.UNINDENT

Compare x86_64 compat. binary pkgs in two remote repos, and two local one:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repodiff --repofrompath=o,http://example.com/repo-old --repofrompath=n,http://example.com/repo-new --repo-old=o --repo-new=n --archlist=x86_64
    .ft P
.UNINDENT
.UNINDENT

Compare x86_64 compat. binary pkgs, but also compare architecture:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repodiff --repofrompath=o,http://example.com/repo-old --repofrompath=n,http://example.com/repo-new --repo-old=o --repo-new=n --archlist=x86_64 --compare-arch
    .ft P
.UNINDENT
.UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

