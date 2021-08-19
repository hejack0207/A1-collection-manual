# ctest(1) - CTest Command-Line Reference

3.17.2, Apr 28, 2020

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

<a name="contents"></a>

### Contents

.INDENT 0.0

* ·  
  _ctest(1)_
  .INDENT 2.0
* ·  
  _Synopsis_
* ·  
  _Description_
* ·  
  _Options_
* ·  
  _Label and Subproject Summary_
* ·  
  _Build and Test Mode_
* ·  
  _Dashboard Client_
  .INDENT 2.0
* ·  
  _Dashboard Client Steps_
* ·  
  _Dashboard Client Modes_
* ·  
  _Dashboard Client via CTest Command-Line_
* ·  
  _Dashboard Client via CTest Script_
  .UNINDENT
* ·  
  _Dashboard Client Configuration_
  .INDENT 2.0
* ·  
  _CTest Start Step_
* ·  
  _CTest Update Step_
* ·  
  _CTest Configure Step_
* ·  
  _CTest Build Step_
* ·  
  _CTest Test Step_
* ·  
  _CTest Coverage Step_
* ·  
  _CTest MemCheck Step_
* ·  
  _CTest Submit Step_
  .UNINDENT
* ·  
  _Show as JSON Object Model_
* ·  
  _Resource Allocation_
  .INDENT 2.0
* ·  
  _Resource Specification File_
* ·  
  _RESOURCE_GROUPS Property_
* ·  
  _Environment Variables_
  .UNINDENT
* ·  
  _See Also_
  .UNINDENT
  .UNINDENT

<a name="synopsis"></a>

# Synopsis

```
.INDENT 0.0 .INDENT 3.5 

</synopsis>
    .ft C
    ctest [<options>]
    ctest --build-and-test <path-to-source> <path-to-build>
          --build-generator <generator> [<options>...]
          [--build-options <opts>...] [--test-command <command> [<args>...]]
    ctest {-D <dashboard> | -M <model> -T <action> | -S <script> | -SP <script>}
          [-- <dashboard-options>...]
    .ft P
<synopsis>
.UNINDENT .UNINDENT
```

<a name="description"></a>

# Description


The **ctest** executable is the CMake test driver program.
CMake-generated build trees created for projects that use the
**enable\_testing()** and **add\_test()** commands have testing support.
This program will run the tests and report results.

<a name="options"></a>

# Options

.INDENT 0.0

* <b>**-C &lt;cfg&gt;, --build-config &lt;cfg&gt;**</b>  
  Choose configuration to test.

Some CMake-generated build trees can have multiple build
configurations in the same tree.  This option can be used to specify
which one should be tested.  Example configurations are **Debug** and
**Release**.

* <b>**--progress**</b>  
  Enable short progress output from tests.

When the output of **ctest** is being sent directly to a terminal, the
progress through the set of tests is reported by updating the same line
rather than printing start and end messages for each test on new lines.
This can significantly reduce the verbosity of the test output.
Test completion messages are still output on their own line for failed
tests and the final test summary will also still be logged.

This option can also be enabled by setting the environment variable
**CTEST\_PROGRESS\_OUTPUT**.

* <b>**-V,--verbose**</b>  
  Enable verbose output from tests.

Test output is normally suppressed and only summary information is
displayed.  This option will show all test output.

* <b>**-VV,--extra-verbose**</b>  
  Enable more verbose output from tests.

Test output is normally suppressed and only summary information is
displayed.  This option will show even more test output.

* <b>**--debug**</b>  
  Displaying more verbose internals of CTest.

This feature will result in a large number of output that is mostly
useful for debugging dashboard problems.

* <b>**--output-on-failure**</b>  
  Output anything outputted by the test program if the test should fail.
  This option can also be enabled by setting the
  **CTEST\_OUTPUT\_ON\_FAILURE** environment variable
* <b>**-F**</b>  
  Enable failover.

This option allows CTest to resume a test set execution that was
previously interrupted.  If no interruption occurred, the **-F** option
will have no effect.

* <b>**-j &lt;jobs&gt;, --parallel &lt;jobs&gt;**</b>  
  Run the tests in parallel using the given number of jobs.

This option tells CTest to run the tests in parallel using given
number of jobs. This option can also be set by setting the
**CTEST\_PARALLEL\_LEVEL** environment variable.

This option can be used with the **PROCESSORS** test property.

See _Label and Subproject Summary_.

* <b>**--resource-spec-file &lt;file&gt;**</b>  
  Run CTest with _resource allocation_ enabled,
  using the
  _resource specification file_
  specified in **&lt;file&gt;**.

When **ctest** is run as a _Dashboard Client_ this sets the
**ResourceSpecFile** option of the _CTest Test Step_.

* <b>**--test-load &lt;level&gt;**</b>  
  While running tests in parallel (e.g. with **-j**), try not to start
  tests when they may cause the CPU load to pass above a given threshold.

When **ctest** is run as a _Dashboard Client_ this sets the
**TestLoad** option of the _CTest Test Step_.

* <b>**-Q,--quiet**</b>  
  Make CTest quiet.

This option will suppress all the output.  The output log file will
still be generated if the **--output-log** is specified.  Options such
as **--verbose**, **--extra-verbose**, and **--debug** are ignored
if **--quiet** is specified.

* <b>**-O &lt;file&gt;, --output-log &lt;file&gt;**</b>  
  Output to log file.

This option tells CTest to write all its output to a **&lt;file&gt;** log file.

* <b>**-N,--show-only[=&lt;format&gt;]**</b>  
  Disable actual execution of tests.

This option tells CTest to list the tests that would be run but not
actually run them.  Useful in conjunction with the **-R** and **-E**
options.

**&lt;format&gt;** can be one of the following values.
.INDENT 7.0
.INDENT 3.5
.INDENT 0.0

* <b>**human**</b>  
  Human-friendly output.  This is not guaranteed to be stable.
  This is the default.
* <b>**json-v1**</b>  
  Dump the test information in JSON format.
  See _Show as JSON Object Model_.
  .UNINDENT
  .UNINDENT
  .UNINDENT
* <b>**-L &lt;regex&gt;, --label-regex &lt;regex&gt;**</b>  
  Run tests with labels matching regular expression.

This option tells CTest to run only the tests whose labels match the
given regular expression.

* <b>**-R &lt;regex&gt;, --tests-regex &lt;regex&gt;**</b>  
  Run tests matching regular expression.

This option tells CTest to run only the tests whose names match the
given regular expression.

* <b>**-E &lt;regex&gt;, --exclude-regex &lt;regex&gt;**</b>  
  Exclude tests matching regular expression.

This option tells CTest to NOT run the tests whose names match the
given regular expression.

* <b>**-LE &lt;regex&gt;, --label-exclude &lt;regex&gt;**</b>  
  Exclude tests with labels matching regular expression.

This option tells CTest to NOT run the tests whose labels match the
given regular expression.

* <b>**-FA &lt;regex&gt;, --fixture-exclude-any &lt;regex&gt;**</b>  
  Exclude fixtures matching **&lt;regex&gt;** from automatically adding any tests to
  the test set.

If a test in the set of tests to be executed requires a particular fixture,
that fixture’s setup and cleanup tests would normally be added to the test set
automatically. This option prevents adding setup or cleanup tests for fixtures
matching the **&lt;regex&gt;**. Note that all other fixture behavior is retained,
including test dependencies and skipping tests that have fixture setup tests
that fail.

* <b>**-FS &lt;regex&gt;, --fixture-exclude-setup &lt;regex&gt;**</b>  
  Same as **-FA** except only matching setup tests are excluded.
* <b>**-FC &lt;regex&gt;, --fixture-exclude-cleanup &lt;regex&gt;**</b>  
  Same as **-FA** except only matching cleanup tests are excluded.
* <b>**-D &lt;dashboard&gt;, --dashboard &lt;dashboard&gt;**</b>  
  Execute dashboard test.

This option tells CTest to act as a CDash client and perform a
dashboard test.  All tests are **&lt;Mode&gt;&lt;Test&gt;**, where **&lt;Mode&gt;** can be
**Experimental**, **Nightly**, and **Continuous**, and **&lt;Test&gt;** can be
**Start**, **Update**, **Configure**, **Build**, **Test**,
**Coverage**, and **Submit**.

See _Dashboard Client_.

* <b>**-D &lt;var&gt;:&lt;type&gt;=&lt;value&gt;**</b>  
  Define a variable for script mode.

Pass in variable values on the command line.  Use in conjunction
with **-S** to pass variable values to a dashboard script.  Parsing **-D**
arguments as variable values is only attempted if the value
following **-D** does not match any of the known dashboard types.

* <b>**-M &lt;model&gt;, --test-model &lt;model&gt;**</b>  
  Sets the model for a dashboard.

This option tells CTest to act as a CDash client where the **&lt;model&gt;**
can be **Experimental**, **Nightly**, and **Continuous**.
Combining **-M** and **-T** is similar to **-D**.

See _Dashboard Client_.

* <b>**-T &lt;action&gt;, --test-action &lt;action&gt;**</b>  
  Sets the dashboard action to perform.

This option tells CTest to act as a CDash client and perform some
action such as **start**, **build**, **test** etc. See
_Dashboard Client Steps_ for the full list of actions.
Combining **-M** and **-T** is similar to **-D**.

See _Dashboard Client_.

* <b>**-S &lt;script&gt;, --script &lt;script&gt;**</b>  
  Execute a dashboard for a configuration.

This option tells CTest to load in a configuration script which sets
a number of parameters such as the binary and source directories.
Then CTest will do what is required to create and run a dashboard.
This option basically sets up a dashboard and then runs **ctest -D**
with the appropriate options.

See _Dashboard Client_.

* <b>**-SP &lt;script&gt;, --script-new-process &lt;script&gt;**</b>  
  Execute a dashboard for a configuration.

This option does the same operations as **-S** but it will do them in a
separate process.  This is primarily useful in cases where the
script may modify the environment and you do not want the modified
environment to impact other **-S** scripts.

See _Dashboard Client_.

* <b>**-I [Start,End,Stride,test#,test#|Test file], --tests-information**</b>  
  Run a specific number of tests by number.

This option causes CTest to run tests starting at number **Start**,
ending at number **End**, and incrementing by **Stride**.  Any additional
numbers after **Stride** are considered individual test numbers.  **Start**,
**End**, or **Stride** can be empty.  Optionally a file can be given that
contains the same syntax as the command line.

* <b>**-U, --union**</b>  
  Take the Union of **-I** and **-R**.

When both **-R** and **-I** are specified by default the intersection of
tests are run.  By specifying **-U** the union of tests is run instead.

* <b>**--rerun-failed**</b>  
  Run only the tests that failed previously.

This option tells CTest to perform only the tests that failed during
its previous run.  When this option is specified, CTest ignores all
other options intended to modify the list of tests to run (**-L**, **-R**,
**-E**, **-LE**, **-I**, etc).  In the event that CTest runs and no tests
fail, subsequent calls to CTest with the **--rerun-failed** option will run
the set of tests that most recently failed (if any).

* <b>**--repeat &lt;mode&gt;:&lt;n&gt;**</b>  
  Run tests repeatedly based on the given **&lt;mode&gt;** up to **&lt;n&gt;** times.
  The modes are:
  .INDENT 7.0
* <b>**until-fail**</b>  
  Require each test to run **&lt;n&gt;** times without failing in order to pass.
  This is useful in finding sporadic failures in test cases.
* <b>**until-pass**</b>  
  Allow each test to run up to **&lt;n&gt;** times in order to pass.
  Repeats tests if they fail for any reason.
  This is useful in tolerating sporadic failures in test cases.
* <b>**after-timeout**</b>  
  Allow each test to run up to **&lt;n&gt;** times in order to pass.
  Repeats tests only if they timeout.
  This is useful in tolerating sporadic timeouts in test cases
  on busy machines.
  .UNINDENT
* <b>**--repeat-until-fail &lt;n&gt;**</b>  
  Equivalent to **--repeat until-fail:&lt;n&gt;**.
* <b>**--max-width &lt;width&gt;**</b>  
  Set the max width for a test name to output.

Set the maximum width for each test name to show in the output.
This allows the user to widen the output to avoid clipping the test
name which can be very annoying.

* <b>**--interactive-debug-mode [0|1]**</b>  
  Set the interactive mode to **0** or **1**.

This option causes CTest to run tests in either an interactive mode
or a non-interactive mode.  On Windows this means that in
non-interactive mode, all system debug pop up windows are blocked.
In dashboard mode (**Experimental**, **Nightly**, **Continuous**), the default
is non-interactive.  When just running tests not for a dashboard the
default is to allow popups and interactive debugging.

* <b>**--no-label-summary**</b>  
  Disable timing summary information for labels.

This option tells CTest not to print summary information for each
label associated with the tests run.  If there are no labels on the
tests, nothing extra is printed.

See _Label and Subproject Summary_.

* <b>**--no-subproject-summary**</b>  
  Disable timing summary information for subprojects.

This option tells CTest not to print summary information for each
subproject associated with the tests run.  If there are no subprojects on the
tests, nothing extra is printed.

See _Label and Subproject Summary_.
.UNINDENT

**--build-and-test**
See _Build and Test Mode_.
.INDENT 0.0

* <b>**--test-output-size-passed &lt;size&gt;**</b>  
  Limit the output for passed tests to **&lt;size&gt;** bytes.
* <b>**--test-output-size-failed &lt;size&gt;**</b>  
  Limit the output for failed tests to **&lt;size&gt;** bytes.
* <b>**--overwrite**</b>  
  Overwrite CTest configuration option.

By default CTest uses configuration options from configuration file.
This option will overwrite the configuration option.

* <b>**--force-new-ctest-process**</b>  
  Run child CTest instances as new processes.

By default CTest will run child CTest instances within the same
process.  If this behavior is not desired, this argument will
enforce new processes for child CTest processes.

* <b>**--schedule-random**</b>  
  Use a random order for scheduling tests.

This option will run the tests in a random order.  It is commonly
used to detect implicit dependencies in a test suite.

* <b>**--submit-index**</b>  
  Legacy option for old Dart2 dashboard server feature.
  Do not use.
* <b>**--timeout &lt;seconds&gt;**</b>  
  Set the default test timeout.

This option effectively sets a timeout on all tests that do not
already have a timeout set on them via the **TIMEOUT**
property.

* <b>**--stop-time &lt;time&gt;**</b>  
  Set a time at which all tests should stop running.

Set a real time of day at which all tests should timeout.  Example:
**7:00:00 -0400**.  Any time format understood by the curl date parser
is accepted.  Local time is assumed if no timezone is specified.

* <b>**--print-labels**</b>  
  Print all available test labels.

This option will not run any tests, it will simply print the list of
all labels associated with the test set.

* <b>**--no-tests=&lt;[error|ignore]&gt;**</b>  
  Regard no tests found either as error or ignore it.

If no tests were found, the default behavior of CTest is to always log an
error message but to return an error code in script mode only.  This option
unifies the behavior of CTest by either returning an error code if no tests
were found or by ignoring it.
.UNINDENT
.INDENT 0.0

* <b>**--help,-help,-usage,-h,-H,/?**</b>  
  Print usage information and exit.

Usage describes the basic command line interface and its options.

* <b>**--version,-version,/V [&lt;f&gt;]**</b>  
  Show program name/version banner and exit.

If a file is specified, the version is written into it.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-full [&lt;f&gt;]**</b>  
  Print all help manuals and exit.

All manuals are printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-manual &lt;man&gt; [&lt;f&gt;]**</b>  
  Print one help manual and exit.

The specified manual is printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-manual-list [&lt;f&gt;]**</b>  
  List help manuals available and exit.

The list contains all manuals for which help may be obtained by
using the **--help-manual** option followed by a manual name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-command &lt;cmd&gt; [&lt;f&gt;]**</b>  
  Print help for one command and exit.

The **cmake-commands(7)** manual entry for **&lt;cmd&gt;** is
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-command-list [&lt;f&gt;]**</b>  
  List commands with help available and exit.

The list contains all commands for which help may be obtained by
using the **--help-command** option followed by a command name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-commands [&lt;f&gt;]**</b>  
  Print cmake-commands manual and exit.

The **cmake-commands(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-module &lt;mod&gt; [&lt;f&gt;]**</b>  
  Print help for one module and exit.

The **cmake-modules(7)** manual entry for **&lt;mod&gt;** is printed
in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-module-list [&lt;f&gt;]**</b>  
  List modules with help available and exit.

The list contains all modules for which help may be obtained by
using the **--help-module** option followed by a module name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-modules [&lt;f&gt;]**</b>  
  Print cmake-modules manual and exit.

The **cmake-modules(7)** manual is printed in a human-readable
text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-policy &lt;cmp&gt; [&lt;f&gt;]**</b>  
  Print help for one policy and exit.

The **cmake-policies(7)** manual entry for **&lt;cmp&gt;** is
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-policy-list [&lt;f&gt;]**</b>  
  List policies with help available and exit.

The list contains all policies for which help may be obtained by
using the **--help-policy** option followed by a policy name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-policies [&lt;f&gt;]**</b>  
  Print cmake-policies manual and exit.

The **cmake-policies(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-property &lt;prop&gt; [&lt;f&gt;]**</b>  
  Print help for one property and exit.

The **cmake-properties(7)** manual entries for **&lt;prop&gt;** are
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-property-list [&lt;f&gt;]**</b>  
  List properties with help available and exit.

The list contains all properties for which help may be obtained by
using the **--help-property** option followed by a property name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-properties [&lt;f&gt;]**</b>  
  Print cmake-properties manual and exit.

The **cmake-properties(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-variable &lt;var&gt; [&lt;f&gt;]**</b>  
  Print help for one variable and exit.

The **cmake-variables(7)** manual entry for **&lt;var&gt;** is
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-variable-list [&lt;f&gt;]**</b>  
  List variables with help available and exit.

The list contains all variables for which help may be obtained by
using the **--help-variable** option followed by a variable name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-variables [&lt;f&gt;]**</b>  
  Print cmake-variables manual and exit.

The **cmake-variables(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.
.UNINDENT

<a name="label-and-subproject-summary"></a>

# Label and Subproject Summary


CTest prints timing summary information for each **LABEL** and subproject
associated with the tests run. The label time summary will not include labels
that are mapped to subprojects.

When the **PROCESSORS** test property is set, CTest will display a
weighted test timing result in label and subproject summaries. The time is
reported with _sec*proc_ instead of just _sec_.

The weighted time summary reported for each label or subproject **j**
is computed as:
.INDENT 0.0
.INDENT 3.5

    .ft C
    Weighted Time Summary for Label/Subproject j =
        sum(raw_test_time[j,i] * num_processors[j,i], i=1...num_tests[j])
    
    for labels/subprojects j=1...total
    .ft P
.UNINDENT
.UNINDENT

where:
.INDENT 0.0

* ·  
  **raw\_test\_time[j,i]**: Wall-clock time for the **i** test
  for the **j** label or subproject
* ·  
  **num\_processors[j,i]**: Value of the CTest **PROCESSORS** property
  for the **i** test for the **j** label or subproject
* ·  
  **num\_tests[j]**: Number of tests associated with the **j** label or subproject
* ·  
  **total**: Total number of labels or subprojects that have at least one test run
  .UNINDENT

Therefore, the weighted time summary for each label or subproject represents
the amount of time that CTest gave to run the tests for each label or
subproject and gives a good representation of the total expense of the tests
for each label or subproject when compared to other labels or subprojects.

For example, if **SubprojectA** showed **100 sec*proc** and **SubprojectB** showed
**10 sec*proc**, then CTest allocated approximately 10 times the CPU/core time
to run the tests for **SubprojectA** than for **SubprojectB** (e.g. so if effort
is going to be expended to reduce the cost of the test suite for the whole
project, then reducing the cost of the test suite for **SubprojectA** would
likely have a larger impact than effort to reduce the cost of the test suite
for **SubprojectB**).

<a name="build-and-test-mode"></a>

# Build and Test Mode


CTest provides a command-line signature to configure (i.e. run cmake on),
build, and/or execute a test:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest --build-and-test <path-to-source> <path-to-build>
          --build-generator <generator>
          [<options>...]
          [--build-options <opts>...]
          [--test-command <command> [<args>...]]
    .ft P
.UNINDENT
.UNINDENT

The configure and test steps are optional. The arguments to this command line
are the source and binary directories.  The **--build-generator** option _must_
be provided to use **--build-and-test**.  If **--test-command** is specified
then that will be run after the build is complete.  Other options that affect
this mode include:
.INDENT 0.0

* <b>**--build-target**</b>  
  Specify a specific target to build.

If left out the **all** target is built.

* <b>**--build-nocmake**</b>  
  Run the build without running cmake first.

Skip the cmake step.

* <b>**--build-run-dir**</b>  
  Specify directory to run programs from.

Directory where programs will be after it has been compiled.

* <b>**--build-two-config**</b>  
  Run CMake twice.
* <b>**--build-exe-dir**</b>  
  Specify the directory for the executable.
* <b>**--build-generator**</b>  
  Specify the generator to use. See the **cmake-generators(7)** manual.
* <b>**--build-generator-platform**</b>  
  Specify the generator-specific platform.
* <b>**--build-generator-toolset**</b>  
  Specify the generator-specific toolset.
* <b>**--build-project**</b>  
  Specify the name of the project to build.
* <b>**--build-makeprogram**</b>  
  Specify the explicit make program to be used by CMake when configuring and
  building the project. Only applicable for Make and Ninja based generators.
* <b>**--build-noclean**</b>  
  Skip the make clean step.
* <b>**--build-config-sample**</b>  
  A sample executable to use to determine the configuration that
  should be used.  e.g.  **Debug**, **Release** etc.
* <b>**--build-options**</b>  
  Additional options for configuring the build (i.e. for CMake, not for
  the build tool).  Note that if this is specified, the **--build-options**
  keyword and its arguments must be the last option given on the command
  line, with the possible exception of **--test-command**.
* <b>**--test-command**</b>  
  The command to run as the test step with the **--build-and-test** option.
  All arguments following this keyword will be assumed to be part of the
  test command line, so it must be the last option given.
* <b>**--test-timeout**</b>  
  The time limit in seconds
  .UNINDENT

<a name="dashboard-client"></a>

# Dashboard Client


CTest can operate as a client for the _CDash_ software quality dashboard
application.  As a dashboard client, CTest performs a sequence of steps
to configure, build, and test software, and then submits the results to
a _CDash_ server. The command-line signature used to submit to _CDash_ is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest (-D <dashboard> | -M <model> -T <action> | -S <script> | -SP <script>)
          [-- <dashboard-options>...]
    .ft P
.UNINDENT
.UNINDENT

Options for Dashboard Client include:
.INDENT 0.0

* <b>**--group &lt;group&gt;**</b>  
  Specify what group you’d like to submit results to

Submit dashboard to specified group instead of default one.  By
default, the dashboard is submitted to Nightly, Experimental, or
Continuous group, but by specifying this option, the group can be
arbitrary.

This replaces the deprecated option **--track**.
Despite the name change its behavior is unchanged.

* <b>**-A &lt;file&gt;, --add-notes &lt;file&gt;**</b>  
  Add a notes file with submission.

This option tells CTest to include a notes file when submitting
dashboard.

* <b>**--tomorrow-tag**</b>  
  **Nightly** or **Experimental** starts with next day tag.

This is useful if the build will not finish in one day.

* <b>**--extra-submit &lt;file&gt;[;&lt;file&gt;]**</b>  
  Submit extra files to the dashboard.

This option will submit extra files to the dashboard.

* <b>**--http1.0**</b>  
  Submit using _HTTP 1.0_.

This option will force CTest to use _HTTP 1.0_ to submit files to the
dashboard, instead of _HTTP 1.1_.

* <b>**--no-compress-output**</b>  
  Do not compress test output when submitting.

This flag will turn off automatic compression of test output.  Use
this to maintain compatibility with an older version of CDash which
doesn’t support compressed test output.
.UNINDENT

<a name="dashboard-client-steps"></a>

### Dashboard Client Steps


CTest defines an ordered list of testing steps of which some or all may
be run as a dashboard client:
.INDENT 0.0

* <b>**Start**</b>  
  Start a new dashboard submission to be composed of results recorded
  by the following steps.
  See the _CTest Start Step_ section below.
* <b>**Update**</b>  
  Update the source tree from its version control repository.
  Record the old and new versions and the list of updated source files.
  See the _CTest Update Step_ section below.
* <b>**Configure**</b>  
  Configure the software by running a command in the build tree.
  Record the configuration output log.
  See the _CTest Configure Step_ section below.
* <b>**Build**</b>  
  Build the software by running a command in the build tree.
  Record the build output log and detect warnings and errors.
  See the _CTest Build Step_ section below.
* <b>**Test**</b>  
  Test the software by loading a **CTestTestfile.cmake**
  from the build tree and executing the defined tests.
  Record the output and result of each test.
  See the _CTest Test Step_ section below.
* <b>**Coverage**</b>  
  Compute coverage of the source code by running a coverage
  analysis tool and recording its output.
  See the _CTest Coverage Step_ section below.
* <b>**MemCheck**</b>  
  Run the software test suite through a memory check tool.
  Record the test output, results, and issues reported by the tool.
  See the _CTest MemCheck Step_ section below.
* <b>**Submit**</b>  
  Submit results recorded from other testing steps to the
  software quality dashboard server.
  See the _CTest Submit Step_ section below.
  .UNINDENT

<a name="dashboard-client-modes"></a>

### Dashboard Client Modes


CTest defines three modes of operation as a dashboard client:
.INDENT 0.0

* <b>**Nightly**</b>  
  This mode is intended to be invoked once per day, typically at night.
  It enables the **Start**, **Update**, **Configure**, **Build**, **Test**,
  **Coverage**, and **Submit** steps by default.  Selected steps run even
  if the **Update** step reports no changes to the source tree.
* <b>**Continuous**</b>  
  This mode is intended to be invoked repeatedly throughout the day.
  It enables the **Start**, **Update**, **Configure**, **Build**, **Test**,
  **Coverage**, and **Submit** steps by default, but exits after the
  **Update** step if it reports no changes to the source tree.
* <b>**Experimental**</b>  
  This mode is intended to be invoked by a developer to test local changes.
  It enables the **Start**, **Configure**, **Build**, **Test**, **Coverage**,
  and **Submit** steps by default.
  .UNINDENT

<a name="dashboard-client-via-ctest-command-line"></a>

### Dashboard Client via CTest Command\-Line


CTest can perform testing on an already-generated build tree.
Run the **ctest** command with the current working directory set
to the build tree and use one of these signatures:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest -D <mode>[<step>]
    ctest -M <mode> [ -T <step> ]...
    .ft P
.UNINDENT
.UNINDENT

The **&lt;mode&gt;** must be one of the above _Dashboard Client Modes_,
and each **&lt;step&gt;** must be one of the above _Dashboard Client Steps_.

CTest reads the _Dashboard Client Configuration_ settings from
a file in the build tree called either **CTestConfiguration.ini**
or **DartConfiguration.tcl** (the names are historical).  The format
of the file is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # Lines starting in '#' are comments.
    # Other non-blank lines are key-value pairs.
    <setting>: <value>
    .ft P
.UNINDENT
.UNINDENT

where **&lt;setting&gt;** is the setting name and **&lt;value&gt;** is the
setting value.

In build trees generated by CMake, this configuration file is
generated by the **CTest** module if included by the project.
The module uses variables to obtain a value for each setting
as documented with the settings below.

<a name="dashboard-client-via-ctest-script"></a>

### Dashboard Client via CTest Script


CTest can perform testing driven by a **cmake-language(7)**
script that creates and maintains the source and build tree as
well as performing the testing steps.  Run the **ctest** command
with the current working directory set outside of any build tree
and use one of these signatures:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest -S <script>
    ctest -SP <script>
    .ft P
.UNINDENT
.UNINDENT

The **&lt;script&gt;** file must call CTest Commands commands
to run testing steps explicitly as documented below.  The commands
obtain _Dashboard Client Configuration_ settings from their
arguments or from variables set in the script.

<a name="dashboard-client-configuration"></a>

# Dashboard Client Configuration


The _Dashboard Client Steps_ may be configured by named
settings as documented in the following sections.

<a name="ctest-start-step"></a>

### CTest Start Step


Start a new dashboard submission to be composed of results recorded
by the following steps.

In a _CTest Script_, the **ctest\_start()** command runs this step.
Arguments to the command may specify some of the step settings.
The command first runs the command-line specified by the
**CTEST\_CHECKOUT\_COMMAND** variable, if set, to initialize the source
directory.

Configuration settings include:
.INDENT 0.0

* <b>**BuildDirectory**</b>  
  The full path to the project build tree.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_BINARY\_DIRECTORY**
* ·  
  **CTest** module variable: **PROJECT\_BINARY\_DIR**
  .UNINDENT
* <b>**SourceDirectory**</b>  
  The full path to the project source tree.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SOURCE\_DIRECTORY**
* ·  
  **CTest** module variable: **PROJECT\_SOURCE\_DIR**
  .UNINDENT
  .UNINDENT

<a name="ctest-update-step"></a>

### CTest Update Step


In a _CTest Script_, the **ctest\_update()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings to specify the version control tool include:
.INDENT 0.0

* <b>**BZRCommand**</b>  
  **bzr** command-line tool to use if source tree is managed by Bazaar.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_BZR\_COMMAND**
* ·  
  **CTest** module variable: none
  .UNINDENT
* <b>**BZRUpdateOptions**</b>  
  Command-line options to the **BZRCommand** when updating the source.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_BZR\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: none
  .UNINDENT
* <b>**CVSCommand**</b>  
  **cvs** command-line tool to use if source tree is managed by CVS.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_CVS\_COMMAND**
* ·  
  **CTest** module variable: **CVSCOMMAND**
  .UNINDENT
* <b>**CVSUpdateOptions**</b>  
  Command-line options to the **CVSCommand** when updating the source.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_CVS\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: **CVS\_UPDATE\_OPTIONS**
  .UNINDENT
* <b>**GITCommand**</b>  
  **git** command-line tool to use if source tree is managed by Git.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_GIT\_COMMAND**
* ·  
  **CTest** module variable: **GITCOMMAND**
  .UNINDENT

The source tree is updated by **git fetch** followed by
**git reset --hard** to the **FETCH\_HEAD**.  The result is the same
as **git pull** except that any local modifications are overwritten.
Use **GITUpdateCustom** to specify a different approach.

* <b>**GITInitSubmodules**</b>  
  If set, CTest will update the repository’s submodules before updating.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_GIT\_INIT\_SUBMODULES**
* ·  
  **CTest** module variable: **CTEST\_GIT\_INIT\_SUBMODULES**
  .UNINDENT
* <b>**GITUpdateCustom**</b>  
  Specify a custom command line (as a semicolon-separated list) to run
  in the source tree (Git work tree) to update it instead of running
  the **GITCommand**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_GIT\_UPDATE\_CUSTOM**
* ·  
  **CTest** module variable: **CTEST\_GIT\_UPDATE\_CUSTOM**
  .UNINDENT
* <b>**GITUpdateOptions**</b>  
  Command-line options to the **GITCommand** when updating the source.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_GIT\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: **GIT\_UPDATE\_OPTIONS**
  .UNINDENT
* <b>**HGCommand**</b>  
  **hg** command-line tool to use if source tree is managed by Mercurial.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_HG\_COMMAND**
* ·  
  **CTest** module variable: none
  .UNINDENT
* <b>**HGUpdateOptions**</b>  
  Command-line options to the **HGCommand** when updating the source.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_HG\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: none
  .UNINDENT
* <b>**P4Client**</b>  
  Value of the **-c** option to the **P4Command**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_P4\_CLIENT**
* ·  
  **CTest** module variable: **CTEST\_P4\_CLIENT**
  .UNINDENT
* <b>**P4Command**</b>  
  **p4** command-line tool to use if source tree is managed by Perforce.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_P4\_COMMAND**
* ·  
  **CTest** module variable: **P4COMMAND**
  .UNINDENT
* <b>**P4Options**</b>  
  Command-line options to the **P4Command** for all invocations.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_P4\_OPTIONS**
* ·  
  **CTest** module variable: **CTEST\_P4\_OPTIONS**
  .UNINDENT
* <b>**P4UpdateCustom**</b>  
  Specify a custom command line (as a semicolon-separated list) to run
  in the source tree (Perforce tree) to update it instead of running
  the **P4Command**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: **CTEST\_P4\_UPDATE\_CUSTOM**
  .UNINDENT
* <b>**P4UpdateOptions**</b>  
  Command-line options to the **P4Command** when updating the source.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_P4\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: **CTEST\_P4\_UPDATE\_OPTIONS**
  .UNINDENT
* <b>**SVNCommand**</b>  
  **svn** command-line tool to use if source tree is managed by Subversion.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SVN\_COMMAND**
* ·  
  **CTest** module variable: **SVNCOMMAND**
  .UNINDENT
* <b>**SVNOptions**</b>  
  Command-line options to the **SVNCommand** for all invocations.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SVN\_OPTIONS**
* ·  
  **CTest** module variable: **CTEST\_SVN\_OPTIONS**
  .UNINDENT
* <b>**SVNUpdateOptions**</b>  
  Command-line options to the **SVNCommand** when updating the source.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SVN\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: **SVN\_UPDATE\_OPTIONS**
  .UNINDENT
* <b>**UpdateCommand**</b>  
  Specify the version-control command-line tool to use without
  detecting the VCS that manages the source tree.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_UPDATE\_COMMAND**
* ·  
  **CTest** module variable: **&lt;VCS&gt;COMMAND**
  when **UPDATE\_TYPE** is **&lt;vcs&gt;**, else **UPDATE\_COMMAND**
  .UNINDENT
* <b>**UpdateOptions**</b>  
  Command-line options to the **UpdateCommand**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_UPDATE\_OPTIONS**
* ·  
  **CTest** module variable: **&lt;VCS&gt;\_UPDATE\_OPTIONS**
  when **UPDATE\_TYPE** is **&lt;vcs&gt;**, else **UPDATE\_OPTIONS**
  .UNINDENT
* <b>**UpdateType**</b>  
  Specify the version-control system that manages the source
  tree if it cannot be detected automatically.
  The value may be **bzr**, **cvs**, **git**, **hg**,
  **p4**, or **svn**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none, detected from source tree
* ·  
  **CTest** module variable: **UPDATE\_TYPE** if set,
  else **CTEST\_UPDATE\_TYPE**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* <b>**UpdateVersionOnly**</b>  
  Specify that you want the version control update command to only
  discover the current version that is checked out, and not to update
  to a different version.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_UPDATE\_VERSION\_ONLY**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* <b>**UpdateVersionOverride**</b>  
  Specify the current version of your source tree.

When this variable is set to a non-empty string, CTest will report the value
you specified rather than using the update command to discover the current
version that is checked out. Use of this variable supersedes
**UpdateVersionOnly**. Like **UpdateVersionOnly**, using this variable tells
CTest not to update the source tree to a different version.
.INDENT 7.0

* ·  
  _CTest Script_ variable: **CTEST\_UPDATE\_VERSION\_OVERRIDE**
  .UNINDENT
  .UNINDENT

Additional configuration settings include:
.INDENT 0.0

* <b>**NightlyStartTime**</b>  
  In the **Nightly** dashboard mode, specify the “nightly start time”.
  With centralized version control systems (**cvs** and **svn**),
  the **Update** step checks out the version of the software as of
  this time so that multiple clients choose a common version to test.
  This is not well-defined in distributed version-control systems so
  the setting is ignored.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_NIGHTLY\_START\_TIME**
* ·  
  **CTest** module variable: **NIGHTLY\_START\_TIME** if set,
  else **CTEST\_NIGHTLY\_START\_TIME**
  .UNINDENT
  .UNINDENT

<a name="ctest-configure-step"></a>

### CTest Configure Step


In a _CTest Script_, the **ctest\_configure()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings include:
.INDENT 0.0

* <b>**ConfigureCommand**</b>  
  Command-line to launch the software configuration process.
  It will be executed in the location specified by the
  **BuildDirectory** setting.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_CONFIGURE\_COMMAND**
* ·  
  **CTest** module variable: **CMAKE\_COMMAND**
  followed by **PROJECT\_SOURCE\_DIR**
  .UNINDENT
* <b>**LabelsForSubprojects**</b>  
  Specify a semicolon-separated list of labels that will be treated as
  subprojects. This mapping will be passed on to CDash when configure, test or
  build results are submitted.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_LABELS\_FOR\_SUBPROJECTS**
* ·  
  **CTest** module variable: **CTEST\_LABELS\_FOR\_SUBPROJECTS**
  .UNINDENT

See _Label and Subproject Summary_.
.UNINDENT

<a name="ctest-build-step"></a>

### CTest Build Step


In a _CTest Script_, the **ctest\_build()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings include:
.INDENT 0.0

* <b>**DefaultCTestConfigurationType**</b>  
  When the build system to be launched allows build-time selection
  of the configuration (e.g. **Debug**, **Release**), this specifies
  the default configuration to be built when no **-C** option is
  given to the **ctest** command.  The value will be substituted into
  the value of **MakeCommand** to replace the literal string
  **${CTEST\_CONFIGURATION\_TYPE}** if it appears.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_CONFIGURATION\_TYPE**
* ·  
  **CTest** module variable: **DEFAULT\_CTEST\_CONFIGURATION\_TYPE**,
  initialized by the **CMAKE\_CONFIG\_TYPE** environment variable
  .UNINDENT
* <b>**LabelsForSubprojects**</b>  
  Specify a semicolon-separated list of labels that will be treated as
  subprojects. This mapping will be passed on to CDash when configure, test or
  build results are submitted.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_LABELS\_FOR\_SUBPROJECTS**
* ·  
  **CTest** module variable: **CTEST\_LABELS\_FOR\_SUBPROJECTS**
  .UNINDENT

See _Label and Subproject Summary_.

* <b>**MakeCommand**</b>  
  Command-line to launch the software build process.
  It will be executed in the location specified by the
  **BuildDirectory** setting.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_BUILD\_COMMAND**
* ·  
  **CTest** module variable: **MAKECOMMAND**,
  initialized by the **build\_command()** command
  .UNINDENT
* <b>**UseLaunchers**</b>  
  For build trees generated by CMake using one of the
  Makefile Generators or the **Ninja**
  generator, specify whether the
  **CTEST\_USE\_LAUNCHERS** feature is enabled by the
  **CTestUseLaunchers** module (also included by the
  **CTest** module).  When enabled, the generated build
  system wraps each invocation of the compiler, linker, or
  custom command line with a “launcher” that communicates
  with CTest via environment variables and files to report
  granular build warning and error information.  Otherwise,
  CTest must “scrape” the build output log for diagnostics.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_USE\_LAUNCHERS**
* ·  
  **CTest** module variable: **CTEST\_USE\_LAUNCHERS**
  .UNINDENT
  .UNINDENT

<a name="ctest-test-step"></a>

### CTest Test Step


In a _CTest Script_, the **ctest\_test()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings include:
.INDENT 0.0

* <b>**ResourceSpecFile**</b>  
  Specify a
  _resource specification file_. See
  _Resource Allocation_ for more information.
* <b>**LabelsForSubprojects**</b>  
  Specify a semicolon-separated list of labels that will be treated as
  subprojects. This mapping will be passed on to CDash when configure, test or
  build results are submitted.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_LABELS\_FOR\_SUBPROJECTS**
* ·  
  **CTest** module variable: **CTEST\_LABELS\_FOR\_SUBPROJECTS**
  .UNINDENT

See _Label and Subproject Summary_.

* <b>**TestLoad**</b>  
  While running tests in parallel (e.g. with **-j**), try not to start
  tests when they may cause the CPU load to pass above a given threshold.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_TEST\_LOAD**
* ·  
  **CTest** module variable: **CTEST\_TEST\_LOAD**
  .UNINDENT
* <b>**TimeOut**</b>  
  The default timeout for each test if not specified by the
  **TIMEOUT** test property.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_TEST\_TIMEOUT**
* ·  
  **CTest** module variable: **DART\_TESTING\_TIMEOUT**
  .UNINDENT
  .UNINDENT

<a name="ctest-coverage-step"></a>

### CTest Coverage Step


In a _CTest Script_, the **ctest\_coverage()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings include:
.INDENT 0.0

* <b>**CoverageCommand**</b>  
  Command-line tool to perform software coverage analysis.
  It will be executed in the location specified by the
  **BuildDirectory** setting.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_COVERAGE\_COMMAND**
* ·  
  **CTest** module variable: **COVERAGE\_COMMAND**
  .UNINDENT
* <b>**CoverageExtraFlags**</b>  
  Specify command-line options to the **CoverageCommand** tool.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_COVERAGE\_EXTRA\_FLAGS**
* ·  
  **CTest** module variable: **COVERAGE\_EXTRA\_FLAGS**
  .UNINDENT

These options are the first arguments passed to **CoverageCommand**.
.UNINDENT

<a name="ctest-memcheck-step"></a>

### CTest MemCheck Step


In a _CTest Script_, the **ctest\_memcheck()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings include:
.INDENT 0.0

* <b>**MemoryCheckCommand**</b>  
  Command-line tool to perform dynamic analysis.  Test command lines
  will be launched through this tool.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_MEMORYCHECK\_COMMAND**
* ·  
  **CTest** module variable: **MEMORYCHECK\_COMMAND**
  .UNINDENT
* <b>**MemoryCheckCommandOptions**</b>  
  Specify command-line options to the **MemoryCheckCommand** tool.
  They will be placed prior to the test command line.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_MEMORYCHECK\_COMMAND\_OPTIONS**
* ·  
  **CTest** module variable: **MEMORYCHECK\_COMMAND\_OPTIONS**
  .UNINDENT
* <b>**MemoryCheckType**</b>  
  Specify the type of memory checking to perform.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_MEMORYCHECK\_TYPE**
* ·  
  **CTest** module variable: **MEMORYCHECK\_TYPE**
  .UNINDENT
* <b>**MemoryCheckSanitizerOptions**</b>  
  Specify options to sanitizers when running with a sanitize-enabled build.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_MEMORYCHECK\_SANITIZER\_OPTIONS**
* ·  
  **CTest** module variable: **MEMORYCHECK\_SANITIZER\_OPTIONS**
  .UNINDENT
* <b>**MemoryCheckSuppressionFile**</b>  
  Specify a file containing suppression rules for the
  **MemoryCheckCommand** tool.  It will be passed with options
  appropriate to the tool.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_MEMORYCHECK\_SUPPRESSIONS\_FILE**
* ·  
  **CTest** module variable: **MEMORYCHECK\_SUPPRESSIONS\_FILE**
  .UNINDENT
  .UNINDENT

Additional configuration settings include:
.INDENT 0.0

* <b>**BoundsCheckerCommand**</b>  
  Specify a **MemoryCheckCommand** that is known to be command-line
  compatible with Bounds Checker.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: none
  .UNINDENT
* <b>**PurifyCommand**</b>  
  Specify a **MemoryCheckCommand** that is known to be command-line
  compatible with Purify.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: **PURIFYCOMMAND**
  .UNINDENT
* <b>**ValgrindCommand**</b>  
  Specify a **MemoryCheckCommand** that is known to be command-line
  compatible with Valgrind.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: **VALGRIND\_COMMAND**
  .UNINDENT
* <b>**ValgrindCommandOptions**</b>  
  Specify command-line options to the **ValgrindCommand** tool.
  They will be placed prior to the test command line.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: **VALGRIND\_COMMAND\_OPTIONS**
  .UNINDENT
* <b>**DrMemoryCommand**</b>  
  Specify a **MemoryCheckCommand** that is known to be a command-line
  compatible with DrMemory.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: **DRMEMORY\_COMMAND**
  .UNINDENT
* <b>**DrMemoryCommandOptions**</b>  
  Specify command-line options to the **DrMemoryCommand** tool.
  They will be placed prior to the test command line.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none
* ·  
  **CTest** module variable: **DRMEMORY\_COMMAND\_OPTIONS**
  .UNINDENT
  .UNINDENT

<a name="ctest-submit-step"></a>

### CTest Submit Step


In a _CTest Script_, the **ctest\_submit()** command runs this step.
Arguments to the command may specify some of the step settings.

Configuration settings include:
.INDENT 0.0

* <b>**BuildName**</b>  
  Describe the dashboard client platform with a short string.
  (Operating system, compiler, etc.)
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_BUILD\_NAME**
* ·  
  **CTest** module variable: **BUILDNAME**
  .UNINDENT
* <b>**CDashVersion**</b>  
  Legacy option.  Not used.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none, detected from server
* ·  
  **CTest** module variable: **CTEST\_CDASH\_VERSION**
  .UNINDENT
* <b>**CTestSubmitRetryCount**</b>  
  Specify a number of attempts to retry submission on network failure.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none,
  use the **ctest\_submit()** **RETRY\_COUNT** option.
* ·  
  **CTest** module variable: **CTEST\_SUBMIT\_RETRY\_COUNT**
  .UNINDENT
* <b>**CTestSubmitRetryDelay**</b>  
  Specify a delay before retrying submission on network failure.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: none,
  use the **ctest\_submit()** **RETRY\_DELAY** option.
* ·  
  **CTest** module variable: **CTEST\_SUBMIT\_RETRY\_DELAY**
  .UNINDENT
* <b>**CurlOptions**</b>  
  Specify a semicolon-separated list of options to control the
  Curl library that CTest uses internally to connect to the
  server.  Possible options are **CURLOPT\_SSL\_VERIFYPEER\_OFF**
  and **CURLOPT\_SSL\_VERIFYHOST\_OFF**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_CURL\_OPTIONS**
* ·  
  **CTest** module variable: **CTEST\_CURL\_OPTIONS**
  .UNINDENT
* <b>**DropLocation**</b>  
  Legacy option.  When **SubmitURL** is not set, it is constructed from
  **DropMethod**, **DropSiteUser**, **DropSitePassword**, **DropSite**, and
  **DropLocation**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_DROP\_LOCATION**
* ·  
  **CTest** module variable: **DROP\_LOCATION** if set,
  else **CTEST\_DROP\_LOCATION**
  .UNINDENT
* <b>**DropMethod**</b>  
  Legacy option.  When **SubmitURL** is not set, it is constructed from
  **DropMethod**, **DropSiteUser**, **DropSitePassword**, **DropSite**, and
  **DropLocation**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_DROP\_METHOD**
* ·  
  **CTest** module variable: **DROP\_METHOD** if set,
  else **CTEST\_DROP\_METHOD**
  .UNINDENT
* <b>**DropSite**</b>  
  Legacy option.  When **SubmitURL** is not set, it is constructed from
  **DropMethod**, **DropSiteUser**, **DropSitePassword**, **DropSite**, and
  **DropLocation**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_DROP\_SITE**
* ·  
  **CTest** module variable: **DROP\_SITE** if set,
  else **CTEST\_DROP\_SITE**
  .UNINDENT
* <b>**DropSitePassword**</b>  
  Legacy option.  When **SubmitURL** is not set, it is constructed from
  **DropMethod**, **DropSiteUser**, **DropSitePassword**, **DropSite**, and
  **DropLocation**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_DROP\_SITE\_PASSWORD**
* ·  
  **CTest** module variable: **DROP\_SITE\_PASSWORD** if set,
  else **CTEST\_DROP\_SITE\_PASWORD**
  .UNINDENT
* <b>**DropSiteUser**</b>  
  Legacy option.  When **SubmitURL** is not set, it is constructed from
  **DropMethod**, **DropSiteUser**, **DropSitePassword**, **DropSite**, and
  **DropLocation**.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_DROP\_SITE\_USER**
* ·  
  **CTest** module variable: **DROP\_SITE\_USER** if set,
  else **CTEST\_DROP\_SITE\_USER**
  .UNINDENT
* <b>**IsCDash**</b>  
  Legacy option.  Not used.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_DROP\_SITE\_CDASH**
* ·  
  **CTest** module variable: **CTEST\_DROP\_SITE\_CDASH**
  .UNINDENT
* <b>**ScpCommand**</b>  
  Legacy option.  Not used.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SCP\_COMMAND**
* ·  
  **CTest** module variable: **SCPCOMMAND**
  .UNINDENT
* <b>**Site**</b>  
  Describe the dashboard client host site with a short string.
  (Hostname, domain, etc.)
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SITE**
* ·  
  **CTest** module variable: **SITE**,
  initialized by the **site\_name()** command
  .UNINDENT
* <b>**SubmitURL**</b>  
  The **http** or **https** URL of the dashboard server to send the submission
  to.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_SUBMIT\_URL**
* ·  
  **CTest** module variable: **SUBMIT\_URL** if set,
  else **CTEST\_SUBMIT\_URL**
  .UNINDENT
* <b>**TriggerSite**</b>  
  Legacy option.  Not used.
  .INDENT 7.0
* ·  
  _CTest Script_ variable: **CTEST\_TRIGGER\_SITE**
* ·  
  **CTest** module variable: **TRIGGER\_SITE** if set,
  else **CTEST\_TRIGGER\_SITE**
  .UNINDENT
  .UNINDENT

<a name="show-as-json-object-model"></a>

# Show as Json Object Model


When the **--show-only=json-v1** command line option is given, the test
information is output in JSON format.  Version 1.0 of the JSON object
model is defined as follows:
.INDENT 0.0

* <b>**kind**</b>  
  The string “ctestInfo”.
* <b>**version**</b>  
  A JSON object specifying the version components.  Its members are
  .INDENT 7.0
* <b>**major**</b>  
  A non-negative integer specifying the major version component.
* <b>**minor**</b>  
  A non-negative integer specifying the minor version component.
  .UNINDENT
* <b>**backtraceGraph**</b>  
  JSON object representing backtrace information with the
  following members:
  .INDENT 7.0
* <b>**commands**</b>  
  List of command names.
* <b>**files**</b>  
  List of file names.
* <b>**nodes**</b>  
  List of node JSON objects with members:
  .INDENT 7.0
* <b>**command**</b>  
  Index into the **commands** member of the **backtraceGraph**.
* <b>**file**</b>  
  Index into the **files** member of the **backtraceGraph**.
* <b>**line**</b>  
  Line number in the file where the backtrace was added.
* <b>**parent**</b>  
  Index into the **nodes** member of the **backtraceGraph**
  representing the parent in the graph.
  .UNINDENT
  .UNINDENT
* <b>**tests**</b>  
  A JSON array listing information about each test.  Each entry
  is a JSON object with members:
  .INDENT 7.0
* <b>**name**</b>  
  Test name.
* <b>**config**</b>  
  Configuration that the test can run on.
  Empty string means any config.
* <b>**command**</b>  
  List where the first element is the test command and the
  remaining elements are the command arguments.
* <b>**backtrace**</b>  
  Index into the **nodes** member of the **backtraceGraph**.
* <b>**properties**</b>  
  Test properties.
  Can contain keys for each of the supported test properties.
  .UNINDENT
  .UNINDENT

<a name="resource-allocation"></a>

# Resource Allocation


CTest provides a mechanism for tests to specify the resources that they need
in a fine-grained way, and for users to specify the resources availiable on
the running machine. This allows CTest to internally keep track of which
resources are in use and which are free, scheduling tests in a way that
prevents them from trying to claim resources that are not available.

When the resource allocation feature is used, CTest will not oversubscribe
resources. For example, if a resource has 8 slots, CTest will not run tests
that collectively use more than 8 slots at a time. This has the effect of
limiting how many tests can run at any given time, even if a high **-j**
argument is used, if those tests all use some slots from the same resource.
In addition, it means that a single test that uses more of a resource than is
available on a machine will not run at all (and will be reported as
**Not Run**).

A common use case for this feature is for tests that require the use of a GPU.
Multiple tests can simultaneously allocate memory from a GPU, but if too many
tests try to do this at once, some of them will fail to allocate, resulting in
a failed test, even though the test would have succeeded if it had the memory
it needed. By using the resource allocation feature, each test can specify how
much memory it requires from a GPU, allowing CTest to schedule tests in a way
that running several of these tests at once does not exhaust the GPU’s memory
pool.

Please note that CTest has no concept of what a GPU is or how much memory it
has, nor does it have any way of communicating with a GPU to retrieve this
information or perform any memory management. CTest simply keeps track of a
list of abstract resource types, each of which has a certain number of slots
available for tests to use. Each test specifies the number of slots that it
requires from a certain resource, and CTest then schedules them in a way that
prevents the total number of slots in use from exceeding the listed capacity.
When a test is executed, and slots from a resource are allocated to that test,
tests may assume that they have exclusive use of those slots for the duration
of the test’s process.

The CTest resource allocation feature consists of two inputs:
.INDENT 0.0

* ·  
  The _resource specification file_,
  described below, which describes the resources available on the system.
* ·  
  The **RESOURCE\_GROUPS** property of tests, which describes the
  resources required by the test.
  .UNINDENT

When CTest runs a test, the resources allocated to that test are passed in the
form of a set of
_environment variables_ as
described below. Using this information to decide which resource to connect to
is left to the test writer.

The **RESOURCE\_GROUPS** property tells CTest what resources a test expects
to use grouped in a way meaningful to the test.  The test itself must read
the _environment variables_ to
determine which resources have been allocated to each group.  For example,
each group may correspond to a process the test will spawn when executed.

Note that even if a test specifies a **RESOURCE\_GROUPS** property, it is still
possible for that to test to run without any resource allocation (and without
the corresponding
_environment variables_)
if the user does not pass a resource specification file. Passing this file,
either through the **--resource-spec-file** command-line argument or the
**RESOURCE\_SPEC\_FILE** argument to **ctest\_test()**, is what activates the
resource allocation feature. Tests should check the
**CTEST\_RESOURCE\_GROUP\_COUNT** environment variable to find out whether or not
resource allocation is activated. This variable will always (and only) be
defined if resource allocation is activated. If resource allocation is not
activated, then the **CTEST\_RESOURCE\_GROUP\_COUNT** variable will not exist,
even if it exists for the parent **ctest** process. If a test absolutely must
have resource allocation, then it can return a failing exit code or use the
**SKIP\_RETURN\_CODE** or **SKIP\_REGULAR\_EXPRESSION**
properties to indicate a skipped test.

<a name="resource-specification-file"></a>

### Resource Specification File


The resource specification file is a JSON file which is passed to CTest, either
on the _ctest(1)_ command line as **--resource-spec-file**, or as the
**RESOURCE\_SPEC\_FILE** argument of **ctest\_test()**. The resource
specification file must be a JSON object. All examples in this document assume
the following resource specification file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "version": {
        "major": 1,
        "minor": 0
      },
      "local": [
        {
          "gpus": [
            {
              "id": "0",
              "slots": 2
            },
            {
              "id": "1",
              "slots": 4
            },
            {
              "id": "2",
              "slots": 2
            },
            {
              "id": "3"
            }
          ],
          "crypto_chips": [
            {
              "id": "card0",
              "slots": 4
            }
          ]
        }
      ]
    }
    .ft P
.UNINDENT
.UNINDENT

The members are:
.INDENT 0.0

* <b>**version**</b>  
  An object containing a **major** integer field and a **minor** integer field.
  Currently, the only supported version is major **1**, minor **0**. Any other
  value is an error.
* <b>**local**</b>  
  A JSON array of resource sets present on the system.  Currently, this array
  is restricted to being of size 1.

Each array element is a JSON object with members whose names are equal to the
desired resource types, such as **gpus**. These names must start with a
lowercase letter or an underscore, and subsequent characters can be a
lowercase letter, a digit, or an underscore. Uppercase letters are not
allowed, because certain platforms have case-insensitive environment
variables. See the _Environment Variables_ section below for
more information. It is recommended that the resource type name be the plural
of a noun, such as **gpus** or **crypto\_chips** (and not **gpu** or
**crypto\_chip**.)

Please note that the names **gpus** and **crypto\_chips** are just examples,
and CTest does not interpret them in any way. You are free to make up any
resource type you want to meet your own requirements.

The value for each resource type is a JSON array consisting of JSON objects,
each of which describe a specific instance of the specified resource. These
objects have the following members:
.INDENT 7.0

* <b>**id**</b>  
  A string consisting of an identifier for the resource. Each character in
  the identifier can be a lowercase letter, a digit, or an underscore.
  Uppercase letters are not allowed.

Identifiers must be unique within a resource type. However, they do not
have to be unique across resource types. For example, it is valid to have a
**gpus** resource named **0** and a **crypto\_chips** resource named **0**,
but not two **gpus** resources both named **0**.

Please note that the IDs **0**, **1**, **2**, **3**, and **card0** are just
examples, and CTest does not interpret them in any way. You are free to
make up any IDs you want to meet your own requirements.

* <b>**slots**</b>  
  An optional unsigned number specifying the number of slots available on the
  resource. For example, this could be megabytes of RAM on a GPU, or
  cryptography units available on a cryptography chip. If **slots** is not
  specified, a default value of **1** is assumed.
  .UNINDENT
  .UNINDENT

In the example file above, there are four GPUs with ID’s 0 through 3. GPU 0 has
2 slots, GPU 1 has 4, GPU 2 has 2, and GPU 3 has a default of 1 slot. There is
also one cryptography chip with 4 slots.

<a name="fbresource_groupsfp-property"></a>

### \fBRESOURCE_GROUPS\fP Property


See **RESOURCE\_GROUPS** for a description of this property.

<a name="environment-variables"></a>

### Environment Variables


Once CTest has decided which resources to allocate to a test, it passes this
information to the test executable as a series of environment variables. For
each example below, we will assume that the test in question has a
**RESOURCE\_GROUPS** property of
**2,gpus:2;gpus:4,gpus:1,crypto\_chips:2**.

The following variables are passed to the test process:
.INDENT 0.0

* **CTEST_RESOURCE_GROUP_COUNT**  
  The total number of groups specified by the **RESOURCE\_GROUPS**
  property. For example:
  .INDENT 7.0
* ·  
  **CTEST\_RESOURCE\_GROUP\_COUNT=3**
  .UNINDENT

This variable will only be defined if _ctest(1)_ has been given a
**--resource-spec-file**, or if **ctest\_test()** has been given a
**RESOURCE\_SPEC\_FILE**. If no resource specification file has been given,
this variable will not be defined.
.UNINDENT
.INDENT 0.0

* **CTEST_RESOURCE_GROUP_&lt;num&gt;**  
  The list of resource types allocated to each group, with each item
  separated by a comma. **&lt;num&gt;** is a number from zero to
  **CTEST\_RESOURCE\_GROUP\_COUNT** minus one. **CTEST\_RESOURCE\_GROUP\_&lt;num&gt;**
  is defined for each **&lt;num&gt;** in this range. For example:
  .INDENT 7.0
* ·  
  **CTEST\_RESOURCE\_GROUP\_0=gpus**
* ·  
  **CTEST\_RESOURCE\_GROUP\_1=gpus**
* ·  
  **CTEST\_RESOURCE\_GROUP\_2=crypto\_chips,gpus**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CTEST_RESOURCE_GROUP_&lt;num&gt;_&lt;resource-type&gt;**  
  The list of resource IDs and number of slots from each ID allocated to each
  group for a given resource type. This variable consists of a series of
  pairs, each pair separated by a semicolon, and with the two items in the pair
  separated by a comma. The first item in each pair is **id:** followed by the
  ID of a resource of type **&lt;resource-type&gt;**, and the second item is
  **slots:** followed by the number of slots from that resource allocated to
  the given group. For example:
  .INDENT 7.0
* ·  
  **CTEST\_RESOURCE\_GROUP\_0\_GPUS=id:0,slots:2**
* ·  
  **CTEST\_RESOURCE\_GROUP\_1\_GPUS=id:2,slots:2**
* ·  
  **CTEST\_RESOURCE\_GROUP\_2\_GPUS=id:1,slots:4;id:3,slots:1**
* ·  
  **CTEST\_RESOURCE\_GROUP\_2\_CRYPTO\_CHIPS=id:card0,slots:2**
  .UNINDENT

In this example, group 0 gets 2 slots from GPU **0**, group 1 gets 2 slots
from GPU **2**, and group 2 gets 4 slots from GPU **1**, 1 slot from GPU
**3**, and 2 slots from cryptography chip **card0**.

**&lt;num&gt;** is a number from zero to **CTEST\_RESOURCE\_GROUP\_COUNT** minus one.
**&lt;resource-type&gt;** is the name of a resource type, converted to uppercase.
**CTEST\_RESOURCE\_GROUP\_&lt;num&gt;\_&lt;resource-type&gt;** is defined for the product
of each **&lt;num&gt;** in the range listed above and each resource type listed in
**CTEST\_RESOURCE\_GROUP\_&lt;num&gt;**.

Because some platforms have case-insensitive names for environment variables,
the names of resource types may not clash in a case-insensitive environment.
Because of this, for the sake of simplicity, all resource types must be
listed in all lowercase in the
_resource specification file_ and
in the **RESOURCE\_GROUPS** property, and they are converted to all
uppercase in the **CTEST\_RESOURCE\_GROUP\_&lt;num&gt;\_&lt;resource-type&gt;** environment
variable.
.UNINDENT

<a name="see-also"></a>

# See Also


The following resources are available to get help using CMake:
.INDENT 0.0

* **Home Page**  
  _https://cmake.org_

The primary starting point for learning about CMake.

* **Online Documentation and Community Resources**  
  _https://cmake.org/documentation_

Links to available documentation and community resources may be
found on this web page.

* **Discourse Forum**  
  _https://discourse.cmake.org_

The Discourse Forum hosts discussion and questions about CMake.
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

