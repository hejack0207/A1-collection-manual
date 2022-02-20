# cargo\-publish(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-publish - Upload a package to the registry

<a name="synopsis"></a>

# Synopsis

```
cargo publish [options]
```

<a name="description"></a>

# Description

This command will create a distributable, compressed **.crate** file with the
source code of the package in the current directory and upload it to a
registry. The default registry is &lt;https://crates.io&gt;. This performs the
following steps:

\h'-04' 1.\h'+01'Performs a few checks, including:

\h'-04'·\h'+02'Checks the **package.publish** key in the manifest for restrictions on
which registries you are allowed to publish to.

\h'-04' 2.\h'+01'Create a **.crate** file by following the steps in **cargo-package**(1).

\h'-04' 3.\h'+01'Upload the crate to the registry. Note that the server will perform
additional checks on the crate.

This command requires you to be authenticated with either the **--token** option
or using **cargo-login**(1).

See _the reference_ &lt;https://doc.rust-lang.org/cargo/reference/publishing.html&gt; for more details about
packaging and publishing.

<a name="options"></a>

# Options


<a name="publish-options"></a>

### Publish Options


**--dry-run**
Perform all checks without uploading.

**--token** _token_
API token to use when authenticating. This overrides the token stored in
the credentials file (which is created by **cargo-login**(1)).

_Cargo config_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt; environment variables can be
used to override the tokens stored in the credentials file. The token for
crates.io may be specified with the **CARGO\_REGISTRY\_TOKEN** environment
variable. Tokens for other registries may be specified with environment
variables of the form **CARGO\_REGISTRIES\_NAME\_TOKEN** where **NAME** is the name
of the registry in all capital letters.

**--no-verify**
Don't verify the contents by building them.

**--allow-dirty**
Allow working directories with uncommitted VCS changes to be packaged.

**--index** _index_
The URL of the registry index to use.

**--registry** _registry_
Name of the registry to publish to. Registry names are defined in Cargo
config files &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;. If not specified, and there is a
_\f(BIpackage.publish_ &lt;https://doc.rust-lang.org/cargo/reference/manifest.html#the-publish-field&gt; field in
**Cargo.toml** with a single registry, then it will publish to that registry.
Otherwise it will use the default registry, which is defined by the
_\f(BIregistry.default_ &lt;https://doc.rust-lang.org/cargo/reference/config.html#registrydefault&gt; config key
which defaults to **crates-io**.

<a name="package-selection"></a>

### Package Selection

By default, the package in the current working directory is selected. The **-p**
flag can be used to choose a different package in a workspace.

**-p** _spec_, 
**--package** _spec_
The package to publish. See **cargo-pkgid**(1) for the SPEC
format.

<a name="compilation-options"></a>

### Compilation Options


**--target** _triple_
Publish for the given architecture. The default is the host
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


\h'-04' 1.\h'+01'Publish the current package:

    cargo publish

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-package**(1), **cargo-login**(1)
