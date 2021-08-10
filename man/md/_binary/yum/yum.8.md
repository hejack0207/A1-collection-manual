# yum(8) - redirecting to DNF Command Reference

4.2.23, Jul 27, 2020

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

<a name="synopsis"></a>

# Synopsis

```

 dnf [options] <command> [<args>...]
```

<a name="description"></a>

# Description


_DNF_ is the next upcoming major version of _YUM_, a package manager for RPM-based Linux
distributions. It roughly maintains CLI compatibility with YUM and defines a strict API for
extensions and plugins.

Plugins can modify or extend features of DNF or provide additional CLI commands on top of those
mentioned below. If you know the name of such a command (including commands mentioned below), you
may find/install the package which provides it using the appropriate virtual provide in the form of
**dnf-command(&lt;alias&gt;)**, where **&lt;alias&gt;** is the name of the command; e.g.\`\`dnf install
'dnf-command(versionlock)'\`\` installs a **versionlock** plugin. This approach also applies to
specifying dependencies of packages that require a particular DNF command.

Return values:
.INDENT 0.0

* ·  
  **0**  : Operation was successful.
* ·  
  **1**  : An error occurred, which was handled by dnf.
* ·  
  **3**  : An unknown unhandled error occurred during operation.
* ·  
  **100**: See _check-update_
* ·  
  **200**: There was a problem with acquiring or releasing of locks.
  .UNINDENT

Available commands:
.INDENT 0.0

* ·  
  _alias_
* ·  
  _autoremove_
* ·  
  _check_
* ·  
  _check-update_
* ·  
  _clean_
* ·  
  _deplist_
* ·  
  _distro-sync_
* ·  
  _downgrade_
* ·  
  _group_
* ·  
  _help_
* ·  
  _history_
* ·  
  _info_
* ·  
  _install_
* ·  
  _list_
* ·  
  _makecache_
* ·  
  _mark_
* ·  
  _module_
* ·  
  _provides_
* ·  
  _reinstall_
* ·  
  _remove_
* ·  
  _repoinfo_
* ·  
  _repolist_
* ·  
  _repoquery_
* ·  
  _repository-packages_
* ·  
  _search_
* ·  
  _shell_
* ·  
  _swap_
* ·  
  _updateinfo_
* ·  
  _upgrade_
* ·  
  _upgrade-minimal_
* ·  
  _upgrade-to_
  .UNINDENT

Additional information:
.INDENT 0.0

* ·  
  _Options_
* ·  
  _Specifying Packages_
* ·  
  _Specifying Exact Versions of Packages_
* ·  
  _Specifying Provides_
* ·  
  _Specifying Groups_
* ·  
  _Specifying Transactions_
* ·  
  _Metadata Synchronization_
* ·  
  _Configuration Files Replacement Policy_
* ·  
  _Files_
* ·  
  _See Also_
  .UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* <b>**-4**</b>  
  Resolve to IPv4 addresses only.
* <b>**-6**</b>  
  Resolve to IPv6 addresses only.
* <b>**--advisory=&lt;advisory&gt;, --advisories=&lt;advisory&gt;**</b>  
  Include packages corresponding to the advisory ID, Eg. FEDORA-2201-123.
  Applicable for the install, repoquery, updateinfo and upgrade commands.
* <b>**--allowerasing**</b>  
  Allow erasing of installed packages to resolve dependencies. This option could be used as an alternative to the **yum swap** command where packages to remove are not explicitly defined.
* <b>**--assumeno**</b>  
  Automatically answer no for all questions.
* <b>**-b, --best**</b>  
  Try the best available package versions in transactions. Specifically during _dnf upgrade_, which by default skips over updates that can not be installed for dependency reasons, the switch forces DNF to only consider the latest packages. When running into packages with broken dependencies, DNF will fail giving a reason why the latest version can not be installed.
* <b>**--bugfix**</b>  
  Include packages that fix a bugfix issue. Applicable for the install, repoquery, updateinfo and
  upgrade commands.
* <b>**--bz=&lt;bugzilla&gt;, --bzs=&lt;bugzilla&gt;**</b>  
  Include packages that fix a Bugzilla ID, Eg. 123123. Applicable for the install, repoquery,
  updateinfo and upgrade commands.
* <b>**-C, --cacheonly**</b>  
  Run entirely from system cache, don't update the cache and use it even in case it is expired.

DNF uses a separate cache for each user under which it executes. The cache for the root user is called the system cache. This switch allows a regular user read-only access to the system cache, which usually is more fresh than the user's and thus he does not have to wait for metadata sync.

* <b>**--color=&lt;color&gt;**</b>  
  Control whether color is used in terminal output. Valid values are **always**, **never** and **auto** (default).
* <b>**--comment=&lt;comment&gt;**</b>  
  Add a comment to the transaction history.
* <b>**-c &lt;config file&gt;, --config=&lt;config file&gt;**</b>  
  Configuration file location.
* <b>**--cve=&lt;cves&gt;, --cves=&lt;cves&gt;**</b>  
  Include packages that fix a CVE (Common Vulnerabilities and Exposures) ID
  (_http://cve.mitre.org/about/_), Eg. CVE-2201-0123. Applicable for the install, repoquery, updateinfo,
  and upgrade commands.
* <b>**-d &lt;debug level&gt;, --debuglevel=&lt;debug level&gt;**</b>  
  Debugging output level. This is an integer value between 0 (no additional information strings) and 10 (shows all debugging information, even that not understandable to the user), default is 2. Deprecated, use **-v** instead.
* <b>**--debugsolver**</b>  
  Dump data aiding in dependency solver debugging into **./debugdata**.
  .UNINDENT

**--disableexcludes=[all|main|&lt;repoid&gt;], --disableexcludepkgs=[all|main|&lt;repoid&gt;]**
.INDENT 0.0
.INDENT 3.5
Disable the configuration file excludes. Takes one of the following three options:
.INDENT 0.0

* ·  
  **all**, disables all configuration file excludes
* ·  
  **main**, disables excludes defined in the **[main]** section
* ·  
  **repoid**, disables excludes defined for the given repository
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* <b>**--disable, --set-disabled**</b>  
  Disable specified repositories (automatically saves). The option has to be used together with the
  **config-manager** command (dnf-plugins-core).
  .UNINDENT
  .INDENT 0.0
* <b>**--disableplugin=&lt;plugin names&gt;**</b>  
  Disable the listed plugins specified by names or globs.
* <b>**--disablerepo=&lt;repoid&gt;**</b>  
  Disable specific repositories by an id or a glob. This option is mutually exclusive with **--repo**.
* <b>**--downloaddir=&lt;path&gt;, --destdir=&lt;path&gt;**</b>  
  Redirect downloaded packages to provided directory. The option has to be used together with the -_-downloadonly_ command line option, with the
  **download** command (dnf-plugins-core) or with the **system-upgrade** command
  (dnf-plugins-extras).
  .UNINDENT
  .INDENT 0.0
* <b>**--downloadonly**</b>  
  Download the resolved package set without performing any rpm transaction (install/upgrade/erase).
* <b>**-e &lt;error level&gt;, --errorlevel=&lt;error level&gt;**</b>  
  Error output level. This is an integer value between 0 (no error output) and
  10 (shows all error messages), default is 3. Deprecated, use **-v** instead.
* <b>**--enable, --set-enabled**</b>  
  Enable specified repositories (automatically saves). The option has to be used together with the
  **config-manager** command (dnf-plugins-core).
* <b>**--enableplugin=&lt;plugin names&gt;**</b>  
  Enable the listed plugins specified by names or globs.
* <b>**--enablerepo=&lt;repoid&gt;**</b>  
  Enable additional repositories by an id or a glob.
* <b>**--enhancement**</b>  
  Include enhancement relevant packages. Applicable for the install, repoquery, updateinfo and
  upgrade commands.
  .UNINDENT
  .INDENT 0.0
* <b>**-x &lt;package-file-spec&gt;, --exclude=&lt;package-file-spec&gt;**</b>  
  Exclude packages specified by **&lt;package-file-spec&gt;** from the operation.
* <b>**--excludepkgs=&lt;package-file-spec&gt;**</b>  
  Deprecated option. It was replaced by the -_-exclude_ option.
* <b>**--forcearch=&lt;arch&gt;**</b>  
  Force the use of an architecture. Any architecture can be specified.
  However, use of an architecture not supported natively by your CPU will
  require emulation of some kind. This is usually through QEMU. The behavior of **--forcearch**
  can be configured by using the arch and ignorearch
  configuration options with values **&lt;arch&gt;** and **True** respectively.
* <b>**-h, --help, --help-cmd**</b>  
  Show the help.
  .UNINDENT
  .INDENT 0.0
* <b>**--installroot=&lt;path&gt;**</b>  
  Specifies an alternative installroot, relative to where all packages will be
  installed. Think of this like doing **chroot &lt;root&gt; dnf**, except using
  **--installroot** allows dnf to work before the chroot is created. It requires absolute path.
  .UNINDENT
  .INDENT 0.0
* ·  
  _cachedir_, _log files_, _releasever_, and _gpgkey_ are taken from or
  stored in the installroot. _Gpgkeys_ are imported into the installroot from
  a path relative to the host which can be specified in the repository section
  of configuration files.
* ·  
  _configuration file_ and reposdir are searched inside the installroot first. If
  they are not present, they are taken from the host system.
  Note:  When a path is specified within a command line argument
  (**--config=&lt;config file&gt;** in case of _configuration file_ and
  **--setopt=reposdir=&lt;reposdir&gt;** for _reposdir_) then this path is always
  relative to the host with no exceptions.
* ·  
  _vars_ are taken from the host system or installroot according to reposdir
  . When _reposdir_ path is specified within a command line argument, vars are taken from the
  installroot. When varsdir paths are specified within a command line
  argument (**--setopt=varsdir=&lt;reposdir&gt;**) then those path are always relative to the host with no
  exceptions.
* ·  
  The _pluginpath_ and _pluginconfpath_ are relative to the host.
  .UNINDENT
  .INDENT 0.0
  .INDENT 3.5
  Note: You may also want to use the command-line option
  **--releasever=&lt;release&gt;** when creating the installroot, otherwise the
  _$releasever_ value is taken from the rpmdb within the installroot (and thus
  it is empty at the time of creation and the transaction will fail). If **--releasever=/** is used, the
  releasever will be detected from the host (**/**) system. The new installroot path at the time of creation
  does not contain the _repository_, _releasever_ and _dnf.conf_ files.

On a modular system you may also want to use the
**--setopt=module\_platform\_id=&lt;module\_platform\_name:stream&gt;** command-line option when creating the installroot,
otherwise the module_platform_id value will be taken from the
**/etc/os-release** file within the installroot (and thus it will be empty at the time of creation, the modular
dependency could be unsatisfied and modules content could be excluded).

Installroot examples:
.INDENT 0.0

* <b>**dnf --installroot=&lt;installroot&gt; --releasever=&lt;release&gt; install system-release**</b>  
  Permanently sets the **releasever** of the system in the
  **&lt;installroot&gt;** directory to **&lt;release&gt;**.
* <b>**dnf --installroot=&lt;installroot&gt; --setopt=reposdir=&lt;path&gt; --config /path/dnf.conf upgrade**</b>  
  Upgrades packages inside the installroot from a repository described by
  **--setopt** using configuration from **/path/dnf.conf**.
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* <b>**--newpackage**</b>  
  Include newpackage relevant packages. Applicable for the install, repoquery, updateinfo and
  upgrade commands.
* <b>**--noautoremove**</b>  
  Disable removal of dependencies that are no longer used. It sets
  clean_requirements_on_remove configuration option to **False**.
* <b>**--nobest**</b>  
  Set best option to **False**, so that transactions are not limited to best candidates only.
* <b>**--nodocs**</b>  
  Do not install documentation. Sets the rpm flag 'RPMTRANS_FLAG_NODOCS'.
* <b>**--nogpgcheck**</b>  
  Skip checking GPG signatures on packages (if RPM policy allows).
* <b>**--noplugins**</b>  
  Disable all plugins.
  .UNINDENT
  .INDENT 0.0
* <b>**--obsoletes**</b>  
  This option has an effect on an install/update, it enables
  dnf's obsoletes processing logic. For more information see the
  obsoletes option.

This option also displays capabilities that the package obsoletes when used together with the _repoquery_ command.

Configuration Option: obsoletes

* <b>**-q, --quiet**</b>  
  In combination with a non-interactive command, shows just the relevant content. Suppresses messages notifying about the current state or actions of DNF.
* <b>**-R &lt;minutes&gt;, --randomwait=&lt;minutes&gt;**</b>  
  Maximum command wait time.
  .UNINDENT
  .INDENT 0.0
* <b>**--refresh**</b>  
  Set metadata as expired before running the command.
* <b>**--releasever=&lt;release&gt;**</b>  
  Configure DNF as if the distribution release was **&lt;release&gt;**. This can
  affect cache paths, values in configuration files and mirrorlist URLs.
  .UNINDENT
  .INDENT 0.0
* <b>**--repofrompath &lt;repo&gt;,&lt;path/url&gt;**</b>  
  Specify a repository to add to the repositories for this query.
  This option can be used multiple times.
  .UNINDENT
  .INDENT 0.0
* ·  
  The repository label is specified by **&lt;repo&gt;**.
* ·  
  The path or url to the repository is specified by **&lt;path/url&gt;**.
  It is the same path as a baseurl and can be also enriched by the
  repo variables.
* ·  
  The configuration for the repository can be adjusted using -_-setopt_=&lt;repo&gt;.&lt;option&gt;=&lt;value&gt;.
* ·  
  If you want to view only packages from this repository, combine this
  with the **--repo=&lt;repo&gt;** or **--disablerepo="*"** switches.
  .UNINDENT
  .INDENT 0.0
* <b>**--repo=&lt;repoid&gt;, --repoid=&lt;repoid&gt;**</b>  
  Enable just specific repositories by an id or a glob. Can be used multiple
  times with accumulative effect. It is basically a shortcut for
  **--disablerepo="*" --enablerepo=&lt;repoid&gt;** and is mutually exclusive with
  the **--disablerepo** option.
* <b>**--rpmverbosity=&lt;name&gt;**</b>  
  RPM debug scriptlet output level. Sets the debug level to **&lt;name&gt;** for RPM scriptlets.
  For available levels, see the **rpmverbosity** configuration option.
* <b>**--sec-severity=&lt;severity&gt;, --secseverity=&lt;severity&gt;**</b>  
  Includes packages that provide a fix for an issue of the specified severity.
  Applicable for the install, repoquery, updateinfo and upgrade commands.
* <b>**--security**</b>  
  Includes packages that provide a fix for a security issue. Applicable for the
  upgrade command.
  .UNINDENT
  .INDENT 0.0
* <b>**--setopt=&lt;option&gt;=&lt;value&gt;**</b>  
  Override a configuration option from the configuration file. To override configuration options for repositories, use
  **repoid.option** for the **&lt;option&gt;**. Values for configuration options like **excludepkgs**, **includepkgs**,
  **installonlypkgs** and **tsflags** are appended to the original value, they do not override it. However, specifying
  an empty value (e.g. **--setopt=tsflags=**) will clear the option.
  .UNINDENT
  .INDENT 0.0
* <b>**--skip-broken**</b>  
  Resolve depsolve problems by removing packages that are causing problems from the transaction.
  It is an alias for the strict configuration option with value **False**.
  Additionally, with the _enable_ and
  _disable_ module subcommands it allows one to perform an action even in case of
  broken modular dependencies.
* <b>**--showduplicates**</b>  
  Show duplicate packages in repositories. Applicable for the list and search commands.
  .UNINDENT
  .INDENT 0.0
* <b>**-v, --verbose**</b>  
  Verbose operation, show debug messages.
* <b>**--version**</b>  
  Show DNF version and exit.
* <b>**-y, --assumeyes**</b>  
  Automatically answer yes for all questions.
  .UNINDENT

List options are comma-separated. Command-line options override respective settings from configuration files.

<a name="commands"></a>

# Commands


For an explanation of **&lt;package-spec&gt;** and **&lt;package-file-spec&gt;** see
_Specifying Packages_.

For an explanation of **&lt;package-nevr-spec&gt;** see
_Specifying Exact Versions of Packages_.

For an explanation of **&lt;provide-spec&gt;** see _Specifying Provides_.

For an explanation of **&lt;group-spec&gt;** see _Specifying Groups_.

For an explanation of **&lt;module-spec&gt;** see _Specifying Modules_.

For an explanation of **&lt;transaction-spec&gt;** see _Specifying Transactions_.

<a name="alias-command"></a>

### Alias Command


Allows the user to define and manage a list of aliases (in the form **&lt;name=value&gt;**),
which can be then used as dnf commands to abbreviate longer command sequences. For examples on using
the alias command, see _Alias Examples_. For examples on the alias
processing, see _Alias Processing Examples_.

To use an alias (name=value), the name must be placed as the first "command" (e.g. the first argument
that is not an option). It is then replaced by its value and the resulting sequence is again searched
for aliases. The alias processing stops when the first found command is not a name of any alias.

In case the processing would result in an infinite recursion, the original arguments are used instead.

Also, like in shell aliases, if the result starts with a **\e**, the alias processing will stop.

All aliases are defined in configuration files in the **/etc/dnf/aliases.d/** directory in the [aliases] section,
and aliases created by the alias command are written to the **USER.conf** file. In case of conflicts,
the **USER.conf** has the highest priority, and alphabetical ordering is used for the rest of the
configuration files.

Optionally, there is the **enabled** option in the **[main]** section defaulting to True. This can be set for each
file separately in the respective file, or globally for all aliases in the **ALIASES.conf** file.

**dnf alias [options] [list] [&lt;name&gt;...]**
.INDENT 0.0
.INDENT 3.5
List aliases with their final result. The **[&lt;alias&gt;...]** parameter further limits the result to only those aliases matching it.
.UNINDENT
.UNINDENT

**dnf alias [options] add &lt;name=value&gt;...**
.INDENT 0.0
.INDENT 3.5
Create new aliases.
.UNINDENT
.UNINDENT

**dnf alias [options] delete &lt;name&gt;...**
.INDENT 0.0
.INDENT 3.5
Delete aliases.
.UNINDENT
.UNINDENT

<a name="alias-examples"></a>

### Alias Examples

.INDENT 0.0

* <b>**dnf alias list**</b>  
  Lists all defined aliases.
* <b>**dnf alias add rm=remove**</b>  
  Adds a new command alias called **rm** which works the same as the **remove** command.
* <b>**dnf alias add upgrade="\eupgrade --skip-broken --disableexcludes=all --obsoletes"**</b>  
  Adds a new command alias called **upgrade** which works the same as the **upgrade** command,
  with additional options. Note that the original **upgrade** command is prefixed with a **\e**
  to prevent an infinite loop in alias processing.
  .UNINDENT

<a name="alias-processing-examples"></a>

### Alias Processing Examples


If there are defined aliases **in=install** and **FORCE="--skip-broken --disableexcludes=all"**:
.INDENT 0.0

* ·  
  **dnf FORCE in** will be replaced with **dnf --skip-broken --disableexcludes=all install**
* ·  
  **dnf in FORCE** will be replaced with **dnf install FORCE** (which will fail)
  .UNINDENT

If there is defined alias **in=install**:
.INDENT 0.0

* ·  
  **dnf in** will be replaced with **dnf install**
* ·  
  **dnf --repo updates in** will be replaced with **dnf --repo updates in** (which will fail)
  .UNINDENT

<a name="auto-remove-command"></a>

### Auto Remove Command


**dnf [options] autoremove**
.INDENT 0.0
.INDENT 3.5
Removes all "leaf" packages from the system that were originally installed as dependencies of user-installed packages, but which are no longer required by any such package.
.UNINDENT
.UNINDENT

Packages listed in installonlypkgs are never automatically removed by
this command.

**dnf [options] autoremove &lt;spec&gt;...**
.INDENT 0.0
.INDENT 3.5
This is an alias for the _Remove Command_ command with clean_requirements_on_remove set to
**True**. It removes the specified packages from the system along with any packages depending on the
packages being removed. Each **&lt;spec&gt;** can be either a **&lt;package-spec&gt;**, which specifies a
package directly, or a **@&lt;group-spec&gt;**, which specifies an (environment) group which contains
it. It also removes any dependencies that are no longer needed.

There are also a few specific autoremove commands **autoremove-n**, **autoremove-na** and
**autoremove-nevra** that allow the specification of an exact argument in the NEVRA
(name-epoch:version-release.architecture) format.
.UNINDENT
.UNINDENT

This command by default does not force a sync of expired metadata. See also _Metadata Synchronization_.

<a name="check-command"></a>

### Check Command


**dnf [options] check [--dependencies] [--duplicates] [--obsoleted] [--provides]**
.INDENT 0.0
.INDENT 3.5
Checks the local packagedb and produces information on any problems it
finds. You can limit the checks to be performed by using the **--dependencies**,
**--duplicates**, **--obsoleted** and **--provides** options (the default is to
check everything).
.UNINDENT
.UNINDENT

<a name="check-update-command"></a>

### Check\-Update Command


**dnf [options] check-update [--changelogs] [&lt;package-file-spec&gt;...]**
.INDENT 0.0
.INDENT 3.5
Non-interactively checks if updates of the specified packages are available. If no **&lt;package-file-spec&gt;** is given, checks whether any updates at all are available for your system. DNF exit code will be 100 when there are updates available and a list of the updates will be printed, 0 if not and 1 if an error occurs. If **--changelogs** option is specified, also changelog delta of packages about to be updated is printed.

Please note that having a specific newer version available for an installed package (and reported by **check-update**) does not imply that subsequent **dnf upgrade** will install it. The difference is that **dnf upgrade** has restrictions (like package dependencies being satisfied) to take into account.

The output is affected by the autocheck_running_kernel configuration option.
.UNINDENT
.UNINDENT

<a name="clean-command"></a>

### Clean Command


Performs cleanup of temporary files kept for repositories. This includes any
such data left behind from disabled or removed repositories as well as for
different distribution release versions.
.INDENT 0.0

* <b>**dnf clean dbcache**</b>  
  Removes cache files generated from the repository metadata. This forces DNF
  to regenerate the cache files the next time it is run.
* <b>**dnf clean expire-cache**</b>  
  Marks the repository metadata expired. DNF will re-validate the cache for
  each repository the next time it is used.
* <b>**dnf clean metadata**</b>  
  Removes repository metadata. Those are the files which DNF uses to determine
  the remote availability of packages. Using this option will make DNF
  download all the metadata the next time it is run.
* <b>**dnf clean packages**</b>  
  Removes any cached packages from the system.
* <b>**dnf clean all**</b>  
  Does all of the above.
  .UNINDENT

<a name="deplist-command"></a>

### Deplist command

.INDENT 0.0

* <b>**dnf [options] deplist [&lt;select-options&gt;] [&lt;query-options&gt;] [&lt;package-spec&gt;]**</b>  
  Alias for _dnf repoquery --deplist_.
  .UNINDENT

<a name="distro-sync-command"></a>

### Distro\-Sync command

.INDENT 0.0

* <b>**dnf distro-sync [&lt;package-spec&gt;...]**</b>  
  As necessary upgrades, downgrades or keeps selected installed packages to match
  the latest version available from any enabled repository. If no package is given, all installed packages are considered.

See also _Configuration Files Replacement Policy_.
.UNINDENT

<a name="distribution-synchronization-command"></a>

### Distribution\-Synchronization command

.INDENT 0.0

* <b>**dnf distribution-synchronization**</b>  
  Deprecated alias for the _Distro-Sync command_.
  .UNINDENT

<a name="downgrade-command"></a>

### Downgrade Command

.INDENT 0.0

* <b>**dnf [options] downgrade &lt;package-spec&gt;...**</b>  
  Downgrades the specified packages to the highest installable package of all known lower versions
  if possible. When version is given and is lower than version of installed package then it
  downgrades to target version.
  .UNINDENT

<a name="erase-command"></a>

### Erase Command

.INDENT 0.0

* <b>**dnf [options] erase &lt;spec&gt;...**</b>  
  Deprecated alias for the _Remove Command_.
  .UNINDENT

<a name="group-command"></a>

### Group Command


Groups are virtual collections of packages. DNF keeps track of groups that the user selected ("marked") installed and can manipulate the comprising packages with simple commands.
.INDENT 0.0

* <b>**dnf [options] group [summary] &lt;group-spec&gt;**</b>  
  Display overview of how many groups are installed and available. With a
  spec, limit the output to the matching groups. **summary** is the default
  groups subcommand.
* <b>**dnf [options] group info &lt;group-spec&gt;**</b>  
  Display package lists of a group. Shows which packages are installed or
  available from a repository when **-v** is used.
* <b>**dnf [options] group install [--with-optional] &lt;group-spec&gt;...**</b>  
  Mark the specified group installed and install packages it contains. Also
  include _optional_ packages of the group if **--with-optional** is
  specified. All _mandatory_ and _Default_ packages will be installed whenever possible.
  Conditional packages are installed if they meet their requirement.
  If the group is already (partially) installed, the command installs the missing packages from the group.
  Depending on the value of obsoletes configuration option group installation takes obsoletes into account.
  .UNINDENT
  .INDENT 0.0
* <b>**dnf [options] group list &lt;group-spec&gt;...**</b>  
  List all matching groups, either among installed or available groups. If
  nothing is specified, list all known groups. **--installed** and **--available** options narrow down the requested list.
  Records are ordered by the _display\_order_ tag defined in comps.xml file.
  Provides a list of all hidden groups by using option **--hidden**.
  Provides group IDs when the **-v** or **--ids** options are used.
* <b>**dnf [options] group remove &lt;group-spec&gt;...**</b>  
  Mark the group removed and remove those packages in the group from the system which do not belong to another installed group and were not installed explicitly by the user.
* <b>**dnf [options] group upgrade &lt;group-spec&gt;...**</b>  
  Upgrades the packages from the group and upgrades the group itself. The latter comprises of installing packages that were added to the group by the distribution and removing packages that got removed from the group as far as they were not installed explicitly by the user.
  .UNINDENT

Groups can also be marked installed or removed without physically manipulating any packages:
.INDENT 0.0

* <b>**dnf [options] group mark install &lt;group-spec&gt;...**</b>  
  Mark the specified group installed. No packages will be installed by this command, but the group is then considered installed.
* <b>**dnf [options] group mark remove &lt;group-spec&gt;...**</b>  
  Mark the specified group removed. No packages will be removed by this command.
  .UNINDENT

See also _Configuration Files Replacement Policy_.

<a name="groups-command"></a>

### Groups Command

.INDENT 0.0

* <b>**dnf [options] groups**</b>  
  Deprecated alias for the _Group Command_.
  .UNINDENT

<a name="help-command"></a>

### Help Command

.INDENT 0.0

* <b>**dnf help [&lt;command&gt;]**</b>  
  Displays the help text for all commands. If given a command name then only
  displays help for that particular command.
  .UNINDENT

<a name="history-command"></a>

### History Command


The history command allows the user to view what has happened in past
transactions and act according to this information (assuming the
**history\_record** configuration option is set).
.INDENT 0.0

* <b>**dnf history [list] [&lt;spec&gt;...]**</b>  
  The default history action is listing information about given transactions
  in a table. Each **&lt;spec&gt;** can be either a **&lt;transaction-spec&gt;**, which
  specifies a transaction directly, or a **&lt;transaction-spec&gt;..&lt;transaction-spec&gt;**,
  which specifies a range of transactions, or a **&lt;package-name-spec&gt;**,
  which specifies a transaction by a package which it manipulated. When no
  transaction is specified, list all known transactions.
* <b>**dnf history info [&lt;spec&gt;...]**</b>  
  Describe the given transactions. The meaning of **&lt;spec&gt;** is the same as
  in the _History List Command_. When no
  transaction is specified, describe what happened during the latest
  transaction.
  .UNINDENT
  .INDENT 0.0
* <b>**dnf history redo &lt;transaction-spec&gt;|&lt;package-file-spec&gt;**</b>  
  Repeat the specified transaction. Uses the last transaction (with the highest ID)
  if more than one transaction for given &lt;package-file-spec&gt; is found. If it is not possible
  to redo some operations due to the current state of RPMDB, it will not redo the transaction.
* <b>**dnf history rollback &lt;transaction-spec&gt;|&lt;package-file-spec&gt;**</b>  
  Undo all transactions performed after the specified transaction. Uses the last transaction
  (with the highest ID) if more than one transaction for given &lt;package-file-spec&gt; is found.
  If it is not possible to undo some transactions due to the current state of RPMDB, it will not undo
  any transaction.
* <b>**dnf history undo &lt;transaction-spec&gt;|&lt;package-file-spec&gt;**</b>  
  Perform the opposite operation to all operations performed in the specified transaction.
  Uses the last transaction (with the highest ID) if more than one transaction for given
  &lt;package-file-spec&gt; is found. If it is not possible to undo some operations due to
  the current state of RPMDB, it will not undo the transaction.
* <b>**dnf history userinstalled**</b>  
  Show all installonly packages, packages installed outside of DNF and packages not
  installed as dependency. I.e. it lists packages that will stay on the system when
  _Auto Remove Command_ or _Remove Command_ along with
  _clean\_requirements\_on\_remove_ configuration option set to True is executed. Note the same
  results can be accomplished with **dnf repoquery --userinstalled**, and the repoquery
  command is more powerful in formatting of the output.
  .UNINDENT

This command by default does not force a sync of expired metadata, except for
the redo, rollback, and undo subcommands.
See also _Metadata Synchronization_
and _Configuration Files Replacement Policy_.

<a name="info-command"></a>

### Info Command

.INDENT 0.0

* <b>**dnf [options] info [&lt;package-file-spec&gt;...]**</b>  
  Lists description and summary information about installed and available packages.
  .UNINDENT

The info command limits the displayed packages the same way as the _list command_.

This command by default does not force a sync of expired metadata. See also _Metadata Synchronization_.

<a name="install-command"></a>

### Install Command

.INDENT 0.0

* <b>**dnf [options] install &lt;spec&gt;...**</b>  
  Makes sure that the given packages and their dependencies are installed
  on the system. Each **&lt;spec&gt;** can be either a _&lt;package-spec&gt;_,
  or a @_&lt;module-spec&gt;_, or a @_&lt;group-spec&gt;_.
  See _Install Examples_.
  If a given package or provide cannot be (and is not already) installed,
  the exit code will be non-zero.
  If the **&lt;spec&gt;** matches both a @_&lt;module-spec&gt;_ and
  a @_&lt;group-spec&gt;_, only the module is installed.

When _&lt;package-spec&gt;_ to specify the exact version
of the package is given, DNF will install the desired version, no matter which
version of the package is already installed. The former version of the package
will be removed in the case of non-installonly package.

There are also a few specific install commands **install-n**, **install-na** and
**install-nevra** that allow the specification of an exact argument in the NEVRA format.

See also _Configuration Files Replacement Policy_.
.UNINDENT

<a name="install-examples"></a>

### Install Examples

.INDENT 0.0

* <b>**dnf install tito**</b>  
  Install the **tito** package (tito is the package name).
* <b>**dnf install ~/Downloads/tito-0.6.2-1.fc22.noarch.rpm**</b>  
  Install a local rpm file tito-0.6.2-1.fc22.noarch.rpm from the ~/Downloads/
  directory.
* <b>**dnf install tito-0.5.6-1.fc22**</b>  
  Install the package with a specific version. If the package is already installed it
  will automatically try to downgrade or upgrade to the specific version.
* <b>**dnf --best install tito**</b>  
  Install the latest available version of the package. If the package is already installed it
  will try to automatically upgrade to the latest version. If the latest version
  of the package cannot be installed, the installation will fail.
* <b>**dnf install vim**</b>  
  DNF will automatically recognize that vim is not a package name, but
  will look up and install a package that provides vim with all the required
  dependencies. Note: Package name match has precedence over package provides
  match.
* <b>**dnf install https://kojipkgs.fedoraproject.org//packages/tito/0.6.0/1.fc22/noarch/tito-0.6.0-1.fc22.noarch.rpm**</b>  
  Install a package directly from a URL.
* <b>**dnf install '@docker'**</b>  
  Install all default profiles of module 'docker' and their RPMs. Module streams get enabled accordingly.
* <b>**dnf install '@Web Server'**</b>  
  Install the 'Web Server' environmental group.
* <b>**dnf install /usr/bin/rpmsign**</b>  
  Install a package that provides the /usr/bin/rpmsign file.
* <b>**dnf -y install tito --setopt=install\_weak\_deps=False**</b>  
  Install the **tito** package (tito is the package name) without weak deps. Weak deps are not required for
  core functionality of the package, but they enhance the original package (like extended
  documentation, plugins, additional functions, etc.).
* <b>**dnf install --advisory=FEDORA-2018-b7b99fe852 \e***</b>  
  Install all packages that belong to the "FEDORA-2018-b7b99fe852" advisory.
  .UNINDENT

<a name="list-command"></a>

### List Command


Prints lists of packages depending on the packages' relation to the
system. A package is **installed** if it is present in the RPMDB, and it is **available**
if it is not installed but is present in a repository that DNF knows about.

The list command also limits the displayed packages according to specific criteria,
e.g. to only those that update an installed package (respecting the repository
priority). The exclude option in the configuration file can influence the
result, but if the -_-disableexcludes_ command line
option is used, it ensures that all installed packages will be listed.
.INDENT 0.0

* <b>**dnf [options] list [--all] [&lt;package-file-spec&gt;...]**</b>  
  Lists all packages, present in the RPMDB, in a repository or both.
* <b>**dnf [options] list --installed [&lt;package-file-spec&gt;...]**</b>  
  Lists installed packages.
* <b>**dnf [options] list --available [&lt;package-file-spec&gt;...]**</b>  
  Lists available packages.
* <b>**dnf [options] list --extras [&lt;package-file-spec&gt;...]**</b>  
  Lists extras, that is packages installed on the system that are not
  available in any known repository.
* <b>**dnf [options] list --obsoletes [&lt;package-file-spec&gt;...]**</b>  
  List packages installed on the system that are obsoleted by packages in
  any known repository.
* <b>**dnf [options] list --recent [&lt;package-file-spec&gt;...]**</b>  
  List packages recently added into the repositories.
* <b>**dnf [options] list --upgrades [&lt;package-file-spec&gt;...]**</b>  
  List upgrades available for the installed packages.
* <b>**dnf [options] list --autoremove**</b>  
  List packages which will be removed by the **dnf autoremove** command.
  .UNINDENT

This command by default does not force a sync of expired metadata. See also _Metadata Synchronization_.

<a name="localinstall-command"></a>

### Localinstall Command

.INDENT 0.0

* <b>**dnf [options] localinstall &lt;spec&gt;...**</b>  
  Deprecated alias for the _Install Command_.
  .UNINDENT

<a name="makecache-command"></a>

### Makecache Command

.INDENT 0.0

* <b>**dnf [options] makecache**</b>  
  Downloads and caches metadata for all known repos. Tries to
  avoid downloading whenever possible (e.g. when the local metadata hasn't
  expired yet or when the metadata timestamp hasn't changed).
* <b>**dnf [options] makecache --timer**</b>  
  Like plain **makecache**, but instructs DNF to be more resource-aware,
  meaning it will not do anything if running on battery power and will terminate
  immediately if it's too soon after the last successful **makecache** run
  (see **dnf.conf(5)**, metadata_timer_sync).
  .UNINDENT

<a name="mark-command"></a>

### Mark Command

.INDENT 0.0

* <b>**dnf mark install &lt;package-spec&gt;...**</b>  
  Marks the specified packages as installed by user. This can be useful if any package was installed as a dependency and is desired to stay on the system when _Auto Remove Command_ or _Remove Command_ along with _clean\_requirements\_on\_remove_ configuration option set to **True** is executed.
* <b>**dnf mark remove &lt;package-spec&gt;...**</b>  
  Unmarks the specified packages as installed by user. Whenever you as a user don't need a specific package you can mark it for removal. The package stays installed on the system but will be removed when _Auto Remove Command_ or _Remove Command_ along with _clean\_requirements\_on\_remove_ configuration option set to **True** is executed. You should use this operation instead of _Remove Command_ if you're not sure whether the package is a requirement of other user installed packages on the system.
* <b>**dnf mark group &lt;package-spec&gt;...**</b>  
  Marks the specified packages as installed by group. This can be useful if any package was
  installed as a dependency or a user and is desired to be protected and handled as a group
  member like during group remove.
  .UNINDENT

<a name="module-command"></a>

### Module Command


Modularity overview is available at man page dnf.modularity(7).
Module subcommands take _&lt;module-spec&gt;_... arguments that specify modules or profiles.
.INDENT 0.0

* <b>**dnf [options] module install &lt;module-spec&gt;...**</b>  
  Install module profiles, including their packages.
  In case no profile was provided, all default profiles get installed.
  Module streams get enabled accordingly.

This command cannot be used for switching module streams. It is recommended to remove all
installed content from the module and reset the module using the
_reset_ command. After you reset the module, you can install
the other stream.

* <b>**dnf [options] module update &lt;module-spec&gt;...**</b>  
  Update packages associated with an active module stream, optionally restricted to a profile.
  If the _profile\_name_ is provided, only the packages referenced by that profile will be updated.
* <b>**dnf [options] module remove &lt;module-spec&gt;...**</b>  
  Remove installed module profiles, including packages that were installed with the
  _dnf module install_ command. Will not remove packages
  required by other installed module profiles or by other user-installed packages.
  In case no profile was provided, all installed profiles get removed.
* <b>**dnf [options] module remove --all &lt;module-spec&gt;...**</b>  
  Remove installed module profiles, including packages that were installed with the
  _dnf module install_ command.
  With --all option it additionally removes all packages whose names are provided by specified
  modules. Packages required by other installed module profiles and packages whose names are also
  provided by any other module are not removed.
  .UNINDENT
  .INDENT 0.0
* <b>**dnf [options] module enable &lt;module-spec&gt;...**</b>  
  Enable a module stream and make the stream RPMs available in the package set.

Modular dependencies are resolved, dependencies checked and also recursively enabled. In case
of modular dependency issue the operation will be rejected. To perform the action anyway please use
-_-skip-broken_ option.

This command cannot be used for switching module streams. It is recommended to remove all
installed content from the module, and reset the module using the
_reset_ command. After you reset the module, you can enable
the other stream.
.UNINDENT
.INDENT 0.0

* <b>**dnf [options] module disable &lt;module-name&gt;...**</b>  
  Disable a module. All related module streams will become unavailable.
  Consequently, all installed profiles will be removed and the module RPMs
  will become unavailable in the package set. In case of modular
  dependency issue the operation will be rejected. To perform the action anyway please use -_-skip-broken_ option.
  .UNINDENT
  .INDENT 0.0
* <b>**dnf [options] module reset &lt;module-name&gt;...**</b>  
  Reset module state so it's no longer enabled or disabled.
  Consequently, all installed profiles will be removed and
  only RPMs from the default stream will be available in the package set.
  .UNINDENT
  .INDENT 0.0
* <b>**dnf [options] module provides &lt;package-name-spec&gt;...**</b>  
  Lists all modular packages matching **&lt;package-name-spec&gt;** from all modules (including disabled), along with the modules and streams they belong to.
* <b>**dnf [options] module list [--all] [module\_name...]**</b>  
  Lists all module streams, their profiles and states (enabled, disabled, default).
* <b>**dnf [options] module list --enabled [module\_name...]**</b>  
  Lists module streams that are enabled.
* <b>**dnf [options] module list --disabled [module\_name...]**</b>  
  Lists module streams that are disabled.
* <b>**dnf [options] module list --installed [module\_name...]**</b>  
  List module streams with installed profiles.
* <b>**dnf [options] module info &lt;module-spec&gt;...**</b>  
  Print detailed information about given module stream.
* <b>**dnf [options] module info --profile &lt;module-spec&gt;...**</b>  
  Print detailed information about given module profiles.
* <b>**dnf [options] module repoquery &lt;module-spec&gt;...**</b>  
  List all available packages belonging to selected modules.
* <b>**dnf [options] module repoquery --available &lt;module-spec&gt;...**</b>  
  List all available packages belonging to selected modules.
* <b>**dnf [options] module repoquery --installed &lt;module-spec&gt;...**</b>  
  List all installed packages with same name like packages belonging to selected modules.
  .UNINDENT

<a name="provides-command"></a>

### Provides Command

.INDENT 0.0

* <b>**dnf [options] provides &lt;provide-spec&gt;**</b>  
  Finds the packages providing the given **&lt;provide-spec&gt;**. This is useful
  when one knows a filename and wants to find what package (installed or not)
  provides this file.
  The **&lt;provide-spec&gt;** is gradually looked for at following locations:
  .INDENT 7.0
* 1.  
  The **&lt;provide-spec&gt;** is matched with all file provides of any available package:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    $ dnf provides /usr/bin/gzip
    gzip-1.9-9.fc29.x86_64 : The GNU data compression program
    Matched from:
    Filename    : /usr/bin/gzip
    .ft P
.UNINDENT
.UNINDENT

* 2.  
  Then all provides of all available packages are searched:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    $ dnf provides "gzip(x86-64)"
    gzip-1.9-9.fc29.x86_64 : The GNU data compression program
    Matched from:
    Provide     : gzip(x86-64) = 1.9-9.fc29
    .ft P
.UNINDENT
.UNINDENT

* 3.  
  DNF assumes that the **&lt;provide-spec&gt;** is a system command, prepends it with **/usr/bin/**, **/usr/sbin/** prefixes (one at a time) and does the file provides search again. For legacy reasons (packages that didn't do UsrMove) also **/bin** and **/sbin** prefixes are being searched:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    $ dnf provides zless
    gzip-1.9-9.fc29.x86_64 : The GNU data compression program
    Matched from:
    Filename    : /usr/bin/zless
    .ft P
.UNINDENT
.UNINDENT

* 4.  
  If this last step also fails, DNF returns "Error: No Matches found".
  .UNINDENT

This command by default does not force a sync of expired metadata. See also _Metadata Synchronization_.
.UNINDENT

<a name="reinstall-command"></a>

### Reinstall Command

.INDENT 0.0

* <b>**dnf [options] reinstall &lt;package-spec&gt;...**</b>  
  Installs the specified packages, fails if some of the packages are either
  not installed or not available (i.e. there is no repository where to
  download the same RPM).
  .UNINDENT

<a name="remove-command"></a>

### Remove Command

.INDENT 0.0

* <b>**dnf [options] remove &lt;package-spec&gt;...**</b>  
  Removes the specified packages from the system along with any packages depending on the packages being removed. Each **&lt;spec&gt;** can be either a **&lt;package-spec&gt;**, which specifies a package directly, or a **@&lt;group-spec&gt;**, which specifies an (environment) group which contains it. If **clean\_requirements\_on\_remove** is enabled (the default), also removes any dependencies that are no longer needed.
* <b>**dnf [options] remove --duplicates**</b>  
  Removes older versions of duplicate packages. To ensure the integrity of the system it
  reinstalls the newest package. In some cases the command cannot resolve conflicts. In such cases
  the _dnf shell_ command with **remove --duplicates** and **upgrade**
  dnf-shell sub-commands could help.
* <b>**dnf [options] remove --oldinstallonly**</b>  
  Removes old installonly packages, keeping only latest versions and version of running kernel.

There are also a few specific remove commands **remove-n**, **remove-na** and **remove-nevra**
that allow the specification of an exact argument in the NEVRA format.
.UNINDENT

<a name="remove-examples"></a>

### Remove Examples

.INDENT 0.0

* <b>**dnf remove acpi tito**</b>  
  Remove the **acpi** and **tito** packages.
* <b>**dnf remove $(dnf repoquery --extras --exclude=tito,acpi)**</b>  
  Remove packages not present in any repository, but don't remove the **tito**
  and **acpi** packages (they still might be removed if they depend on some of the removed packages).
  .UNINDENT

Remove older versions of duplicated packages (an equivalent of yum's _package-cleanup --cleandups_):
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf remove --duplicates
    .ft P
.UNINDENT
.UNINDENT

<a name="repoinfo-command"></a>

### Repoinfo Command

.INDENT 0.0
.INDENT 3.5
An alias for the _repolist_ command
that provides more detailed information like **dnf repolist -v**.
.UNINDENT
.UNINDENT

<a name="repolist-command"></a>

### Repolist Command

.INDENT 0.0

* <b>**dnf [options] repolist [--enabled|--disabled|--all]**</b>  
  Depending on the exact command lists enabled, disabled or all known
  repositories. Lists all enabled repositories by default. Provides more
  detailed information when **-v** option is used.
  .UNINDENT

This command by default does not force a sync of expired metadata. See also _Metadata Synchronization_.

<a name="repoquery-command"></a>

### Repoquery Command

.INDENT 0.0

* <b>**dnf [options] repoquery [&lt;select-options&gt;] [&lt;query-options&gt;] [&lt;package-file-spec&gt;]**</b>  
  Searches available DNF repositories for selected packages and displays the requested information about them. It
  is an equivalent of **rpm -q** for remote repositories.
* <b>**dnf [options] repoquery --querytags**</b>  
  Provides the list of tags recognized by the -_-queryformat_ repoquery option.

There are also a few specific repoquery commands **repoquery-n**, **repoquery-na** and **repoquery-nevra**
that allow the specification of an exact argument in the NEVRA format (does not affect arguments of options like --whatprovides &lt;arg&gt;, ...).
.UNINDENT

<a name="select-options"></a>

### Select Options


Together with **&lt;package-file-spec&gt;**, control what packages are displayed in the output. If **&lt;package-file-spec&gt;** is given, limits the resulting set of
packages to those matching the specification. All packages are considered if no **&lt;package-file-spec&gt;** is specified.
.INDENT 0.0

* <b>**&lt;package-file-spec&gt;**</b>  
  Package specification in the NEVRA format (name[-[epoch:]version[-release]][.arch]), a package provide or a file provide. See _Specifying Packages_.
* <b>**-a**, **--all**</b>  
  Query all packages (for rpmquery compatibility, also a shorthand for repoquery '*' or repoquery
  without arguments).
* <b>**--arch &lt;arch&gt;[,&lt;arch&gt;...], --archlist &lt;arch&gt;[,&lt;arch&gt;...]**</b>  
  Limit the resulting set only to packages of selected architectures (default is all
  architectures). In some cases the result is affected by the basearch of the running system, therefore
  to run repoquery for an arch incompatible with your system use the **--forcearch=&lt;arch&gt;**
  option to change the basearch.
* <b>**--duplicates**</b>  
  Limit the resulting set to installed duplicate packages (i.e. more package versions
  for the same name and architecture). Installonly packages are excluded from this set.
* <b>**--unneeded**</b>  
  Limit the resulting set to leaves packages that were installed as dependencies so they are no longer needed. This
  switch lists packages that are going to be removed after executing the **dnf autoremove** command.
* <b>**--available**</b>  
  Limit the resulting set to available packages only (set by default).
* <b>**--disable-modular-filtering**</b>  
  Disables filtering of modular packages, so that packages of inactive module streams are included in the result.
* <b>**--extras**</b>  
  Limit the resulting set to packages that are not present in any of the available repositories.
* <b>**-f &lt;file&gt;**, **--file &lt;file&gt;**</b>  
  Limit the resulting set only to the package that owns **&lt;file&gt;**.
* <b>**--installed**</b>  
  Limit the resulting set to installed packages only. The exclude option in the configuration file
  might influence the result, but if the command line option  -_-disableexcludes_ is used, it ensures that all installed packages will be listed.
* <b>**--installonly**</b>  
  Limit the resulting set to installed installonly packages.
* <b>**--latest-limit &lt;number&gt;**</b>  
  Limit the resulting set to &lt;number&gt; of latest packages for every package name and architecture.
  If &lt;number&gt; is negative, skip &lt;number&gt; of latest packages. For a negative &lt;number&gt; use the
  **--latest-limit=&lt;number&gt;** syntax.
* <b>**--recent**</b>  
  Limit the resulting set to packages that were recently edited.
* <b>**--repo &lt;repoid&gt;**</b>  
  Limit the resulting set only to packages from a repository identified by **&lt;repoid&gt;**.
  Can be used multiple times with accumulative effect.
* <b>**--unsatisfied**</b>  
  Report unsatisfied dependencies among installed packages (i.e. missing requires and
  and existing conflicts).
* <b>**--upgrades**</b>  
  Limit the resulting set to packages that provide an upgrade for some already installed package.
* <b>**--userinstalled**</b>  
  Limit the resulting set to packages installed by the user. The exclude option
  in the configuration file might influence the result, but if the command line option  -_-disableexcludes_ is used, it ensures that all installed packages will be listed.
  .UNINDENT
  .INDENT 0.0
* <b>**--whatdepends &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that require, enhance, recommend, suggest or
  supplement any of **&lt;capabilities&gt;**.
* <b>**--whatconflicts &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that conflict with any of **&lt;capabilities&gt;**.
* <b>**--whatenhances &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that enhance any of **&lt;capabilities&gt;**. Use -_-whatdepends_ if you want to list all depending packages.
* <b>**--whatobsoletes &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that obsolete any of **&lt;capabilities&gt;**.
* <b>**--whatprovides &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that provide any of **&lt;capabilities&gt;**.
* <b>**--whatrecommends &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that recommend any of **&lt;capabilities&gt;**. Use -_-whatdepends_ if you want to list all depending packages.
* <b>**--whatrequires &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that require any of **&lt;capabilities&gt;**. Use -_-whatdepends_ if you want to list all depending packages.
* <b>**--whatsuggests &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that suggest any of **&lt;capabilities&gt;**. Use -_-whatdepends_ if you want to list all depending packages.
* <b>**--whatsupplements &lt;capability&gt;[,&lt;capability&gt;...]**</b>  
  Limit the resulting set only to packages that supplement any of **&lt;capabilities&gt;**. Use -_-whatdepends_ if you want to list all depending packages.
* <b>**--alldeps**</b>  
  This option is stackable with **--whatrequires** or -_-whatdepends_ only. Additionally it adds all packages requiring
  the package features to the result set (used as default).
* <b>**--exactdeps**</b>  
  This option is stackable with **--whatrequires** or -_-whatdepends_ only. Limit the resulting set only to packages
  that require **&lt;capability&gt;** specified by --whatrequires.
* <b>**--srpm**</b>  
  Operate on the corresponding source RPM.
  .UNINDENT

<a name="query-options"></a>

### Query Options


Set what information is displayed about each package.

The following are mutually exclusive, i.e. at most one can be specified. If no query option is given, matching packages
are displayed in the standard NEVRA notation.
.INDENT 0.0

* <b>**-i, --info**</b>  
  Show detailed information about the package.
* <b>**-l, --list**</b>  
  Show the list of files in the package.
* <b>**-s, --source**</b>  
  Show the package source RPM name.
* <b>**--changelogs**</b>  
  Print the package changelogs.
* <b>**--conflicts**</b>  
  Display capabilities that the package conflicts with. Same as **--qf "%{conflicts}**.
* <b>**--depends**</b>  
  Display capabilities that the package depends on, enhances, recommends, suggests or
  supplements.
* <b>**--enhances**</b>  
  Display capabilities enhanced by the package. Same as **--qf "%{enhances}""**.
* <b>**--location**</b>  
  Show a location where the package could be downloaded from.
* <b>**--obsoletes**</b>  
  Display capabilities that the package obsoletes. Same as **--qf "%{obsoletes}"**.
* <b>**--provides**</b>  
  Display capabilities provided by the package. Same as **--qf "%{provides}"**.
* <b>**--recommends**</b>  
  Display capabilities recommended by the package. Same as **--qf "%{recommends}"**.
* <b>**--requires**</b>  
  Display capabilities that the package depends on. Same as **--qf "%{requires}"**.
* <b>**--requires-pre**</b>  
  Display capabilities that the package depends on for running a **%pre** script.
  Same as **--qf "%{requires-pre}"**.
* <b>**--suggests**</b>  
  Display capabilities suggested by the package. Same as **--qf "%{suggests}"**.
* <b>**--supplements**</b>  
  Display capabilities supplemented by the package. Same as **--qf "%{supplements}"**.
* <b>**--tree**</b>  
  Display a recursive tree of packages with capabilities specified by one of the following supplementary options:
  **--whatrequires**, **--requires**, **--conflicts**, **--enhances**, **--suggests**, **--provides**,
  **--supplements**, **--recommends**.
  .UNINDENT
  .INDENT 0.0
* <b>**--deplist**</b>  
  Produce a list of all direct dependencies and what packages provide those
  dependencies for the given packages. The result only shows the newest
  providers (which can be changed by using --verbose).
* <b>**--nvr**</b>  
  Show found packages in the name-version-release format. Same as
  **--qf "%{name}-%{version}-%{release}"**.
* <b>**--nevra**</b>  
  Show found packages in the name-epoch:version-release.architecture format. Same as
  **--qf "%{name}-%{epoch}:%{version}-%{release}.%{arch}"** (default).
* <b>**--envra**</b>  
  Show found packages in the epoch:name-version-release.architecture format. Same as
  **--qf "%{epoch}:%{name}-%{version}-%{release}.%{arch}"**
  .UNINDENT
  .INDENT 0.0
* <b>**--qf &lt;format&gt;**, **--queryformat &lt;format&gt;**</b>  
  Custom display format. **&lt;format&gt;** is the string to output for each matched package. Every occurrence of
  **%{&lt;tag&gt;}** within is replaced by the corresponding attribute of the package. The list of recognized tags can be displayed
  by running **dnf repoquery --querytags**.
* <b>**--recursive**</b>  
  Query packages recursively. Has to be used with **--whatrequires &lt;REQ&gt;**
  (optionally with **--alldeps**, but not with **--exactdeps**) or with
  **--requires &lt;REQ&gt; --resolve**.
* <b>**--resolve**</b>  
  resolve capabilities to originating package(s).
  .UNINDENT

<a name="examples"></a>

### Examples


Display NEVRAs of all available packages matching **light***:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery 'light*'
    .ft P
.UNINDENT
.UNINDENT

Display NEVRAs of all available packages matching name **light*** and architecture **noarch** (accepts only arguments in the "&lt;name&gt;.&lt;arch&gt;" format):
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery-na 'light*.noarch'
    .ft P
.UNINDENT
.UNINDENT

Display requires of all lighttpd packages:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --requires lighttpd
    .ft P
.UNINDENT
.UNINDENT

Display packages providing the requires of python packages:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --requires python --resolve
    .ft P
.UNINDENT
.UNINDENT

Display source rpm of ligttpd package:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --source lighttpd
    .ft P
.UNINDENT
.UNINDENT

Display package name that owns the given file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --file /etc/lighttpd/lighttpd.conf
    .ft P
.UNINDENT
.UNINDENT

Display name, architecture and the containing repository of all lighttpd packages:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --queryformat '%{name}.%{arch} : %{reponame}' lighttpd
    .ft P
.UNINDENT
.UNINDENT

Display all available packages providing "webserver":
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --whatprovides webserver
    .ft P
.UNINDENT
.UNINDENT

Display all available packages providing "webserver" but only for "i686" architecture:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --whatprovides webserver --arch i686
    .ft P
.UNINDENT
.UNINDENT

Display duplicate packages:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --duplicates
    .ft P
.UNINDENT
.UNINDENT

Display source packages that require a &lt;provide&gt; for a build:
.INDENT 0.0
.INDENT 3.5

    .ft C
    dnf repoquery --disablerepo="*" --enablerepo="*-source" --arch=src --whatrequires <provide>
    .ft P
.UNINDENT
.UNINDENT

<a name="repo-pkgs-command"></a>

### Repo\-Pkgs Command

.INDENT 0.0

* <b>**dnf [options] repo-pkgs**</b>  
  Deprecated alias for the _Repository-Packages Command_.
  .UNINDENT

<a name="repository-packages-command"></a>

### Repository\-Packages Command


The repository-packages command allows the user to run commands on top of all packages in the repository named **&lt;repoid&gt;**. However, any dependency resolution takes into account packages from all enabled repositories. The **&lt;package-file-spec&gt;** and **&lt;package-spec&gt;** specifications further limit the candidates to only those packages matching at least one of them.

The **info** subcommand lists description and summary information about packages depending on the packages' relation to the repository. The **list** subcommand just prints lists of those packages.
.INDENT 0.0

* <b>**dnf [options] repository-packages &lt;repoid&gt; check-update [&lt;package-file-spec&gt;...]**</b>  
  Non-interactively checks if updates of the specified packages in the repository are available. DNF exit code will be 100 when there are updates available and a list of the updates will be printed.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info [--all] [&lt;package-file-spec&gt;...]**</b>  
  List all related packages.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info --installed [&lt;package-file-spec&gt;...]**</b>  
  List packages installed from the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info --available [&lt;package-file-spec&gt;...]**</b>  
  List packages available in the repository but not currently installed on the system.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info --extras [&lt;package-file-specs&gt;...]**</b>  
  List packages installed from the repository that are not available in any repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info --obsoletes [&lt;package-file-spec&gt;...]**</b>  
  List packages in the repository that obsolete packages installed on the system.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info --recent [&lt;package-file-spec&gt;...]**</b>  
  List packages recently added into the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; info --upgrades [&lt;package-file-spec&gt;...]**</b>  
  List packages in the repository that upgrade packages installed on the system.
* <b>**dnf [options] repository-packages &lt;repoid&gt; install [&lt;package-spec&gt;...]**</b>  
  Install all packages in the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list [--all] [&lt;package-file-spec&gt;...]**</b>  
  List all related packages.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list --installed [&lt;package-file-spec&gt;...]**</b>  
  List packages installed from the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list --available [&lt;package-file-spec&gt;...]**</b>  
  List packages available in the repository but not currently installed on the system.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list --extras [&lt;package-file-spec&gt;...]**</b>  
  List packages installed from the repository that are not available in any repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list --obsoletes [&lt;package-file-spec&gt;...]**</b>  
  List packages in the repository that obsolete packages installed on the system.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list --recent [&lt;package-file-spec&gt;...]**</b>  
  List packages recently added into the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; list --upgrades [&lt;package-file-spec&gt;...]**</b>  
  List packages in the repository that upgrade packages installed on the system.
* <b>**dnf [options] repository-packages &lt;repoid&gt; move-to [&lt;package-spec&gt;...]**</b>  
  Reinstall all those packages that are available in the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; reinstall [&lt;package-spec&gt;...]**</b>  
  Run the **reinstall-old** subcommand. If it fails, run the **move-to** subcommand.
* <b>**dnf [options] repository-packages &lt;repoid&gt; reinstall-old [&lt;package-spec&gt;...]**</b>  
  Reinstall all those packages that were installed from the repository and simultaneously are available in the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; remove [&lt;package-spec&gt;...]**</b>  
  Remove all packages installed from the repository along with any packages depending on the packages being removed. If **clean\_requirements\_on\_remove** is enabled (the default) also removes any dependencies that are no longer needed.
* <b>**dnf [options] repository-packages &lt;repoid&gt; remove-or-distro-sync [&lt;package-spec&gt;...]**</b>  
  Select all packages installed from the repository. Upgrade, downgrade or keep those of them that are available in another repository to match the latest version available there and remove the others along with any packages depending on the packages being removed. If **clean\_requirements\_on\_remove** is enabled (the default) also removes any dependencies that are no longer needed.
* <b>**dnf [options] repository-packages &lt;repoid&gt; remove-or-reinstall [&lt;package-spec&gt;...]**</b>  
  Select all packages installed from the repository. Reinstall those of them that are available in another repository and remove the others along with any packages depending on the packages being removed. If **clean\_requirements\_on\_remove** is enabled (the default) also removes any dependencies that are no longer needed.
* <b>**dnf [options] repository-packages &lt;repoid&gt; upgrade [&lt;package-spec&gt;...]**</b>  
  Update all packages to the highest resolvable version available in the repository.
* <b>**dnf [options] repository-packages &lt;repoid&gt; upgrade-to &lt;package-nevr-specs&gt;...**</b>  
  Update packages to the specified versions that are available in the repository. Upgrade-to is
  a deprecated alias for the upgrade subcommand.
  .UNINDENT

<a name="search-command"></a>

### Search Command

.INDENT 0.0

* <b>**dnf [options] search [--all] &lt;keywords&gt;...**</b>  
  Search package metadata for keywords. Keywords are matched as case-insensitive substrings, globbing is supported.
  By default lists packages that match all requested keys (AND operation). Keys are searched in package names and summaries.
  If the "--all" option is used, lists packages that match at least one of the keys (an OR operation).
  In addition the keys are searched in the package descriptions and URLs.
  The result is sorted from the most relevant results to the least.
  .UNINDENT

This command by default does not force a sync of expired metadata. See also _Metadata Synchronization_.

<a name="shell-command"></a>

### Shell Command

.INDENT 0.0

* <b>**dnf [options] shell [filename]**</b>  
  Open an interactive shell for conducting multiple commands during a single execution of DNF. These commands can be issued manually
  or passed to DNF from a file. The commands are much the same as the normal DNF command line options. There are a few additional
  commands documented below.
  .INDENT 7.0
* <b>**config [conf-option] [value]**</b>  
  .INDENT 7.0
* ·  
  Set a configuration option to a requested value. If no value is given it prints the current value.
  .UNINDENT
* <b>**repo [list|enable|disable] [repo-id]**</b>  
  .INDENT 7.0
* ·  
  list: list repositories and their status
* ·  
  enable: enable repository
* ·  
  disable: disable repository
  .UNINDENT
* <b>**transaction [list|reset|solve|run]**</b>  
  .INDENT 7.0
* ·  
  list: resolve and list the content of the transaction
* ·  
  reset: reset the transaction
* ·  
  run: resolve and run the transaction
  .UNINDENT
  .UNINDENT

Note that all local packages must be used in the first shell transaction subcommand (e.g.
_install /tmp/nodejs-1-1.x86_64.rpm /tmp/acpi-1-1.noarch.rpm_) otherwise an error will occur.
Any _disable_, _enable_, and _reset_ module operations (e.g. _module enable nodejs_) must also
be performed before any other shell transaction subcommand is used.
.UNINDENT

<a name="swap-command"></a>

### Swap Command


**dnf [options] swap &lt;remove-spec&gt; &lt;install-spec&gt;**
.INDENT 0.0
.INDENT 3.5
Remove spec and install spec in one transaction. Each **&lt;spec&gt;** can be either a
_&lt;package-spec&gt;_, which specifies a package directly, or a
**@&lt;group-spec&gt;**, which specifies an (environment) group which contains it. Automatic
conflict solving is provided in DNF by the --allowerasing option that provides the functionality of the swap
command automatically.
.UNINDENT
.UNINDENT

<a name="update-command"></a>

### Update Command

.INDENT 0.0

* <b>**dnf [options] update**</b>  
  Deprecated alias for the _Upgrade Command_.
  .UNINDENT

<a name="updateinfo-command"></a>

### Updateinfo Command

.INDENT 0.0

* <b>**dnf [options] updateinfo [--summary|--list|--info] [&lt;availability&gt;] [&lt;spec&gt;...]**</b>  
  Display information about update advisories.

Depending on the output type, DNF displays just counts of advisory types
(omitted or **--summary**), list of advisories (**--list**) or detailed
information (**--info**). The **-v** option extends the output. When
used with **--info**, the information is even more detailed. When used
with **--list**, an additional column with date of the last advisory update
is added.

**&lt;availability&gt;** specifies whether advisories about newer versions of
installed packages (omitted or **--available**), advisories about equal and
older versions of installed packages (**--installed**), advisories about
newer versions of those installed packages for which a newer version is
available (**--updates**) or advisories about any versions of installed
packages (**--all**) are taken into account. Most of the time, **--available**
and **--updates** displays the same output. The outputs differ only in the
cases when an advisory refers to a newer version but there is no enabled
repository which contains any newer version.

Note, that **--available** tooks only the latest installed versions of
packages into account. In case of the kernel packages (when multiple
version could be installed simultaneously) also packages of the currently
running version of kernel are added.

To print only advisories referencing a CVE or a bugzilla use **--with-cve** or
**--with-bz** options. When these switches are used also the output
of the **--list** is altered - the ID of the CVE or the bugzilla is printed
instead of the one of the advisory.

If given and if neither ID, type (**bugfix**, **enhancement**,
**security**/**sec**) nor a package name of an advisory matches
**&lt;spec&gt;**, the advisory is not taken into account. The matching is
case-sensitive and in the case of advisory IDs and package names, globbing
is supported.

Output of the **--summary** option is affected by the autocheck_running_kernel configuration option.
.UNINDENT

<a name="update-minimal-command"></a>

### Update\-Minimal Command

.INDENT 0.0

* <b>**dnf [options] update-minimal**</b>  
  Deprecated alias for the _Upgrade-Minimal Command_.
  .UNINDENT

<a name="upgrade-command"></a>

### Upgrade Command

.INDENT 0.0

* <b>**dnf [options] upgrade**</b>  
  Updates each package to the latest version that is both available and
  resolvable.
* <b>**dnf [options] upgrade &lt;package-spec&gt;...**</b>  
  Updates each specified package to the latest available version. Updates
  dependencies as necessary.
* <b>**dnf [options] upgrade &lt;package-nevr-specs&gt;...**</b>  
  Upgrades packages to the specified versions.
* <b>**dnf [options] upgrade @&lt;spec&gt;...**</b>  
  Alias for the _dnf module update_ command.
  .UNINDENT

If the main **obsoletes** configure option is true or the **--obsoletes** flag
is present, dnf will include package obsoletes in its calculations.
For more information see obsoletes.

See also _Configuration Files Replacement Policy_.

<a name="upgrade-minimal-command"></a>

### Upgrade\-Minimal Command

.INDENT 0.0

* <b>**dnf [options] upgrade-minimal**</b>  
  Updates each package to the latest available version that provides a bugfix, enhancement
  or a fix for a security issue (security).
* <b>**dnf [options] upgrade-minimal &lt;package-spec&gt;...**</b>  
  Updates each specified package to the latest available version that provides
  a bugfix, enhancement or a fix for security issue (security). Updates
  dependencies as necessary.
  .UNINDENT

<a name="update-to-command"></a>

### Update\-To Command

.INDENT 0.0

* <b>**dnf [options] update-to &lt;package-nevr-specs&gt;...**</b>  
  Deprecated alias for the _Upgrade Command_.
  .UNINDENT

<a name="upgrade-to-command"></a>

### Upgrade\-To Command

.INDENT 0.0

* <b>**dnf [options] upgrade-to &lt;package-nevr-specs&gt;...**</b>  
  Deprecated alias for the _Upgrade Command_.
  .UNINDENT

<a name="specifying-packages"></a>

# Specifying Packages


Many commands take a **&lt;package-spec&gt;** parameter that selects a package for
the operation. The **&lt;package-spec&gt;** argument is matched against package
NEVRAs, provides and file provides.

**&lt;package-file-spec&gt;** is similar to **&lt;package-spec&gt;**, except provides
matching is not performed. Therefore, **&lt;package-file-spec&gt;** is matched only
against NEVRAs and file provides.

**&lt;package-name-spec&gt;** is matched against NEVRAs only.

<a name="globs"></a>

### Globs


Package specification supports the same glob pattern matching that shell does,
in all three above mentioned packages it matches against (NEVRAs, provides and
file provides).

The following patterns are supported:
.INDENT 0.0

* **<b>\*</b>**  
  Matches any number of characters.
* <b>**?**</b>  
  Matches any single character.
* <b>**[]**</b>  
  Matches any one of the enclosed characters. A pair of characters separated
  by a hyphen denotes a range expression; any character that falls between
  those two characters, inclusive, is matched. If the first character
  following the **[** is a **!** or a **^** then any character not enclosed
  is matched.
* <b>**{}**</b>  
  Matches any of the comma separated list of enclosed strings.
  .UNINDENT

<a name="nevra-matching"></a>

### NEVRA Matching


When matching against NEVRAs, partial matching is supported. DNF tries to match
the spec against the following list of NEVRA forms (in decreasing order of
priority):
.INDENT 0.0

* ·  
  **name-[epoch:]version-release.arch**
* ·  
  **name.arch**
* ·  
  **name**
* ·  
  **name-[epoch:]version-release**
* ·  
  **name-[epoch:]version**
  .UNINDENT

Note that **name** can in general contain dashes (e.g. **package-with-dashes**).

The first form that matches any packages is used and the remaining forms are
not tried. If none of the forms match any packages, an attempt is made to match
the **&lt;package-spec&gt;** against full package NEVRAs. This is only relevant
if globs are present in the **&lt;package-spec&gt;**.

**&lt;package-spec&gt;** matches NEVRAs the same way **&lt;package-name-spec&gt;** does,
but in case matching NEVRAs fails, it attempts to match against provides and
file provides of packages as well.

You can specify globs as part of any of the five NEVRA components. You can also
specify a glob pattern to match over multiple NEVRA components (in other words,
to match across the NEVRA separators). In that case, however, you need to write
the spec to match against full package NEVRAs, as it is not possible to split
such spec into NEVRA forms.

<a name="specifying-exact-versions-of-packages"></a>

# Specifying Exact Versions of Packages


Commands accepting the **&lt;package-nevr-spec&gt;** parameter need not only the name
of the package, but also its version, release and optionally the
architecture. Further, the version part can be preceded by an epoch when it is
relevant (i.e. the epoch is non-zero).

<a name="specifying-provides"></a>

# Specifying Provides


**&lt;provide-spec&gt;** in command descriptions means the command operates on
packages providing the given spec. This can either be an explicit provide, an
implicit provide (i.e. name of the package) or a file provide. The selection is
case-sensitive and globbing is supported.

<a name="specifying-groups"></a>

# Specifying Groups


**&lt;group-spec&gt;** allows one to select (environment) groups a particular operation should work
on. It is a case insensitive string (supporting globbing characters) that is
matched against a group's ID, canonical name and name translated into the
current LC_MESSAGES locale (if possible).

<a name="specifying-modules"></a>

# Specifying Modules


**&lt;module-spec&gt;** allows one to select modules or profiles a particular operation should work
on.

It is in the form of **NAME:STREAM:VERSION:CONTEXT:ARCH/PROFILE** and supported partial forms are the following:
.INDENT 0.0

* ·  
  **NAME**
* ·  
  **NAME:STREAM**
* ·  
  **NAME:STREAM:VERSION**
* ·  
  **NAME:STREAM:VERSION:CONTEXT**
* ·  
  all above combinations with **::ARCH** (e.g. **NAME::ARCH**)
* ·  
  **NAME:STREAM:VERSION:CONTEXT:ARCH**
* ·  
  all above combinations with **/PROFILE** (e.g. **NAME/PROFILE**)
  .UNINDENT

In case stream is not specified, the enabled or the default stream is used, in this order. In case profile is not specified, the system default profile or the 'default' profile is used.

<a name="specifying-transactions"></a>

# Specifying Transactions


**&lt;transaction-spec&gt;** can be in one of several forms. If it is an integer, it
specifies a transaction ID. Specifying **last** is the same as specifying the ID
of the most recent transaction. The last form is **last-&lt;offset&gt;**, where
**&lt;offset&gt;** is a positive integer. It specifies offset-th transaction preceding
the most recent transaction.

<a name="package-filtering"></a>

# Package Filtering


Package filtering filters packages out from the available package set, making them invisible to most
of dnf commands. They cannot be used in a transaction. Packages can be filtered out by either
Exclude Filtering or Modular Filtering.

<a name="exclude-filtering"></a>

### Exclude Filtering


Exclude Filtering is a mechanism used by a user or by a DNF plugin to modify the set of available
packages. Exclude Filtering can be modified by either includepkgs or
excludepkgs configuration options in
configuration files. The -_-disableexcludes_
command line option can be used to override excludes from configuration files. In addition to
user-configured excludes, plugins can also extend the set of excluded packages. To disable excludes
from a DNF plugin you can use the -_-disableplugin_ command line option.

To disable all excludes for e.g. the install command you can use the following combination
of command line options:

**dnf --disableexcludes=all --disableplugin="*" install bash**

<a name="modular-filtering"></a>

### Modular Filtering


Please see the modularity documentation for details on how Modular
Filtering works.

With modularity, only RPM packages from **active** module streams are included in the available
package set. RPM packages from **inactive** module streams, as well as non-modular packages with
the same name or provides as a package from an **active** module stream, are filtered out. Modular
filtering is not applied to packages added from the command line, installed packages, or packages
from repositories with **module\_hotfixes=true** in their **.repo** file.

Disabling of modular filtering is not recommended, because it could cause the system to get into
a broken state. To disable modular filtering for a particular repository, specify
**module\_hotfixes=true** in the **.repo** file or use **--setopt=&lt;repo\_id&gt;.module\_hotfixes=true**.

To discover the module which contains an excluded package use
_dnf module provides_.

<a name="metadata-synchronization"></a>

# Metadata Synchronization


Correct operation of DNF depends on having access to up-to-date data from all enabled repositories but contacting remote mirrors on every operation considerably slows it down and costs bandwidth for both the client and the repository provider. The metadata_expire (see **dnf.conf(5)**) repository configuration option is used by DNF to determine whether a particular local copy of repository data is due to be re-synced. It is crucial that the repository providers set the option well, namely to a value where it is guaranteed that if particular metadata was available in time **T** on the server, then all packages it references will still be available for download from the server in time **T + metadata\_expire**.

To further reduce the bandwidth load, some of the commands where having up-to-date metadata is not critical (e.g. the **list** command) do not look at whether a repository is expired and whenever any version of it is locally available to the user's account, it will be used. For non-root use, see also the **--cacheonly** switch. Note that in all situations the user can force synchronization of all enabled repositories with the **--refresh** switch.

<a name="configuration-files-replacement-policy"></a>

# Configuration Files Replacement Policy


The updated packages could replace the old modified configuration files
with the new ones or keep the older files. Neither of the files are actually replaced.
To the conflicting ones RPM gives additional suffix to the origin name. Which file
should maintain the true name after transaction is not controlled by package manager
but is specified by each package itself, following packaging guideline.

<a name="files"></a>

# Files

.INDENT 0.0

* <b>**Cache Files**</b>  
  /var/cache/dnf
* <b>**Main Configuration**</b>  
  /etc/dnf/dnf.conf
* <b>**Repository**</b>  
  /etc/yum.repos.d/
  .UNINDENT

<a name="see-also"></a>

# See Also

.INDENT 0.0

* ·  
  **dnf.conf(5)**, DNF Configuration Reference
* ·  
  **dnf-PLUGIN(8)** for documentation on DNF plugins.
* ·  
  **dnf.modularity(7)**, Modularity overview.
* ·  
  _DNF_ project homepage (_https://github.com/rpm-software-management/dnf/_)
* ·  
  How to report a bug (_https://github.com/rpm-software-management/dnf/wiki/Bug-Reporting_)
* ·  
  _YUM_ project homepage (_http://yum.baseurl.org/_)
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in DNF source distribution.

<a name="copyright"></a>

# Copyright

2012-2020, Red Hat, Licensed under GPLv2+

