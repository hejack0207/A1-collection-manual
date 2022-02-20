# cargo\-yank(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-yank - Remove a pushed crate from the index

<a name="synopsis"></a>

# Synopsis

```
cargo yank [options] --vers version [crate]
```

<a name="description"></a>

# Description

The yank command removes a previously published crate's version from the
server's index. This command does not delete any data, and the crate will
still be available for download via the registry's download link.

Note that existing crates locked to a yanked version will still be able to
download the yanked version to use it. Cargo will, however, not allow any new
crates to be locked to any yanked version.

This command requires you to be authenticated with either the **--token** option
or using **cargo-login**(1).

If the crate name is not specified, it will use the package name from the
current directory.

<a name="options"></a>

# Options


<a name="yank-options"></a>

### Yank Options


**--vers** _version_
The version to yank or un-yank.

**--undo**
Undo a yank, putting a version back into the index.

**--token** _token_
API token to use when authenticating. This overrides the token stored in
the credentials file (which is created by **cargo-login**(1)).

_Cargo config_ &lt;https://doc.rust-lang.org/cargo/reference/config.html&gt; environment variables can be
used to override the tokens stored in the credentials file. The token for
crates.io may be specified with the **CARGO\_REGISTRY\_TOKEN** environment
variable. Tokens for other registries may be specified with environment
variables of the form **CARGO\_REGISTRIES\_NAME\_TOKEN** where **NAME** is the name
of the registry in all capital letters.

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


\h'-04' 1.\h'+01'Yank a crate from the index:

    cargo yank --vers 1.0.7 foo

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-login**(1), **cargo-publish**(1)
