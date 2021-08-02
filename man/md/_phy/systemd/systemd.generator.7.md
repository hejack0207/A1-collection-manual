# systemd\&.generator(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.generator - systemd unit generators

<a name="synopsis"></a>

# Synopsis

```
.HP \w'/path/to/generator&nbsp;'u /path/to/generator normal-dir early-dir late-dir 

</synopsis>
    /run/systemd/system-generators/*
    /etc/systemd/system-generators/*
    /usr/local/lib/systemd/system-generators/*
    /usr/lib/systemd/system-generators/*
<synopsis>


</synopsis>
    /run/systemd/user-generators/*
    /etc/systemd/user-generators/*
    /usr/local/lib/systemd/user-generators/*
    /usr/lib/systemd/user-generators/*
<synopsis>


```

<a name="description"></a>

# Description


Generators are small executables that live in
/usr/lib/systemd/system-generators/
and other directories listed above.
**systemd**(1)
will execute those binaries very early at bootup and at configuration reload time — before unit files are loaded. Their main purpose is to convert configuration that is not native into dynamically generated unit files.

Each generator is called with three directory paths that are to be used for generator output. In these three directories, generators may dynamically generate unit files (regular ones, instances, as well as templates), unit file
.d/
drop-ins, and create symbolic links to unit files to add additional dependencies, create aliases, or instantiate existing templates. Those directories are included in the unit load path of
**systemd**(1), allowing generated configuration to extend or override existing definitions.

Directory paths for generator output differ by priority:
.../generator.early
has priority higher than the admin configuration in
/etc, while
.../generator
has lower priority than
/etc
but higher than vendor configuration in
/usr, and
.../generator.late
has priority lower than all other configuration. See the next section and the discussion of unit load paths and unit overriding in
**systemd.unit**(5).

Generators are loaded from a set of paths determined during compilation, as listed above. System and user generators are loaded from directories with names ending in
system-generators/
and
user-generators/, respectively. Generators found in directories listed earlier override the ones with the same name in directories lower in the list. A symlink to
/dev/null
or an empty file can be used to mask a generator, thereby preventing it from running. Please note that the order of the two directories with the highest priority is reversed with respect to the unit load path, and generators in
/run
overwrite those in
/etc.

After installing new generators or updating the configuration,
**systemctl daemon-reload**
may be executed. This will delete the previous configuration created by generators, re-run all generators, and cause
**systemd**
to reload units from disk. See
**systemctl**(1)
for more information.

<a name="output-directories"></a>

# Output Directories


Generators are invoked with three arguments: paths to directories where generators can place their generated unit files or symlinks. By default those paths are runtime directories that are included in the search path of
**systemd**, but a generator may be called with different paths for debugging purposes.

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  _normal-dir_

In normal use this is
/run/systemd/generator
in case of the system generators and
$XDG_RUNTIME_DIR/generator
in case of the user generators. Unit files placed in this directory take precedence over vendor unit configuration but not over native user/administrator unit configuration.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  _early-dir_

In normal use this is
/run/systemd/generator.early
in case of the system generators and
$XDG_RUNTIME_DIR/generator.early
in case of the user generators. Unit files placed in this directory override unit files in
/usr,
/run
and
/etc. This means that unit files placed in this directory take precedence over all normal configuration, both vendor and user/administrator.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  _late-dir_

In normal use this is
/run/systemd/generator.late
in case of the system generators and
$XDG_RUNTIME_DIR/generator.late
in case of the user generators. This directory may be used to extend the unit file tree without overriding any other unit files. Any native configuration files supplied by the vendor or user/administrator take precedence.

<a name="notes-about-writing-generators"></a>

# Notes About Writing Generators


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  All generators are executed in parallel. That means all executables are started at the very same time and need to be able to cope with this parallelism.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Generators are run very early at boot and cannot rely on any external services. They may not talk to any other process. That includes simple things such as logging to
  **syslog**(3), or
  **systemd**
  itself (this means: no
  **systemctl**(1))! Non-essential file systems like
  /var
  and
  /home
  are mounted after generators have run. Generators can however rely on the most basic kernel functionality to be available, including a mounted
  /sys,
  /proc,
  /dev,
  /usr.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Units written by generators are removed when the configuration is reloaded. That means the lifetime of the generated units is closely bound to the reload cycles of
  **systemd**
  itself.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Generators should only be used to generate unit files and symlinks to them, not any other kind of configuration. Due to the lifecycle logic mentioned above, generators are not a good fit to generate dynamic configuration for other services. If you need to generate dynamic configuration for other services, do so in normal services you order before the service in question.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Since
  **syslog**(3)
  is not available (see above), log messages have to be written to
  /dev/kmsg
  instead.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The generator should always include its own name in a comment at the top of the generated file, so that the user can easily figure out which component created or amended a particular unit.

The
_SourcePath=_
directive should be used in generated files to specify the source configuration file they are generated from. This makes things more easily understood by the user and also has the benefit that systemd can warn the user about configuration files that changed on disk but have not been read yet by systemd. The
_SourcePath=_
value does not have to be a file in a physical filesystem. For example, in the common case of the generator looking at the kernel command line,
**SourcePath=/proc/cmdline**
should be used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Generators may write out dynamic unit files or just hook unit files into other units with the usual
  .wants/
  or
  .requires/
  symlinks. Often, it is nicer to simply instantiate a template unit file from
  /usr
  with a generator instead of writing out entirely dynamic unit files. Of course, this works only if a single parameter is to be used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If you are careful, you can implement generators in shell scripts. We do recommend C code however, since generators are executed synchronously and hence delay the entire boot if they are slow.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Regarding overriding semantics: there are two rules we try to follow when thinking about the overriding semantics:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  User configuration should override vendor configuration. This (mostly) means that stuff from
  /etc
  should override stuff from
  /usr.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Native configuration should override non-native configuration. This (mostly) means that stuff you generate should never override native unit files for the same purpose.

Of these two rules the first rule is probably the more important one and breaks the second one sometimes. Hence, when deciding whether to use argv[1], argv[2], or argv[3], your default choice should probably be argv[1].

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Instead of heading off now and writing all kind of generators for legacy configuration file formats, please think twice! It is often a better idea to just deprecate old stuff instead of keeping it artificially alive.

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;systemd-fstab-generator**

**systemd-fstab-generator**(8)
converts
/etc/fstab
into native mount units. It uses argv[1] as location to place the generated unit files in order to allow the user to override
/etc/fstab
with their own native unit files, but also to ensure that
/etc/fstab
overrides any vendor default from
/usr.

After editing
/etc/fstab, the user should invoke
**systemctl daemon-reload**. This will re-run all generators and cause
**systemd**
to reload units from disk. To actually mount new directories added to
fstab,
**systemctl start ****/path/to/mountpoint**
or
**systemctl start local-fs.target**
may be used.

**Example&nbsp;2.&nbsp;systemd-system-update-generator**

**systemd-system-update-generator**(8)
temporarily redirects
default.target
to
system-update.target, if a system update is scheduled. Since this needs to override the default user configuration for
default.target, it uses argv[2]. For details about this logic, see
**systemd.offline-updates**(7).

**Example&nbsp;3.&nbsp;Debugging a generator**

.if n \{.RS 4
.\}
    dir=$(mktemp -d)
    SYSTEMD_LOG_LEVEL=debug /usr/lib/systemd/system-generators/systemd-fstab-generator e
            "$dir" "$dir" "$dir"
    find $dir
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-cryptsetup-generator**(8),
**systemd-debug-generator**(8),
**systemd-fstab-generator**(8),
**fstab**(5),
**systemd-getty-generator**(8),
**systemd-gpt-auto-generator**(8),
**systemd-hibernate-resume-generator**(8),
**systemd-rc-local-generator**(8),
**systemd-system-update-generator**(8),
**systemd-sysv-generator**(8),
**systemd.unit**(5),
**systemctl**(1),
**systemd.environment-generator**(7)
