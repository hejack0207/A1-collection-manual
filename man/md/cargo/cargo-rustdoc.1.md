# cargo\-rustdoc(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-rustdoc - Build a package's documentation, using specified custom flags

<a name="synopsis"></a>

# Synopsis

```
cargo rustdoc [options] [-- args]
```

<a name="description"></a>

# Description

The specified target for the current package (or package specified by **-p** if
provided) will be documented with the specified _args_ being passed to the
final rustdoc invocation. Dependencies will not be documented as part of this
command. Note that rustdoc will still unconditionally receive arguments such
as **-L**, **--extern**, and **--crate-type**, and the specified _args_ will simply
be added to the rustdoc invocation.

See &lt;https://doc.rust-lang.org/rustdoc/index.html&gt; for documentation on rustdoc
flags.

This command requires that only one target is being compiled when additional
arguments are provided. If more than one target is available for the current
package the filters of **--lib**, **--bin**, etc, must be used to select which
target is compiled.

To pass flags to all rustdoc processes spawned by Cargo, use the
**RUSTDOCFLAGS** _environment variable_ &lt;https://doc.rust-lang.org/cargo/reference/environment-variables.html&gt;
or the **build.rustdocflags** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

<a name="options"></a>

# Options


<a name="documentation-options"></a>

### Documentation Options


**--open**
Open the docs in a browser after building them. This will use your default
browser unless you define another one in the **BROWSER** environment variable
or use the _\f(BIdoc.browser_ &lt;https://doc.rust-lang.org/cargo/reference/config.html#docbrowser&gt; configuration
option.

<a name="package-selection"></a>

### Package Selection

By default, the package in the current working directory is selected. The **-p**
flag can be used to choose a different package in a workspace.

**-p** _spec_, 
**--package** _spec_
The package to document. See **cargo-pkgid**(1) for the SPEC
format.

<a name="target-selection"></a>

### Target Selection

When no target selection options are given, **cargo rustdoc** will document all
binary and library targets of the selected package. The binary will be skipped
if its name is the same as the lib target. Binaries are skipped if they have
**required-features** that are missing.

Passing target selection flags will document only the specified
targets. 

Note that **--bin**, **--example**, **--test** and **--bench** flags also 
support common Unix glob patterns like ***, ?** and **[]**. However, to avoid your 
shell accidentally expanding glob patterns before Cargo handles them, you must 
use single quotes or double quotes around each glob pattern.

**--lib**
Document the package's library.

**--bin** _name_...
Document the specified binary. This flag may be specified multiple times
and supports common Unix glob patterns.

**--bins**
Document all binary targets.

**--example** _name_...
Document the specified example. This flag may be specified multiple times
and supports common Unix glob patterns.

**--examples**
Document all example targets.

**--test** _name_...
Document the specified integration test. This flag may be specified
multiple times and supports common Unix glob patterns.

**--tests**
Document all targets in test mode that have the **test = true** manifest
flag set. By default this includes the library and binaries built as
unittests, and integration tests. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
unittest, and once as a dependency for binaries, integration tests, etc.).
Targets may be enabled or disabled by setting the **test** flag in the
manifest settings for the target.

**--bench** _name_...
Document the specified benchmark. This flag may be specified multiple
times and supports common Unix glob patterns.

**--benches**
Document all targets in benchmark mode that have the **bench = true**
manifest flag set. By default this includes the library and binaries built
as benchmarks, and bench targets. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
benchmark, and once as a dependency for binaries, benchmarks, etc.).
Targets may be enabled or disabled by setting the **bench** flag in the
manifest settings for the target.

**--all-targets**
Document all targets. This is equivalent to specifying **--lib --bins --tests --benches --examples**.

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
Document for the given architecture. The default is the host
architecture. The general format of the triple is
**&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;**. Run **rustc --print target-list** for a
list of supported targets.

This may also be specified with the **build.target**
_config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
_build cache_ &lt;https://doc.rust-lang.org/cargo/guide/build-cache.html&gt; documentation for more details.

**--release**
Document optimized artifacts with the **release** profile. See the
PROFILES section for details on how this affects profile
selection.

**--ignore-rust-version**
Document the target even if the selected Rust compiler is older than the
required Rust version as configured in the project's **rust-version** field.

<a name="output-options"></a>

### Output Options


**--target-dir** _directory_
Directory for all generated artifacts and intermediate files. May also be
specified with the **CARGO\_TARGET\_DIR** environment variable, or the
**build.target-dir** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.
Defaults to **target** in the root of the workspace.

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


\h'-04' 1.\h'+01'Build documentation with custom CSS included from a given file:

    cargo rustdoc --lib -- --extend-css extra.css

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-doc**(1), **rustdoc**(1)
