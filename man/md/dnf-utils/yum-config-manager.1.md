# yum-config-manager(1) - redirecting to DNF config-manager Plugin

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

Manage main and repository DNF configuration options, toggle which
repositories are enabled or disabled, and add new repositories.

<a name="synopsis"></a>

# Synopsis

```

 dnf config-manager [options] <section>...
```

<a name="arguments"></a>

# Arguments

.INDENT 0.0

* <b>**&lt;section&gt;**</b>  
  This argument can be used to explicitly select the configuration sections to manage.
  A section can either be **main** or a repoid.
  If not specified, the program will select the **main** section and each repoid
  used within any **--setopt** options.
  A repoid can be specified using globs.
  .UNINDENT

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--help-cmd**</b>  
  Show this help.
* <b>**--add-repo=URL**</b>  
  Add (and enable) the repo from the specified file or url. If it has to be added into installroot, combine it with
  **--setopt=reposdir=/&lt;installroot&gt;/etc/yum.repos.d** command-line option.
* <b>**--dump**</b>  
  Print dump of current configuration values to stdout.
* <b>**--set-disabled**, **--disable**</b>  
  Disable the specified repos (implies **--save**).
* <b>**--set-enabled**, **--enable**</b>  
  Enable the specified repos (implies **--save**).
* <b>**--save**</b>  
  Save the current options (useful with **--setopt**).
* <b>**--setopt=&lt;option&gt;=&lt;value&gt;**</b>  
  Set a configuration option. To set configuration options for repositories, use
  **repoid.option** for the **&lt;option&gt;**. Globs are supported in repoid.
  .UNINDENT

<a name="examples"></a>

# Examples

.INDENT 0.0

* <b>**dnf config-manager --add-repo http://example.com/some/additional.repo**</b>  
  Download additional.repo and store it in repodir.
* <b>**dnf config-manager --add-repo http://example.com/different/repo**</b>  
  Create new repo file with _http://example.com/different/repo_ as baseurl and enable it.
* <b>**dnf config-manager --dump**</b>  
  Display main DNF configuration.
* <b>**dnf config-manager --dump &lt;section&gt;**</b>  
  Display configuration of a repository identified by &lt;section&gt;.
* <b>**dnf config-manager --set-enabled &lt;repoid&gt;**</b>  
  Enable repository identified by &lt;repoid&gt; and make the change permanent.
* <b>**dnf config-manager --set-disabled &lt;repoid1&gt; &lt;repoid2&gt;**</b>  
  Disable repositories identified by &lt;repoid1&gt; and &lt;repoid2&gt;
* <b>**dnf config-manager --set-disabled &lt;repoid1&gt;,&lt;repoid2&gt;**</b>  
  Disable repositories identified by &lt;repoid1&gt; and &lt;repoid2&gt;
* <b>**dnf config-manager --save --setopt=*.proxy=http://proxy.example.com:3128/ &lt;repo1&gt; &lt;repo2&gt;**</b>  
  Update proxy setting in repositories with repoid &lt;repo1&gt; and &lt;repo2&gt; and make the change
  permanent.
* <b>**dnf config-manager --save --setopt=*-debuginfo.gpgcheck=0**</b>  
  Update gpgcheck setting in all repositories whose id ends with -debuginfo and make the change permanent.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

