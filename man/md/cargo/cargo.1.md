# cargo(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo - The Rust package manager

<a name="synopsis"></a>

# Synopsis

```
cargo [options] command [args]
cargo [options] --version
cargo [options] --list
cargo [options] --help
cargo [options] --explain code
```

<a name="description"></a>

# Description

This program is a package manager and build tool for the Rust language,
available at &lt;https://rust-lang.org&gt;.

<a name="commands"></a>

# Commands


<a name="build-commands"></a>

### Build Commands

**cargo-bench**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Execute benchmarks of a package.

**cargo-build**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Compile a package.

**cargo-check**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Check a local package and all of its dependencies for errors.

**cargo-clean**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Remove artifacts that Cargo has generated in the past.

**cargo-doc**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Build a package's documentation.

**cargo-fetch**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Fetch dependencies of a package from the network.

**cargo-fix**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Automatically fix lint warnings reported by rustc.

**cargo-run**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Run a binary or example of the local package.

**cargo-rustc**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Compile a package, and pass extra options to the compiler.

**cargo-rustdoc**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Build a package's documentation, using specified custom flags.

**cargo-test**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Execute unit and integration tests of a package.

<a name="manifest-commands"></a>

### Manifest Commands

**cargo-generate-lockfile**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Generate **Cargo.lock** for a project.

**cargo-locate-project**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Print a JSON representation of a **Cargo.toml** file's location.

**cargo-metadata**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Output the resolved dependencies of a package in machine-readable format.

**cargo-pkgid**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Print a fully qualified package specification.

**cargo-tree**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Display a tree visualization of a dependency graph.

**cargo-update**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Update dependencies as recorded in the local lock file.

**cargo-vendor**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Vendor all dependencies locally.

**cargo-verify-project**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Check correctness of crate manifest.

<a name="package-commands"></a>

### Package Commands

**cargo-init**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Create a new Cargo package in an existing directory.

**cargo-install**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Build and install a Rust binary.

**cargo-new**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Create a new Cargo package.

**cargo-search**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Search packages in crates.io.

**cargo-uninstall**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Remove a Rust binary.

<a name="publishing-commands"></a>

### Publishing Commands

**cargo-login**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Save an API token from the registry locally.

**cargo-owner**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Manage the owners of a crate on the registry.

**cargo-package**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Assemble the local package into a distributable tarball.

**cargo-publish**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Upload a package to the registry.

**cargo-yank**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Remove a pushed crate from the index.

<a name="general-commands"></a>

### General Commands

**cargo-help**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Display help information about Cargo.

**cargo-version**(1)  
&nbsp;&nbsp;&nbsp;&nbsp;Show version information.

<a name="options"></a>

# Options


<a name="special-options"></a>

### Special Options


**-V**, 
**--version**
Print version info and exit. If used with **--verbose**, prints extra
information.

**--list**
List all installed Cargo subcommands. If used with **--verbose**, prints extra
information.

**--explain** _code_
Run **rustc --explain CODE** which will print out a detailed explanation of an
error message (for example, **E0004**).

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

<a name="files"></a>

# Files

**~/.cargo/**  
&nbsp;&nbsp;&nbsp;&nbsp;Default location for Cargo's "home" directory where it
stores various files. The location can be changed with the **CARGO\_HOME**
environment variable.

**$CARGO\_HOME/bin/**  
&nbsp;&nbsp;&nbsp;&nbsp;Binaries installed by **cargo-install**(1) will be located here. If using
_rustup_ &lt;https://rust-lang.github.io/rustup/&gt;, executables distributed with Rust are also located here.

**$CARGO\_HOME/config.toml**  
&nbsp;&nbsp;&nbsp;&nbsp;The global configuration file. See _the reference_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;
for more information about configuration files.

**.cargo/config.toml**  
&nbsp;&nbsp;&nbsp;&nbsp;Cargo automatically searches for a file named **.cargo/config.toml** in the
current directory, and all parent directories. These configuration files
will be merged with the global configuration file.

**$CARGO\_HOME/credentials.toml**  
&nbsp;&nbsp;&nbsp;&nbsp;Private authentication information for logging in to a registry.

**$CARGO\_HOME/registry/**  
&nbsp;&nbsp;&nbsp;&nbsp;This directory contains cached downloads of the registry index and any
downloaded dependencies.

**$CARGO\_HOME/git/**  
&nbsp;&nbsp;&nbsp;&nbsp;This directory contains cached downloads of git dependencies.

Please note that the internal structure of the **$CARGO\_HOME** directory is not
stable yet and may be subject to change.

<a name="examples"></a>

# Examples


\h'-04' 1.\h'+01'Build a local package and all of its dependencies:

    cargo build

\h'-04' 2.\h'+01'Build a package with optimizations:

    cargo build --release

\h'-04' 3.\h'+01'Run tests for a cross-compiled target:

    cargo test --target i686-unknown-linux-gnu

\h'-04' 4.\h'+01'Create a new package that builds an executable:

    cargo new foobar

\h'-04' 5.\h'+01'Create a package in the current directory:

    mkdir foo && cd foo
    cargo init .

\h'-04' 6.\h'+01'Learn about a command's options and usage:

    cargo help clean

<a name="bugs"></a>

# Bugs

See &lt;https://github.com/rust-lang/cargo/issues&gt; for issues.

<a name="see-also"></a>

# See Also

**rustc**(1), **rustdoc**(1)
