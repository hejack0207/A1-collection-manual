# cargo\-locate\-project(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-locate-project - Print a JSON representation of a Cargo.toml file's location

<a name="synopsis"></a>

# Synopsis

```
cargo locate-project [options]
```

<a name="description"></a>

# Description

This command will print a JSON object to stdout with the full path to the
**Cargo.toml** manifest.

<a name="options"></a>

# Options


**--workspace**
Locate the **Cargo.toml** at the root of the workspace, as opposed to the current
workspace member.

<a name="display-options"></a>

### Display Options


**--message-format** _fmt_
The representation in which to print the project location. Valid values:

\h'-04'·\h'+02'**json** (default): JSON object with the path under the key "root".

\h'-04'·\h'+02'**plain**: Just the path.

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


\h'-04' 1.\h'+01'Display the path to the manifest based on the current directory:

    cargo locate-project

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-metadata**(1)
