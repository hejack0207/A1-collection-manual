# sed(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

sed
— stream editor

<a name="synopsis"></a>

# Synopsis

```


```
    sed [(min] script [file...]
    
    sed [(min] (mie script [(mie script]... [(mif script_file]... [file...]
    
    sed [(min] [(mie script]... (mif script_file [(mif script_file]... [file...]

<a name="description"></a>

# Description

The
_sed_
utility is a stream editor that shall read one or more text files, make
editing changes according to a script of editing commands, and write
the results to standard output. The script shall be obtained from
either the
_script_
operand string or a combination of the option-arguments from the
**\(mie**
_script_
and
**\(mif**
_script_file_
options.

<a name="options"></a>

# Options

The
_sed_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that the order of presentation of the
**\(mie**
and
**\(mif**
options is significant.

The following options shall be supported:

* **\(mie&nbsp;script**  
  Add the editing commands specified by the
  _script_
  option-argument to the end of the script of editing commands.
* **\(mif&nbsp;script\_file**  
  Add the editing commands in the file
  _script_file_
  to the end of the script of editing commands.
* **\(min**  
  Suppress the default output (in which each line, after it is examined
  for editing, is written to standard output). Only lines explicitly
  selected for output are written.

If any
**\(mie**
or
**\(mif**
options are specified, the script of editing commands shall initially
be empty. The commands specified by each
**\(mie**
or
**\(mif**
option shall be added to the script in the order specified. When each
addition is made, if the previous addition (if any) was from a
**\(mie**
option, a
&lt;newline&gt;
shall be inserted before the new addition. The resulting script shall
have the same properties as the
_script_
operand, described in the OPERANDS section.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file_  
  A pathname of a file whose contents are read and edited. If multiple
  _file_
  operands are specified, the named files shall be read in the order
  specified and the concatenation shall be edited. If no
  _file_
  operands are specified, the standard input shall be used.
* _script_  
  A string to be used as the script of editing commands. The application
  shall not present a
  _script_
  that violates the restrictions of a text file except that the final
  character need not be a
  &lt;newline&gt;.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operands are specified, and shall be used if a
_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard input.
Otherwise, the standard input shall not be used.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files. The
_script_file_s
named by the
**\(mif**
option shall consist of editing commands.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_sed_:

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
  and multi-character collating elements within regular expressions.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files), and the behavior
  of character classes within regular expressions.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The input files shall be written to standard output, with the editing
commands specified in the script applied. If the
**\(min**
option is specified, only those input lines selected by the script
shall be written to standard output.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output files shall be text files whose formats are dependent on the
editing commands given.

<a name="extended-description"></a>

# Extended Description

The
_script_
shall consist of editing commands of the following form:

    
    [address[,address]]function


where
_function_
represents a single-character command verb from the list in
_Editing Commands in sed_,
followed by any applicable arguments.

The command can be preceded by
&lt;blank&gt;
characters and/or
&lt;semicolon&gt;
characters. The function can be preceded by
&lt;blank&gt;
characters. These optional characters shall have no effect.

In default operation,
_sed_
cyclically shall append a line of input, less its terminating
&lt;newline&gt;
character, into the pattern space. Reading from input shall be skipped
if a
&lt;newline&gt;
was in the pattern space prior to a
**D**
command ending the previous cycle. The
_sed_
utility shall then apply in sequence all commands whose addresses select
that pattern space, until a command starts the next cycle or quits. If
no commands explicitly started a new cycle, then at the end of the script
the pattern space shall be copied to standard output (except when
**\(min**
is specified) and the pattern space shall be deleted. Whenever the
pattern space is written to standard output or a named file,
_sed_
shall immediately follow it with a
&lt;newline&gt;.

Some of the editing commands use a hold space to save all or part of
the pattern space for subsequent retrieval. The pattern and hold spaces
shall each be able to hold at least 8\|192 bytes.

<a name="addresses-in-sed"></a>

### Addresses in sed


An address is either a decimal number that counts input lines
cumulatively across files, a
**'$'**
character that addresses the last line of input, or a context address
(which consists of a BRE, as described in
_Regular Expressions in sed_,
preceded and followed by a delimiter, usually a
&lt;slash&gt;).

An editing command with no addresses shall select every pattern space.

An editing command with one address shall select each pattern space
that matches the address.

An editing command with two addresses shall select the inclusive range
from the first pattern space that matches the first address through the
next pattern space that matches the second. (If the second address is a
number less than or equal to the line number first selected, only one
line shall be selected.) Starting at the first line following the
selected range,
_sed_
shall look again for the first address. Thereafter, the process shall
be repeated. Omitting either or both of the address components in the
following form produces undefined results:

    
    [address[,address]]


<a name="regular-expressions-in-sed"></a>

### Regular Expressions in sed


The
_sed_
utility shall support the BREs described in the Base Definitions volume of POSIX.1-2008,
_Section 9.3_, _Basic Regular Expressions_,
with the following additions:

*  *  
  In a context address, the construction
  **"\ecBREc"**,
  where
  _c_
  is any character other than
  &lt;backslash&gt;
  or
  &lt;newline&gt;,
  shall be identical to
  **"/BRE/"**.
  If the character designated by
  _c_
  appears following a
  &lt;backslash&gt;,
  then it shall be considered to be that literal character, which shall
  not terminate the BRE. For example, in the context address
  **"\exabc\exdefx"**,
  the second
  _x_
  stands for itself, so that the BRE is
  **"abcxdef"**.
*  *  
  The escape sequence
  **'\en'**
  shall match a
  &lt;newline&gt;
  embedded in the pattern space. A literal
  &lt;newline&gt;
  shall not be used in the BRE of a context address or in the substitute
  function.
*  *  
  If an RE is empty (that is, no pattern is specified)
  _sed_
  shall behave as if the last RE used in the last command applied (either
  as an address or as part of a substitute command) was specified.

<a name="editing-commands-in-sed"></a>

### Editing Commands in sed


In the following list of editing commands, the maximum number of
permissible addresses for each function is indicated by [\c
_0addr_],
[\c
_1addr_],
or [\c
_2addr_],
representing zero, one, or two addresses.

The argument
_text_
shall consist of one or more lines. Each embedded
&lt;newline&gt;
in the text shall be preceded by a
&lt;backslash&gt;.
Other
&lt;backslash&gt;
characters in text shall be removed, and the following character shall
be treated literally.

The
**r**
and
**w**
command verbs, and the
_w_
flag to the
**s**
command, take an
_rfile_
(or
_wfile_)
parameter, separated from the command verb letter or flag by one or
more
&lt;blank&gt;
characters; implementations may allow zero separation as an extension.

The argument
_rfile_
or the argument
_wfile_
shall terminate the editing command. Each
_wfile_
shall be created before processing begins. Implementations shall
support at least ten
_wfile_
arguments in the script; the actual number (greater than or equal to
10) that is supported by the implementation is unspecified. The
use of the
_wfile_
parameter shall cause that file to be initially created, if it does not
exist, or shall replace the contents of an existing file.

The
**b**,
**r**,
**s**,
**t**,
**w**,
**y**,
and
**:**
command verbs shall accept additional arguments. The following synopses
indicate which arguments shall be separated from the command verbs by a
single
&lt;space&gt;.

The
**a**
and
**r**
commands schedule text for later output. The text specified for the
**a**
command, and the contents of the file specified for the
**r**
command, shall be written to standard output just before the next
attempt to fetch a line of input when executing the
**N**
or
**n**
commands, or when reaching the end of the script. If written when
reaching the end of the script, and the
**\(min**
option was not specified, the text shall be written after copying the
pattern space to standard output. The contents of the file specified
for the
**r**
command shall be as of the time the output is written, not the time the
**r**
command is applied. The text shall be output in the order in which the
**a**
and
**r**
commands were applied to the input.

Command verbs other than
**{**,
**a**,
**b**,
**c**,
**i**,
**r**,
**t**,
**w**,
**:**,
and
**#**
can be followed by a
&lt;semicolon&gt;,
optional
&lt;blank&gt;
characters, and another command verb. However, when the
**s**
command verb is used with the
_w_
flag, following it with another command in this manner produces
undefined results.

A function can be preceded by one or more
**'!'**
characters, in which case the function shall be applied if the
addresses do not select the pattern space. Zero or more
&lt;blank&gt;
characters shall be accepted before the first
**'!'**
character. It is unspecified whether
&lt;blank&gt;
characters can follow a
**'!'**
character, and conforming applications shall not follow a
**'!'**
character with
&lt;blank&gt;
characters.

* **[2addr]&nbsp;{editing command**  
* _editing command_  
* .\|.\|.  
* **}**  
  Execute a list of
  _sed_
  editing commands only when the pattern space is selected. The list of
  _sed_
  editing commands shall be surrounded by braces and separated by
  &lt;newline&gt;
  characters, and conform to the following rules. The braces can be preceded
  or followed by
  &lt;blank&gt;
  characters. The editing commands can be preceded by
  &lt;blank&gt;
  characters, but shall not be followed by
  &lt;blank&gt;
  characters. The
  &lt;right-brace&gt;
  shall be preceded by a
  &lt;newline&gt;
  and can be preceded or followed by
  &lt;blank&gt;
  characters.
* **[1addr]a\e**  
* _text_  
  Write text to standard output as described previously.
* **[2addr]b&nbsp;[label]**    
  Branch to the
  **:**
  function bearing the
  _label_.
  If
  _label_
  is not specified, branch to the end of the script. The implementation
  shall support
  _label_s
  recognized as unique up to at least 8 characters; the actual length
  (greater than or equal to 8) that shall be supported by the
  implementation is unspecified. It is unspecified whether exceeding a
  label length causes an error or a silent truncation.
* **[2addr]c\e**  
* _text_  
  Delete the pattern space. With a 0 or 1 address or at the end of a
  2-address range, place
  _text_
  on the output and start the next cycle.
* **[2addr]d**  
  Delete the pattern space and start the next cycle.
* **[2addr]D**  
  If the pattern space contains no
  &lt;newline&gt;,
  delete the pattern space and start a normal new cycle as if the
  **d**
  command was issued. Otherwise, delete the initial segment of the
  pattern space through the first
  &lt;newline&gt;,
  and start the next cycle with the resultant pattern space and without
  reading any new input.
* **[2addr]g**  
  Replace the contents of the pattern space by the contents of the hold
  space.
* **[2addr]G**  
  Append to the pattern space a
  &lt;newline&gt;
  followed by the contents of the hold space.
* **[2addr]h**  
  Replace the contents of the hold space with the contents of the pattern
  space.
* **[2addr]H**  
  Append to the hold space a
  &lt;newline&gt;
  followed by the contents of the pattern space.
* **[1addr]i\e**  
* _text_  
  Write
  _text_
  to standard output.
* **[2addr]l**  
  (The letter ell.) Write the pattern space to standard output in a
  visually unambiguous form. The characters listed in the Base Definitions volume of POSIX.1-2008,
  _Table 5-1_, _Escape Sequences and Associated Actions_
  (\c
  **'\e\e'**,
  **'\ea'**,
  **'\eb'**,
  **'\ef'**,
  **'\er'**,
  **'\et'**,
  **'\ev'**)
  shall be written as the corresponding escape sequence; the
  **'\en'**
  in that table is not applicable. Non-printable characters not in that
  table shall be written as one three-digit octal number (with a
  preceding
  &lt;backslash&gt;)
  for each byte in the character (most significant byte first).

Long lines shall be folded, with the point of folding indicated by
writing a
&lt;backslash&gt;
followed by a
&lt;newline&gt;;
the length at which folding occurs is unspecified, but should be
appropriate for the output device. The end of each line shall be marked
with a
**'$'**.

* **[2addr]n**  
  Write the pattern space to standard output if the default output has
  not been suppressed, and replace the pattern space with the next line
  of input, less its terminating
  &lt;newline&gt;.

If no next line of input is available, the
**n**
command verb shall branch to the end of the script and quit without
starting a new cycle.

* **[2addr]N**  
  Append the next line of input, less its terminating
  &lt;newline&gt;,
  to the pattern space, using an embedded
  &lt;newline&gt;
  to separate the appended material from the original material. Note that
  the current line number changes.

If no next line of input is available, the
**N**
command verb shall branch to the end of the script and quit without
starting a new cycle or copying the pattern space to standard output.

* **[2addr]p**  
  Write the pattern space to standard output.
* **[2addr]P**  
  Write the pattern space, up to the first
  &lt;newline&gt;,
  to standard output.
* **[1addr]q**  
  Branch to the end of the script and quit without starting a new cycle.
* **[1addr]r&nbsp;rfile**  
  Copy the contents of
  _rfile_
  to standard output as described previously. If
  _rfile_
  does not exist or cannot be read, it shall be treated as if it were an
  empty file, causing no error condition.
* **[2addr]s/BRE/replacement/flags**    
  Substitute the replacement string for instances of the BRE in the
  pattern space. Any character other than
  &lt;backslash&gt;
  or
  &lt;newline&gt;
  can be used instead of a
  &lt;slash&gt;
  to delimit the BRE and the replacement. Within the BRE and the
  replacement, the BRE delimiter itself can be used as a literal character
  if it is preceded by a
  &lt;backslash&gt;.

The replacement string shall be scanned from beginning to end. An
&lt;ampersand&gt;
(\c
**'&'**)
appearing in the replacement shall be replaced by the string matching
the BRE. The special meaning of
**'&'**
in this context can be suppressed by preceding it by a
&lt;backslash&gt;.
The characters "\e_n"_, where
_n_
is a digit, shall be replaced by the text matched by the corresponding
back-reference expression. If the corresponding back-reference expression
does not match, then the characters "\e_n"_ shall be replaced
by the empty string. The special meaning of "\e_n"_ where
_n_
is a digit in this context, can be suppressed by preceding it by a
&lt;backslash&gt;.
For each other
&lt;backslash&gt;
encountered, the following character shall lose its special meaning (if
any). The meaning of a
&lt;backslash&gt;
immediately followed by any character other than
**'&'**,
&lt;backslash&gt;,
a digit, or the delimiter character used for this command, is
unspecified.

A line can be split by substituting a
&lt;newline&gt;
into it. The application shall escape the
&lt;newline&gt;
in the replacement by preceding it by a
&lt;backslash&gt;.
A substitution shall be considered to have been performed even if the
replacement string is identical to the string that it replaces. Any
&lt;backslash&gt;
used to alter the default meaning of a subsequent character shall be
discarded from the BRE or the replacement before evaluating the BRE or
using the replacement.

The value of
_flags_
shall be zero or more of:

* _n_  
  Substitute for the
  _n_th
  occurrence only of the BRE found within the pattern space.
* **g**  
  Globally substitute for all non-overlapping instances of the BRE rather
  than just the first one. If both
  **g**
  and
  _n_
  are specified, the results are unspecified.
* **p**  
  Write the pattern space to standard output if a replacement was made.
* **w&nbsp;wfile**  
  Write. Append the pattern space to
  _wfile_
  if a replacement was made. A conforming application shall precede the
  _wfile_
  argument with one or more
  &lt;blank&gt;
  characters. If the
  **w**
  flag is not the last flag value given in a concatenation of multiple
  flag values, the results are undefined.

* **[2addr]t&nbsp;[label]**    
  Test. Branch to the
  **:**
  command verb bearing the
  _label_
  if any substitutions have been made since the most recent reading of an
  input line or execution of a
  **t**.
  If
  _label_
  is not specified, branch to the end of the script.
* **[2addr]w&nbsp;wfile**    
  Append (write) the pattern space to
  _wfile_.
* **[2addr]x**  
  Exchange the contents of the pattern and hold spaces.
* **[2addr]y/string1/string2/**    
  Replace all occurrences of characters in
  _string1_
  with the corresponding characters in
  _string2_.
  If a
  &lt;backslash&gt;
  followed by an
  **'n'**
  appear in
  _string1_
  or
  _string2_,
  the two characters shall be handled as a single
  &lt;newline&gt;.
  If the number of characters in
  _string1_
  and
  _string2_
  are not equal, or if any of the characters in
  _string1_
  appear more than once, the results are undefined. Any character other
  than
  &lt;backslash&gt;
  or
  &lt;newline&gt;
  can be used instead of
  &lt;slash&gt;
  to delimit the strings. If the delimiter is not
  **'n'**,
  within
  _string1_
  and
  _string2_,
  the delimiter itself can be used as a literal character if it is
  preceded by a
  &lt;backslash&gt;.
  If a
  &lt;backslash&gt;
  character is immediately followed by a
  &lt;backslash&gt;
  character in
  _string1_
  or
  _string2_,
  the two
  &lt;backslash&gt;
  characters shall be counted as a single literal
  &lt;backslash&gt;
  character. The meaning of a
  &lt;backslash&gt;
  followed by any character that is not
  **'n'**,
  a
  &lt;backslash&gt;,
  or the delimiter character is undefined.
* **[0addr]:label**  
  Do nothing. This command bears a
  _label_
  to which the
  **b**
  and
  **t**
  commands branch.
* **[1addr]=**  
  Write the following to standard output:

    
    "%den", <current line number>


* **[0addr]**  
  Ignore this empty command.
* **[0addr]#**  
  Ignore the
  **'#'**
  and the remainder of the line (treat them as a comment), with the
  single exception that if the first two characters in the script are
  **"#n"**,
  the default output shall be suppressed; this shall be the equivalent of
  specifying
  **\(min**
  on the command line.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

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

Regular expressions match entire strings, not just individual lines,
but a
&lt;newline&gt;
is matched by
**'\en'**
in a
_sed_
RE; a
&lt;newline&gt;
is not allowed by the general definition of regular expression in
POSIX.1-2008. Also note that
**'\en'**
cannot be used to match a
&lt;newline&gt;
at the end of an arbitrary input line;
&lt;newline&gt;
characters appear in the pattern space as a result of the
**N**
editing command.

<a name="examples"></a>

# Examples

This
_sed_
script simulates the BSD
_cat_
**\(mis**
command, squeezing excess empty lines from standard input.

    
    sed (min '
    # Write non-empty lines.
    /./ {
        p
        d
        }
    # Write a single empty line, then look for more empty lines.
    /^$/    p
    # Get next line, discard the held <newline> (empty line),
    # and look for more empty lines.
    :Empty
    /^$/    {
        N
        s/.//
        b Empty
        }
    # Write the non-empty line before going back to search
    # for the first in a set of empty lines.
        p
    '


The following
_sed_
command is a much simpler method of squeezing empty lines, although
it is not quite the same as
_cat_
**\(mis**
since it removes any initial empty lines:

    
    sed (min '/./,/^$/p'


<a name="rationale"></a>

# Rationale

This volume of POSIX.1-2008 requires implementations to support at least ten distinct
_wfile_s,
matching historical practice on many implementations. Implementations
are encouraged to support more, but conforming applications should not
exceed this limit.

The exit status codes specified here are different from those in System
V. System V returns 2 for garbled
_sed_
commands, but returns zero with its usage message or if the input file
could not be opened. The standard developers considered this to be a
bug.

The manner in which the
**l**
command writes non-printable characters was changed to avoid
the historical backspace-overstrike method, and other requirements to
achieve unambiguous output were added. See the RATIONALE for
__ed_\^_
for details of the format chosen, which is the same as that chosen for
_sed_.

This volume of POSIX.1-2008 requires implementations to provide pattern and hold spaces of at
least 8\|192 bytes, larger than the 4\|000 bytes spaces used by some
historical implementations, but less than the 20\|480 bytes limit used
in an early proposal. Implementations are encouraged to allocate
dynamically larger pattern and hold spaces as needed.

The requirements for acceptance of
&lt;blank&gt;
and
&lt;space&gt;
characters in command lines has been made more explicit than in early
proposals to describe clearly the historical practice and to remove
confusion about the phrase \`\`protect initial blanks [_sic_] and tabs
from the stripping that is done on every script line'' that appears in
much of the historical documentation of the
_sed_
utility description of text. (Not all implementations are known to have
stripped
&lt;blank&gt;
characters from text lines, although they all have allowed leading
&lt;blank&gt;
characters preceding the address on a command line.)

The treatment of
**'#'**
comments differs from the SVID which only allows a comment as the first
line of the script, but matches BSD-derived implementations. The
comment character is treated as a command, and it has the same
properties in terms of being accepted with leading
&lt;blank&gt;
characters; the BSD implementation has historically supported this.

Early proposals required that a
_script_file_
have at least one non-comment line. Some historical implementations
have behaved in unexpected ways if this were not the case. The standard
developers considered that this was incorrect behavior and that
application developers should not have to avoid this feature. A correct
implementation of this volume of POSIX.1-2008 shall permit
_script_file_s
that consist only of comment lines.

Early proposals indicated that if
**\(mie**
and
**\(mif**
options were intermixed, all
**\(mie**
options were processed before any
**\(mif**
options. This has been changed to process them in the order presented
because it matches historical practice and is more intuitive.

The treatment of the
**p**
flag to the
**s**
command differs between System V and BSD-based systems when the default
output is suppressed. In the two examples:

    
    echo a | sed    's/a/A/p'
    echo a | sed (min 's/a/A/p'


this volume of POSIX.1-2008, BSD, System V documentation, and the SVID indicate that the
first example should write two lines with
**A**,
whereas the second should write one. Some System V systems write the
**A**
only once in both examples because the
**p**
flag is ignored if the
**\(min**
option is not specified.

This is a case of a diametrical difference between systems that could
not be reconciled through the compromise of declaring the behavior to
be unspecified. The SVID/BSD/System V documentation behavior was
adopted for this volume of POSIX.1-2008 because:

*  *  
  No known documentation for any historic system describes the
  interaction between the
  **p**
  flag and the
  **\(min**
  option.
*  *  
  The selected behavior is more correct as there is no technical
  justification for any interaction between the
  **p**
  flag and the
  **\(min**
  option. A relationship between
  **\(min**
  and the
  **p**
  flag might imply that they are only used together, but this ignores
  valid scripts that interrupt the cyclical nature of the processing
  through the use of the
  **D**,
  **d**,
  **q**,
  or branching commands. Such scripts rely on the
  **p**
  suffix to write the pattern space because they do not make use of the
  default output at the \`\`bottom'' of the script.
*  *  
  Because the
  **\(min**
  option makes the
  **p**
  flag unnecessary, any interaction would only be useful if
  _sed_
  scripts were written to run both with and without the
  **\(min**
  option. This is believed to be unlikely. It is even more unlikely that
  programmers have coded the
  **p**
  flag expecting it to be unnecessary. Because the interaction was not
  documented, the likelihood of a programmer discovering the interaction
  and depending on it is further decreased.
*  *  
  Finally, scripts that break under the specified behavior produce too
  much output instead of too little, which is easier to diagnose and
  correct.

The form of the substitute command that uses the
**n**
suffix was limited to the first 512 matches in an early proposal. This
limit has been removed because there is no reason an editor processing
lines of
{LINE_MAX}
length should have this restriction. The command
**s/a/A/2047**
should be able to substitute the 2\|047th occurrence of
**a**
on a line.

The
**b**,
**t**,
and
**:**
commands are documented to ignore leading white space, but no mention
is made of trailing white space. Historical implementations of
_sed_
assigned different locations to the labels
**'x'**
and
**"x&nbsp;"**.
This is not useful, and leads to subtle programming errors, but it is
historical practice, and changing it could theoretically break working
scripts. Implementors are encouraged to provide warning messages about
labels that are never used or jumps to labels that do not exist.

Historically, the
_sed_
**!**
and
**}**
editing commands did not permit multiple commands on a single line
using a
&lt;semicolon&gt;
as a command delimiter. Implementations are permitted, but not required,
to support this extension.

Earlier versions of this standard allowed for implementations with
bytes other than eight bits, but this has been modified in this
version.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__awk_\^_,
__ed_\^_,
__grep_\^_

The Base Definitions volume of POSIX.1-2008,
_Table 5-1_, _Escape Sequences and Associated Actions_,
_Chapter 8_, _Environment Variables_,
_Section 9.3_, _Basic Regular Expressions_,
_Section 12.2_, _Utility Syntax Guidelines_

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
