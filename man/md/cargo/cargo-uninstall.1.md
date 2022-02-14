# cargo\-uninstall(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-uninstall - Remove a Rust binary

<a name="synopsis"></a>

# Synopsis

```
cargo uninstall [options] [spec...]
```

<a name="description"></a>

# Description

This command removes a package installed with **cargo-install**(1). The _spec_
argument is a package ID specification of the package to remove (see
**cargo-pkgid**(1)).

By default all binaries are removed for a crate but the **--bin** and
**--example** flags can be used to only remove particular binaries.

The installation root is determined, in order of precedence:

\h'-04'·\h'+02'**--root** option

\h'-04'·\h'+02'**CARGO\_INSTALL\_ROOT** environment variable

\h'-04'·\h'+02'**install.root** Cargo _config value_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;

\h'-04'·\h'+02'**CARGO\_HOME** environment variable

\h'-04'·\h'+02'**$HOME/.cargo**

<a name="options"></a>

# Options


<a name="install-options"></a>

### Install Options


**-p**, 
**--package** _spec_...
Package to uninstall.

**--bin** _name_...
Only uninstall the binary _name_.

**--root** _dir_
Directory to uninstall packages from.

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


\h'-04' 1.\h'+01'Uninstall a previously installed package.

    cargo uninstall ripgrep

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-install**(1)
