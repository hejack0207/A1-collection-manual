# cargo\-clean(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-clean - Remove generated artifacts

<a name="synopsis"></a>

# Synopsis

```
cargo clean [options]
```

<a name="description"></a>

# Description

Remove artifacts from the target directory that Cargo has generated in the
past.

With no options, **cargo clean** will delete the entire target directory.

<a name="options"></a>

# Options


<a name="package-selection"></a>

### Package Selection

When no packages are selected, all packages and all dependencies in the
workspace are cleaned.

**-p** _spec_..., 
**--package** _spec_...
Clean only the specified packages. This flag may be specified
multiple times. See **cargo-pkgid**(1) for the SPEC format.

<a name="clean-options"></a>

### Clean Options


**--doc**
This option will cause **cargo clean** to remove only the **doc** directory in
the target directory.

**--release**
Clean all artifacts that were built with the **release** or **bench** profiles.

**--target-dir** _directory_
Directory for all generated artifacts and intermediate files. May also be
specified with the **CARGO\_TARGET\_DIR** environment variable, or the
**build.target-dir** _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.
Defaults to **target** in the root of the workspace.

**--target** _triple_
Clean for the given architecture. The default is the host
architecture. The general format of the triple is
**&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;**. Run **rustc --print target-list** for a
list of supported targets.

This may also be specified with the **build.target**
_config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.

Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
_build cache_ &lt;https://doc.rust-lang.org/cargo/guide/build-cache.html&gt; documentation for more details.

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


\h'-04' 1.\h'+01'Remove the entire target directory:

    cargo clean

\h'-04' 2.\h'+01'Remove only the release artifacts:

    cargo clean --release

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-build**(1)
