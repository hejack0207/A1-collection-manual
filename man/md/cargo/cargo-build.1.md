# cargo\-build(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-build - Compile the current package

<a name="synopsis"></a>

# Synopsis

```
cargo build [options]
```

<a name="description"></a>

# Description

Compile local packages and all of their dependencies.

<a name="options"></a>

# Options


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
Build only the specified packages. See **cargo-pkgid**(1) for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like ***, ?** and **[]**. However, to avoid your shell accidentally 
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.

**--workspace**
Build all members in the workspace.

**--all**
Deprecated alias for **--workspace**.

**--exclude** _SPEC_...
Exclude the specified packages. Must be used in conjunction with the
**--workspace** flag. This flag may be specified multiple times and supports
common Unix glob patterns like ***, ?** and **[]**. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.

<a name="target-selection"></a>

### Target Selection

When no target selection options are given, **cargo build** will build all
binary and library targets of the selected packages. Binaries are skipped if
they have **required-features** that are missing.

Passing target selection flags will build only the specified
targets. 

Note that **--bin**, **--example**, **--test** and **--bench** flags also 
support common Unix glob patterns like ***, ?** and **[]**. However, to avoid your 
shell accidentally expanding glob patterns before Cargo handles them, you must 
use single quotes or double quotes around each glob pattern.

**--lib**
Build the package's library.

**--bin** _name_...
Build the specified binary. This flag may be specified multiple times
and supports common Unix glob patterns.

**--bins**
Build all binary targets.

**--example** _name_...
Build the specified example. This flag may be specified multiple times
and supports common Unix glob patterns.

**--examples**
Build all example targets.

**--test** _name_...
Build the specified integration test. This flag may be specified
multiple times and supports common Unix glob patterns.

**--tests**
Build all targets in test mode that have the **test = true** manifest
flag set. By default this includes the library and binaries built as
unittests, and integration tests. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
unittest, and once as a dependency for binaries, integration tests, etc.).
Targets may be enabled or disabled by setting the **test** flag in the
manifest settings for the target.

**--bench** _name_...
Build the specified benchmark. This flag may be specified multiple
times and supports common Unix glob patterns.

**--benches**
Build all targets in benchmark mode that have the **bench = true**
manifest flag set. By default this includes the library and binaries built
as benchmarks, and bench targets. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
benchmark, and once as a dependency for binaries, benchmarks, etc.).
Targets may be enabled or disabled by setting the **bench** flag in the
manifest settings for the target.

**--all-targets**
Build all targets. This is equivalent to specifying **--lib --bins --tests --benches --examples**.

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
Build for the given architecture. The default is the host
architecture. The general format of the triple is
**&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;**. Run **rustc --print target-list** for a
list of supported targets.

This may also be specified with the **build.target**
_config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
_build cache_ &lt;https://doc.rust-lang.org/cargo/guide/build-cache.html&gt; documentation for more details.

**--release**
Build optimized artifacts with the **release** profile. See the
PROFILES section for details on how this affects profile
selection.

**--ignore-rust-version**
Build the target even if the selected Rust compiler is older than the
required Rust version as configured in the project's **rust-version** field.

<a name="output-options"></a>

### Output Options


**--target-dir** _directory_
Directory for all generated artifacts and intermediate files. May also be
specified with the **CARGO\_TARGET\_DIR** environment variable, or the
**build.target-dir** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.
Defaults to **target** in the root of the workspace.

**--out-dir** _directory_
Copy final artifacts to this directory.

This option is unstable and available only on the
_nightly channel_ &lt;https://doc.rust-lang.org/book/appendix-07-nightly-rust.html&gt;
and requires the **-Z unstable-options** flag to enable.
See &lt;https://github.com/rust-lang/cargo/issues/6790&gt; for more information.

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

**--message-format** _fmt_
The output format for diagnostic messages. Can be specified multiple times
and consists of comma-separated values. Valid values:

\h'-04'·\h'+02'**human** (default): Display in a human-readable text format. Conflicts with
**short** and **json**.

\h'-04'·\h'+02'**short**: Emit shorter, human-readable text messages. Conflicts with **human**
and **json**.

\h'-04'·\h'+02'**json**: Emit JSON messages to stdout. See
_the reference_ &lt;https://doc.rust-lang.org/cargo/reference/external-tools.html#json-messages&gt;
for more details. Conflicts with **human** and **short**.

\h'-04'·\h'+02'**json-diagnostic-short**: Ensure the **rendered** field of JSON messages contains
the "short" rendering from rustc. Cannot be used with **human** or **short**.

\h'-04'·\h'+02'**json-diagnostic-rendered-ansi**: Ensure the **rendered** field of JSON messages
contains embedded ANSI color codes for respecting rustc's default color
scheme. Cannot be used with **human** or **short**.

\h'-04'·\h'+02'**json-render-diagnostics**: Instruct Cargo to not include rustc diagnostics in
in JSON messages printed, but instead Cargo itself should render the
JSON diagnostics coming from rustc. Cargo's own JSON diagnostics and others
coming from rustc are still emitted. Cannot be used with **human** or **short**.

**--build-plan**
Outputs a series of JSON messages to stdout that indicate the commands to run
the build.

This option is unstable and available only on the
_nightly channel_ &lt;https://doc.rust-lang.org/book/appendix-07-nightly-rust.html&gt;
and requires the **-Z unstable-options** flag to enable.
See &lt;https://github.com/rust-lang/cargo/issues/5579&gt; for more information.

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

<a name="miscellaneous-options"></a>

### Miscellaneous Options


**-j** _N_, 
**--jobs** _N_
Number of parallel jobs to run. May also be specified with the
**build.jobs** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;. Defaults to
the number of CPUs.

<a name="profiles"></a>

# Profiles

Profiles may be used to configure compiler options such as optimization levels
and debug settings. See _the reference_ &lt;https://doc.rust-lang.org/cargo/reference/profiles.html&gt; for more
details.

Profile selection depends on the target and crate being built. By default the
**dev** or **test** profiles are used. If the **--release** flag is given, then the
**release** or **bench** profiles are used.

.TS
allbox tab(:);
lt lt lt.
T{
Target
T}:T{
Default Profile
T}:T{
**--release** Profile
T}
T{
lib, bin, example
T}:T{
**dev**
T}:T{
**release**
T}
T{
test, bench, or any target in "test" or "bench" mode
T}:T{
**test**
T}:T{
**bench**
T}
.TE


Dependencies use the **dev**/**release** profiles.

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


\h'-04' 1.\h'+01'Build the local package and all of its dependencies:

    cargo build

\h'-04' 2.\h'+01'Build with optimizations:

    cargo build --release

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-rustc**(1)
