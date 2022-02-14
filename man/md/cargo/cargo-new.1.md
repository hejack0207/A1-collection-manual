# cargo\-new(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-new - Create a new Cargo package

<a name="synopsis"></a>

# Synopsis

```
cargo new [options] path
```

<a name="description"></a>

# Description

This command will create a new Cargo package in the given directory. This
includes a simple template with a **Cargo.toml** manifest, sample source file,
and a VCS ignore file. If the directory is not already in a VCS repository,
then a new repository is created (see **--vcs** below).

See **cargo-init**(1) for a similar command which will create a new manifest
in an existing directory.

<a name="options"></a>

# Options


<a name="new-options"></a>

### New Options


**--bin**
Create a package with a binary target (**src/main.rs**).
This is the default behavior.

**--lib**
Create a package with a library target (**src/lib.rs**).

**--edition** _edition_
Specify the Rust edition to use. Default is 2021.
Possible values: 2015, 2018, 2021

**--name** _name_
Set the package name. Defaults to the directory name.

**--vcs** _vcs_
Initialize a new VCS repository for the given version control system (git,
hg, pijul, or fossil) or do not initialize any version control at all
(none). If not specified, defaults to **git** or the configuration value
**cargo-new.vcs**, or **none** if already inside a VCS repository.

**--registry** _registry_
This sets the **publish** field in **Cargo.toml** to the given registry name
which will restrict publishing only to that registry.

Registry names are defined in _Cargo config files_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt;.
If not specified, the default registry defined by the **registry.default**
config key is used. If the default registry is not set and **--registry** is not
used, the **publish** field will not be set which means that publishing will not
be restricted.

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


\h'-04' 1.\h'+01'Create a binary Cargo package in the given directory:

    cargo new foo

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-init**(1)
