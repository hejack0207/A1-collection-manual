# cargo\-install(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-install - Build and install a Rust binary

<a name="synopsis"></a>

# Synopsis

```
cargo install [options] crate...
cargo install [options] --path path
cargo install [options] --git url [crate...]
cargo install [options] --list
```

<a name="description"></a>

# Description

This command manages Cargo's local set of installed binary crates. Only
packages which have executable **[[bin]]** or **[[example]]** targets can be
installed, and all executables are installed into the installation root's
**bin** folder.

The installation root is determined, in order of precedence:

\h'-04'·\h'+02'**--root** option

\h'-04'·\h'+02'**CARGO\_INSTALL\_ROOT** environment variable

\h'-04'·\h'+02'**install.root** Cargo _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;

\h'-04'·\h'+02'**CARGO\_HOME** environment variable

\h'-04'·\h'+02'**$HOME/.cargo**

There are multiple sources from which a crate can be installed. The default
location is crates.io but the **--git**, **--path**, and **--registry** flags can
change this source. If the source contains more than one package (such as
crates.io or a git repository with multiple crates) the _crate_ argument is
required to indicate which crate should be installed.

Crates from crates.io can optionally specify the version they wish to install
via the **--version** flags, and similarly packages from git repositories can
optionally specify the branch, tag, or revision that should be installed. If a
crate has multiple binaries, the **--bin** argument can selectively install only
one of them, and if you'd rather install examples the **--example** argument can
be used as well.

If the package is already installed, Cargo will reinstall it if the installed
version does not appear to be up-to-date. If any of the following values
change, then Cargo will reinstall the package:

\h'-04'·\h'+02'The package version and source.

\h'-04'·\h'+02'The set of binary names installed.

\h'-04'·\h'+02'The chosen features.

\h'-04'·\h'+02'The release mode (**--debug**).

\h'-04'·\h'+02'The target (**--target**).

Installing with **--path** will always build and install, unless there are
conflicting binaries from another package. The **--force** flag may be used to
force Cargo to always reinstall the package.

If the source is crates.io or **--git** then by default the crate will be built
in a temporary target directory. To avoid this, the target directory can be
specified by setting the **CARGO\_TARGET\_DIR** environment variable to a relative
path. In particular, this can be useful for caching build artifacts on
continuous integration systems.

By default, the **Cargo.lock** file that is included with the package will be
ignored. This means that Cargo will recompute which versions of dependencies
to use, possibly using newer versions that have been released since the
package was published. The **--locked** flag can be used to force Cargo to use
the packaged **Cargo.lock** file if it is available. This may be useful for
ensuring reproducible builds, to use the exact same set of dependencies that
were available when the package was published. It may also be useful if a
newer version of a dependency is published that no longer builds on your
system, or has other problems. The downside to using **--locked** is that you
will not receive any fixes or updates to any dependency. Note that Cargo did
not start publishing **Cargo.lock** files until version 1.37, which means
packages published with prior versions will not have a **Cargo.lock** file
available.

<a name="options"></a>

# Options


<a name="install-options"></a>

### Install Options


**--vers** _version_, 
**--version** _version_
Specify a version to install. This may be a version
requirement &lt;https://doc.rust-lang.org/cargo/reference/specifying-dependencies.md&gt;, like **~1.2**, to have Cargo
select the newest version from the given requirement. If the version does not
have a requirement operator (such as **^** or **~**), then it must be in the form
_MAJOR.MINOR.PATCH_, and will install exactly that version; it is _not_
treated as a caret requirement like Cargo dependencies are.

**--git** _url_
Git URL to install the specified crate from.

**--branch** _branch_
Branch to use when installing from git.

**--tag** _tag_
Tag to use when installing from git.

**--rev** _sha_
Specific commit to use when installing from git.

**--path** _path_
Filesystem path to local crate to install.

**--list**
List all installed packages and their versions.

**-f**, 
**--force**
Force overwriting existing crates or binaries. This can be used if a package
has installed a binary with the same name as another package. This is also
useful if something has changed on the system that you want to rebuild with,
such as a newer version of **rustc**.

**--no-track**
By default, Cargo keeps track of the installed packages with a metadata file
stored in the installation root directory. This flag tells Cargo not to use or
create that file. With this flag, Cargo will refuse to overwrite any existing
files unless the **--force** flag is used. This also disables Cargo's ability to
protect against multiple concurrent invocations of Cargo installing at the
same time.

**--bin** _name_...
Install only the specified binary.

**--bins**
Install all binaries.

**--example** _name_...
Install only the specified example.

**--examples**
Install all examples.

**--root** _dir_
Directory to install packages into.

**--registry** _registry_
Name of the registry to use. Registry names are defined in Cargo config
files &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;. If not specified, the default registry is used,
which is defined by the **registry.default** config key which defaults to
**crates-io**.

**--index** _index_
The URL of the registry index to use.

<a name="feature-selection"></a>

### Feature Selection

The feature flags allow you to control which features are enabled. When no
feature options are given, the **default** feature is activated for every
selected package.

See _the features documentation_ &lt;https://doc.rust-lang.org/cargo/reference/features.html#command-line-feature-options&gt;
for more details.

**--features** _features_
Space or comma separated list of features to activate. Features of workspace
members may be enabled with **package-name/feature-name** syntax. This flag may
be specified multiple times, which enables all specified features.

**--all-features**
Activate all available features of all selected packages.

**--no-default-features**
Do not activate the **default** feature of the selected packages.

<a name="compilation-options"></a>

### Compilation Options


**--target** _triple_
Install for the given architecture. The default is the host
architecture. The general format of the triple is
**&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;**. Run **rustc --print target-list** for a
list of supported targets.

This may also be specified with the **build.target**
_config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
_build cache_ &lt;https://doc.rust-lang.org/cargo/guide/build-cache.html&gt; documentation for more details.

**--target-dir** _directory_
Directory for all generated artifacts and intermediate files. May also be
specified with the **CARGO\_TARGET\_DIR** environment variable, or the
**build.target-dir** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.
Defaults to a new temporary folder located in the
temporary directory of the platform. 

When using **--path**, by default it will use **target** directory in the workspace
of the local crate unless **--target-dir**
is specified.

**--debug**
Build with the **dev** profile instead the **release** profile.

<a name="manifest-options"></a>

### Manifest Options


**--frozen**, 
**--locked**
Either of these flags requires that the **Cargo.lock** file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The **--frozen** flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.

These may be used in environments where you want to assert that the
**Cargo.lock** file is up-to-date (such as a CI build) or want to avoid network
access.

**--offline**
Prevents Cargo from accessing the network for any reason. Without this
flag, Cargo will stop with an error if it needs to access the network and
the network is not available. With this flag, Cargo will attempt to
proceed without the network if possible.

Beware that this may result in different dependency resolution than online
mode. Cargo will restrict itself to crates that are downloaded locally, even
if there might be a newer version as indicated in the local copy of the index.
See the **cargo-fetch**(1) command to download dependencies before going
offline.

May also be specified with the **net.offline** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

<a name="miscellaneous-options"></a>

### Miscellaneous Options


**-j** _N_, 
**--jobs** _N_
Number of parallel jobs to run. May also be specified with the
**build.jobs** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;. Defaults to
the number of CPUs.

<a name="display-options"></a>

### Display Options


**-v**, 
**--verbose**
Use verbose output. May be specified twice for "very verbose" output which
includes extra output such as dependency warnings and build script output.
May also be specified with the **term.verbose**
_config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

**-q**, 
**--quiet**
No output printed to stdout.

**--color** _when_
Control when colored output is used. Valid values:

\h'-04'·\h'+02'**auto** (default): Automatically detect if color support is available on the
terminal.

\h'-04'·\h'+02'**always**: Always display colors.

\h'-04'·\h'+02'**never**: Never display colors.

May also be specified with the **term.color**
_config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

<a name="common-options"></a>

### Common Options


**+**_toolchain_
If Cargo has been installed with rustup, and the first argument to **cargo**
begins with **+**, it will be interpreted as a rustup toolchain name (such
as **+stable** or **+nightly**).
See the _rustup documentation_ &lt;https://rust-lang.github.io/rustup/overrides.html&gt;
for more information about how toolchain overrides work.

**-h**, 
**--help**
Prints help information.

**-Z** _flag_
Unstable (nightly-only) flags to Cargo. Run **cargo -Z help** for details.

<a name="environment"></a>

# Environment

See _the reference_ &lt;https://doc.rust-lang.org/cargo/reference/environment-variables.html&gt; for
details on environment variables that Cargo reads.

<a name="exit-status"></a>

# Exit Status


\h'-04'·\h'+02'**0**: Cargo succeeded.

\h'-04'·\h'+02'**101**: Cargo failed to complete.

<a name="examples"></a>

# Examples


\h'-04' 1.\h'+01'Install or upgrade a package from crates.io:

    cargo install ripgrep

\h'-04' 2.\h'+01'Install or reinstall the package in the current directory:

    cargo install --path .

\h'-04' 3.\h'+01'View the list of installed packages:

    cargo install --list

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-uninstall**(1), **cargo-search**(1), **cargo-publish**(1)
