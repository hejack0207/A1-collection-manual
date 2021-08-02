# systemd\-analyze(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-analyze - Analyze and debug system manager

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] [time] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] blame .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] critical-chain [UNIT...] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] plot [>&nbsp;file.svg] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] dot [PATTERN...] [>&nbsp;file.dot] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] dump .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] cat-config NAME|PATH... .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] unit-paths .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] log-level [LEVEL] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] log-target [TARGET] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] syscall-filter [SET...] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] verify [FILES...] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] calendar SPECS... .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] service-watchdogs [BOOL] .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] timespan SPAN... .HP \w'systemd-analyze&nbsp;'u systemd-analyze [OPTIONS...] security UNIT...
```

<a name="description"></a>

# Description


**systemd-analyze**
may be used to determine system boot-up performance statistics and retrieve other state and tracing information from the system and service manager, and to verify the correctness of unit files. It is also used to access special functions useful for advanced system manager debugging.

**systemd-analyze time**
prints the time spent in the kernel before userspace has been reached, the time spent in the initial RAM disk (initrd) before normal system userspace has been reached, and the time normal system userspace took to initialize. Note that these measurements simply measure the time passed up to the point where all system services have been spawned, but not necessarily until they fully finished initialization or the disk is idle.

**systemd-analyze blame**
prints a list of all running units, ordered by the time they took to initialize. This information may be used to optimize boot-up times. Note that the output might be misleading as the initialization of one service might be slow simply because it waits for the initialization of another service to complete. Also note:
**systemd-analyze blame**
doesnt display results for services with
_Type=simple_, because systemd considers such services to be started immediately, hence no measurement of the initialization delays can be done.

**systemd-analyze critical-chain [****UNIT...****]**
prints a tree of the time-critical chain of units (for each of the specified
_UNIT_s or for the default target otherwise). The time after the unit is active or started is printed after the "@" character. The time the unit takes to start is printed after the "+" character. Note that the output might be misleading as the initialization of one service might depend on socket activation and because of the parallel execution of units.

**systemd-analyze plot**
prints an SVG graphic detailing which system services have been started at what time, highlighting the time they spent on initialization.

**systemd-analyze dot**
generates textual dependency graph description in dot format for further processing with the GraphViz
**dot**(1)
tool. Use a command line like
**systemd-analyze dot | dot -Tsvg &gt; systemd.svg**
to generate a graphical dependency tree. Unless
**--order**
or
**--require**
is passed, the generated graph will show both ordering and requirement dependencies. Optional pattern globbing style specifications (e.g.
*.target) may be given at the end. A unit dependency is included in the graph if any of these patterns match either the origin or destination node.

**systemd-analyze dump**
outputs a (usually very long) human-readable serialization of the complete server state. Its format is subject to change without notice and should not be parsed by applications.

**systemd-analyze cat-config**
is similar to
**systemctl cat**, but operates on config files. It will copy the contents of a config file and any drop-ins to standard output, using the usual systemd set of directories and rules for precedence. Each argument must be either an absolute path including the prefix (such as
/etc/systemd/logind.conf
or
/usr/lib/systemd/logind.conf), or a name relative to the prefix (such as
systemd/logind.conf).

**Example&nbsp;1.&nbsp;Showing logind configuration**

.if n \{.RS 4
.\}
    $ systemd-analyze cat-config systemd/logind.conf
    # /etc/systemd/logind.conf
    ...
    [Login]
    NAutoVTs=8
    ...
    
    # /usr/lib/systemd/logind.conf.d/20-test.conf
    ... some override from another package
    
    # /etc/systemd/logind.conf.d/50-override.conf
    ... some administrator override
          
.if n \{.RE
.\}

**systemd-analyze unit-paths**
outputs a list of all directories from which unit files,
.d
overrides, and
.wants,
.requires
symlinks may be loaded. Combine with
**--user**
to retrieve the list for the user manager instance, and
**--global**
for the global configuration of user manager instances. Note that this verb prints the list that is compiled into
**systemd-analyze**
itself, and does not comunicate with the running manager. Use

.if n \{.RS 4
.\}
    systemctl [--user] [--global] show -p UnitPath --value
.if n \{.RE
.\}

to retrieve the actual list that the manager uses, with any empty directories omitted.

**systemd-analyze log-level**
prints the current log level of the
**systemd**
daemon. If an optional argument
_LEVEL_
is provided, then the command changes the current log level of the
**systemd**
daemon to
_LEVEL_
(accepts the same values as
**--log-level=**
described in
**systemd**(1)).

**systemd-analyze log-target**
prints the current log target of the
**systemd**
daemon. If an optional argument
_TARGET_
is provided, then the command changes the current log target of the
**systemd**
daemon to
_TARGET_
(accepts the same values as
**--log-target=**, described in
**systemd**(1)).

**systemd-analyze syscall-filter ****[_SET**...]_
will list system calls contained in the specified system call set
_SET_, or all known sets if no sets are specified. Argument
_SET_
must include the
"@"
prefix.

**systemd-analyze verify**
will load unit files and print warnings if any errors are detected. Files specified on the command line will be loaded, but also any other units referenced by them. The full unit search path is formed by combining the directories for all command line arguments, and the usual unit load paths (variable
_$SYSTEMD\_UNIT\_PATH_
is supported, and may be used to replace or augment the compiled in set of unit load paths; see
**systemd.unit**(5)). All units files present in the directories containing the command line arguments will be used in preference to the other paths.

**systemd-analyze calendar**
will parse and normalize repetitive calendar time events, and will calculate when they will elapse next. This takes the same input as the
_OnCalendar=_
setting in
**systemd.timer**(5), following the syntax described in
**systemd.time**(7).

**systemd-analyze service-watchdogs**
prints the current state of service runtime watchdogs of the
**systemd**
daemon. If an optional boolean argument is provided, then globally enables or disables the service runtime watchdogs (**WatchdogSec=**) and emergency actions (e.g.
**OnFailure=**
or
**StartLimitAction=**); see
**systemd.service**(5). The hardware watchdog is not affected by this setting.

**systemd-analyze timespan**
parses a time span and outputs the equivalent value in microseconds, and as a reformatted timespan. The time span should adhere to the same syntax documented in
**systemd.time**(7). Values without associated magnitudes are parsed as seconds.

**systemd-analyze security**
analyzes the security and sandboxing settings of one or more specified service units. If at least one unit name is specified the security settings of the specified service units are inspected and a detailed analysis is shown. If no unit name is specified, all currently loaded, long-running service units are inspected and a terse table with results shown. The command checks for various security-related service settings, assigning each a numeric "exposure level" value, depending on how important a setting is. It then calculates an overall exposure level for the whole unit, which is an estimation in the range 0.0...10.0 indicating how exposed a service is security-wise. High exposure levels indicate very little applied sandboxing. Low exposure levels indicate tight sandboxing and strongest security restrictions. Note that this only analyzes the per-service security features systemd itself implements. This means that any additional security mechanisms applied by the service code itself are not accounted for. The exposure level determined this way should not be misunderstood: a high exposure level neither means that there is no effective sandboxing applied by the service code itself, nor that the service is actually vulnerable to remote or local attacks. High exposure levels do indicate however that most likely the service might benefit from additional settings applied to them. Please note that many of the security and sandboxing settings individually can be circumvented — unless combined with others. For example, if a service retains the privilege to establish or undo mount points many of the sandboxing options can be undone by the service code itself. Due to that is essential that each service uses the most comprehensive and strict sandboxing and security settings possible. The tool will take into account some of these combinations and relationships between the settings, but not all. Also note that the security and sandboxing settings analyzed here only apply to the operations executed by the service code itself. If a service has access to an IPC system (such as D-Bus) it might request operations from other services that are not subject to the same restrictions. Any comprehensive security and sandboxing analysis is hence incomplete if the IPC access policy is not validated too.

If no command is passed,
**systemd-analyze time**
is implied.

<a name="options"></a>

# Options


The following options are understood:

**--system**
Operates on the system systemd instance. This is the implied default.

**--user**
Operates on the user systemd instance.

**--global**
Operates on the system-wide configuration for user systemd instance.

**--order**, **--require**
When used in conjunction with the
**dot**
command (see above), selects which dependencies are shown in the dependency graph. If
**--order**
is passed, only dependencies of type
_After=_
or
_Before=_
are shown. If
**--require**
is passed, only dependencies of type
_Requires=_,
_Requisite=_,
_Wants=_
and
_Conflicts=_
are shown. If neither is passed, this shows dependencies of all these types.

**--from-pattern=**, **--to-pattern=**
When used in conjunction with the
**dot**
command (see above), this selects which relationships are shown in the dependency graph. Both options require a
**glob**(7)
pattern as an argument, which will be matched against the left-hand and the right-hand, respectively, nodes of a relationship.

Each of these can be used more than once, in which case the unit name must match one of the values. When tests for both sides of the relation are present, a relation must pass both tests to be shown. When patterns are also specified as positional arguments, they must match at least one side of the relation. In other words, patterns specified with those two options will trim the list of edges matched by the positional arguments, if any are given, and fully determine the list of edges shown otherwise.

**--fuzz=**_timespan_
When used in conjunction with the
**critical-chain**
command (see above), also show units, which finished
_timespan_
earlier, than the latest unit in the same level. The unit of
_timespan_
is seconds unless specified with a different unit, e.g. "50ms".

**--man=no**
Do not invoke man to verify the existence of man pages listed in
_Documentation=_.

**--generators**
Invoke unit generators, see
**systemd.generator**(7). Some generators require root privileges. Under a normal user, running with generators enabled will generally result in some warnings.

**--root=****PATH**
With
**cat-files**, show config files underneath the specified root path
_PATH_.

**-H**, **--host=**
Execute the operation remotely. Specify a hostname, or a username and hostname separated by
"@", to connect to. The hostname may optionally be suffixed by a port ssh is listening on, seperated by
":", and then a container name, separated by
"/", which connects directly to a specific container on the specified host. This will use SSH to talk to the remote machine manager instance. Container names may be enumerated with
**machinectl -H ****HOST**. Put IPv6 addresses in brackets.

**-M**, **--machine=**
Execute operation on a local container. Specify a container name to connect to.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**--no-pager**
Do not pipe output into a pager.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="examples-for-dot"></a>

# Examples for Dot


**Example&nbsp;2.&nbsp;Plots all dependencies of any unit whose name starts with "avahi-daemon"**

.if n \{.RS 4
.\}
    $ systemd-analyze dot avahi-daemon.**(Aq | dot -Tsvg > avahi.svg
    $ eog avahi.svg
.if n \{.RE
.\}

**Example&nbsp;3.&nbsp;Plots the dependencies between all known target units**

.if n \{.RS 4
.\}
    $ systemd-analyze dot --to-pattern=*.target*(Aq --from-pattern=*(Aq*.target*(Aq | dot -Tsvg > targets.svg
    $ eog targets.svg
.if n \{.RE
.\}

<a name="examples-for-verify"></a>

# Examples for Verify


The following errors are currently detected:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  unknown sections and directives,

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  missing dependencies which are required to start the given unit,

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  man pages listed in
  _Documentation=_
  which are not found in the system,

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  commands listed in
  _ExecStart=_
  and similar which are not found in the system or not executable.

**Example&nbsp;4.&nbsp;Misspelt directives**

.if n \{.RS 4
.\}
    $ cat ./user.slice
    [Unit]
    WhatIsThis=11
    Documentation=man:nosuchfile(1)
    Requires=different.service
    
    [Service]
    Description=x
    
    $ systemd-analyze verify ./user.slice
    [./user.slice:9] Unknown lvalue WhatIsThis*(Aq in section *(AqUnit*(Aq
    [./user.slice:13] Unknown section Service*(Aq. Ignoring.
    Error: org.freedesktop.systemd1.LoadFailed:
       Unit different.service failed to load:
       No such file or directory.
    Failed to create user.slice/start: Invalid argument
    user.slice: man nosuchfile(1) command failed with code 16
          
.if n \{.RE
.\}

**Example&nbsp;5.&nbsp;Missing service units**

.if n \{.RS 4
.\}
    $ tail ./a.socket ./b.socket
    ==> ./a.socket <==
    [Socket]
    ListenStream=100
    
    ==> ./b.socket <==
    [Socket]
    ListenStream=100
    Accept=yes
    
    $ systemd-analyze verify ./a.socket ./b.socket
    Service a.service not loaded, a.socket cannot be started.
    Service b@0.service not loaded, b.socket cannot be started.
          
.if n \{.RE
.\}

<a name="environment"></a>

# Environment


_$SYSTEMD\_PAGER_
Pager to use when
**--no-pager**
is not given; overrides
_$PAGER_. If neither
_$SYSTEMD\_PAGER_
nor
_$PAGER_
are set, a set of well-known pager implementations are tried in turn, including
**less**(1)
and
**more**(1), until one is found. If no pager implementation is discovered no pager is invoked. Setting this environment variable to an empty string or the value
"cat"
is equivalent to passing
**--no-pager**.

_$SYSTEMD\_LESS_
Override the options passed to
**less**
(by default
"FRSXMK").

If the value of
_$SYSTEMD\_LESS_
does not include
"K", and the pager that is invoked is
**less**,
Ctrl+C
will be ignored by the executable. This allows
**less**
to handle
Ctrl+C
itself.

_$SYSTEMD\_LESSCHARSET_
Override the charset passed to
**less**
(by default
"utf-8", if the invoking terminal is determined to be UTF-8 compatible).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1)
