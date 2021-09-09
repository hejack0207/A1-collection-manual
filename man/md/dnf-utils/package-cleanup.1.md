# package-cleanup(1) - clean up locally installed, duplicate, or orphaned packages.

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

A DNF-based shim imitating the original YUM-based package-cleanup utility.

<a name="synopsis"></a>

# Synopsis

```

 package-cleanup [options]
```

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--leaves**</b>  
  List leaf nodes in the local RPM database.
  Leaf nodes are RPMs that are not relied upon by any other RPM.
  Maps to **dnf repoquery --unneeded**.
* <b>**--orphans**</b>  
  List installed packages which are not available from currently configured
  repositories.
  Maps to **dnf repoquery --extras**.
* <b>**--problems**</b>  
  List dependency problems in the local RPM database.
  Maps to **dnf repoquery --unsatisfied**.
* <b>**--dupes**</b>  
  Scan for duplicates in the local RPM database.
  Maps to **dnf repoquery --duplicates**.
* <b>**--cleandupes**</b>  
  Scan for duplicates in the local RPM database and clean out the older
  versions.
  Maps to **dnf remove --duplicates**.
  .UNINDENT

<a name="examples"></a>

# Examples

.INDENT 0.0

* <b>**package-cleanup --problems**</b>  
  List all dependency problems.
* <b>**package-cleanup --orphans**</b>  
  List all packages that are not in any DNF repository.
* <b>**package-cleanup --cleandupes**</b>  
  Remove all packages that have a duplicate installed.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

