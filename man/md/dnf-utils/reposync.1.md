# reposync(1) - redirecting to DNF reposync Plugin

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

Synchronize packages of a remote DNF repository to a local directory.

<a name="synopsis"></a>

# Synopsis

```

 dnf reposync [options]
```

<a name="description"></a>

# Description


_reposync_ makes local copies of remote repositories. Packages that are already present in the local directory are not downloaded again.

<a name="options"></a>

# Options


All general DNF options are accepted. Namely, the **--repoid** option can be used to specify the repositories to synchronize. See _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**-a &lt;architecture&gt;, --arch=&lt;architecture&gt;**</b>  
  Download only packages of given architectures (default is all architectures). Can be used multiple times.
* <b>**--delete**</b>  
  Delete local packages no longer present in repository.
* <b>**--download-metadata**</b>  
  Download all repository metadata. Downloaded copy is instantly usable as a repository, no need to run createrepo_c on it.
* <b>**-g, --gpgcheck**</b>  
  Remove packages that fail GPG signature checking after downloading. Exit code is **1** if at least one package was removed.
  Note that for repositories with **gpgcheck=0** set in their configuration the GPG signature is not checked even with this option used.
* <b>**-m, --downloadcomps**</b>  
  Also download and uncompress comps.xml. Consider using **--download-metadata** option which will download all available repository metadata.
* <b>**--metadata-path**</b>  
  Root path under which the downloaded metadata are stored. It defaults to **--download-path** value if not given.
* <b>**-n, --newest-only**</b>  
  Download only newest packages per-repo.
* <b>**--norepopath**</b>  
  Don't add the reponame to the download path. Can only be used when syncing a single repository (default is to add the reponame).
* <b>**-p &lt;download-path&gt;, --download-path=&lt;download-path&gt;**</b>  
  Root path under which the downloaded repositories are stored, relative to the current working directory. Defaults to the current working directory. Every downloaded repository has a subdirectory named after its ID under this path.
* <b>**--remote-time**</b>  
  Try to set the timestamps of the downloaded files to those on the remote side.
* <b>**--source**</b>  
  Download only source packages.
* <b>**-u, --urls**</b>  
  Just print urls of what would be downloaded, don't download.
  .UNINDENT

<a name="examples"></a>

# Examples

.INDENT 0.0

* <b>**dnf reposync --repoid=the\_repo**</b>  
  Synchronize all packages from the repository with id "the_repo". The synchronized copy is saved in "the_repo" subdirectory of the current working directory.
* <b>**dnf reposync -p /my/repos/path --repoid=the\_repo**</b>  
  Synchronize all packages from the repository with id "the_repo". In this case files are saved in "/my/repos/path/the_repo" directory.
* <b>**dnf reposync --repoid=the_repo --download-metadata**</b>  
  Synchronize all packages and metadata from "the_repo" repository.
  .UNINDENT

Repository synchronized with **--download-metadata** option can be directly used in DNF for example by using **--repofrompath** option:

**dnf --repofrompath=syncedrepo,the_repo --repoid=syncedrepo list --available**

<a name="see-also"></a>

# See Also

.INDENT 0.0

* ·  
  **dnf(8)**, DNF Command Reference
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

