# cargo\-owner(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-owner - Manage the owners of a crate on the registry

<a name="synopsis"></a>

# Synopsis

```
cargo owner [options] --add login [crate]
cargo owner [options] --remove login [crate]
cargo owner [options] --list [crate]
```

<a name="description"></a>

# Description

This command will modify the owners for a crate on the registry. Owners of a
crate can upload new versions and yank old versions. Non-team owners can also
modify the set of owners, so take care!

This command requires you to be authenticated with either the **--token** option
or using **cargo-login**(1).

If the crate name is not specified, it will use the package name from the
current directory.

See _the reference_ &lt;https://doc.rust-lang.org/cargo/reference/publishing.html#cargo-owner&gt; for more
information about owners and publishing.

<a name="options"></a>

# Options


<a name="owner-options"></a>

### Owner Options


**-a**, 
**--add** _login_...
Invite the given user or team as an owner.

**-r**, 
**--remove** _login_...
Remove the given user or team as an owner.

**-l**, 
**--list**
List owners of a crate.

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


\h'-04' 1.\h'+01'List owners of a package:

    cargo owner --list foo

\h'-04' 2.\h'+01'Invite an owner to a package:

    cargo owner --add username foo

\h'-04' 3.\h'+01'Remove an owner from a package:

    cargo owner --remove username foo

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-login**(1), **cargo-publish**(1)
