# lit(1) - LLVM Integrated Tester

11, 2020-10-15

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```

 lit [options] [tests]
```

<a name="description"></a>

# Description


**lit** is a portable tool for executing LLVM and Clang style test
suites, summarizing their results, and providing indication of failures.
**lit** is designed to be a lightweight testing tool with as simple a
user interface as possible.

**lit** should be run with one or more _tests_ to run specified on the
command line.  Tests can be either individual test files or directories to
search for tests (see _TEST DISCOVERY_).

Each specified test will be executed (potentially in parallel) and once all
tests have been run **lit** will print summary information on the number
of tests which passed or failed (see _TEST STATUS RESULTS_).  The
**lit** program will execute with a non-zero exit code if any tests
fail.

By default **lit** will use a succinct progress display and will only
print summary information for test failures.  See _OUTPUT OPTIONS_ for
options controlling the **lit** progress display and output.

**lit** also includes a number of options for controlling how tests are
executed (specific features may depend on the particular test format).  See
_EXECUTION OPTIONS_ for more information.

Finally, **lit** also supports additional options for only running a
subset of the options specified on the command line, see
_SELECTION OPTIONS_ for more information.

**lit** parses options from the environment variable **LIT\_OPTS** after
parsing options from the command line.  **LIT\_OPTS** is primarily useful for
supplementing or overriding the command-line options supplied to **lit**
by **check** targets defined by a project's build system.

Users interested in the **lit** architecture or designing a
**lit** testing implementation should see _LIT INFRASTRUCTURE_.

<a name="general-options"></a>

# General Options

.INDENT 0.0

* **-h, --help**  
  Show the **lit** help message.
  .UNINDENT
  .INDENT 0.0
* **-j N, --workers=N**  
  Run **N** tests in parallel.  By default, this is automatically chosen to
  match the number of detected available CPUs.
  .UNINDENT
  .INDENT 0.0
* **--config-prefix=NAME**  
  Search for **NAME****.cfg** and **NAME****.site.cfg** when searching for
  test suites, instead of **lit.cfg** and **lit.site.cfg**.
  .UNINDENT
  .INDENT 0.0
* **-D NAME[=VALUE], --param NAME[=VALUE]**  
  Add a user defined parameter **NAME** with the given **VALUE** (or the empty
  string if not given).  The meaning and use of these parameters is test suite
  dependent.
  .UNINDENT

<a name="output-options"></a>

# Output Options

.INDENT 0.0

* **-q, --quiet**  
  Suppress any output except for test failures.
  .UNINDENT
  .INDENT 0.0
* **-s, --succinct**  
  Show less output, for example don't show information on tests that pass.
  .UNINDENT
  .INDENT 0.0
* **-v, --verbose**  
  Show more information on test failures, for example the entire test output
  instead of just the test result.
  .UNINDENT
  .INDENT 0.0
* **-vv, --echo-all-commands**  
  Echo all commands to stdout, as they are being executed.
  This can be valuable for debugging test failures, as the last echoed command
  will be the one which has failed.
  **lit** normally inserts a no-op command (**:** in the case of bash)
  with argument **'RUN: at line N'** before each command pipeline, and this
  option also causes those no-op commands to be echoed to stdout to help you
  locate the source line of the failed command.
  This option implies **--verbose**.
  .UNINDENT
  .INDENT 0.0
* **-a, --show-all**  
  Show more information about all tests, for example the entire test
  commandline and output.
  .UNINDENT
  .INDENT 0.0
* **--no-progress-bar**  
  Do not use curses based progress bar.
  .UNINDENT
  .INDENT 0.0
* **--show-unsupported**  
  Show the names of unsupported tests.
  .UNINDENT
  .INDENT 0.0
* **--show-xfail**  
  Show the names of tests that were expected to fail.
  .UNINDENT

<a name="execution-options"></a>

# Execution Options

.INDENT 0.0

* **--path=PATH**  
  Specify an additional **PATH** to use when searching for executables in tests.
  .UNINDENT
  .INDENT 0.0
* **--vg**  
  Run individual tests under valgrind (using the memcheck tool).  The
  **--error-exitcode** argument for valgrind is used so that valgrind failures
  will cause the program to exit with a non-zero status.

When this option is enabled, **lit** will also automatically provide a
"**valgrind**" feature that can be used to conditionally disable (or expect
failure in) certain tests.
.UNINDENT
.INDENT 0.0

* **--vg-arg=ARG**  
  When _--vg_ is used, specify an additional argument to pass to
  **valgrind** itself.
  .UNINDENT
  .INDENT 0.0
* **--vg-leak**  
  When _--vg_ is used, enable memory leak checks.  When this option is
  enabled, **lit** will also automatically provide a "**vg\_leak**"
  feature that can be used to conditionally disable (or expect failure in)
  certain tests.
  .UNINDENT
  .INDENT 0.0
* **--time-tests**  
  Track the wall time individual tests take to execute and includes the results
  in the summary output.  This is useful for determining which tests in a test
  suite take the most time to execute.  Note that this option is most useful
  with **-j 1**.
  .UNINDENT

<a name="selection-options"></a>

# Selection Options

.INDENT 0.0

* **--max-failures N**  
  Stop execution after the given number **N** of failures.
  An integer argument should be passed on the command line
  prior to execution.
  .UNINDENT
  .INDENT 0.0
* **--max-tests=N**  
  Run at most **N** tests and then terminate.
  .UNINDENT
  .INDENT 0.0
* **--max-time=N**  
  Spend at most **N** seconds (approximately) running tests and then terminate.
  Note that this is not an alias for _--timeout_; the two are
  different kinds of maximums.
  .UNINDENT
  .INDENT 0.0
* **--num-shards=M**  
  Divide the set of selected tests into **M** equal-sized subsets or
  "shards", and run only one of them.  Must be used with the
  **--run-shard=N** option, which selects the shard to run. The environment
  variable **LIT\_NUM\_SHARDS** can also be used in place of this
  option. These two options provide a coarse mechanism for partitioning large
  testsuites, for parallel execution on separate machines (say in a large
  testing farm).
  .UNINDENT
  .INDENT 0.0
* **--run-shard=N**  
  Select which shard to run, assuming the **--num-shards=M** option was
  provided. The two options must be used together, and the value of **N**
  must be in the range **1..M**. The environment variable
  **LIT\_RUN\_SHARD** can also be used in place of this option.
  .UNINDENT
  .INDENT 0.0
* **--shuffle**  
  Run the tests in a random order.
  .UNINDENT
  .INDENT 0.0
* **--timeout=N**  
  Spend at most **N** seconds (approximately) running each individual test.
  **0** means no time limit, and **0** is the default. Note that this is not an
  alias for _--max-time_; the two are different kinds of maximums.
  .UNINDENT
  .INDENT 0.0
* **--filter=REGEXP**  
  Run only those tests whose name matches the regular expression specified in
  **REGEXP**. The environment variable **LIT\_FILTER** can be also used in place
  of this option, which is especially useful in environments where the call
  to **lit** is issued indirectly.
  .UNINDENT

<a name="additional-options"></a>

# Additional Options

.INDENT 0.0

* **--debug**  
  Run **lit** in debug mode, for debugging configuration issues and
  **lit** itself.
  .UNINDENT
  .INDENT 0.0
* **--show-suites**  
  List the discovered test suites and exit.
  .UNINDENT
  .INDENT 0.0
* **--show-tests**  
  List all of the discovered tests and exit.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**lit** will exit with an exit code of 1 if there are any FAIL or XPASS
results.  Otherwise, it will exit with the status 0.  Other exit codes are used
for non-test related failures (for example a user error or an internal program
error).

<a name="test-discovery"></a>

# Test Discovery


The inputs passed to **lit** can be either individual tests, or entire
directories or hierarchies of tests to run.  When **lit** starts up, the
first thing it does is convert the inputs into a complete list of tests to run
as part of _test discovery_.

In the **lit** model, every test must exist inside some _test suite_.
**lit** resolves the inputs specified on the command line to test suites
by searching upwards from the input path until it finds a **lit.cfg** or
**lit.site.cfg** file.  These files serve as both a marker of test suites
and as configuration files which **lit** loads in order to understand
how to find and run the tests inside the test suite.

Once **lit** has mapped the inputs into test suites it traverses the
list of inputs adding tests for individual files and recursively searching for
tests in directories.

This behavior makes it easy to specify a subset of tests to run, while still
allowing the test suite configuration to control exactly how tests are
interpreted.  In addition, **lit** always identifies tests by the test
suite they are in, and their relative path inside the test suite.  For
appropriately configured projects, this allows **lit** to provide
convenient and flexible support for out-of-tree builds.

<a name="test-status-results"></a>

# Test Status Results


Each test ultimately produces one of the following eight results:

**PASS**
.INDENT 0.0
.INDENT 3.5
The test succeeded.
.UNINDENT
.UNINDENT

**FLAKYPASS**
.INDENT 0.0
.INDENT 3.5
The test succeeded after being re-run more than once. This only applies to
tests containing an **ALLOW\_RETRIES:** annotation.
.UNINDENT
.UNINDENT

**XFAIL**
.INDENT 0.0
.INDENT 3.5
The test failed, but that is expected.  This is used for test formats which allow
specifying that a test does not currently work, but wish to leave it in the test
suite.
.UNINDENT
.UNINDENT

**XPASS**
.INDENT 0.0
.INDENT 3.5
The test succeeded, but it was expected to fail.  This is used for tests which
were specified as expected to fail, but are now succeeding (generally because
the feature they test was broken and has been fixed).
.UNINDENT
.UNINDENT

**FAIL**
.INDENT 0.0
.INDENT 3.5
The test failed.
.UNINDENT
.UNINDENT

**UNRESOLVED**
.INDENT 0.0
.INDENT 3.5
The test result could not be determined.  For example, this occurs when the test
could not be run, the test itself is invalid, or the test was interrupted.
.UNINDENT
.UNINDENT

**UNSUPPORTED**
.INDENT 0.0
.INDENT 3.5
The test is not supported in this environment.  This is used by test formats
which can report unsupported tests.
.UNINDENT
.UNINDENT

**TIMEOUT**
.INDENT 0.0
.INDENT 3.5
The test was run, but it timed out before it was able to complete. This is
considered a failure.
.UNINDENT
.UNINDENT

Depending on the test format tests may produce additional information about
their status (generally only for failures).  See the _OUTPUT OPTIONS_
section for more information.

<a name="lit-infrastructure"></a>

# Lit Infrastructure


This section describes the **lit** testing architecture for users interested in
creating a new **lit** testing implementation, or extending an existing one.

**lit** proper is primarily an infrastructure for discovering and running
arbitrary tests, and to expose a single convenient interface to these
tests. **lit** itself doesn't know how to run tests, rather this logic is
defined by _test suites_.

<a name="test-suites"></a>

### TEST SUITES


As described in _TEST DISCOVERY_, tests are always located inside a test
suite.  Test suites serve to define the format of the tests they contain, the
logic for finding those tests, and any additional information to run the tests.

**lit** identifies test suites as directories containing **lit.cfg** or
**lit.site.cfg** files (see also _--config-prefix_).  Test suites are
initially discovered by recursively searching up the directory hierarchy for
all the input files passed on the command line.  You can use
_--show-suites_ to display the discovered test suites at startup.

Once a test suite is discovered, its config file is loaded.  Config files
themselves are Python modules which will be executed.  When the config file is
executed, two important global variables are predefined:

**lit\_config**
.INDENT 0.0
.INDENT 3.5
The global **lit** configuration object (a _LitConfig_ instance), which defines
the builtin test formats, global configuration parameters, and other helper
routines for implementing test configurations.
.UNINDENT
.UNINDENT

**config**
.INDENT 0.0
.INDENT 3.5
This is the config object (a _TestingConfig_ instance) for the test suite,
which the config file is expected to populate.  The following variables are also
available on the _config_ object, some of which must be set by the config and
others are optional or predefined:

**name** _[required]_ The name of the test suite, for use in reports and
diagnostics.

**test\_format** _[required]_ The test format object which will be used to
discover and run tests in the test suite.  Generally this will be a builtin test
format available from the _lit.formats_ module.

**test\_source\_root** The filesystem path to the test suite root.  For out-of-dir
builds this is the directory that will be scanned for tests.

**test\_exec\_root** For out-of-dir builds, the path to the test suite root inside
the object directory.  This is where tests will be run and temporary output files
placed.

**environment** A dictionary representing the environment to use when executing
tests in the suite.

**suffixes** For **lit** test formats which scan directories for tests, this
variable is a list of suffixes to identify test files.  Used by: _ShTest_.

**substitutions** For **lit** test formats which substitute variables into a test
script, the list of substitutions to perform.  Used by: _ShTest_.

**unsupported** Mark an unsupported directory, all tests within it will be
reported as unsupported.  Used by: _ShTest_.

**parent** The parent configuration, this is the config object for the directory
containing the test suite, or None.

**root** The root configuration.  This is the top-most **lit** configuration in
the project.

**pipefail** Normally a test using a shell pipe fails if any of the commands
on the pipe fail. If this is not desired, setting this variable to false
makes the test fail only if the last command in the pipe fails.

**available\_features** A set of features that can be used in _XFAIL_,
_REQUIRES_, and _UNSUPPORTED_ directives.
.UNINDENT
.UNINDENT

<a name="test-discovery"></a>

### TEST DISCOVERY


Once test suites are located, **lit** recursively traverses the source
directory (following _test\_source\_root_) looking for tests.  When **lit**
enters a sub-directory, it first checks to see if a nested test suite is
defined in that directory.  If so, it loads that test suite recursively,
otherwise it instantiates a local test config for the directory (see
_LOCAL CONFIGURATION FILES_).

Tests are identified by the test suite they are contained within, and the
relative path inside that suite.  Note that the relative path may not refer to
an actual file on disk; some test formats (such as _GoogleTest_) define
"virtual tests" which have a path that contains both the path to the actual
test file and a subpath to identify the virtual test.

<a name="local-configuration-files"></a>

### LOCAL CONFIGURATION FILES


When **lit** loads a subdirectory in a test suite, it instantiates a
local test configuration by cloning the configuration for the parent directory
--- the root of this configuration chain will always be a test suite.  Once the
test configuration is cloned **lit** checks for a _lit.local.cfg_ file
in the subdirectory.  If present, this file will be loaded and can be used to
specialize the configuration for each individual directory.  This facility can
be used to define subdirectories of optional tests, or to change other
configuration parameters --- for example, to change the test format, or the
suffixes which identify test files.

<a name="substitutions"></a>

### SUBSTITUTIONS


**lit** allows patterns to be substituted inside RUN commands. It also
provides the following base set of substitutions, which are defined in
TestRunner.py:
.INDENT 0.0
.INDENT 3.5
.TS
center;
|l|l|.
_
T{
Macro
T}	T{
Substitution
T}
_
T{
%s
T}	T{
source path (path to the file currently being run)
T}
_
T{
%S
T}	T{
source dir (directory of the file currently being run)
T}
_
T{
%p
T}	T{
same as %S
T}
_
T{
%{pathsep}
T}	T{
path separator
T}
_
T{
%t
T}	T{
temporary file name unique to the test
T}
_
T{
%basename_t
T}	T{
The last path component of %t but without the **.tmp** extension
T}
_
T{
%T
T}	T{
parent directory of %t (not unique, deprecated, do not use)
T}
_
T{
%%
T}	T{
%
T}
_
T{
%/s
T}	T{
%s but **\e** is replaced by **/**
T}
_
T{
%/S
T}	T{
%S but **\e** is replaced by **/**
T}
_
T{
%/p
T}	T{
%p but **\e** is replaced by **/**
T}
_
T{
%/t
T}	T{
%t but **\e** is replaced by **/**
T}
_
T{
%/T
T}	T{
%T but **\e** is replaced by **/**
T}
_
T{
%{/s:regex_replacement}
T}	T{
%/s but escaped for use in the replacement of a **s@@@** command in sed
T}
_
T{
%{/S:regex_replacement}
T}	T{
%/S but escaped for use in the replacement of a **s@@@** command in sed
T}
_
T{
%{/p:regex_replacement}
T}	T{
%/p but escaped for use in the replacement of a **s@@@** command in sed
T}
_
T{
%{/t:regex_replacement}
T}	T{
%/t but escaped for use in the replacement of a **s@@@** command in sed
T}
_
T{
%{/T:regex_replacement}
T}	T{
%/T but escaped for use in the replacement of a **s@@@** command in sed
T}
_
T{
%:s
T}	T{
On Windows, %/s but a **:** is removed if its the second character.
Otherwise, %s but with a single leading **/** removed.
T}
_
T{
%:S
T}	T{
On Windows, %/S but a **:** is removed if its the second character.
Otherwise, %S but with a single leading **/** removed.
T}
_
T{
%:p
T}	T{
On Windows, %/p but a **:** is removed if its the second character.
Otherwise, %p but with a single leading **/** removed.
T}
_
T{
%:t
T}	T{
On Windows, %/t but a **:** is removed if its the second character.
Otherwise, %t but with a single leading **/** removed.
T}
_
T{
%:T
T}	T{
On Windows, %/T but a **:** is removed if its the second character.
Otherwise, %T but with a single leading **/** removed.
T}
_
.TE
.UNINDENT
.UNINDENT

Other substitutions are provided that are variations on this base set and
further substitution patterns can be defined by each test module. See the
modules _LOCAL CONFIGURATION FILES_.

By default, substitutions are expanded exactly once, so that if e.g. a
substitution **%build** is defined in top of another substitution **%cxx**,
**%build** will expand to **%cxx** textually, not to what **%cxx** expands to.
However, if the **recursiveExpansionLimit** property of the **TestingConfig**
is set to a non-negative integer, substitutions will be expanded recursively
until that limit is reached. It is an error if the limit is reached and
expanding substitutions again would yield a different result.

More detailed information on substitutions can be found in the
../TestingGuide.

<a name="test-run-output-format"></a>

### TEST RUN OUTPUT FORMAT


The **lit** output for a test run conforms to the following schema, in
both short and verbose modes (although in short mode no PASS lines will be
shown).  This schema has been chosen to be relatively easy to reliably parse by
a machine (for example in buildbot log scraping), and for other tools to
generate.

Each test result is expected to appear on a line that matches:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <result code>: <test name> (<progress info>)
    .ft P
.UNINDENT
.UNINDENT

where **&lt;result-code&gt;** is a standard test result such as PASS, FAIL, XFAIL,
XPASS, UNRESOLVED, or UNSUPPORTED.  The performance result codes of IMPROVED and
REGRESSED are also allowed.

The **&lt;test name&gt;** field can consist of an arbitrary string containing no
newline.

The **&lt;progress info&gt;** field can be used to report progress information such
as (1/300) or can be empty, but even when empty the parentheses are required.

Each test result may include additional (multiline) log information in the
following format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <log delineator> TEST '(<test name>)' <trailing delineator>
    ... log message ...
    <log delineator>
    .ft P
.UNINDENT
.UNINDENT

where **&lt;test name&gt;** should be the name of a preceding reported test, &lt;log
delineator&gt; is a string of "*" characters _at least_ four characters long
(the recommended length is 20), and **&lt;trailing delineator&gt;** is an arbitrary
(unparsed) string.

The following is an example of a test run output which consists of four tests A,
B, C, and D, and a log message for the failing test C:
.INDENT 0.0
.INDENT 3.5

    .ft C
    PASS: A (1 of 4)
    PASS: B (2 of 4)
    FAIL: C (3 of 4)
    ******************** TEST 'C' FAILED ********************
    Test 'C' failed as a result of exit code 1.
    ********************
    PASS: D (4 of 4)
    .ft P
.UNINDENT
.UNINDENT

<a name="lit-example-tests"></a>

### LIT EXAMPLE TESTS


The **lit** distribution contains several example implementations of
test suites in the _ExampleTests_ directory.

<a name="see-also"></a>

# See Also


valgrind(1)

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

