# xargs(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

xargs
— construct argument lists and invoke utility

<a name="synopsis"></a>

# Synopsis

```


```
    xargs [(miptx] [(miE eofstr] [(miI replstr|(miL number|(min number]
        [(mis size] [utility [argument...]]

<a name="description"></a>

# Description

The
_xargs_
utility shall construct a command line consisting of the
_utility_
and
_argument_
operands specified followed by as many arguments read in sequence from
standard input as fit in length and number constraints specified by the
options. The
_xargs_
utility shall then invoke the constructed command line and wait for its
completion. This sequence shall be repeated until one of the following
occurs:

*  *  
  An end-of-file condition is detected on standard input.
*  *  
  An argument consisting of just the logical end-of-file string
  (see the
  **\(miE**
  _eofstr_
  option) is found on standard input after double-quote processing,
  &lt;apostrophe&gt;
  processing, and
  &lt;backslash&gt;-escape
  processing (see next paragraph). All arguments up to but not including
  the argument consisting of just the logical end-of-file string shall be
  used as arguments in constructed command lines.
*  *  
  An invocation of a constructed command line returns an exit status of
  255.

The application shall ensure that arguments in the standard input are
separated by unquoted
&lt;blank&gt;
characters, unescaped
&lt;blank&gt;
characters, or
&lt;newline&gt;
characters. A string of zero or more non-double-quote (\c
**'"'**)
characters and non-\c
&lt;newline&gt;
characters can be quoted by enclosing them in double-quotes. A string
of zero or more non-\c
&lt;apostrophe&gt;
(\c
**'\e''**)
characters and non-\c
&lt;newline&gt;
characters can be quoted by enclosing them in
&lt;apostrophe&gt;
characters. Any unquoted character can be escaped by preceding it with a
&lt;backslash&gt;.
The utility named by
_utility_
shall be executed one or more times until the end-of-file is reached or
the logical end-of file string is found. The results are unspecified if
the utility named by
_utility_
attempts to read from its standard input.

The generated command line length shall be the sum of the size in bytes
of the utility name and each argument treated as strings, including a
null byte terminator for each of these strings. The
_xargs_
utility shall limit the command line length such that when the command
line is invoked, the combined argument and environment lists (see the
_exec_
family of functions in the System Interfaces volume of POSIX.1-2008) shall not exceed
{ARG_MAX}\(mi2\|048
bytes. Within this constraint, if neither the
**\(min**
nor the
**\(mis**
option is specified, the default command line length shall be at least
{LINE_MAX}.

<a name="options"></a>

# Options

The
_xargs_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miE&nbsp;eofstr**  
  Use
  _eofstr_
  as the logical end-of-file string. If
  **\(miE**
  is not specified, it is unspecified whether the logical end-of-file
  string is the
  &lt;underscore&gt;
  character (\c
  **'_'**)
  or the end-of-file string capability is disabled. When
  _eofstr_
  is the null string, the logical end-of-file string capability shall be
  disabled and
  &lt;underscore&gt;
  characters shall be taken literally.
* **\(miI&nbsp;replstr**  
  Insert mode:
  _utility_
  is executed for each logical line from standard input. Arguments in the
  standard input shall be separated only by unescaped
  &lt;newline&gt;
  characters, not by
  &lt;blank&gt;
  characters. Any unquoted unescaped
  &lt;blank&gt;
  characters at the beginning of each line shall be ignored. The resulting
  argument shall be inserted in
  _arguments_
  in place of each occurrence of
  _replstr_.
  At least five arguments in
  _arguments_
  can each contain one or more instances of
  _replstr_.
  Each of these constructed arguments cannot grow larger than an
  implementation-defined limit greater than or equal to 255 bytes. Option
  **\(mix**
  shall be forced on.
* **\(miL&nbsp;number**  
  The
  _utility_
  shall be executed for each non-empty
  _number_
  lines of arguments from standard input. The last invocation of
  _utility_
  shall be with fewer lines of arguments if fewer than
  _number_
  remain. A line is considered to end with the first
  &lt;newline&gt;
  unless the last character of the line is a
  &lt;blank&gt;;
  a trailing
  &lt;blank&gt;
  signals continuation to the next non-empty line, inclusive.
* **\(min&nbsp;number**  
  Invoke
  _utility_
  using as many standard input arguments as possible, up to
  _number_
  (a positive decimal integer) arguments maximum. Fewer arguments shall
  be used if:
    *  *  
      The command line length accumulated exceeds the size specified by the
      **\(mis**
      option (or
      {LINE_MAX}
      if there is no
      **\(mis**
      option).
    *  *  
      The last iteration has fewer than
      _number_,
      but not zero, operands remaining.
* **\(mip**  
  Prompt mode: the user is asked whether to execute
  _utility_
  at each invocation. Trace mode (\c
  **\(mit**)
  is turned on to write the command instance to be executed, followed by
  a prompt to standard error. An affirmative response read from
  **/dev/tty**
  shall execute the command; otherwise, that particular invocation of
  _utility_
  shall be skipped.
* **\(mis&nbsp;size**  
  Invoke
  _utility_
  using as many standard input arguments as possible yielding a command
  line length less than
  _size_
  (a positive decimal integer) bytes. Fewer arguments shall be used if:
    *  *  
      The total number of arguments exceeds that specified by the
      **\(min**
      option.
    *  *  
      The total number of lines exceeds that specified by the
      **\(miL**
      option.
    *  *  
      End-of-file is encountered on standard input before
      _size_
      bytes are accumulated.

Values of
_size_
up to at least
{LINE_MAX}
bytes shall be supported, provided that the constraints specified in
the DESCRIPTION are met. It shall not be considered an error if a
value larger than that supported by the implementation or exceeding the
constraints specified in the DESCRIPTION is given;
_xargs_
shall use the largest value it supports within the constraints.

* **\(mit**  
  Enable trace mode. Each generated command line shall be written to
  standard error just prior to invocation.
* **\(mix**  
  Terminate if a constructed command line will not fit in the
  implied or specified size (see the
  **\(mis**
  option above).

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _utility_  
  The name of the utility to be invoked, found by search path using the
  _PATH_
  environment variable, described in the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.
  If
  _utility_
  is omitted, the default shall be the
  _echo_
  utility. If the
  _utility_
  operand names any of the special built-in utilities in
  _Section 2.14_, _Special Built-In Utilities_,
  the results are undefined.
* _argument_  
  An initial option or operand for the invocation of
  _utility_.

<a name="stdin"></a>

# Stdin

The standard input shall be a text file. The results are unspecified if
an end-of-file condition is detected immediately following an escaped
&lt;newline&gt;.

<a name="input-files"></a>

# Input Files

The file
**/dev/tty**
shall be used to read responses required by the
**\(mip**
option.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_xargs_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements used in the extended regular
  expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classes used in the extended regular expression defined for
  the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_MESSAGES_    
  Determine the locale used to process affirmative responses, and the
  locale used to affect the format and contents of diagnostic messages
  and prompts written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PATH_  
  Determine the location of
  _utility_,
  as described in the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used for diagnostic messages and the
**\(mit**
and
**\(mip**
options. If the
**\(mit**
option is specified, the
_utility_
and its constructed argument list shall be written to standard error,
as it will be invoked, prior to invocation. If
**\(mip**
is specified, a prompt of the following format shall be written (in the
POSIX locale):

    
    "?..."


at the end of the line of the output from
**\(mit**.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \0\0\0\00  
  All invocations of
  _utility_
  returned exit status zero.
* 1-125  
  A command line meeting the specified requirements could not be
  assembled, one or more of the invocations of
  _utility_
  returned a non-zero exit status, or some other error occurred.
* \0\0126  
  The utility specified by
  _utility_
  was found but could not be invoked.
* \0\0127  
  The utility specified by
  _utility_
  could not be found.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If a command line meeting the specified requirements cannot be
assembled, the utility cannot be invoked, an invocation of the utility
is terminated by a signal, or an invocation of the utility exits with
exit status 255, the
_xargs_
utility shall write a diagnostic message and exit without processing
any remaining input.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The 255 exit status allows a utility being used by
_xargs_
to tell
_xargs_
to terminate if it knows no further invocations using the current data
stream will succeed. Thus,
_utility_
should explicitly
_exit_
with an appropriate value to avoid accidentally returning with 255.

Note that since input is parsed as lines,
&lt;blank&gt;
characters separate arguments, and
&lt;backslash&gt;,
&lt;apostrophe&gt;,
and double-quote characters are used for quoting, if
_xargs_
is used to bundle the output of commands like
_find_
_dir_
**\(miprint**
or
_ls_
into commands to be executed, unexpected results are likely if any
filenames contain
&lt;blank&gt;,
&lt;newline&gt;,
or quoting characters. This can be solved by using find to call a script
that converts each file found into a quoted string that is then piped to
_xargs_,
but in most cases it is preferable just to have
_find_
do the argument aggregation itself by using
**\(miexec**
with a
**'+'**
terminator instead of
**';'**.
Note that the quoting rules used by
_xargs_
are not the same as in the shell. They were not made consistent here
because existing applications depend on the current rules. An easy (but
inefficient) method that can be used to transform input consisting of
one argument per line into a quoted form that
_xargs_
interprets correctly is to precede each non-\c
&lt;newline&gt;
character with a
&lt;backslash&gt;.
More efficient alternatives are shown in Example 2 and Example 5 below.

On implementations with a large value for
{ARG_MAX},
_xargs_
may produce command lines longer than
{LINE_MAX}.
For invocation of utilities, this is not a problem. If
_xargs_
is being used to create a text file, users should explicitly set the
maximum command line length with the
**\(mis**
option.

The
_command_,
_env_,
_nice_,
_nohup_,
_time_,
and
_xargs_
utilities have been specified to use exit code 127 if an error occurs
so that applications can distinguish \`\`failure to find a utility'' from
\`\`invoked utility exited with an error indication''. The value 127 was
chosen because it is not commonly used for other meanings; most
utilities use small values for \`\`normal error conditions'' and the
values above 128 can be confused with termination due to receipt of a
signal. The value 126 was chosen in a similar manner to indicate that
the utility could be found, but not invoked. Some scripts produce
meaningful error messages differentiating the 126 and 127 cases. The
distinction between exit codes 126 and 127 is based on KornShell
practice that uses 127 when all attempts to
_exec_
the utility fail with
**[ENOENT]**,
and uses 126 when any attempt to
_exec_
the utility fails for any other reason.

<a name="examples"></a>

# Examples


*  1.  
  The following command combines the output of the parenthesized
  commands (minus the
  &lt;apostrophe&gt;
  characters) onto one line, which is then appended to the file log. It
  assumes that the expansion of
  **"$0**$*"
  does not include any
  &lt;apostrophe&gt;
  or
  &lt;newline&gt;
  characters.

    
    (logname; date; printf "'%s'en$0 $*") | xargs (miE "" >>log


*  2.  
  The following command invokes
  _diff_
  with successive pairs of arguments originally typed as command line
  arguments. It assumes there are no embedded
  &lt;newline&gt;
  characters in the elements of the original argument list.

    
    printf "%sen$@" | sed 's/[^[:alnum:]]/ee&/g' |
        xargs (miE "" (min 2 (mix diff


*  3.  
  In the following commands, the user is asked which files in the current
  directory (excluding dotfiles) are to be archived. The files are
  archived into
  **arch**;
  _a_,
  one at a time or
  _b_,
  many at a time. The commands assume that no filenames contain
  &lt;blank&gt;,
  &lt;newline&gt;,
  &lt;backslash&gt;,
  &lt;apostrophe&gt;,
  or double-quote characters.

    
    a. ls | xargs (miE "" (mip (miL 1 ar (mir arch
    
    b. ls | xargs (miE "" (mip (miL 1 | xargs (miE "" ar (mir arch


*  4.  
  The following command invokes
  _command1_
  one or more times with multiple arguments, stopping if an invocation of
  _command1_
  has a non-zero exit status.

    
    xargs (miE "" sh (mic 'command1 "$@" || exit 255' sh < xargs_input


*  5.  
  On XSI-conformant systems, the following command moves all files
  from directory
  **$1**
  to directory
  **$2**,
  and echoes each move command just before doing it. It assumes no
  filenames contain
  &lt;newline&gt;
  characters and that neither
  **$1**
  nor
  **$2**
  contains the sequence
  **"{}"**.

    
    ls (miA "$1" | sed (mie 's/"/"ee""/g' (mie 's/.*/"&"/' |
        xargs (miE "" (miI {} (mit mv "$1"/{} "$2"/{}


<a name="rationale"></a>

# Rationale

The
_xargs_
utility was usually found only in System V-based systems; BSD systems
included an
_apply_
utility that provided functionality similar to
_xargs_
**\(min**
_number_.
The SVID lists
_xargs_
as a software development extension. This volume of POSIX.1-2008 does not share the view that
it is used only for development, and therefore it is not optional.

The classic application of the
_xargs_
utility is in conjunction with the
_find_
utility to reduce the number of processes launched by a simplistic use
of the
_find_
**\(miexec**
combination. The
_xargs_
utility is also used to enforce an upper limit on memory required to
launch a process. With this basis in mind, this volume of POSIX.1-2008 selected only the
minimal features required.

Although the 255 exit status is mostly an accident of historical
implementations, it allows a utility being used by
_xargs_
to tell
_xargs_
to terminate if it knows no further invocations using the current data
stream shall succeed. Any non-zero exit status from a utility falls
into the 1-125 range when
_xargs_
exits. There is no statement of how the various non-zero utility exit
status codes are accumulated by
_xargs_.
The value could be the addition of all codes, their highest value, the
last one received, or a single value such as 1. Since no algorithm is
arguably better than the others, and since many of the standard
utilities say little more (portably) than \`\`pass/fail'', no new
algorithm was invented.

Several other
_xargs_
options were removed because simple alternatives already exist within
this volume of POSIX.1-2008. For example, the
**\(mii**
_replstr_
option can be just as efficiently performed using a shell
**for**
loop. Since
_xargs_
calls an
_exec_
function with each input line, the
**\(mii**
option does not usually exploit the grouping capabilities of
_xargs_.

The requirement that
_xargs_
never produces command lines such that invocation of
_utility_
is within 2\|048 bytes of hitting the POSIX
_exec_
{ARG_MAX}
limitations is intended to guarantee that the invoked utility has room
to modify its environment variables and command line arguments and
still be able to invoke another utility. Note that the minimum
{ARG_MAX}
allowed by the System Interfaces volume of POSIX.1-2008 is 4\|096 bytes and the minimum
value allowed by this volume of POSIX.1-2008 is 2\|048 bytes; therefore,
the 2\|048 bytes difference seems reasonable. Note, however, that
_xargs_
may never be able to invoke a utility if the environment passed in to
_xargs_
comes close to using
{ARG_MAX}
bytes.

The version of
_xargs_
required by this volume of POSIX.1-2008 is required to wait for the completion of the invoked
command before invoking another command. This was done because
historical scripts using
_xargs_
assumed sequential execution. Implementations wanting to provide
parallel operation of the invoked utilities are encouraged to add an
option enabling parallel invocation, but should still wait for
termination of all of the children before
_xargs_
terminates normally.

The
**\(mie**
option was omitted from the ISO&nbsp;POSIX-2:\|1993 standard in the belief that the
_eofstr_
option-argument was recognized only when it was on a line by itself and
before quote and escape processing were performed, and that the logical
end-of-file processing was only enabled if a
**\(mie**
option was specified. In that case, a simple
_sed_
script could be used to duplicate the
**\(mie**
functionality. Further investigation revealed that:

*  *  
  The logical end-of-file string was checked for after quote and escape
  processing, making a
  _sed_
  script that provided equivalent functionality much more difficult to
  write.
*  *  
  The default was to perform logical end-of-file processing with an
  &lt;underscore&gt;
  as the logical end-of-file string.

To correct this misunderstanding, the
**\(miE**
_eofstr_
option was adopted from the X/Open Portability Guide. Users should
note that the description of the
**\(miE**
option matches historical documentation of the
**\(mie**
option (which was not adopted because it did not support the Utility
Syntax Guidelines), by
saying that if
_eofstr_
is the null string, logical end-of-file processing is disabled.
Historical implementations of
_xargs_
actually did not disable logical end-of-file processing; they treated a
null argument found in the input as a logical end-of-file string. (A
null
_string_
argument could be generated using single or double-quotes (\c
**'\^'**
or
**"\^"**).
Since this behavior was not documented historically, it is considered
to be a bug.

The
**\(miI**,
**\(miL**,
and
**\(min**
options are mutually-exclusive. Some implementations use the last one
specified if more than one is given on a command line; other
implementations treat combinations of the options in different ways.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__diff_\^_,
__echo_\^_,
__find_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__exec_\^_

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
