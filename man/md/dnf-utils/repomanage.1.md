# repomanage(1) - redirecting to DNF repomanage Plugin

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

Manage a repository or a simple directory of rpm packages.

<a name="synopsis"></a>

# Synopsis

```

 dnf repomanage [<optional-options>] [<options>] <path>
```

<a name="description"></a>

# Description


_repomanage_ prints newest or older packages in a repository specified by &lt;path&gt; for easy piping to xargs or similar programs. In case &lt;path&gt; doesn't contain a valid repodata, it is searched for rpm packages which are then used instead.
If the repodata are present, _repomanage_ uses them as the source of truth, it doesn't verify that they match the present rpm packages. In fact, _repomanage_ can run with just the repodata, no rpm packages are needed.

In order to work correctly with modular packages, &lt;path&gt; has to contain repodata with modular metadata. If modular content is present, _repomanage_ prints packages from newest or older stream versions in addition to newest or older non-modular packages.

<a name="options"></a>

### Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.

The following options set what packages are displayed. These options are mutually exclusive, i.e. only one can be specified. If no option is specified, the newest packages are shown.
.INDENT 0.0

* <b>**--old**</b>  
  Show older packages (for a package or a stream show all versions except the newest one).
* <b>**--new**</b>  
  Show newest packages.
  .UNINDENT

The following options control how packages are displayed in the output:
.INDENT 0.0

* <b>**-s**, **--space**</b>  
  Print resulting set separated by space instead of newline.
* <b>**-k &lt;keep-number&gt;**, **--keep &lt;keep-number&gt;**</b>  
  Limit the resulting set to newest **&lt;keep-number&gt;** packages.
  .UNINDENT

<a name="examples"></a>

# Examples


Display newest packages in current repository (directory):
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repomanage --new .
    .ft P
.UNINDENT
.UNINDENT

Display 2 newest versions of each package in "home" directory:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repomanage --new --keep 2 ~/
    .ft P
.UNINDENT
.UNINDENT

Display oldest packages separated by space in current repository (directory):
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repomanage --old --space .
    .ft P
.UNINDENT
.UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

