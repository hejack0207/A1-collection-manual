# cargo\-package(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-package - Assemble the local package into a distributable tarball

<a name="synopsis"></a>

# Synopsis

```
cargo package [options]
```

<a name="description"></a>

# Description

This command will create a distributable, compressed **.crate** file with the
source code of the package in the current directory. The resulting file will
be stored in the **target/package** directory. This performs the following
steps:

\h'-04' 1.\h'+01'Load and check the current workspace, performing some basic checks.

\h'-04'·\h'+02'Path dependencies are not allowed unless they have a version key. Cargo
will ignore the path key for dependencies in published packages.
**dev-dependencies** do not have this restriction.

\h'-04' 2.\h'+01'Create the compressed **.crate** file.

\h'-04'·\h'+02'The original **Cargo.toml** file is rewritten and normalized.

\h'-04'·\h'+02'**[patch]**, **[replace]**, and **[workspace]** sections are removed from the
manifest.

\h'-04'·\h'+02'**Cargo.lock** is automatically included if the package contains an
executable binary or example target. **cargo-install**(1) will use the
packaged lock file if the **--locked** flag is used.

\h'-04'·\h'+02'A **.cargo\_vcs\_info.json** file is included that contains information
about the current VCS checkout hash if available (not included with
**--allow-dirty**).

\h'-04' 3.\h'+01'Extract the **.crate** file and build it to verify it can build.

\h'-04'·\h'+02'This will rebuild your package from scratch to ensure that it can be
built from a pristine state. The **--no-verify** flag can be used to skip
this step.

\h'-04' 4.\h'+01'Check that build scripts did not modify any source files.

The list of files included can be controlled with the **include** and **exclude**
fields in the manifest.

See _the reference_ &lt;https://doc.rust-lang.org/cargo/reference/publishing.html&gt; for more details about
packaging and publishing.

<a name="options"></a>

# Options


<a name="package-options"></a>

### Package Options


**-l**, 
**--list**
Print files included in a package without making one.

**--no-verify**
Don't verify the contents by building them.

**--no-metadata**
Ignore warnings about a lack of human-usable metadata (such as the description
or the license).

**--allow-dirty**
Allow working directories with uncommitted VCS changes to be packaged.

<a name="package-selection"></a>

### Package Selection

By default, when no package selection options are given, the packages selected
depend on the selected manifest file (based on the current working directory if
**--manifest-path** is not given). If the manifest is the root of a workspace then
the workspaces default members are selected, otherwise only the package defined
by the manifest will be selected.

The default members of a workspace can be set explicitly with the
**workspace.default-members** key in the root manifest. If this is not set, a
virtual workspace will include all workspace members (equivalent to passing
**--workspace**), and a non-virtual workspace will include only the root crate itself.

**-p** _spec_..., 
**--package** _spec_...
Package only the specified packages. See **cargo-pkgid**(1) for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like ***, ?** and **[]**. However, to avoid your shell accidentally 
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.

**--workspace**
Package all members in the workspace.

**--exclude** _SPEC_...
Exclude the specified packages. Must be used in conjunction with the
**--workspace** flag. This flag may be specified multiple times and supports
common Unix glob patterns like ***, ?** and **[]**. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.

<a name="compilation-options"></a>

### Compilation Options


**--target** _triple_
Package for the given architecture. The default is the host
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
Defaults to **target** in the root of the workspace.

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

<a name="manifest-options"></a>

### Manifest Options


**--manifest-path** _path_
Path to the **Cargo.toml** file. By default, Cargo searches for the
**Cargo.toml** file in the current directory or any parent directory.

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


\h'-04' 1.\h'+01'Create a compressed **.crate** file of the current package:

    cargo package

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-publish**(1)
