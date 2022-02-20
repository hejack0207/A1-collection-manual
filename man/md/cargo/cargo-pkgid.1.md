# cargo\-pkgid(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-pkgid - Print a fully qualified package specification

<a name="synopsis"></a>

# Synopsis

```
cargo pkgid [options] [spec]
```

<a name="description"></a>

# Description

Given a _spec_ argument, print out the fully qualified package ID specifier
for a package or dependency in the current workspace. This command will
generate an error if _spec_ is ambiguous as to which package it refers to in
the dependency graph. If no _spec_ is given, then the specifier for the local
package is printed.

This command requires that a lockfile is available and dependencies have been
fetched.

A package specifier consists of a name, version, and source URL. You are
allowed to use partial specifiers to succinctly match a specific package as
long as it matches only one package. The format of a _spec_ can be one of the
following:

.TS
allbox tab(:);
lt lt.
T{
SPEC Structure
T}:T{
Example SPEC
T}
T{
_name_
T}:T{
**bitflags**
T}
T{
_name_**:**_version_
T}:T{
**bitflags:1.0.4**
T}
T{
_url_
T}:T{
**https://github.com/rust-lang/cargo**
T}
T{
_url_**#**_version_
T}:T{
**https://github.com/rust-lang/cargo#0.33.0**
T}
T{
_url_**#**_name_
T}:T{
**https://github.com/rust-lang/crates.io-index#bitflags**
T}
T{
_url_**#**_name_**:**_version_
T}:T{
**https://github.com/rust-lang/cargo#crates-io:0.21.0**
T}
.TE


<a name="options"></a>

# Options


<a name="package-selection"></a>

### Package Selection


**-p** _spec_, 
**--package** _spec_
Get the package ID for the given package instead of the current package.

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


\h'-04' 1.\h'+01'Retrieve package specification for **foo** package:

    cargo pkgid foo

\h'-04' 2.\h'+01'Retrieve package specification for version 1.0.0 of **foo**:

    cargo pkgid foo:1.0.0

\h'-04' 3.\h'+01'Retrieve package specification for **foo** from crates.io:

    cargo pkgid https://github.com/rust-lang/crates.io-index#foo

\h'-04' 4.\h'+01'Retrieve package specification for **foo** from a local package:

    cargo pkgid file:///path/to/local/package#foo

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-generate-lockfile**(1), **cargo-metadata**(1)
