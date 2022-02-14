# cargo\-search(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-search - Search packages in crates.io

<a name="synopsis"></a>

# Synopsis

```
cargo search [options] [query...]
```

<a name="description"></a>

# Description

This performs a textual search for crates on &lt;https://crates.io&gt;. The matching
crates will be displayed along with their description in TOML format suitable
for copying into a **Cargo.toml** manifest.

<a name="options"></a>

# Options


<a name="search-options"></a>

### Search Options


**--limit** _limit_
Limit the number of results (default: 10, max: 100).

**--index** _index_
The URL of the registry index to use.

**--registry** _registry_
Name of the registry to use. Registry names are defined in Cargo config
files &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;. If not specified, the default registry is used,
which is defined by the **registry.default** config key which defaults to
**crates-io**.

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


\h'-04' 1.\h'+01'Search for a package from crates.io:

    cargo search serde

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-install**(1), **cargo-publish**(1)
