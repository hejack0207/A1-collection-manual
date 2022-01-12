# more(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

more
— display files on a page-by-page basis

<a name="synopsis"></a>

# Synopsis

```


```
    more [(miceisu] [(min number] [(mip command] [(mit tagstring] [file...]

<a name="description"></a>

# Description

The
_more_
utility shall read files and either write them to the terminal on a
page-by-page basis or filter them to standard output. If standard
output is not a terminal device, all input files shall be copied to
standard output in their entirety, without modification, except as
specified for the
**\(mis**
option. If standard output is a terminal device, the files shall be
written a number of lines (one screenful) at a time under the control
of user commands. See the EXTENDED DESCRIPTION section.

Certain block-mode terminals do not have all the capabilities necessary
to support the complete
_more_
definition; they are incapable of accepting commands that are not
terminated with a
&lt;newline&gt;.
Implementations that support such terminals shall provide an
operating mode to
_more_
in which all commands can be terminated with a
&lt;newline&gt;
on those terminals. This mode:

*  *  
  Shall be documented in the system documentation
*  *  
  Shall, at invocation, inform the user of the terminal deficiency that
  requires the
  &lt;newline&gt;
  usage and provide instructions on how this warning can be suppressed in
  future invocations
*  *  
  Shall not be required for implementations supporting only fully capable
  terminals
*  *  
  Shall not affect commands already requiring
  &lt;newline&gt;
  characters
*  *  
  Shall not affect users on the capable terminals from using
  _more_
  as described in this volume of POSIX.1-2008

<a name="options"></a>

# Options

The
_more_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that
**'\(pl'**
may be recognized as an option delimiter as well as
**'\(mi'**.

The following options shall be supported:

* **\(mic**  
  If a screen is to be written that has no lines in common with the
  current screen, or
  _more_
  is writing its first screen,
  _more_
  shall not scroll the screen, but instead shall redraw each line of the
  screen in turn, from the top of the screen to the bottom. In addition,
  if
  _more_
  is writing its first screen, the screen shall be cleared. This option
  may be silently ignored on devices with insufficient terminal
  capabilities.
* **\(mie**  
  Exit immediately after writing the last line of the last file in the
  argument list; see the EXTENDED DESCRIPTION section.
* **\(mii**  
  Perform pattern matching in searches without regard to case; see the Base Definitions volume of POSIX.1-2008,
  _Section 9.2_, _Regular Expression General Requirements_.
* **\(min&nbsp;number**  
  Specify the number of lines per screenful. The
  _number_
  argument is a positive decimal integer. The
  **\(min**
  option shall override any values obtained from any other source.
* **\(mip&nbsp;command**  
  Each time a screen from a new file is displayed or redisplayed
  (including as a result of
  _more_
  commands; for example,
  **:p**),
  execute the
  _more_
  command(s) in the command arguments in the order specified, as if
  entered by the user after the first screen has been displayed. No
  intermediate results shall be displayed (that is, if the command is a
  movement to a screen different from the normal first screen, only the
  screen resulting from the command shall be displayed.) If any of the
  commands fail for any reason, an informational message to this effect
  shall be written, and no further commands specified using the
  **\(mip**
  option shall be executed for this file.
* **\(mis**  
  Behave as if consecutive empty lines were a single empty line.
* **\(mit&nbsp;tagstring**  
  Write the screenful of the file containing the tag named by the
  _tagstring_
  argument. See the
  __ctags_\^_
  utility. The tags feature represented by
  **\(mit**
  _tagstring_
  and the
  **:t**
  command is optional. It shall be provided on any system that also
  provides a conforming implementation of
  _ctags_;
  otherwise, the use of
  **\(mit**
  produces undefined results.

The filename resulting from the
**\(mit**
option shall be logically added as a prefix to the list of command line
files, as if specified by the user. If the tag named by the
_tagstring_
argument is not found, it shall be an error, and
_more_
shall take no further action.

If the tag specifies a line number, the first line of the display shall
contain the beginning of that line. If the tag specifies a pattern, the
first line of the display shall contain the beginning of the matching
text from the first line of the file that contains that pattern. If the
line does not exist in the file or matching text is not found, an
informational message to this effect shall be displayed, and
_more_
shall display the default screen as if
**\(mit**
had not been specified.

If both the
**\(mit**
_tagstring_
and
**\(mip**
_command_
options are given, the
**\(mit**
_tagstring_
shall be processed first; that is, the file and starting line for the
display shall be as specified by
**\(mit**,
and then the
**\(mip**
_more_
command shall be executed. If the line (matching text) specified by the
**\(mit**
command does not exist (is not found), no
**\(mip**
_more_
command shall be executed for this file at any time.

* **\(miu**  
  Treat a
  &lt;backspace&gt;
  as a printable control character, displayed as an
  implementation-defined character sequence (see the EXTENDED DESCRIPTION
  section), suppressing backspacing and the special handling that
  produces underlined or standout mode text on some terminal types.
  Also, do not ignore a
  &lt;carriage-return&gt;
  at the end of a line.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If no
  _file_
  operands are specified, the standard input shall be used. If a
  _file_
  is
  **'\(mi'**,
  the standard input shall be read at that point in the sequence.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.

<a name="input-files"></a>

# Input Files

The input files being examined shall be text files. If standard output
is a terminal, standard error shall be used to read commands from the
user. If standard output is a terminal, standard error is not readable,
and command input is needed,
_more_
may attempt to obtain user commands from the controlling terminal (for
example,
**/dev/tty**);
otherwise,
_more_
shall terminate with an error indicating that it was unable to read
user commands. If standard output is not a terminal, no error shall
result if standard error cannot be opened for reading.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_more_:

* _COLUMNS_  
  Override the system-selected horizontal display line size. See the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_
  for valid values and results when it is unset or null.
* _EDITOR_  
  Used by the
  **v**
  command to select an editor. See the EXTENDED DESCRIPTION section.
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
  multi-byte characters in arguments and input files) and the behavior of
  character classes within regular expressions.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _LINES_  
  Override the system-selected vertical screen size, used as the number
  of lines in a screenful. See the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_
  for valid values and results when it is unset or null. The
  **\(min**
  option shall take precedence over the
  _LINES_
  variable for determining the number of lines in a screenful.
* _MORE_  
  Determine a string containing options described in the OPTIONS section
  preceded with
  &lt;hyphen&gt;
  characters and
  &lt;blank&gt;-separated
  as on the command line. Any command line options shall be processed
  after those in the
  _MORE_
  variable, as if the command line were:

    
    more $MORE options operands


The
_MORE_
variable shall take precedence over the
_TERM_
and
_LINES_
variables for determining the number of lines in a screenful.

* _TERM_  
  Determine the name of the terminal type. If this variable is unset or
  null, an unspecified default terminal type is used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The standard output shall be used to write the contents of the input
files.

<a name="stderr"></a>

# Stderr

The standard error shall be used for diagnostic messages and user
commands (see the INPUT FILES section), and, if standard output is a
terminal device, to write a prompting string. The prompting string
shall appear on the screen line below the last line of the file
displayed in the current screenful. The prompt shall contain the name
of the file currently being examined and shall contain an end-of-file
indication and the name of the next file, if any, when prompting at the
end-of-file. If an error or informational message is displayed, it is
unspecified whether it is contained in the prompt. If it is not
contained in the prompt, it shall be displayed and then the user shall
be prompted for a continuation character, at which point another
message or the user prompt may be displayed. The prompt is otherwise
unspecified. It is unspecified whether informational messages are
written for other user commands.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

The following section describes the behavior of
_more_
when the standard output is a terminal device. If the standard output
is not a terminal device, no options other than
**\(mis**
shall have any effect, and all input files shall be copied to standard
output otherwise unmodified, at which time
_more_
shall exit without further action.

The number of lines available per screen shall be determined by the
**\(min**
option, if present, or by examining values in the environment (see the
ENVIRONMENT VARIABLES section). If neither method yields a number, an
unspecified number of lines shall be used.

The maximum number of lines written shall be one less than this number,
because the screen line after the last line written shall be used to
write a user prompt and user input. If the number of lines in the
screen is less than two, the results are undefined. It is unspecified
whether user input is permitted to be longer than the remainder of the
single line where the prompt has been written.

The number of columns available per line shall be determined by
examining values in the environment (see the ENVIRONMENT VARIABLES
section), with a default value as described in the Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_.

Lines that are longer than the display shall be folded; the length at
which folding occurs is unspecified, but should be appropriate for the
output device. Folding may occur between glyphs of single characters
that take up multiple display columns.

When standard output is a terminal and
**\(miu**
is not specified,
_more_
shall treat
&lt;backspace&gt;
and
&lt;carriage-return&gt;
characters specially:

*  *  
  A character, followed first by a sequence of
  _n_
  &lt;backspace&gt;
  characters (where
  _n_
  is the same as the number of column positions that the character
  occupies), then by
  _n_
  &lt;underscore&gt;
  characters (\c
  **'_'**),
  shall cause that character to be written as underlined text, if the
  terminal type supports that. The
  _n_
  &lt;underscore&gt;
  characters, followed first by
  _n_
  &lt;backspace&gt;
  characters, then any character with
  _n_
  column positions, shall also cause that character to be written as
  underlined text, if the terminal type supports that.
*  *  
  A sequence of
  _n_
  &lt;backspace&gt;
  characters (where
  _n_
  is the same as the number of column positions that the previous
  character occupies) that appears between two identical printable
  characters shall cause the first of those two characters to be written
  as emboldened text (that is, visually brighter, standout mode, or
  inverse-video mode), if the terminal type supports that, and the second
  to be discarded. Immediately subsequent occurrences of
  &lt;backspace&gt;/\c
  character pairs for that same character shall also be discarded. (For
  example, the sequence
  **"a\eba\eba\eba"**
  is interpreted as a single emboldened
  **'a'**.)
*  *  
  The
  _more_
  utility shall logically discard all other
  &lt;backspace&gt;
  characters from the line as well as the character which precedes them,
  if any.
*  *  
  A
  &lt;carriage-return&gt;
  at the end of a line shall be ignored, rather than being written as a
  non-printable character, as described in the next paragraph.

It is implementation-defined how other non-printable characters are
written. Implementations should use the same format that they use for
the
_ex_
**print**
command; see the OPTIONS section within the
_ed_
utility. It is unspecified whether a multi-column character shall be
separated if it crosses a display line boundary; it shall not be
discarded. The behavior is unspecified if the number of columns on the
display is less than the number of columns any single character in the
line being displayed would occupy.

When each new file is displayed (or redisplayed),
_more_
shall write the first screen of the file. Once the initial screen has
been written,
_more_
shall prompt for a user command. If the execution of the user command
results in a screen that has lines in common with the current screen,
and the device has sufficient terminal capabilities,
_more_
shall scroll the screen; otherwise, it is unspecified whether the
screen is scrolled or redrawn.

For all files but the last (including standard input if no file was
specified, and for the last file as well, if the
**\(mie**
option was not specified), when
_more_
has written the last line in the file,
_more_
shall prompt for a user command. This prompt shall contain the name of
the next file as well as an indication that
_more_
has reached end-of-file. If the user command is
**f**,
&lt;control&gt;-F,
&lt;space&gt;,
**j**,
&lt;newline&gt;,
**d**,
&lt;control&gt;-D,
or
**s**,
_more_
shall display the next file. Otherwise, if displaying the last file,
_more_
shall exit. Otherwise,
_more_
shall execute the user command specified.

Several of the commands described in this section display a previous
screen from the input stream. In the case that text is being taken from
a non-rewindable stream, such as a pipe, it is implementation-defined
how much backwards motion is supported. If a command cannot be executed
because of a limitation on backwards motion, an error message to this
effect shall be displayed, the current screen shall not change, and the
user shall be prompted for another command.

If a command cannot be performed because there are insufficient lines
to display,
_more_
shall alert the terminal. If a command cannot be performed because
there are insufficient lines to display or a
**/**
command fails: if the input is the standard input, the last screen in
the file may be displayed; otherwise, the current file and screen shall
not change, and the user shall be prompted for another command.

The interactive commands in the following sections shall be supported.
Some commands can be preceded by a decimal integer, called
_count_
in the following descriptions. If not specified with the command,
_count_
shall default to 1. In the following descriptions,
_pattern_
is a basic regular expression, as described in the Base Definitions volume of POSIX.1-2008,
_Section 9.3_, _Basic Regular Expressions_.
The term \`\`examine'' is historical usage meaning \`\`open the
file for viewing''; for example,
_more_
**foo**
would be expressed as examining file
**foo**.

In the following descriptions, unless otherwise specified,
_line_
is a line in the
_more_
display, not a line from the file being examined.

In the following descriptions, the
_current position_
refers to two things:

*  1.  
  The position of the current line on the screen
*  2.  
  The line number (in the file) of the current line on the screen

Usually, the line on the screen corresponding to the current position
is the third line on the screen. If this is not possible (there are
fewer than three lines to display or this is the first page of the
file, or it is the last page of the file), then the current position is
either the first or last line on the screen as described later.

<a name="help"></a>

### Help


* _Synopsis_:  


    
    h


Write a summary of these commands and other implementation-defined
commands. The behavior shall be as if the
_more_
utility were executed with the
**\(mie**
option on a file that contained the summary information. The user shall
be prompted as described earlier in this section when end-of-file is
reached. If the user command is one of those specified to continue to
the next file,
_more_
shall return to the file and screen state from which the
**h**
command was executed.

<a name="scroll-forward-one-screenful"></a>

### Scroll Forward One Screenful


* _Synopsis_:  


    
    [count]f
    [count]<control>-F


Scroll forward
_count_
lines, with a default of one screenful. If
_count_
is more than the screen size, only the final screenful shall be
written.

<a name="scroll-backward-one-screenful"></a>

### Scroll Backward One Screenful


* _Synopsis_:  


    
    [count]b
    [count]<control>-B


Scroll backward
_count_
lines, with a default of one screenful (see the
**\(min**
option). If
_count_
is more than the screen size, only the final screenful shall be
written.

<a name="scroll-forward-one-line"></a>

### Scroll Forward One Line


* _Synopsis_:  


    
    [count]<space>
    [count]j
    [count]<newline>


Scroll forward
_count_
lines. The default
_count_
for the
&lt;space&gt;
shall be one screenful; for
**j**
and
&lt;newline&gt;,
one line. The entire
_count_
lines shall be written, even if
_count_
is more than the screen size.

<a name="scroll-backward-one-line"></a>

### Scroll Backward One Line


* _Synopsis_:  


    
    [count]k


Scroll backward
_count_
lines. The entire
_count_
lines shall be written, even if
_count_
is more than the screen size.

<a name="scroll-forward-one-half-screenful"></a>

### Scroll Forward One Half Screenful


* _Synopsis_:  


    
    [count]d
    [count]<control>-D


Scroll forward
_count_
lines, with a default of one half of the screen size. If
_count_
is specified, it shall become the new default for subsequent
**d**,
&lt;control&gt;-D,
and
**u**
commands.

<a name="skip-forward-one-line"></a>

### Skip Forward One Line


* _Synopsis_:  


    
    [count]s


Display the screenful beginning with the line
_count_
lines after the last line on the current screen. If
_count_
would cause the current position to be such that less than one
screenful would be written, the last screenful in the file shall be
written.

<a name="scroll-backward-one-half-screenful"></a>

### Scroll Backward One Half Screenful


* _Synopsis_:  


    
    [count]u
    [count]<control>-U


Scroll backward
_count_
lines, with a default of one half of the screen size. If
_count_
is specified, it shall become the new default for subsequent
**d**,
&lt;control&gt;\(miD,
**u**,
and
&lt;control&gt;\(miU
commands. The entire
_count_
lines shall be written, even if
_count_
is more than the screen size.

<a name="go-to-beginning-of-file"></a>

### Go to Beginning of File


* _Synopsis_:  


    
    [count]g


Display the screenful beginning with line
_count_.

<a name="go-to-end-of-file"></a>

### Go to End-of-File


* _Synopsis_:  


    
    [count]G


If
_count_
is specified, display the screenful beginning with the line
_count_.
Otherwise, display the last screenful of the file.

<a name="refresh-the-screen"></a>

### Refresh the Screen


* _Synopsis_:  


    
    r
    <control>-L


Refresh the screen.

<a name="discard-and-refresh"></a>

### Discard and Refresh


* _Synopsis_:  


    
    R


Refresh the screen, discarding any buffered input. If the current file
is non-seekable, buffered input shall not be discarded and the
**R**
command shall be equivalent to the
**r**
command.

<a name="mark-position"></a>

### Mark Position


* _Synopsis_:  


    
    mletter


Mark the current position with the letter named by
_letter_,
where
_letter_
represents the name of one of the lowercase letters of the portable
character set. When a new file is examined, all marks may be lost.

<a name="return-to-mark"></a>

### Return to Mark


* _Synopsis_:  


    
    'letter


Return to the position that was previously marked with the letter named
by
_letter_,
making that line the current position.

<a name="return-to-previous-position"></a>

### Return to Previous Position


* _Synopsis_:  


    
    ''


Return to the position from which the last large movement command was
executed (where a \`\`large movement'' is defined as any movement of more
than a screenful of lines). If no such movements have been made, return
to the beginning of the file.

<a name="search-forward-for-pattern"></a>

### Search Forward for Pattern


* _Synopsis_:  


    
    [count]/[!]pattern<newline>


Display the screenful beginning with the
_count_th
line containing the pattern. The search shall start after the first
line currently displayed. The null regular expression (\c
**'/'**
followed by a
&lt;newline&gt;)
shall repeat the search using the previous regular expression, with a
default
_count_.
If the character
**'!'**
is included, the matching lines shall be those that do not contain the
_pattern_.
If no match is found for the
_pattern_,
a message to that effect shall be displayed.

<a name="search-backward-for-pattern"></a>

### Search Backward for Pattern


* _Synopsis_:  


    
    [count]?[!]pattern<newline>


Display the screenful beginning with the
_count_th
previous line containing the pattern. The search shall start on the
last line before the first line currently displayed. The null regular
expression (\c
**'?'**
followed by a
&lt;newline&gt;)
shall repeat the search using the previous regular expression, with a
default
_count_.
If the character
**'!'**
is included, matching lines shall be those that do not contain the
_pattern_.
If no match is found for the
_pattern_,
a message to that effect shall be displayed.

<a name="repeat-search"></a>

### Repeat Search


* _Synopsis_:  


    
    [count]n


Repeat the previous search for
_count_th
line containing the last
_pattern_
(or not containing the last
_pattern_,
if the previous search was
**"/!"**
or
**"?!"**).

<a name="repeat-search-in-reverse"></a>

### Repeat Search in Reverse


* _Synopsis_:  


    
    [count]N


Repeat the search in the opposite direction of the previous search for
the
_count_th
line containing the last
_pattern_
(or not containing the last
_pattern_,
if the previous search was
**"/!"**
or
**"?!"**).

<a name="examine-new-file"></a>

### Examine New File


* _Synopsis_:  


    
    :e [filename]<newline>


Examine a new file. If the
_filename_
argument is not specified, the current file (see the
**:n**
and
**:p**
commands below) shall be re-examined. The
_filename_
shall be subjected to the process of shell word expansions (see
_Section 2.6_, _Word Expansions_);
if more than a single pathname results, the effects are unspecified.
If
_filename_
is a
&lt;number-sign&gt;
(\c
**'#'**),
the previously examined file shall be re-examined. If
_filename_
is not accessible for any reason (including that it is a non-seekable
file), an error message to this effect shall be displayed and the
current file and screen shall not change.

<a name="examine-next-file"></a>

### Examine Next File


* _Synopsis_:  


    
    [count]:n


Examine the next file. If a number
_count_
is specified, the
_count_th
next file shall be examined. If
_filename_
refers to a non-seekable file, the results are unspecified.

<a name="examine-previous-file"></a>

### Examine Previous File


* _Synopsis_:  


    
    [count]:p


Examine the previous file. If a number
_count_
is specified, the
_count_th
previous file shall be examined. If
_filename_
refers to a non-seekable file, the results are unspecified.

<a name="go-to-tag"></a>

### Go to Tag


* _Synopsis_:  


    
    :t tagstring<newline>


If the file containing the tag named by the
_tagstring_
argument is not the current file, examine the file, as if the
**:e**
command was executed with that file as the argument. Otherwise, or in
addition, display the screenful beginning with the tag, as described
for the
**\(mit**
option (see the OPTIONS section). If the
_ctags_
utility is not supported by the system, the use of
**:t**
produces undefined results.

<a name="invoke-editor"></a>

### Invoke Editor


* _Synopsis_:  


    
    v


Invoke an editor to edit the current file being examined. If standard
input is being examined, the results are unspecified. The name of the
editor shall be taken from the environment variable
_EDITOR_,
or shall default to
_vi_.
If the last pathname component in
_EDITOR_
is either
_vi_
or
_ex_,
the editor shall be invoked with a
**\(mic**
_linenumber_
command line argument, where
_linenumber_
is the line number of the file line containing the display line
currently displayed as the first line of the screen. It is
implementation-defined whether line-setting options are passed to
editors other than
_vi_
and
_ex_.

When the editor exits,
_more_
shall resume with the same file and screen as when the editor was
invoked.

<a name="display-position"></a>

### Display Position


* _Synopsis_:  


    
    =
    <control>-G


Write a message for which the information references the first byte of
the line after the last line of the file on the screen. This message
shall include the name of the file currently being examined, its number
relative to the total number of files there are to examine, the line
number in the file, the byte number and the total bytes in the file,
and what percentage of the file precedes the current position. If
_more_
is reading from standard input, or the file is shorter than a single
screen, the line number, the byte number, the total bytes, and the
percentage need not be written.

<a name="quit"></a>

### Quit


* _Synopsis_:  


    
    q
    :q
    ZZ


Exit
_more_.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If an error is encountered accessing a file when using the
**:n**
command,
_more_
shall attempt to examine the next file in the argument list, but the
final exit status shall be affected. If an error is encountered
accessing a file via the
**:p**
command,
_more_
shall attempt to examine the previous file in the argument list, but
the final exit status shall be affected. If an error is encountered
accessing a file via the
**:e**
command,
_more_
shall remain in the current file and the final exit status shall not be
affected.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

When the standard output is not a terminal, only the
**\(mis**
filter-modification option is effective. This is based on historical
practice. For example, a typical implementation of
_man_
pipes its output through
_more_
**\(mis**
to squeeze excess white space for terminal users. When
_man_
is piped to
_lp_,
however, it is undesirable for this squeezing to happen.

<a name="examples"></a>

# Examples

The
**\(mip**
allows arbitrary commands to be executed at the start of each file.
Examples are:

* more&nbsp;**\(mip&nbsp;G&nbsp;file1&nbsp;file2**    
  Examine each file starting with its last screenful.
* _more&nbsp;**\(mip&nbsp;**100&nbsp;file1&nbsp;file2_    
  Examine each file starting with line 100 in the current position
  (usually the third line, so line 98 would be the first line written).
* _more&nbsp;**\(mip&nbsp;**/100&nbsp;file1&nbsp;file2_    
  Examine each file starting with the first line containing the string
  **"100"**
  in the current position

<a name="rationale"></a>

# Rationale

The
_more_
utility, available in BSD and BSD-derived systems, was chosen as the
prototype for the POSIX file display program since it is more widely
available than either the public-domain program
_less_
or than
_pg_,
a pager provided in System V. The 4.4 BSD
_more_
is the model for the features selected; it is almost fully
upwards-compatible from the 4.3 BSD version in wide use and has become
more amenable for
_vi_
users. Several features originally derived from various file editors,
found in both
_less_
and
_pg_,
have been added to this volume of POSIX.1-2008 as they have proved extremely popular with
users.

There are inconsistencies between
_more_
and
_vi_
that result from historical practice. For example, the single-character
commands
**h**,
**f**,
**b**,
and
&lt;space&gt;
are screen movers in
_more_,
but cursor movers in
_vi_.
These inconsistencies were maintained because the cursor movements are
not applicable to
_more_
and the powerful functionality achieved without the use of the control
key justifies the differences.

The tags interface has been included in a program that is not a text
editor because it promotes another degree of consistent operation with
_vi_.
It is conceivable that the paging environment of
_more_
would be superior for browsing source code files in some
circumstances.

The operating mode referred to for block-mode terminals effectively
adds a
&lt;newline&gt;
to each Synopsis line that currently has none. So, for example,
**d**\c
&lt;newline&gt;
would page one screenful. The mode could be triggered by a command
line option, environment variable, or some other method. The details
are not imposed by this volume of POSIX.1-2008 because there are so few systems known to
support such terminals. Nevertheless, it was considered that all
systems should be able to support
_more_
given the exception cited for this small community of terminals
because, in comparison to
_vi_,
the cursor movements are few and the command set relatively amenable to
the optional
&lt;newline&gt;
characters.

Some versions of
_more_
provide a shell escaping mechanism similar to the
_ex_
**!**
command. The standard developers did not consider that this was
necessary in a paginator, particularly given the wide acceptance of
multiple window terminals and job control features. (They chose to
retain such features in the editors and
_mailx_
because the shell interaction also gives an opportunity to modify the
editing buffer, which is not applicable to
_more_.)

The
**\(mip**
(position) option replaces the
**+**
command because of the Utility Syntax Guidelines. The
**\(pl**\c
_command_
option is no longer specified by POSIX.1-2008 but may be present
in some implementations. In early proposals, it took a
_pattern_
argument, but historical
_less_
provided the
_more_
general facility of a command. It would have been desirable to use the
same
**\(mic**
as
_ex_
and
_vi_,
but the letter was already in use.

The text stating \`\`from a non-rewindable stream .\|.\|. implementations
may limit the amount of backwards motion supported'' would allow an
implementation that permitted no backwards motion beyond text already
on the screen. It was not possible to require a minimum amount of
backwards motion that would be effective for all conceivable device
types. The implementation should allow the user to back up as far as
possible, within device and reasonable memory allocation constraints.

Historically, non-printable characters were displayed using the ARPA
standard mappings, which are as follows:

*  1.  
  Printable characters are left alone.
*  2.  
  Control characters less than \e177 are represented as followed by the
  character offset from the
  **'@'**
  character in the ASCII map; for example, \e007 is represented as
  **'G'**.
*  3.  
  \e177 is represented as followed by
  **'?'**.

The display of characters having their eighth bit set was less
standard. Existing implementations use hex (0x00), octal (\e000), and a
meta-bit display. (The latter displayed characters with their eighth
bit set as the two characters
**"M\(mi"**,
followed by the seven-bit display as described previously.) The latter
probably has the best claim to historical practice because it was used
with the
**\(miv**
option of 4 BSD and 4 BSD-derived versions of the
_cat_
utility since 1980.

No specific display format is required by POSIX.1-2008. Implementations are
encouraged to conform to historic practice in the absence of any strong
reason to diverge.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__ctags_\^_,
__ed_\^_,
__ex_\^_,
__vi_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 9.2_, _Regular Expression General Requirements_,
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
