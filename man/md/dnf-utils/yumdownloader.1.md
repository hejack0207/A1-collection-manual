# yumdownloader(1) - redirecting to DNF download Plugin

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

Download binary or source packages.

<a name="synopsis"></a>

# Synopsis

```

 dnf download [options] <pkg-spec>...
```

<a name="arguments"></a>

# Arguments

.INDENT 0.0

* <b>**&lt;pkg-spec&gt;**</b>  
  Package specification for the package to download.
  Local RPMs can be specified as well. This is useful with the **--source**
  option or if you want to download the same RPM again.
  .UNINDENT

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--help-cmd**</b>  
  Show this help.
* <b>**--arch &lt;arch&gt;[,&lt;arch&gt;...]**</b>  
  Limit the query to packages of given architectures (default is all compatible architectures with
  your system). To download packages with arch incompatible with your system use
  **--forcearch=&lt;arch&gt;** option to change basearch.
* <b>**--source**</b>  
  Download the source rpm. Enables source repositories of all enabled binary repositories.
* <b>**--debuginfo**</b>  
  Download the debuginfo rpm. Enables debuginfo repositories of all enabled binary repositories.
* <b>**--downloaddir**</b>  
  Download directory, default is the current directory (the directory must exist).
* <b>**--url**</b>  
  Instead of downloading, print list of urls where the rpms can be downloaded.
* <b>**--urlprotocol**</b>  
  Limit the protocol of the urls output by the --url option. Options are http, https, rsync, ftp.
* <b>**--resolve**</b>  
  Resolves dependencies of specified packages and downloads missing dependencies in the system.
* <b>**--alldeps**</b>  
  When used with **--resolve**, download all dependencies (do not skip already installed ones).
  .UNINDENT

<a name="examples"></a>

# Examples

.INDENT 0.0

* <b>**dnf download dnf**</b>  
  Download the latest dnf package to the current directory.
* <b>**dnf download --url dnf**</b>  
  Just print the remote location url where the dnf rpm can be downloaded from.
* <b>**dnf download --url --urlprotocols=https --urlprotocols=rsync dnf**</b>  
  Same as above, but limit urls to https or rsync urls.
* <b>**dnf download dnf --destdir /tmp/dnl**</b>  
  Download the latest dnf package to the /tmp/dnl directory (the directory must exist).
* <b>**dnf download dnf --source**</b>  
  Download the latest dnf source package to the current directory.
* <b>**dnf download rpm --debuginfo**</b>  
  Download the latest rpm-debuginfo package to the current directory.
* <b>**dnf download btanks --resolve**</b>  
  Download the latest btanks package and the uninstalled dependencies to the current directory.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

