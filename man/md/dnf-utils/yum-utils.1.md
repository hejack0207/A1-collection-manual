# yum-utils(1) - classic YUM utilities implemented as CLI shims on top of DNF

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

The main purpose of these shims is ensuring backward compatibility with yum-3.

<a name="shell-commands"></a>

# Shell Commands

.INDENT 0.0

* <b>**debuginfo-install(1)**</b>  
  Install the associated debuginfo packages for a given package
  specification.
  Maps to **dnf debuginfo-install**.
* <b>**needs-restarting(1)**</b>  
  Check for running processes that should be restarted.
  Maps to **dnf needs-restarting**.
* <b>**find-repos-of-install**</b>  
  Report which repository the package was installed from.
  Part of core DNF functionality.
  Maps to **dnf list --installed**.
  See _List Command_ in **dnf(8)** for details.
* <b>**package-cleanup(1)**</b>  
  Clean up locally installed, duplicate, or orphaned packages.
* <b>**repo-graph(1)**</b>  
  Output a full package dependency graph in dot format.
  Maps to **dnf repograph**.
* <b>**repoclosure(1)**</b>  
  Display a list of unresolved dependencies for repositories.
  Maps to **dnf repoclosure**.
* <b>**repodiff(1)**</b>  
  Display a list of differences between two or more repositories.
  Maps to **dnf repodiff**.
* <b>**repomanage(1)**</b>  
  Manage a directory of rpm packages.
  Maps to **dnf repomanage**.
* <b>**repoquery**</b>  
  Searches the available DNF repositories for selected packages and displays
  the requested information about them.
  Part of core DNF functionality.
  Maps to **dnf repoquery**.
  See _Repoquery Command_ in **dnf(8)** for details.
* <b>**reposync(1)**</b>  
  Synchronize packages of a remote DNF repository to a local directory.
  Maps to **dnf reposync**.
* <b>**repotrack**</b>  
  Track packages and its dependencies and download them.
  Maps to **yumdownloader --resolve --alldeps**.
  See **yumdownloader(1)** for details.
* <b>**yum-builddep(1)**</b>  
  Install whatever is needed to build the given .src.rpm, .nosrc.rpm or .spec
  file.
  Maps to **dnf builddep**.
* <b>**yum-config-manager(1)**</b>  
  Manage main DNF configuration options, toggle which repositories are
  enabled or disabled, and add new repositories.
  Maps to **dnf config-manager**.
* <b>**yum-debug-dump(1)**</b>  
  Writes system RPM configuration to a dump file.
  Maps to **dnf debug-dump**.
* <b>**yum-debug-restore(1)**</b>  
  Restores system RPM configuration from a dump file.
  Maps to **dnf debug-restore**.
* <b>**yumdownloader(1)**</b>  
  Download binary or source packages.
  Maps to **dnf download**.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

