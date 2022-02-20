# cargo\-tree(1)

.nh
.ss \n[.ss] 0

<a name="name"></a>

# Name

cargo-tree - Display a tree visualization of a dependency graph

<a name="synopsis"></a>

# Synopsis

```
cargo tree [options]
```

<a name="description"></a>

# Description

This command will display a tree of dependencies to the terminal. An example
of a simple project that depends on the "rand" package:

    myproject v0.1.0 (/myproject)
    `-- rand v0.7.3
        |-- getrandom v0.1.14
        |   |-- cfg-if v0.1.10
        |   `-- libc v0.2.68
        |-- libc v0.2.68 (*)
        |-- rand_chacha v0.2.2
        |   |-- ppv-lite86 v0.2.6
        |   `-- rand_core v0.5.1
        |       `-- getrandom v0.1.14 (*)
        `-- rand_core v0.5.1 (*)
    [build-dependencies]
    `-- cc v1.0.50

Packages marked with **(*)** have been "de-duplicated". The dependencies for the
package have already been shown elsewhere in the graph, and so are not
repeated. Use the **--no-dedupe** option to repeat the duplicates.

The **-e** flag can be used to select the dependency kinds to display. The
"features" kind changes the output to display the features enabled by
each dependency. For example, **cargo tree -e features**:

    myproject v0.1.0 (/myproject)
    `-- log feature "serde"
        `-- log v0.4.8
            |-- serde v1.0.106
            `-- cfg-if feature "default"
                `-- cfg-if v0.1.10

In this tree, **myproject** depends on **log** with the **serde** feature. **log** in
turn depends on **cfg-if** with "default" features. When using **-e features** it
can be helpful to use **-i** flag to show how the features flow into a package.
See the examples below for more detail.

<a name="options"></a>

# Options


<a name="tree-options"></a>

### Tree Options


**-i** _spec_, 
**--invert** _spec_
Show the reverse dependencies for the given package. This flag will invert
the tree and display the packages that depend on the given package.

Note that in a workspace, by default it will only display the package's
reverse dependencies inside the tree of the workspace member in the current
directory. The **--workspace** flag can be used to extend it so that it will
show the package's reverse dependencies across the entire workspace. The **-p**
flag can be used to display the package's reverse dependencies only with the
subtree of the package given to **-p**.

**--prune** _spec_
Prune the given package from the display of the dependency tree.

**--depth** _depth_
Maximum display depth of the dependency tree. A depth of 1 displays the direct
dependencies, for example.

**--no-dedupe**
Do not de-duplicate repeated dependencies. Usually, when a package has already
displayed its dependencies, further occurrences will not re-display its
dependencies, and will include a **(*)** to indicate it has already been shown.
This flag will cause those duplicates to be repeated.

**-d**, 
**--duplicates**
Show only dependencies which come in multiple versions (implies **--invert**).
When used with the **-p** flag, only shows duplicates within the subtree of the
given package.

It can be beneficial for build times and executable sizes to avoid building
that same package multiple times. This flag can help identify the offending
packages. You can then investigate if the package that depends on the
duplicate with the older version can be updated to the newer version so that
only one instance is built.

**-e** _kinds_, 
**--edges** _kinds_
The dependency kinds to display. Takes a comma separated list of values:

\h'-04'·\h'+02'**all** \[em] Show all edge kinds.

\h'-04'·\h'+02'**normal** \[em] Show normal dependencies.

\h'-04'·\h'+02'**build** \[em] Show build dependencies.

\h'-04'·\h'+02'**dev** \[em] Show development dependencies.

\h'-04'·\h'+02'**features** \[em] Show features enabled by each dependency. If this is the only
kind given, then it will automatically include the other dependency kinds.

\h'-04'·\h'+02'**no-normal** \[em] Do not include normal dependencies.

\h'-04'·\h'+02'**no-build** \[em] Do not include build dependencies.

\h'-04'·\h'+02'**no-dev** \[em] Do not include development dependencies.

\h'-04'·\h'+02'**no-proc-macro** \[em] Do not include procedural macro dependencies.

The **normal**, **build**, **dev**, and **all** dependency kinds cannot be mixed with
**no-normal**, **no-build**, or **no-dev** dependency kinds.

The default is **normal,build,dev**.

**--target** _triple_
Filter dependencies matching the given target-triple. The default is the host
platform. Use the value **all** to include _all_ targets.

<a name="tree-formatting-options"></a>

### Tree Formatting Options


**--charset** _charset_
Chooses the character set to use for the tree. Valid values are "utf8" or
"ascii". Default is "utf8".

**-f** _format_, 
**--format** _format_
Set the format string for each package. The default is "{p}".

This is an arbitrary string which will be used to display each package. The following
strings will be replaced with the corresponding value:

\h'-04'·\h'+02'**{p}** \[em] The package name.

\h'-04'·\h'+02'**{l}** \[em] The package license.

\h'-04'·\h'+02'**{r}** \[em] The package repository URL.

\h'-04'·\h'+02'**{f}** \[em] Comma-separated list of package features that are enabled.

\h'-04'·\h'+02'**{lib}** \[em] The name, as used in a **use** statement, of the package's library.

**--prefix** _prefix_
Sets how each line is displayed. The _prefix_ value can be one of:

\h'-04'·\h'+02'**indent** (default) \[em] Shows each line indented as a tree.

\h'-04'·\h'+02'**depth** \[em] Show as a list, with the numeric depth printed before each entry.

\h'-04'·\h'+02'**none** \[em] Show as a flat list.

<a name="package-selection"></a>

### Package Selection

By default, when no package selection options are given, the packages selected
depend on the selected manifest file (based on the current working directory if
**--manifest-path** is not given). If the manifest is the root of a workspace then
the workspaces default members are selected, otherwise only the package defined
by the manifest will be selected.

The default members of a workspace can be set explicitly with the
**workspace.default-members** key in the root manifest. If this is not set, a
virtual workspace will include all workspace members (equivalent to passing
**--workspace**), and a non-virtual workspace will include only the root crate itself.

**-p** _spec_..., 
**--package** _spec_...
Display only the specified packages. See **cargo-pkgid**(1) for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like ***, ?** and **[]**. However, to avoid your shell accidentally 
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.

**--workspace**
Display all members in the workspace.

**--exclude** _SPEC_...
Exclude the specified packages. Must be used in conjunction with the
**--workspace** flag. This flag may be specified multiple times and supports
common Unix glob patterns like ***, ?** and **[]**. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.

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


\h'-04' 1.\h'+01'Display the tree for the package in the current directory:

    cargo tree

\h'-04' 2.\h'+01'Display all the packages that depend on the **syn** package:

    cargo tree -i syn

\h'-04' 3.\h'+01'Show the features enabled on each package:

    cargo tree --format "{p} {f}"

\h'-04' 4.\h'+01'Show all packages that are built multiple times. This can happen if multiple
semver-incompatible versions appear in the tree (like 1.0.0 and 2.0.0).

    cargo tree -d

\h'-04' 5.\h'+01'Explain why features are enabled for the **syn** package:

    cargo tree -e features -i syn

The **-e features** flag is used to show features. The **-i** flag is used to
invert the graph so that it displays the packages that depend on **syn**. An
example of what this would display:

    syn v1.0.17
    |-- syn feature "clone-impls"
    |   `-- syn feature "default"
    |       `-- rustversion v1.0.2
    |           `-- rustversion feature "default"
    |               `-- myproject v0.1.0 (/myproject)
    |                   `-- myproject feature "default" (command-line)
    |-- syn feature "default" (*)
    |-- syn feature "derive"
    |   `-- syn feature "default" (*)
    |-- syn feature "full"
    |   `-- rustversion v1.0.2 (*)
    |-- syn feature "parsing"
    |   `-- syn feature "default" (*)
    |-- syn feature "printing"
    |   `-- syn feature "default" (*)
    |-- syn feature "proc-macro"
    |   `-- syn feature "default" (*)
    `-- syn feature "quote"
        |-- syn feature "printing" (*)
        `-- syn feature "proc-macro" (*)

To read this graph, you can follow the chain for each feature from the root
to see why it is included. For example, the "full" feature is added by the
**rustversion** crate which is included from **myproject** (with the default
features), and **myproject** is the package selected on the command-line. All
of the other **syn** features are added by the "default" feature ("quote" is
added by "printing" and "proc-macro", both of which are default features).

If you're having difficulty cross-referencing the de-duplicated **(*)**
entries, try with the **--no-dedupe** flag to get the full output.

<a name="see-also"></a>

# See Also

**cargo**(1), **cargo-metadata**(1)
