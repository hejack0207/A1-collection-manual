# make(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

make
— maintain, update, and regenerate groups of programs
(**DEVELOPMENT**)

<a name="synopsis"></a>

# Synopsis

```


```
    make [(mieinpqrst] [(mif makefile]... [(mik|(miS] [macro=value...]
        [target_name...]

<a name="description"></a>

# Description

The
_make_
utility shall update files that are derived from other files. A typical
case is one where object files are derived from the corresponding
source files. The
_make_
utility examines time relationships and shall update those derived files
(called targets) that have modified times earlier than the modified
times of the files (called prerequisites) from which they are derived.
A description file (makefile) contains a description of the
relationships between files, and the commands that need to be executed
to update the targets to reflect changes in their prerequisites. Each
specification, or rule, shall consist of a target, optional
prerequisites, and optional commands to be executed when a prerequisite
is newer than the target. There are two types of rule:

*  1.  
  _Inference rules_,
  which have one target name with at least one
  &lt;period&gt;
  (\c
  **'.'**)
  and no
  &lt;slash&gt;
  (\c
  **'/'**)
*  2.  
  _Target rules_,
  which can have more than one target name

In addition,
_make_
shall have a collection of built-in macros and inference rules that
infer prerequisite relationships to simplify maintenance of programs.

To receive exactly the behavior described in this section, the
user shall ensure that a portable makefile shall:

*  *  
  Include the special target
  **.POSIX**
*  *  
  Omit any special target reserved for implementations (a leading period
  followed by uppercase letters) that has not been specified by this
  section

The behavior of
_make_
is unspecified if either or both of these conditions are not met.

<a name="options"></a>

# Options

The
_make_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for Guideline 9.

The following options shall be supported:

* **\(mie**  
  Cause environment variables, including those with null values, to
  override macro assignments within makefiles.
* **\(mif&nbsp;makefile**  
  Specify a different makefile. The argument
  _makefile_
  is a pathname of a description file, which is also referred to as the
  _makefile_.
  A pathname of
  **'\(mi'**
  shall denote the standard input. There can be multiple instances of
  this option, and they shall be processed in the order specified. The
  effect of specifying the same option-argument more than once is
  unspecified.
* **\(mii**  
  Ignore error codes returned by invoked commands. This mode is the same
  as if the special target
  **.IGNORE**
  were specified without prerequisites.
* **\(mik**  
  Continue to update other targets that do not depend on the current
  target if a non-ignored error occurs while executing the commands to
  bring a target up-to-date.
* **\(min**  
  Write commands that would be executed on standard output, but do not
  execute them. However, lines with a
  &lt;plus-sign&gt;
  (\c
  **'\(pl'**)
  prefix shall be executed. In this mode, lines with an at-sign (\c
  **'@'**)
  character prefix shall be written to standard output.
* **\(mip**  
  Write to standard output the complete set of macro definitions and
  target descriptions. The output format is unspecified.
* **\(miq**  
  Return a zero exit value if the target file is up-to-date; otherwise,
  return an exit value of 1. Targets shall not be updated if this option
  is specified. However, a makefile command line (associated with the
  targets) with a
  &lt;plus-sign&gt;
  (\c
  **'\(pl'**)
  prefix shall be executed.
* **\(mir**  
  Clear the suffix list and do not use the built-in rules.
* **\(miS**  
  Terminate
  _make_
  if an error occurs while executing the commands to bring a target
  up-to-date. This shall be the default and the opposite of
  **\(mik**.
* **\(mis**  
  Do not write makefile command lines or touch messages (see
  **\(mit**)
  to standard output before executing. This mode shall be the same as if
  the special target
  **.SILENT**
  were specified without prerequisites.
* **\(mit**  
  Update the modification time of each target as though a
  _touch_
  _target_
  had been executed. Targets that have prerequisites but no commands (see
  _Target Rules_),
  or that are already up-to-date, shall not be touched in this manner.
  Write messages to standard output for each target file indicating the
  name of the file and that it was touched. Normally, the
  _makefile_
  command lines associated with each target are not executed. However, a
  command line with a
  &lt;plus-sign&gt;
  (\c
  **'\(pl'**)
  prefix shall be executed.

Any options specified in the
_MAKEFLAGS_
environment variable shall be evaluated before any options specified on
the
_make_
utility command line. If the
**\(mik**
and
**\(miS**
options are both specified on the
_make_
utility command line or by the
_MAKEFLAGS_
environment variable, the last option specified shall take precedence.
If the
**\(mif**
or
**\(mip**
options appear in the
_MAKEFLAGS_
environment variable, the result is undefined.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _target\_name_  
  Target names, as defined in the EXTENDED DESCRIPTION section. If no
  target is specified, while
  _make_
  is processing the makefiles, the first target that
  _make_
  encounters that is not a special target or an inference rule shall be
  used.
* _macro_=_value_  
  Macro definitions, as defined in
  _Macros_.

If the
_target_name_
and
_macro_=\c
_value_
operands are intermixed on the
_make_
utility command line, the results are unspecified.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if the
_makefile_
option-argument is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input file, otherwise known as the makefile, is a text file
containing rules, macro definitions, and comments. See the
EXTENDED DESCRIPTION section.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_make_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _MAKEFLAGS_    
  This variable shall be interpreted as a character string representing a
  series of option characters to be used as the default options. The
  implementation shall accept both of the following formats (but need not
  accept them when intermixed):
    *  *  
      The characters are option letters without the leading
      &lt;hyphen&gt;
      characters or
      &lt;blank&gt;
      separation used on a
      _make_
      utility command line.
    *  *  
      The characters are formatted in a manner similar to a portion of the
      _make_
      utility command line: options are preceded by
      &lt;hyphen&gt;
      characters and
      &lt;blank&gt;-separated
      as described in the Base Definitions volume of POSIX.1-2008,
      _Section 12.2_, _Utility Syntax Guidelines_.
      The
      _macro_=\c
      _value_
      macro definition operands can also be included. The difference between
      the contents of
      _MAKEFLAGS_
      and the
      _make_
      utility command line is that the contents of the variable shall not be
      subjected to the word expansions (see
      _Section 2.6_, _Word Expansions_)
      associated with parsing the command line values.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PROJECTDIR_    
  Provide a directory to be used to search for SCCS files not found in
  the current directory. In all of the following cases, the search for
  SCCS files is made in the directory
  **SCCS**
  in the identified directory. If the value of
  _PROJECTDIR_
  begins with a
  &lt;slash&gt;,
  it shall be considered an absolute pathname; otherwise, the value of
  _PROJECTDIR_
  is treated as a user name and that user's initial working directory
  shall be examined for a subdirectory
  **src**
  or
  **source**.
  If such a directory is found, it shall be used. Otherwise, the value
  is used as a relative pathname.

If
_PROJECTDIR_
is not set or has a null value, the search for SCCS files shall be made
in the directory
**SCCS**
in the current directory.

The setting of
_PROJECTDIR_
affects all files listed in the remainder of this utility description
for files with a component named
**SCCS**.

The value of the
_SHELL_
environment variable shall not be used as a macro and shall not be
modified by defining the
**SHELL**
macro in a makefile or on the command line. All other environment
variables, including those with null values, shall be used as macros,
as defined in
_Macros_.

<a name="asynchronous-events"></a>

# Asynchronous Events

If not already ignored,
_make_
shall trap SIGHUP, SIGTERM, SIGINT, and SIGQUIT and remove the current
target unless the target is a directory or the target is a prerequisite
of the special target
**.PRECIOUS**
or unless one of the
**\(min**,
**\(mip**,
or
**\(miq**
options was specified. Any targets removed in this manner shall be
reported in diagnostic messages of unspecified format, written to
standard error. After this cleanup process, if any,
_make_
shall take the standard action for all other signals.

<a name="stdout"></a>

# Stdout

The
_make_
utility shall write all commands to be executed to standard output
unless the
**\(mis**
option was specified, the command is prefixed with an at-sign, or the
special target
**.SILENT**
has either the current target as a prerequisite or has no
prerequisites. If
_make_
is invoked without any work needing to be done, it shall write a
message to standard output indicating that no action was taken. If the
**\(mit**
option is present and a file is touched,
_make_
shall write to standard output a message of unspecified format
indicating that the file was touched, including the filename of the
file.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

Files can be created when the
**\(mit**
option is present. Additional files can also be created by the
utilities invoked by
_make_.

<a name="extended-description"></a>

# Extended Description

The
_make_
utility attempts to perform the actions required to ensure that the
specified targets are up-to-date. A target is considered out-of-date
if it is older than any of its prerequisites or if it does not exist.
The
_make_
utility shall treat all prerequisites as targets themselves and
recursively ensure that they are up-to-date, processing them in the
order in which they appear in the rule. The
_make_
utility shall use the modification times of files to determine whether
the corresponding targets are out-of-date.

After
_make_
has ensured that all of the prerequisites of a target are up-to-date
and if the target is out-of-date, the commands associated with the
target entry shall be executed. If there are no commands listed for
the target, the target shall be treated as up-to-date.

<a name="makefile-syntax"></a>

### Makefile Syntax


A makefile can contain rules, macro definitions (see
_Macros_),
include lines, and comments. There are two kinds of rules:
_inference rules_
and
_target rules_.
The
_make_
utility shall contain a set of built-in inference rules. If the
**\(mir**
option is present, the built-in rules shall not be used and the suffix
list shall be cleared. Additional rules of both types can be specified
in a makefile. If a rule is defined more than once, the value of the
rule shall be that of the last one specified. Macros can also be
defined more than once, and the value of the macro is specified in
_Macros_.
Comments start with a
&lt;number-sign&gt;
(\c
**'#'**)
and continue until an unescaped
&lt;newline&gt;
is reached.

By default, the following files shall be tried in sequence:
**./makefile**
and
**./Makefile**.
If neither
**./makefile**
or
**./Makefile**
are found, other implementation-defined files may also be tried.
On XSI-conformant systems, the additional files
**./s.makefile**,
**SCCS/s.makefile**,
**./s.Makefile**,
and
**SCCS/s.Makefile**
shall also be tried.

The
**\(mif**
option shall direct
_make_
to ignore any of these default files and use the specified argument as
a makefile instead. If the
**'\(mi'**
argument is specified, standard input shall be used.

The term
_makefile_
is used to refer to any rules provided by the user, whether in
**./makefile**
or its variants, or specified by the
**\(mif**
option.

The rules in makefiles shall consist of the following types of lines:
target rules, including special targets (see
_Target Rules_),
inference rules (see
_Inference Rules_),
macro definitions (see
_Macros_),
empty lines, and comments.

Target and Inference Rules may contain
_command lines_.
Command lines can have a prefix that shall be removed before
execution (see
_Makefile Execution_).

When an escaped
&lt;newline&gt;
(one preceded by a
&lt;backslash&gt;)
is found anywhere in the makefile except in a command line, an include
line, or a line immediately preceding an include line, it shall be
replaced, along with any leading white space on the following line,
with a single
&lt;space&gt;.
When an escaped
&lt;newline&gt;
is found in a command line in a makefile, the command line shall
contain the
&lt;backslash&gt;,
the
&lt;newline&gt;,
and the next line, except that the first character of the next line
shall not be included if it is a
&lt;tab&gt;.
When an escaped
&lt;newline&gt;
is found in an include line or in a line immediately preceding an
include line, the behavior is unspecified.

<a name="include-lines"></a>

### Include Lines


If the word
**include**
appears at the beginning of a line and is followed by one or more
&lt;blank&gt;
characters, the string formed by the remainder of the line shall be
processed as follows to produce a pathname:

*  *  
  The trailing
  &lt;newline&gt;
  and any comment shall be discarded. If the resulting string contains
  any double-quote characters (\c
  **'"'**)
  the behavior is unspecified.
*  *  
  The resulting string shall be processed for macro expansion (see
  _Macros_.
*  *  
  Any
  &lt;blank&gt;
  characters that appear after the first non-\c
  &lt;blank&gt;
  shall be used as separators to divide the macro-expanded string into
  fields. It is unspecified whether any other white-space characters
  are also used as separators. It is unspecified whether pathname
  expansion (see
  _Section 2.13_, _Pattern Matching Notation_)
  is also performed.
*  *  
  If the processing of separators and optional pathname expansion
  results in either zero or two or more non-empty fields, the
  behavior is unspecified. If it results in one non-empty field,
  that field is taken as the pathname.

If the pathname does not begin with a
**'/'**
it shall be treated as relative to the current working directory
of the process, not relative to the directory containing the makefile.
If the file does not exist in this location, it is unspecified whether
additional directories are searched.

The contents of the file specified by the pathname shall be read
and processed as if they appeared in the makefile in place of the
include line. If the file ends with an escaped
&lt;newline&gt;
the behavior is unspecified.

The file may itself contain further include lines. Implementations
shall support nesting of include files up to a depth of at least 16.

<a name="makefile-execution"></a>

### Makefile Execution


Makefile command lines shall be processed one at a time.

Makefile command lines can have one or more of the following prefixes: a
&lt;hyphen&gt;
(\c
**'-'**),
an at-sign (\c
**'@'**),
or a
&lt;plus-sign&gt;
(\c
**'+'**).
These shall modify the way in which
_make_
processes the command.

* \(mi  
  If the command prefix contains a
  &lt;hyphen&gt;,
  or the
  **\(mii**
  option is present, or the special target
  **.IGNORE**
  has either the current target as a prerequisite or has no prerequisites,
  any error found while executing the command shall be ignored.
* @  
  If the command prefix contains an at-sign and the
  _make_
  utility command line
  **\(min**
  option is not specified, or the
  **\(mis**
  option is present, or the special target
  **.SILENT**
  has either the current target as a prerequisite or has no prerequisites,
  the command shall not be written to standard output before it is executed.
* +  
  If the command prefix contains a
  &lt;plus-sign&gt;,
  this indicates a makefile command line that shall be executed even if
  **\(min**,
  **\(miq**,
  or
  **\(mit**
  is specified.

An
_execution line_
is built from the command line by removing any prefix characters. Except
as described under the at-sign prefix, the execution line shall be
written to the standard output, optionally preceded by a
&lt;tab&gt;.
The execution line shall then be executed by a shell as if it were passed
as the argument to the
_system_()
interface, except that if errors are not being ignored then the shell
**\(mie**
option shall also be in effect. If errors are being ignored for the
command (as a result of the
**\(mii**
option, a
**'\(mi'**
command prefix, or a
**.IGNORE**
special target), the shell
**\(mie**
option shall not be in effect. The environment for the command being
executed shall contain all of the variables in the environment of
_make_.

By default, when
_make_
receives a non-zero status from the execution of a command, it shall
terminate with an error message to standard error.

<a name="target-rules"></a>

### Target Rules


Target rules are formatted as follows:

    
    target [target...]: [prerequisite...][;command]
    [<tab>command
    <tab>command
    ...]
    
    line that does not begin with <tab>


Target entries are specified by a
&lt;blank&gt;-separated,
non-null list of targets, then a
&lt;colon&gt;,
then a
&lt;blank&gt;-separated,
possibly empty list of prerequisites. Text following a
&lt;semicolon&gt;,
if any, and all following lines that begin with a
&lt;tab&gt;,
are makefile command lines to be executed to update the target. The
first non-empty line that does not begin with a
&lt;tab&gt;
or
**'#'**
shall begin a new entry. An empty or blank line, or a line beginning
with
**'#'**,
may begin a new entry.

Applications shall select target names from the set of characters
consisting solely of periods, underscores, digits, and alphabetics from
the portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).
Implementations may allow other characters in target names as
extensions. The interpretation of targets containing the characters
**'%'**
and
**'"'**
is implementation-defined.

A target that has prerequisites, but does not have any commands, can be
used to add to the prerequisite list for that target. Only one target
rule for any given target can contain commands.

Lines that begin with one of the following are called
_special targets_
and control the operation of
_make_:

* **.DEFAULT**  
  If the makefile uses this special target, the application shall ensure
  that it is specified with commands, but without prerequisites. The
  commands shall be used by
  _make_
  if there are no other rules available to build a target.
* **.IGNORE**  
  Prerequisites of this special target are targets themselves; this shall
  cause errors from commands associated with them to be ignored in the
  same manner as specified by the
  **\(mii**
  option. Subsequent occurrences of
  **.IGNORE**
  shall add to the list of targets ignoring command errors. If no
  prerequisites are specified,
  _make_
  shall behave as if the
  **\(mii**
  option had been specified and errors from all commands associated with
  all targets shall be ignored.
* **.POSIX**  
  The application shall ensure that this special target is specified
  without prerequisites or commands. If it appears as the first
  non-comment line in the makefile,
  _make_
  shall process the makefile as specified by this section; otherwise, the
  behavior of
  _make_
  is unspecified.
* **.PRECIOUS**  
  Prerequisites of this special target shall not be removed if
  _make_
  receives one of the asynchronous events explicitly described in the
  ASYNCHRONOUS EVENTS section. Subsequent occurrences of
  **.PRECIOUS**
  shall add to the list of precious files. If no prerequisites are
  specified, all targets in the makefile shall be treated as if specified
  with
  **.PRECIOUS**.
* **.SCCS\_GET**  
  The application shall ensure that this special target is specified
  without prerequisites. If this special target is included in a
  makefile, the commands specified with this target shall replace the
  default commands associated with this special target (see
  _Default Rules_).
  The commands specified with this target are used to get all SCCS files
  that are not found in the current directory.

When source files are named in a dependency list,
_make_
shall treat them just like any other target. Because the source file is
presumed to be present in the directory, there is no need to add an
entry for it to the makefile. When a target has no dependencies, but is
present in the directory,
_make_
shall assume that that file is up-to-date. If, however, an SCCS file
named
**SCCS/s.**\c
_source_file_
is found for a target
_source_file_,
_make_
compares the timestamp of the target file with that of the
**SCCS/s.source_file**
to ensure the target is up-to-date. If the target is missing, or if the
SCCS file is newer,
_make_
shall automatically issue the commands specified for the
**.SCCS_GET**
special target to retrieve the most recent version. However, if the
target is writable by anyone,
_make_
shall not retrieve a new version.

* **.SILENT**  
  Prerequisites of this special target are targets themselves; this shall
  cause commands associated with them not to be written to the standard
  output before they are executed. Subsequent occurrences of
  **.SILENT**
  shall add to the list of targets with silent commands. If no
  prerequisites are specified,
  _make_
  shall behave as if the
  **\(mis**
  option had been specified and no commands or touch messages associated
  with any target shall be written to standard output.
* **.SUFFIXES**  
  Prerequisites of
  **.SUFFIXES**
  shall be appended to the list of known suffixes and are used in
  conjunction with the inference rules (see
  _Inference Rules_).
  If
  **.SUFFIXES**
  does not have any prerequisites, the list of known suffixes shall be
  cleared.

The special targets
**.IGNORE**,
**.POSIX**,
**.PRECIOUS**,
**.SILENT**,
and
**.SUFFIXES**
shall be specified without commands.

Targets with names consisting of a leading
&lt;period&gt;
followed by the uppercase letters
**"POSIX"**
and then any other characters are reserved for future standardization.
Targets with names consisting of a leading
&lt;period&gt;
followed by one or more uppercase letters are reserved for implementation
extensions.

<a name="macros"></a>

### Macros


Macro definitions are in the form:

    
    string1 = [string2]


The macro named
_string1_
is defined as having the value of
_string2_,
where
_string2_
is defined as all characters, if any, after the
&lt;equals-sign&gt;,
up to a comment character (\c
**'#'**)
or an unescaped
&lt;newline&gt;.
Any
&lt;blank&gt;
characters immediately before or after the
&lt;equals-sign&gt;
shall be ignored.

Applications shall select macro names from the set of characters
consisting solely of periods, underscores, digits, and alphabetics from
the portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).
A macro name shall not contain an
&lt;equals-sign&gt;.
Implementations may allow other characters in macro names as extensions.

Macros can appear anywhere in the makefile. Macro expansions using
the forms $(\c
_string1_)
or ${\c
_string1_}
shall be replaced by
_string2_,
as follows:

*  *  
  Macros in target lines shall be evaluated when the target line is read.
*  *  
  Macros in makefile command lines shall be evaluated when the command is
  executed.
*  *  
  Macros in the string before the
  &lt;equals-sign&gt;
  in a macro definition shall be evaluated when the macro assignment
  is made.
*  *  
  Macros after the
  &lt;equals-sign&gt;
  in a macro definition shall not be evaluated until the defined macro
  is used in a rule or command, or before the
  &lt;equals-sign&gt;
  in a macro definition.

The parentheses or braces are optional if
_string1_
is a single character. The macro $$ shall be replaced by the single
character
**'$'**.
If
_string1_
in a macro expansion contains a macro expansion, the results are
unspecified.

Macro expansions using the forms $(\c
_string1_\c
**[:**\c
_subst1_\c
**=[**\c
_subst2_\c
**]]**)
or ${\c
_string1_\c
**[:**\c
_subst1_\c
**=[**\c
_subst2_\c
**]]**}
can be used to replace all occurrences of
_subst1_
with
_subst2_
when the macro substitution is performed. The
_subst1_
to be replaced shall be recognized when it is a suffix at the end of a
word in
_string1_
(where a
_word_,
in this context, is defined to be a string delimited by the beginning
of the line, a
&lt;blank&gt;,
or a
&lt;newline&gt;).
If
_string1_
in a macro expansion contains a macro expansion, the results are
unspecified.

Macro expansions in
_string1_
of macro definition lines shall be evaluated when read. Macro
expansions in
_string2_
of macro definition lines shall be performed when the macro identified
by
_string1_
is expanded in a rule or command.

Macro definitions shall be taken from the following sources, in the
following logical order, before the makefile(s) are read.

*  1.  
  Macros specified on the
  _make_
  utility command line, in the order specified on the command line. It is
  unspecified whether the internal macros defined in
  _Internal Macros_
  are accepted from this source.
*  2.  
  Macros defined by the
  _MAKEFLAGS_
  environment variable, in the order specified in the environment
  variable. It is unspecified whether the internal macros defined in
  _Internal Macros_
  are accepted from this source.
*  3.  
  The contents of the environment, excluding the
  _MAKEFLAGS_
  and
  _SHELL_
  variables and including the variables with null values.
*  4.  
  Macros defined in the inference rules built into
  _make_.

Macro definitions from these sources shall not override macro
definitions from a lower-numbered source. Macro definitions from a
single source (for example, the
_make_
utility command line, the
_MAKEFLAGS_
environment variable, or the other environment variables) shall
override previous macro definitions from the same source.

Macros defined in the makefile(s) shall override macro definitions that
occur before them in the makefile(s) and macro definitions from source
4. If the
**\(mie**
option is not specified, macros defined in the makefile(s) shall
override macro definitions from source 3. Macros defined in the
makefile(s) shall not override macro definitions from source 1 or
source 2.

Before the makefile(s) are read, all of the
_make_
utility command line options (except
**\(mif**
and
**\(mip**)
and
_make_
utility command line macro definitions (except any for the
_MAKEFLAGS_
macro), not already included in the
_MAKEFLAGS_
macro, shall be added to the
_MAKEFLAGS_
macro, quoted in an implementation-defined manner such that when
_MAKEFLAGS_
is read by another instance of the
_make_
command, the original macro's value is recovered. Other
implementation-defined options and macros may also be added to the
_MAKEFLAGS_
macro. If this modifies the value of the
_MAKEFLAGS_
macro, or, if the
_MAKEFLAGS_
macro is modified at any subsequent time, the
_MAKEFLAGS_
environment variable shall be modified to match the new value of the
_MAKEFLAGS_
macro. The result of setting
_MAKEFLAGS_
in the Makefile is unspecified.

Before the makefile(s) are read, all of the
_make_
utility command line macro definitions (except the
_MAKEFLAGS_
macro or the
_SHELL_
macro) shall be added to the environment of
_make_.
Other implementation-defined variables may also be added to the
environment of
_make_.

The
**SHELL**
macro shall be treated specially. It shall be provided by
_make_
and set to the pathname of the shell command language interpreter (see
__sh_\^_).
The
_SHELL_
environment variable shall not affect the value of the
**SHELL**
macro. If
**SHELL**
is defined in the makefile or is specified on the command line, it
shall replace the original value of the
**SHELL**
macro, but shall not affect the
_SHELL_
environment variable. Other effects of defining
**SHELL**
in the makefile or on the command line are implementation-defined.

<a name="inference-rules"></a>

### Inference Rules


Inference rules are formatted as follows:

    
    target:
    <tab>command
    [<tab>command]
    ...
    
    line that does not begin with <tab> or #


The application shall ensure that the
_target_
portion is a valid target name (see
_Target Rules_)
of the form
**.s2**
or
**.s1.s2**
(where
**.s1**
and
**.s2**
are suffixes that have been given as prerequisites of the
**.SUFFIXES**
special target and
_s1_
and
_s2_
do not contain any
&lt;slash&gt;
or
&lt;period&gt;
characters.) If there is only one
&lt;period&gt;
in the target, it is a single-suffix inference rule. Targets with two
periods are double-suffix inference rules. Inference rules can have
only one target before the
&lt;colon&gt;.

The application shall ensure that the makefile does not specify
prerequisites for inference rules; no characters other than white space
shall follow the
&lt;colon&gt;
in the first line, except when creating the
_empty rule,_
described below. Prerequisites are inferred, as described below.

Inference rules can be redefined. A target that matches an existing
inference rule shall overwrite the old inference rule. An empty rule
can be created with a command consisting of simply a
&lt;semicolon&gt;
(that is, the rule still exists and is found during inference rule search,
but since it is empty, execution has no effect). The empty rule can also
be formatted as follows:

    
    rule: ;


where zero or more
&lt;blank&gt;
characters separate the
&lt;colon&gt;
and
&lt;semicolon&gt;.

The
_make_
utility uses the suffixes of targets and their prerequisites to infer
how a target can be made up-to-date. A list of inference rules defines
the commands to be executed. By default,
_make_
contains a built-in set of inference rules. Additional rules can be
specified in the makefile.

The special target
**.SUFFIXES**
contains as its prerequisites a list of suffixes that shall be used by
the inference rules. The order in which the suffixes are specified
defines the order in which the inference rules for the suffixes are
used. New suffixes shall be appended to the current list by specifying
a
**.SUFFIXES**
special target in the makefile. A
**.SUFFIXES**
target with no prerequisites shall clear the list of suffixes. An
empty
**.SUFFIXES**
target followed by a new
**.SUFFIXES**
list is required to change the order of the suffixes.

Normally, the user would provide an inference rule for each suffix.
The inference rule to update a target with a suffix
**.s1**
from a prerequisite with a suffix
**.s2**
is specified as a target
**.s2.s1**.
The internal macros provide the means to specify general inference
rules (see
_Internal Macros_).

When no target rule is found to update a target, the inference rules
shall be checked. The suffix of the target (\c
**.s1**)
to be built is compared to the list of suffixes specified by the
**.SUFFIXES**
special targets. If the
**.s1**
suffix is found in
**.SUFFIXES**,
the inference rules shall be searched in the order defined for the
first
**.s2.s1**
rule whose prerequisite file (\c
**$*.s2**)
exists. If the target is out-of-date with respect to this
prerequisite, the commands for that inference rule shall be executed.

If the target to be built does not contain a suffix and there is no
rule for the target, the single suffix inference rules shall be
checked. The single-suffix inference rules define how to build a
target if a file is found with a name that matches the target name with
one of the single suffixes appended. A rule with one suffix
**.s2**
is the definition of how to build
_target_
from
**target.s2**.
The other suffix (\c
**.s1**)
is treated as null.

A
&lt;tilde&gt;
(\c
**'~'**)
in the above rules refers to an SCCS file in the current directory.
Thus, the rule
**.c~.o**
would transform an SCCS C-language source file into an object file (\c
**.o**).
Because the
**s.**
of the SCCS files is a prefix, it is incompatible with
_make_'s
suffix point of view. Hence, the
**'~'**
is a way of changing any file reference into an SCCS file reference.

<a name="libraries"></a>

### Libraries


If a target or prerequisite contains parentheses, it shall be treated
as a member of an archive library. For the
_lib_(\c
_member_\c
**.o**)
expression
_lib_
refers to the name of the archive library and
_member_\c
**.o**
to the member name. The application shall ensure that the member is an
object file with the
**.o**
suffix. The modification time of the expression is the modification
time for the member as kept in the archive library; see
__ar_\^_.
The
**.a**
suffix shall refer to an archive library. The
**.s2.a**
rule shall be used to update a member in the library from a file
with a suffix
**.s2**.

<a name="internal-macros"></a>

### Internal Macros


The
_make_
utility shall maintain five internal macros that can be used in target
and inference rules. In order to clearly define the meaning of these
macros, some clarification of the terms
_target rule_,
_inference rule_,
_target_,
and
_prerequisite_
is necessary.

Target rules are specified by the user in a makefile for a particular
target. Inference rules are user-specified or
_make_-specified
rules for a particular class of target name. Explicit prerequisites
are those prerequisites specified in a makefile on target lines.
Implicit prerequisites are those prerequisites that are generated when
inference rules are used. Inference rules are applied to implicit
prerequisites or to explicit prerequisites that do not have target
rules defined for them in the makefile. Target rules are applied to
targets specified in the makefile.

Before any target in the makefile is updated, each of its prerequisites
(both explicit and implicit) shall be updated. This shall be
accomplished by recursively processing each prerequisite. Upon
recursion, each prerequisite shall become a target itself. Its
prerequisites in turn shall be processed recursively until a target is
found that has no prerequisites, at which point the recursion stops.
The recursion shall then back up, updating each target as it goes.

In the definitions that follow, the word
_target_
refers to one of:

*  *  
  A target specified in the makefile
*  *  
  An explicit prerequisite specified in the makefile that becomes the
  target when
  _make_
  processes it during recursion
*  *  
  An implicit prerequisite that becomes a target when
  _make_
  processes it during recursion

In the definitions that follow, the word
_prerequisite_
refers to one of the following:

*  *  
  An explicit prerequisite specified in the makefile for a particular
  target
*  *  
  An implicit prerequisite generated as a result of locating an
  appropriate inference rule and corresponding file that matches the
  suffix of the target

The five internal macros are:

* $@  
  The $@ shall evaluate to the full target name of the current target, or
  the archive filename part of a library archive target. It shall be
  evaluated for both target and inference rules.

For example, in the
**.c.a**
inference rule, $@ represents the out-of-date
**.a**
file to be built. Similarly, in a makefile target rule to build
**lib.a**
from
**file.c**,
$@ represents the out-of-date
**lib.a**.

* $%  
  The $% macro shall be evaluated only when the current target is an
  archive library member of the form
  _libname_(\c
  _member_\c
  **.o**).
  In these cases, $@ shall evaluate to
  _libname_
  and $% shall evaluate to
  _member_\c
  **.o**.
  The $% macro shall be evaluated for both target and inference rules.

For example, in a makefile target rule to build
**lib.a**(\c
**file.o**),
$% represents
**file.o**,
as opposed to $@, which represents
**lib.a**.

* $?  
  The $? macro shall evaluate to the list of prerequisites that are
  newer than the current target. It shall be evaluated for both target
  and inference rules.

For example, in a makefile target rule to build
_prog_
from
**file1.o**,
**file2.o**,
and
**file3.o**,
and where
_prog_
is not out-of-date with respect to
**file1.o**,
but is out-of-date with respect to
**file2.o**
and
**file3.o**,
$? represents
**file2.o**
and
**file3.o**.

* $&lt;  
  In an inference rule, the $&lt; macro shall evaluate to the filename
  whose existence allowed the inference rule to be chosen for the target.
  In the
  **.DEFAULT**
  rule, the $&lt; macro shall evaluate to the current target name. The
  meaning of the $&lt; macro shall be otherwise unspecified.

For example, in the
**.c.a**
inference rule, $&lt; represents the prerequisite
**.c**
file.

* $*  
  The $* macro shall evaluate to the current target name with its suffix
  deleted. It shall be evaluated at least for inference rules.

For example, in the
**.c.a**
inference rule, $*.o represents the out-of-date
**.o**
file that corresponds to the prerequisite
**.c**
file.

Each of the internal macros has an alternative form. When an uppercase
**'D'**
or
**'F'**
is appended to any of the macros, the meaning shall be changed to the
_directory part_
for
**'D'**
and
_filename part_
for
**'F'**.
The directory part is the path prefix of the file without a trailing
&lt;slash&gt;;
for the current directory, the directory part is
**'.'**.
When the $? macro contains more than one prerequisite filename, the
$(?D) and $(?F) (or ${?D} and ${?F}) macros expand to a list of
directory name parts and filename parts respectively.

For the target
_lib_(\c
_member_\c
**.o**)
and the
**s2.a**
rule, the internal macros shall be defined as:

* $&lt;  
  _member_\c
  **.s2**
* $*  
  _member_
* $@  
  _lib_
* $?  
  _member_\c
  **.s2**
* $%  
  _member_\c
  **.o**

<a name="default-rules"></a>

### Default Rules


The default rules for
_make_
shall achieve results that are the same as if the following were used.
Implementations that do not support the C-Language Development
Utilities option may omit
**CC**,
**CFLAGS**,
**YACC**,
**YFLAGS**,
**LEX**,
**LFLAGS**,
**LDFLAGS**,
and the
**.c**,
**.y**,
and
**.l**
inference rules. Implementations that do not support FORTRAN may omit
**FC**,
**FFLAGS**,
and the
**.f**
inference rules. Implementations may provide additional macros and
rules.

    
    SPECIAL TARGETS
    
    .SCCS_GET: sccs $(SCCSFLAGS) get $(SCCSGETFLAGS) $@
    
    .SUFFIXES: .o .c .y .l .a .sh .f .c~ .y~ .l~ .sh~ .f~
    
    MACROS
    
    MAKE=make
    AR=ar
    ARFLAGS=(mirv
    YACC=yacc
    YFLAGS=
    LEX=lex
    LFLAGS=
    LDFLAGS=
    CC=c99
    CFLAGS=(miO
    FC=fort77
    FFLAGS=(miO 1
    GET=get
    GFLAGS=
    SCCSFLAGS=
    SCCSGETFLAGS=(mis
    
    SINGLE SUFFIX RULES
    
    .c:
        $(CC) $(CFLAGS) $(LDFLAGS) (mio $@ $<
    
    .f:
        $(FC) $(FFLAGS) $(LDFLAGS) (mio $@ $<
    
    .sh:
        cp $< $@
        chmod a+x $@
    
    .c~:
        $(GET) $(GFLAGS) (mip $< > $*.c
        $(CC) $(CFLAGS) $(LDFLAGS) (mio $@ $*.c
    
    .f~:
        $(GET) $(GFLAGS) (mip $< > $*.f
        $(FC) $(FFLAGS) $(LDFLAGS) (mio $@ $*.f
    
    .sh~:
        $(GET) $(GFLAGS) (mip $< > $*.sh
        cp $*.sh $@
        chmod a+x $@
    
    DOUBLE SUFFIX RULES
    
    .c.o:
        $(CC) $(CFLAGS) (mic $<
    
    .f.o:
        $(FC) $(FFLAGS) (mic $<
    
    .y.o:
        $(YACC) $(YFLAGS) $<
        $(CC) $(CFLAGS) (mic y.tab.c
        rm (mif y.tab.c
        mv y.tab.o $@
    
    .l.o:
        $(LEX) $(LFLAGS) $<
        $(CC) $(CFLAGS) (mic lex.yy.c
        rm (mif lex.yy.c
        mv lex.yy.o $@
    
    .y.c:
        $(YACC) $(YFLAGS) $<
        mv y.tab.c $@
    
    .l.c:
        $(LEX) $(LFLAGS) $<
        mv lex.yy.c $@
    
    .c~.o:
        $(GET) $(GFLAGS) (mip $< > $*.c
        $(CC) $(CFLAGS) (mic $*.c
    
    .f~.o:
        $(GET) $(GFLAGS) (mip $< > $*.f
        $(FC) $(FFLAGS) (mic $*.f
    
    .y~.o:
        $(GET) $(GFLAGS) (mip $< > $*.y
        $(YACC) $(YFLAGS) $*.y
        $(CC) $(CFLAGS) (mic y.tab.c
        rm (mif y.tab.c
        mv y.tab.o $@
    
    .l~.o:
        $(GET) $(GFLAGS) (mip $< > $*.l
        $(LEX) $(LFLAGS) $*.l
        $(CC) $(CFLAGS) (mic lex.yy.c
        rm (mif lex.yy.c
        mv lex.yy.o $@
    
    .y~.c:
        $(GET) $(GFLAGS) (mip $< > $*.y
        $(YACC) $(YFLAGS) $*.y
        mv y.tab.c $@
    
    .l~.c:
        $(GET) $(GFLAGS) (mip $< > $*.l
        $(LEX) $(LFLAGS) $*.l
        mv lex.yy.c $@
    
    .c.a:
        $(CC) (mic $(CFLAGS) $<
        $(AR) $(ARFLAGS) $@ $*.o
        rm (mif $*.o
    
    .f.a:
        $(FC) (mic $(FFLAGS) $<
        $(AR) $(ARFLAGS) $@ $*.o
        rm (mif $*.o


<a name="exit-status"></a>

# Exit Status

When the
**\(miq**
option is specified, the
_make_
utility shall exit with one of the following values:

* \00  
  Successful completion.
* \01  
  The target was not up-to-date.
* &gt;1  
  An error occurred.

When the
**\(miq**
option is not specified, the
_make_
utility shall exit with one of the following values:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

If there is a source file (such as
**./source.c**)
and there are two SCCS files corresponding to it (\c
**./s.source.c**
and
**./SCCS/s.source.c**),
on XSI-conformant systems
_make_
uses the SCCS file in the current directory. However, users are
advised to use the underlying SCCS utilities (\c
_admin_,
_delta_,
_get_,
and so on) or the
_sccs_
utility for all source files in a given directory. If both forms are
used for a given source file, future developers are very likely to be
confused.

It is incumbent upon portable makefiles to specify the
**.POSIX**
special target in order to guarantee that they are not affected by
local extensions.

The
**\(mik**
and
**\(miS**
options are both present so that the relationship between the command
line, the
_MAKEFLAGS_
variable, and the makefile can be controlled precisely. If the
**k**
flag is passed in
_MAKEFLAGS_
and a command is of the form:

    
    $(MAKE) (miS foo


then the default behavior is restored for the child
_make_.

When the
**\(min**
option is specified, it is always added to
_MAKEFLAGS_.
This allows a recursive
_make_
**\(min**
_target_
to be used to see all of the action that would be taken to update
_target_.

Because of widespread historical practice, interpreting a
&lt;number-sign&gt;
(\c
**'#'**)
inside a variable as the start of a comment has the unfortunate
side-effect of making it impossible to place a
&lt;number-sign&gt;
in a variable, thus forbidding something like:

    
    CFLAGS = "(miD COMMENT_CHAR='#'"


Many historical
_make_
utilities stop chaining together inference rules when an intermediate
target is nonexistent. For example, it might be possible for a
_make_
to determine that both
**.y.c**
and
**.c.o**
could be used to convert a
**.y**
to a
**.o**.
Instead, in this case,
_make_
requires the use of a
**.y.o**
rule.

The best way to provide portable makefiles is to include all of the
rules needed in the makefile itself. The rules provided use only
features provided by other parts of this volume of POSIX.1-2008. The default rules include
rules for optional commands in this volume of POSIX.1-2008. Only rules pertaining to commands
that are provided are needed in an implementation's default set.

Macros used within other macros are evaluated when the new macro is
used rather than when the new macro is defined. Therefore:

    
    MACRO = value1
    NEW   = $(MACRO)
    MACRO = value2
    
    target:
        echo $(NEW)


would produce
_value2_
and not
_value1_
since
**NEW**
was not expanded until it was needed in the
_echo_
command line.

Some historical applications have been known to intermix
_target_name_
and
_macro=name_
operands on the command line, expecting that all of the macros are
processed before any of the targets are dealt with. Conforming
applications do not do this, although some backwards-compatibility
support may be included in some implementations.

The following characters in filenames may give trouble:
**'='**,
**':'**,
**'\`'**,
single-quote, and
**'@'**.
In include filenames, pattern matching characters and
**'"'**
should also be avoided, as they may be treated as special by some
implementations.

For inference rules, the description of $&lt; and $? seem similar. However,
an example shows the minor difference. In a makefile containing:

    
    foo.o: foo.h


if
**foo.h**
is newer than
**foo.o**,
yet
**foo.c**
is older than
**foo.o**,
the built-in rule to make
**foo.o**
from
**foo.c**
is used, with $&lt; equal to
**foo.c**
and $? equal to
**foo.h**.
If
**foo.c**
is also newer than
**foo.o**,
$&lt; is equal to
**foo.c**
and $? is equal to
**foo.h foo.c**.

<a name="examples"></a>

# Examples


*  1.  
  The following command:

    
    make


makes the first target found in the makefile.

*  2.  
  The following command:

    
    make junk


makes the target
**junk**.

*  3.  
  The following makefile says that
  **pgm**
  depends on two files,
  **a.o**
  and
  **b.o**,
  and that they in turn depend on their corresponding source files (\c
  **a.c**
  and
  **b.c**),
  and a common file
  **incl.h**:

    
    pgm: a.o b.o
        c99 a.o b.o (mio pgm
    a.o: incl.h a.c
        c99 (mic a.c
    b.o: incl.h b.c
        c99 (mic b.c


*  4.  
  An example for making optimized
  **.o**
  files from
  **.c**
  files is:

    
    .c.o:
        c99 (mic (miO $*.c


or:

    
    .c.o:
        c99 (mic (miO $<


*  5.  
  The most common use of the archive interface follows. Here, it is
  assumed that the source files are all C-language source:

    
    lib: lib(file1.o) lib(file2.o) lib(file3.o)
        @echo lib is now up-to-date


The
**.c.a**
rule is used to make
**file1.o**,
**file2.o**,
and
**file3.o**
and insert them into
**lib**.

The treatment of escaped
&lt;newline&gt;
characters throughout the makefile is historical practice. For example,
the inference rule:

    
    .c.oe
    :


works, and the macro:

    
    f=  bar baze
        biz
    a:
        echo ==$f==


echoes
**"==bar&nbsp;baz&nbsp;biz=="**.

If $? were:

    
    /usr/include/stdio.h /usr/include/unistd.h foo.h


then $(?D) would be:

    
    /usr/include /usr/include .


and $(?F) would be:

    
    stdio.h unistd.h foo.h


*  6.  
  The contents of the built-in rules can be viewed by running:

    
    make (mip (mif /dev/null 2>/dev/null


<a name="rationale"></a>

# Rationale

The
_make_
utility described in this volume of POSIX.1-2008 is intended to provide the means for
changing portable source code into executables that can be run on an
POSIX.1-2008-conforming system. It reflects the most common features present
in System V and BSD
_make_s.

Historically, the
_make_
utility has been an especially fertile ground for vendor and research
organization-specific syntax modifications and extensions. Examples
include:

*  *  
  Syntax supporting parallel execution (such as from various
  multi-processor vendors, GNU, and others)
*  *  
  Additional \`\`operators'' separating targets and their prerequisites
  (System V, BSD, and others)
*  *  
  Specifying that command lines containing the strings
  **"${MAKE}"**
  and
  **"$(MAKE)"**
  are executed when the
  **\(min**
  option is specified (GNU and System V)
*  *  
  Modifications of the meaning of internal macros when referencing
  libraries (BSD and others)
*  *  
  Using a single instance of the shell for all of the command lines of
  the target (BSD and others)
*  *  
  Allowing
  &lt;space&gt;
  characters as well as
  &lt;tab&gt;
  characters to delimit command lines (BSD)
*  *  
  Adding C preprocessor-style \`\`include'' and \`\`ifdef'' constructs
  (System V, GNU, BSD, and others)
*  *  
  Remote execution of command lines (Sprite and others)
*  *  
  Specifying additional special targets (BSD, System V, and most others)

Additionally, many vendors and research organizations have rethought
the basic concepts of
_make_,
creating vastly extended, as well as completely new, syntaxes. Each of
these versions of
_make_
fulfills the needs of a different community of users; it is
unreasonable for this volume of POSIX.1-2008 to require behavior that would be incompatible
(and probably inferior) to historical practice for such a community.

In similar circumstances, when the industry has enough sufficiently
incompatible formats as to make them irreconcilable, this volume of POSIX.1-2008 has followed
one or both of two courses of action. Commands have been renamed (\c
_cksum_,
_echo_,
and
_pax_)
and/or command line options have been provided to select the desired
behavior (\c
_grep_,
_od_,
and
_pax_).

Because the syntax specified for the
_make_
utility is, by and large, a subset of the syntaxes accepted by almost
all versions of
_make_,
it was decided that it would be counter-productive to change the name.
And since the makefile itself is a basic unit of portability, it would
not be completely effective to reserve a new option letter, such as
_make_
**\(miP**,
to achieve the portable behavior. Therefore, the special target
**.POSIX**
was added to the makefile, allowing users to specify \`\`standard''
behavior. This special target does not preclude extensions in the
_make_
utility, nor does it preclude such extensions being used by the
makefile specifying the target; it does, however, preclude any
extensions from being applied that could alter the behavior of
previously valid syntax; such extensions must be controlled via
command line options or new special targets. It is incumbent upon
portable makefiles to specify the
**.POSIX**
special target in order to guarantee that they are not affected by
local extensions.

The portable version of
_make_
described in this reference page is not intended to be the
state-of-the-art software generation tool and, as such, some newer and
more leading-edge features have not been included. An attempt has been
made to describe the portable makefile in a manner that does not
preclude such extensions as long as they do not disturb the portable
behavior described here.

When the
**\(min**
option is specified, it is always added to
_MAKEFLAGS_.
This allows a recursive
_make_
**\(min**
_target_
to be used to see all of the action that would be taken to update
_target_.

The definition of
_MAKEFLAGS_
allows both the System V letter string and the BSD command line
formats. The two formats are sufficiently different to allow
implementations to support both without ambiguity.

Early proposals stated that an \`\`unquoted''
&lt;number-sign&gt;
was treated as the start of a comment. The
_make_
utility does not pay any attention to quotes. A
&lt;number-sign&gt;
starts a comment regardless of its surroundings.

The text about \`\`other implementation-defined pathnames may also be
tried'' in addition to
**./makefile**
and
**./Makefile**
is to allow such extensions as
**SCCS/s.Makefile**
and other variations. It was made an implementation-defined
requirement (as opposed to unspecified behavior) to highlight
surprising implementations that might select something unexpected like
**/etc/Makefile**.
XSI-conformant systems also try
**./s.makefile**,
**SCCS/s.makefile**,
**./s.Makefile**,
and
**SCCS/s.Makefile**.

Early proposals contained the macro
**NPROC**
as a means of specifying that
_make_
should use
_n_
processes to do the work required. While this feature is a valuable
extension for many systems, it is not common usage and could require
other non-trivial extensions to makefile syntax. This extension is not
required by this volume of POSIX.1-2008, but could be provided as a compatible extension. The
macro
**PARALLEL**
is used by some historical systems with essentially the same meaning
(but without using a name that is a common system limit value). It is
suggested that implementors recognize the existing use of
**NPROC**
and/or
**PARALLEL**
as extensions to
_make_.

The default rules are based on System V. The default
**CC=**
value is
_c99_
instead of
_cc_
because this volume of POSIX.1-2008 does not standardize the utility named
_cc_.
Thus, every conforming application would be required to define
**CC=**\c
_c99_
to expect to run. There is no advantage conferred by the hope that the
makefile might hit the \`\`preferred'' compiler because this cannot be
guaranteed to work. Also, since the portable makescript can only use
the
_c99_
options, no advantage is conferred in terms of what the script can do.
It is a quality-of-implementation issue as to whether
_c99_
is as valuable as
_cc_.

The
**\(mid**
option to
_make_
is frequently used to produce debugging information, but is too
implementation-defined to add to this volume of POSIX.1-2008.

The
**\(mip**
option is not passed in
_MAKEFLAGS_
on most historical implementations and to change this would cause many
implementations to break without sufficiently increased portability.

Commands that begin with a
&lt;plus-sign&gt;
(\c
**'\(pl'**)
are executed even if the
**\(min**
option is present. Based on the GNU version of
_make_,
the behavior of
**\(min**
when the
&lt;plus-sign&gt;
prefix is encountered has been extended to apply to
**\(miq**
and
**\(mit**
as well. However, the System V convention of forcing command execution
with
**\(min**
when the command line of a target contains either of the strings
**"$(MAKE)"**
or
**"${MAKE}"**
has not been adopted. This functionality appeared in early proposals,
but the danger of this approach was pointed out with the following
example of a portion of a makefile:

    
    subdir:
        cd subdir; rm all_the_files; $(MAKE)


The loss of the System V behavior in this case is well-balanced by the
safety afforded to other makefiles that were not aware of this
situation. In any event, the command line
&lt;plus-sign&gt;
prefix can provide the desired functionality.

The double
&lt;colon&gt;
in the target rule format is supported in BSD systems to allow more
than one target line containing the same target name to have commands
associated with it. Since this is not functionality described in the
SVID or XPG3 it has been allowed as an extension, but not mandated.

The default rules are provided with text specifying that the built-in
rules shall be the same as if the listed set were used. The intent is
that implementations should be able to use the rules without change,
but will be allowed to alter them in ways that do not affect the
primary behavior.

The best way to provide portable makefiles is to include all of the
rules needed in the makefile itself. The rules provided use only
features provided by other portions of this volume of POSIX.1-2008. The default rules include
rules for optional commands in this volume of POSIX.1-2008. Only rules pertaining to commands
that are provided are needed in the default set of an implementation.

One point of discussion was whether to drop the default rules list from
this volume of POSIX.1-2008. They provide convenience, but do not enhance portability of
applications. The prime benefit is in portability of users who wish to
type
_make_
_command_
and have the command build from a
**command.c**
file.

The historical
_MAKESHELL_
feature was omitted. In some implementations it is used to let a user
override the shell to be used to run
_make_
commands. This was confusing; for a portable
_make_,
the shell should be chosen by the makefile writer or specified on the
_make_
command line and not by a user running
_make_.

The
_make_
utilities in most historical implementations process the prerequisites
of a target in left-to-right order, and the makefile format
requires this. It supports the standard idiom used in many makefiles
that produce
_yacc_
programs; for example:

    
    foo: y.tab.o lex.o main.o
        $(CC) $(CFLAGS) (mio $@ t.tab.o lex.o main.o


In this example, if
_make_
chose any arbitrary order, the
**lex.o**
might not be made with the correct
**y.tab.h**.
Although there may be better ways to express this relationship, it is
widely used historically. Implementations that desire to update
prerequisites in parallel should require an explicit extension to
_make_
or the makefile format to accomplish it, as described previously.

The algorithm for determining a new entry for target rules is partially
unspecified. Some historical
_make_s
allow blank, empty, or comment lines within the collection of commands
marked by leading
&lt;tab&gt;
characters. A conforming makefile must ensure that each command starts
with a
&lt;tab&gt;,
but implementations are free to ignore blank, empty, and comment lines
without triggering the start of a new entry.

The ASYNCHRONOUS EVENTS section includes having SIGTERM and SIGHUP,
along with the more traditional SIGINT and SIGQUIT, remove the current
target unless directed not to do so. SIGTERM and SIGHUP were added to
parallel other utilities that have historically cleaned up their work
as a result of these signals. When
_make_
receives any signal other than SIGQUIT, it is required to resend itself
the signal it received so that it exits with a status that reflects the
signal. The results from SIGQUIT are partially unspecified because, on
systems that create
**core**
files upon receipt of SIGQUIT, the
**core**
from
_make_
would conflict with a
**core**
file from the command that was running when the SIGQUIT arrived. The
main concern was to prevent damaged files from appearing up-to-date when
_make_
is rerun.

The
**.PRECIOUS**
special target was extended to affect all targets globally (by
specifying no prerequisites). The
**.IGNORE**
and
**.SILENT**
special targets were extended to allow prerequisites; it was judged to
be more useful in some cases to be able to turn off errors or echoing
for a list of targets than for the entire makefile. These extensions
to
_make_
in System V were made to match historical practice from the BSD
_make_.

Macros are not exported to the environment of commands to be run. This
was never the case in any historical
_make_
and would have serious consequences. The environment is the same as
the environment to
_make_
except that
_MAKEFLAGS_
and macros defined on the
_make_
command line are added.

Some implementations do not use
_system_()
for all command lines, as required by the portable makefile
format; as a performance enhancement, they select lines without shell
metacharacters for direct execution by
_execve_().
There is no requirement that
_system_()
be used specifically, but merely that the same results be achieved.
The metacharacters typically used to bypass the direct
_execve_()
execution have been any of:

    
    =  |  ^  (  )  ;  &  <  >  *  ?  [  ]  :  $  `  '  "  e  en


The default in some advanced versions of
_make_
is to group all the command lines for a target and execute them using a
single shell invocation; the System V method is to pass each line
individually to a separate shell. The single-shell method has the
advantages in performance and the lack of a requirement for many
continued lines. However, converting to this newer method has caused
portability problems with many historical makefiles, so the behavior
with the POSIX makefile is specified to be the same as that of System
V. It is suggested that the special target
**.ONESHELL**
be used as an implementation extension to achieve the single-shell
grouping for a target or group of targets.

Novice users of
_make_
have had difficulty with the historical need to start commands with a
&lt;tab&gt;.
Since it is often difficult to discern differences between
&lt;tab&gt;
and
&lt;space&gt;
characters on terminals or printed listings, confusing bugs can arise. In
early proposals, an attempt was made to correct this problem by allowing
leading
&lt;blank&gt;
characters instead of
&lt;tab&gt;
characters. However, implementors reported many makefiles that failed
in subtle ways following this change, and it is difficult to implement a
_make_
that unambiguously can differentiate between macro and command lines.
There is extensive historical practice of allowing leading
&lt;space&gt;
characters before macro definitions. Forcing macro lines into column 1
would be a significant backwards-compatibility problem for some makefiles.
Therefore, historical practice was restored.

There is substantial variation in the handling of include lines by
different implementations. However, there is enough commonality for the
standard to be able to specify a minimum set of requirements that allow
the feature to be used portably. Known variations have been explicitly
called out as unspecified behavior in the description.

The System V dynamic dependency feature was not included. It would
support:

    
    cat: $$@.c


that would expand to;

    
    cat: cat.c


This feature exists only in the new version of System V
_make_
and, while useful, is not in wide usage. This means that macros are
expanded twice for prerequisites: once at makefile parse time and once
at target update time.

Consideration was given to adding metarules to the POSIX
_make_.
This would make
**%.o:&nbsp;%.c**
the same as
**.c.o:**.
This is quite useful and available from some vendors, but it would
cause too many changes to this
_make_
to support. It would have introduced rule chaining and new substitution
rules. However, the rules for target names have been set to reserve the
**'%'**
and
**'"'**
characters. These are traditionally used to implement metarules and
quoting of target names, respectively. Implementors are strongly
encouraged to use these characters only for these purposes.

A request was made to extend the suffix delimiter character from a
&lt;period&gt;
to any character. The metarules feature in newer
_make_s
solves this problem in a more general way. This volume of POSIX.1-2008 is staying with the
more conservative historical definition.

The standard output format for the
**\(mip**
option is not described because it is primarily a debugging option and
because the format is not generally useful to programs. In historical
implementations the output is not suitable for use in generating
makefiles. The
**\(mip**
format has been variable across historical implementations. Therefore,
the definition of
**\(mip**
was only to provide a consistently named option for obtaining
_make_
script debugging information.

Some historical implementations have not cleared the suffix list with
**\(mir**.

Implementations should be aware that some historical applications have
intermixed
_target_name_
and
_macro_=\c
_value_
operands on the command line, expecting that all of the macros are
processed before any of the targets are dealt with. Conforming
applications do not do this, but some backwards-compatibility support
may be warranted.

Empty inference rules are specified with a
&lt;semicolon&gt;
command rather than omitting all commands, as described in an early
proposal. The latter case has no traditional meaning and is reserved
for implementation extensions, such as in GNU
_make_.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__ar_\^_,
__c99_\^_,
__get_\^_,
__lex_\^_,
__sccs_\^_,
__sh_\^_,
__yacc_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__exec_\^_,
__system_\^(\|)_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
