# sh(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

sh
— shell, the standard command language interpreter

<a name="synopsis"></a>

# Synopsis

```


```
    sh [(miabCefhimnuvx] [(mio option]... [+abCefhimnuvx] [+o option]...
        [command_file [argument...]]
    
    sh (mic [(miabCefhimnuvx] [(mio option]... [+abCefhimnuvx] [+o option]...
        command_string [command_name [argument...]]
    
    sh (mis [(miabCefhimnuvx] [(mio option]... [+abCefhimnuvx] [+o option]...
        [argument...]

<a name="description"></a>

# Description

The
_sh_
utility is a command language interpreter that shall execute commands
read from a command line string, the standard input, or a specified
file. The application shall ensure that the commands to be executed are
expressed in the language described in
_Chapter 2_, _Shell Command Language_.

Pathname expansion shall not fail due to the size of a file.

Shell input and output redirections have an implementation-defined
offset maximum that is established in the open file description.

<a name="options"></a>

# Options

The
_sh_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
with an extension for support of a leading
&lt;plus-sign&gt;
(\c
**'\(pl'**)
as noted below.

The
**\(mia**,
**\(mib**,
**\(miC**,
**\(mie**,
**\(mif**,
**\(mim**,
**\(min**,
**\(mio**
_option_,
**\(miu**,
**\(miv**,
and
**\(mix**
options are described as part of the
_set_
utility in
_Section 2.14_, _Special Built-In Utilities_.
The option letters derived from the
_set_
special built-in shall also be accepted with a leading
&lt;plus-sign&gt;
(\c
**'\(pl'**)
instead of a leading
&lt;hyphen&gt;
(meaning the reverse case of the option as described in this volume of POSIX.1-2008).

The following additional options shall be supported:

* **\(mic**  
  Read commands from the
  _command_string_
  operand. Set the value of special parameter 0 (see
  _Section 2.5.2_, _Special Parameters_)
  from the value of the
  _command_name_
  operand and the positional parameters ($1, $2, and so on) in sequence
  from the remaining
  _argument_
  operands. No commands shall be read from the standard input.
* **\(mii**  
  Specify that the shell is
  _interactive_;
  see below. An implementation may treat specifying the
  **\(mii**
  option as an error if the real user ID of the calling process does not
  equal the effective user ID or if the real group ID does not equal the
  effective group ID.
* **\(mis**  
  Read commands from the standard input.

If there are no operands and the
**\(mic**
option is not specified, the
**\(mis**
option shall be assumed.

If the
**\(mii**
option is present, or if there are no operands and the shell's standard
input and standard error are attached to a terminal, the shell is
considered to be
_interactive_.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* \(mi  
  A single
  &lt;hyphen&gt;
  shall be treated as the first operand and then ignored. If both
  **'\(mi'**
  and
  **"\(mi\|\(mi"**
  are given as arguments, or if other operands precede the single
  &lt;hyphen&gt;,
  the results are undefined.
* _argument_  
  The positional parameters ($1, $2, and so on) shall be set to
  _arguments_,
  if any.
* _command\_file_  
  The pathname of a file containing commands. If the pathname contains
  one or more
  &lt;slash&gt;
  characters, the implementation attempts to read that file; the file need
  not be executable. If the pathname does not contain a
  &lt;slash&gt;
  character:
    *  *  
      The implementation shall attempt to read that file from the current
      working directory; the file need not be executable.
    *  *  
      If the file is not in the current working directory, the implementation
      may perform a search for an executable file using the value of
      _PATH_,
      as described in
      _Section 2.9.1.1_, _Command Search and Execution_.

Special parameter 0 (see
_Section 2.5.2_, _Special Parameters_)
shall be set to the value of
_command_file_.
If
_sh_
is called using a synopsis form that omits
_command_file_,
special parameter 0 shall be set to the value of the first argument
passed to
_sh_
from its parent (for example,
_argv_[0]
for a C program), which is normally a pathname used to execute the
_sh_
utility.

* _command\_name_    
  A string assigned to special parameter 0 when executing the commands in
  _command_string_.
  If
  _command_name_
  is not specified, special parameter 0 shall be set to the value of the
  first argument passed to
  _sh_
  from its parent (for example,
  _argv_[0]
  for a C program), which is normally a pathname used to execute the
  _sh_
  utility.
* _command\_string_    
  A string that shall be interpreted by the shell as one or more
  commands, as if the string were the argument to the
  _system_()
  function defined in the System Interfaces volume of POSIX.1-2008. If the
  _command_string_
  operand is an empty string,
  _sh_
  shall exit with a zero exit status.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if one of the following is true:

*  *  
  The
  **\(mis**
  option is specified.
*  *  
  The
  **\(mic**
  option is not specified and no operands are specified.
*  *  
  The script executes one or more commands that require input from
  standard input (such as a
  _read_
  command that does not redirect its input).

See the INPUT FILES section.

When the shell is using standard input and it invokes a command that
also uses standard input, the shell shall ensure that the standard
input file pointer points directly after the command it has read when
the command begins execution. It shall not read ahead in such a manner
that any characters intended to be read by the invoked command are
consumed by the shell (whether interpreted by the shell or not) or that
characters that are not read by the invoked command are not seen by the
shell. When the command expecting to read standard input is started
asynchronously by an interactive shell, it is unspecified whether
characters are read by the command or interpreted by the shell.

If the standard input to
_sh_
is a FIFO or terminal device and is set to non-blocking reads, then
_sh_
shall enable blocking reads on standard input. This shall remain in
effect when the command completes.

<a name="input-files"></a>

# Input Files

The input file shall be a text file, except that line lengths shall be
unlimited. If the input file is empty or consists solely of blank
lines or comments, or both,
_sh_
shall exit with a zero exit status.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_sh_:

* _ENV_  
  This variable, when and only when an interactive shell is invoked,
  shall be subjected to parameter expansion (see
  _Section 2.6.2_, _Parameter Expansion_)
  by the shell, and the resulting value shall be used as a pathname of a
  file containing shell commands to execute in the current environment.
  The file need not be executable. If the expanded value of
  _ENV_
  is not an absolute pathname, the results are unspecified.
  _ENV_
  shall be ignored if the real and effective user IDs or real and
  effective group IDs of the process are different.
* _FCEDIT_  
  This variable, when expanded by the shell, shall determine the default
  value for the
  **\(mie**
  _editor_
  option's
  _editor_
  option-argument. If
  _FCEDIT_
  is null or unset,
  _ed_
  shall be used as the editor.
* _HISTFILE_  
  Determine a pathname naming a command history file. If the
  _HISTFILE_
  variable is not set, the shell may attempt to access or create a file
  **.sh_history**
  in the directory referred to by the
  _HOME_
  environment variable. If the shell cannot obtain both read and
  write access to, or create, the history file, it shall use an
  unspecified mechanism that allows the history to operate properly.
  (References to history \`\`file'' in this section shall be understood to
  mean this unspecified mechanism in such cases.) An implementation may
  choose to access this variable only when initializing the history file;
  this initialization shall occur when
  _fc_
  or
  _sh_
  first attempt to retrieve entries from, or add entries to, the file, as
  the result of commands issued by the user, the file named by the
  _ENV_
  variable, or implementation-defined system start-up files.
  Implementations may choose to disable the history list mechanism for
  users with appropriate privileges who do not set
  _HISTFILE_;
  the specific circumstances under which this occurs are
  implementation-defined. If more than one instance of the shell is
  using the same history file, it is unspecified how updates to the
  history file from those shells interact. As entries are deleted from
  the history file, they shall be deleted oldest first. It is
  unspecified when history file entries are physically removed from the
  history file.
* _HISTSIZE_  
  Determine a decimal number representing the limit to the number of
  previous commands that are accessible. If this variable is unset, an
  unspecified default greater than or equal to 128 shall be used. The
  maximum number of commands in the history list is unspecified, but
  shall be at least 128. An implementation may choose to access this
  variable only when initializing the history file, as described under
  _HISTFILE_.
  Therefore, it is unspecified whether changes made to
  _HISTSIZE_
  after the history file has been initialized are effective.
* _HOME_  
  Determine the pathname of the user's home directory. The contents of
  _HOME_
  are used in tilde expansion as described in
  _Section 2.6.1_, _Tilde Expansion_.
* _IFS_  
  A string treated as a list of characters that is used for field
  splitting and to split lines into fields with the
  _read_
  command.

If
_IFS_
is not set, it shall behave as normal for an unset variable, except
that field splitting by the shell and line splitting by the
_read_
command shall be performed as if the value of
_IFS_
is
&lt;space&gt;\c
&lt;tab&gt;\c
&lt;newline&gt;;
see
_Section 2.6.5_, _Field Splitting_.

Implementations may ignore the value of
_IFS_
in the environment, or the absence of
_IFS_
from the environment, at the time the shell is invoked, in which case
the shell shall set
_IFS_
to
&lt;space&gt;\c
&lt;tab&gt;\c
&lt;newline&gt;
when it is invoked.

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
  Determine the behavior of range expressions, equivalence classes, and
  multi-character collating elements within pattern matching.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files), which characters
  are defined as letters (character class
  **alpha**),
  and the behavior of character classes within pattern matching.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _MAIL_  
  Determine a pathname of the user's mailbox file for purposes of
  incoming mail notification. If this variable is set, the shell shall
  inform the user if the file named by the variable is created or if its
  modification time has changed. Informing the user shall be accomplished
  by writing a string of unspecified format to standard error prior to
  the writing of the next primary prompt string. Such check shall be
  performed only after the completion of the interval defined by the
  _MAILCHECK_
  variable after the last such check. The user shall be informed only if
  _MAIL_
  is set and
  _MAILPATH_
  is not set.
* _MAILCHECK_    
  Establish a decimal integer value that specifies how often (in seconds)
  the shell shall check for the arrival of mail in the files specified by
  the
  _MAILPATH_
  or
  _MAIL_
  variables. The default value shall be 600 seconds. If set to zero,
  the shell shall check before issuing each primary prompt.
* _MAILPATH_  
  Provide a list of pathnames and optional messages separated by
  &lt;colon&gt;
  characters. If this variable is set, the shell shall inform the user if
  any of the files named by the variable are created or if any of their
  modification times change. (See the preceding entry for
  _MAIL_
  for descriptions of mail arrival and user informing.) Each pathname can
  be followed by
  **'%'**
  and a string that shall be subjected to parameter expansion and written
  to standard error when the modification time changes. If a
  **'%'**
  character in the pathname is preceded by a
  &lt;backslash&gt;,
  it shall be treated as a literal
  **'%'**
  in the pathname. The default message is unspecified.

The
_MAILPATH_
environment variable takes precedence over the
_MAIL_
variable.

* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PATH_  
  Establish a string formatted as described in the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_,
  used to effect command interpretation; see
  _Section 2.9.1.1_, _Command Search and Execution_.
* _PWD_  
  This variable shall represent an absolute pathname of the current
  working directory. Assignments to this variable may be ignored.

<a name="asynchronous-events"></a>

# Asynchronous Events

The
_sh_
utility shall take the standard action for all signals (see
_Section 1.4_, _Utility Description Defaults_)
with the following exceptions.

If the shell is interactive, SIGINT signals received during command
line editing shall be handled as described in the EXTENDED DESCRIPTION,
and SIGINT signals received at other times shall be caught but no action
performed.

If the shell is interactive:

*  *  
  SIGQUIT and SIGTERM signals shall be ignored.
*  *  
  If the
  **\(mim**
  option is in effect, SIGTTIN, SIGTTOU, and SIGTSTP signals shall be
  ignored.
*  *  
  If the
  **\(mim**
  option is not in effect, it is unspecified whether SIGTTIN, SIGTTOU,
  and SIGTSTP signals are ignored, set to the default action, or caught.
  If they are caught, the shell shall, in the signal-catching function,
  set the signal to the default action and raise the signal (after taking
  any appropriate steps, such as restoring terminal settings).

The standard actions, and the actions described above for interactive
shells, can be overridden by use of the
_trap_
special built-in utility (see
__trap_\^_
and
_Section 2.11_, _Signals and Error Handling_).

<a name="stdout"></a>

# Stdout

See the STDERR section.

<a name="stderr"></a>

# Stderr

Except as otherwise stated (by the descriptions of any invoked
utilities or in interactive mode), standard error shall be used
only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

See
_Chapter 2_, _Shell Command Language_.
The functionality described in the rest of the EXTENDED DESCRIPTION
section shall be provided on implementations that support the User
Portability Utilities option
(and the rest of this section is not further shaded for this option).

<a name="command-history-list"></a>

### Command History List


When the
_sh_
utility is being used interactively, it shall maintain a list of
commands previously entered from the terminal in the file named by the
_HISTFILE_
environment variable. The type, size, and internal format of this file
are unspecified. Multiple
_sh_
processes can share access to the file for a user, if file access
permissions allow this; see the description of the
_HISTFILE_
environment variable.

<a name="command-line-editing"></a>

### Command Line Editing


When
_sh_
is being used interactively from a terminal, the current command and
the command history (see
__fc_\^_)
can be edited using
_vi_-mode
command line editing. This mode uses commands, described below,
similar to a subset of those described in the
_vi_
utility. Implementations may offer other command line editing modes
corresponding to other editing utilities.

The command
_set_
**\(mio**
_vi_
shall enable
_vi_-mode
editing and place
_sh_
into
_vi_
insert mode (see
_Command Line Editing (vi-mode)_).
This command also shall disable any other editing mode that the
implementation may provide. The command
_set_
**+o**
_vi_
disables
_vi_-mode
editing.

Certain block-mode terminals may be unable to support shell command
line editing. If a terminal is unable to provide either edit mode, it
need not be possible to
_set_
**\(mio**
_vi_
when using the shell on this terminal.

In the following sections, the characters
_erase_,
_interrupt_,
_kill_,
and
_end-of-file_
are those set by the
_stty_
utility.

<a name="command-line-editing-vi-mode"></a>

### Command Line Editing (vi-mode)


In
_vi_
editing mode, there shall be a distinguished line, the edit line. All
the editing operations which modify a line affect the edit line. The
edit line is always the newest line in the command history buffer.

With
_vi_-mode
enabled,
_sh_
can be switched between insert mode and command mode.

When in insert mode, an entered character shall be inserted into the
command line, except as noted in
_vi Line Editing Insert Mode_.
Upon entering
_sh_
and after termination of the previous command,
_sh_
shall be in insert mode.

Typing an escape character shall switch
_sh_
into command mode (see
_vi Line Editing Command Mode_).
In command mode, an entered character shall either invoke a defined
operation, be used as part of a multi-character operation, or be
treated as an error. A character that is not recognized as part of an
editing command shall terminate any specific editing command and shall
alert the terminal. If
_sh_
receives a SIGINT signal in command mode (whether generated by typing the
_interrupt_
character or by other means), it shall terminate command line editing
on the current command line, reissue the prompt on the next line of the
terminal, and reset the command history (see
__fc_\^_)
so that the most recently executed command is the previous command
(that is, the command that was being edited when it was interrupted is
not re-entered into the history).

In the following sections, the phrase \`\`move the cursor to the
beginning of the word'' shall mean \`\`move the cursor to the first
character of the current word'' and the phrase \`\`move the cursor to the
end of the word'' shall mean \`\`move the cursor to the last character of
the current word''. The phrase \`\`beginning of the command line''
indicates the point between the end of the prompt string issued by the
shell (or the beginning of the terminal line, if there is no prompt
string) and the first character of the command text.

<a name="vi-line-editing-insert-mode"></a>

### vi Line Editing Insert Mode


While in insert mode, any character typed shall be inserted in the
current command line, unless it is from the following set.

* &lt;newline&gt;  
  Execute the current command line. If the current command line is not
  empty, this line shall be entered into the command history (see
  __fc_\^_).
* _erase_  
  Delete the character previous to the current cursor position and move
  the current cursor position back one character. In insert mode,
  characters shall be erased from both the screen and the buffer when
  backspacing.
* _interrupt_  
  If
  _sh_
  receives a SIGINT signal in insert mode (whether generated by typing
  the
  _interrupt_
  character or by other means), it shall terminate command line editing
  with the same effects as described for interrupting command mode; see
  _Command Line Editing (vi-mode)_.
* _kill_  
  Clear all the characters from the input line.
* &lt;control&gt;-V  
  Insert the next character input, even if the character is otherwise a
  special insert mode character.
* &lt;control&gt;-W  
  Delete the characters from the one preceding the cursor to the
  preceding word boundary. The word boundary in this case is the closer
  to the cursor of either the beginning of the line or a character that
  is in neither the
  **blank**
  nor
  **punct**
  character classification of the current locale.
* _end-of-file_  
  Interpreted as the end of input in
  _sh_.
  This interpretation shall occur only at the beginning of an input
  line. If
  _end-of-file_
  is entered other than at the beginning of the line, the results are
  unspecified.
* &lt;ESC&gt;  
  Place
  _sh_
  into command mode.

<a name="vi-line-editing-command-mode"></a>

### vi Line Editing Command Mode


In command mode for the command line editing feature, decimal digits
not beginning with 0 that precede a command letter shall be
remembered. Some commands use these decimal digits as a count number
that affects the operation.

The term
_motion command_
represents one of the commands:

    
    <space>  0  b  F  l  W  ^  $  ;  E  f  T  w  |  ,  B  e  h  t


If the current line is not the edit line, any command that modifies the
current line shall cause the content of the current line to replace the
content of the edit line, and the current line shall become the edit
line. This replacement cannot be undone (see the
**u**
and
**U**
commands below). The modification requested shall then be performed to
the edit line. When the current line is the edit line, the modification
shall be done directly to the edit line.

Any command that is preceded by
_count_
shall take a count (the numeric value of any preceding decimal
digits). Unless otherwise noted, this count shall cause the specified
operation to repeat by the number of times specified by the count.
Also unless otherwise noted, a
_count_
that is out of range is considered an error condition and shall alert
the terminal, but neither the cursor position, nor the command line,
shall change.

The terms
_word_
and
_bigword_
are used as defined in the
_vi_
description. The term
_save buffer_
corresponds to the term
_unnamed buffer_
in
_vi_.

The following commands shall be recognized in command mode:

* &lt;newline&gt;  
  Execute the current command line. If the current command line is not
  empty, this line shall be entered into the command history (see
  __fc_\^_).
* &lt;control&gt;-L  
  Redraw the current command line. Position the cursor at the same
  location on the redrawn line.
* **#**  
  Insert the character
  **'#'**
  at the beginning of the current command line and treat the resulting
  edit line as a comment. This line shall be entered into the command
  history; see
  __fc_\^_.
* **=**  
  Display the possible shell word expansions (see
  _Section 2.6_, _Word Expansions_)
  of the bigword at the current command line position.
    * **Note:**  
      This does not modify the content of the current line, and therefore
      does not cause the current line to become the edit line.


These expansions shall be displayed on subsequent terminal lines. If
the bigword contains none of the characters
**'?'**,
**'*'**,
or
**'['**,
an
&lt;asterisk&gt;
(\c
**'*'**)
shall be implicitly assumed at the end. If any directories are
matched, these expansions shall have a
**'/'**
character appended. After the expansion, the line shall be redrawn,
the cursor repositioned at the current cursor position, and
_sh_
shall be placed in command mode.

* **\e**  
  Perform pathname expansion (see
  _Section 2.6.6_, _Pathname Expansion_)
  on the current bigword, up to the largest set of characters that can be
  matched uniquely. If the bigword contains none of the characters
  **'?'**,
  **'*'**,
  or
  **'['**,
  an
  &lt;asterisk&gt;
  (\c
  **'*'**)
  shall be implicitly assumed at the end. This maximal expansion then
  shall replace the original bigword in the command line, and the cursor
  shall be placed after this expansion. If the resulting bigword
  completely and uniquely matches a directory, a
  **'/'**
  character shall be inserted directly after the bigword. If some other
  file is completely matched, a single
  &lt;space&gt;
  shall be inserted after the bigword. After this operation,
  _sh_
  shall be placed in insert mode.
* <b>\*</b>  
  Perform pathname expansion on the current bigword and insert all
  expansions into the command to replace the current bigword, with each
  expansion separated by a single
  &lt;space&gt;.
  If at the end of the line, the current cursor position shall be moved
  to the first column position following the expansions and
  _sh_
  shall be placed in insert mode. Otherwise, the current cursor position
  shall be the last column position of the first character after the
  expansions and
  _sh_
  shall be placed in insert mode. If the current bigword contains none
  of the characters
  **'?'**,
  **'*'**,
  or
  **'['**,
  before the operation, an
  &lt;asterisk&gt;
  (\c
  **'*'**)
  shall be implicitly assumed at the end.
* **@letter**  
  Insert the value of the alias named
  __letter_.
  The symbol
  _letter_
  represents a single alphabetic character from the portable character
  set; implementations may support additional characters as an
  extension. If the alias
  __letter_
  contains other editing commands, these commands shall be performed as
  part of the insertion. If no alias
  __letter_
  is enabled, this command shall have no effect.
* **[count]~**  
  Convert, if the current character is a lowercase letter, to the
  equivalent uppercase letter and
  _vice versa_,
  as prescribed by the current locale. The current cursor position then
  shall be advanced by one character. If the cursor was positioned on
  the last character of the line, the case conversion shall occur, but
  the cursor shall not advance. If the
  **'~'**
  command is preceded by a
  _count_,
  that number of characters shall be converted, and the cursor shall be
  advanced to the character position after the last character converted.
  If the
  _count_
  is larger than the number of characters after the cursor, this shall
  not be considered an error; the cursor shall advance to the last
  character on the line.
* **[count].**  
  Repeat the most recent non-motion command, even if it was executed on
  an earlier command line. If the previous command was preceded by a
  _count_,
  and no count is given on the
  **'.'**
  command, the count from the previous command shall be included as part
  of the repeated command. If the
  **'.'**
  command is preceded by a
  _count_,
  this shall override any
  _count_
  argument to the previous command. The
  _count_
  specified in the
  **'.'**
  command shall become the count for subsequent
  **'.'**
  commands issued without a count.
* **[number]v**  
  Invoke the
  _vi_
  editor to edit the current command line in a temporary file. When the
  editor exits, the commands in the temporary file shall be executed and
  placed in the command history. If a
  _number_
  is included, it specifies the command number in the command history to
  be edited, rather than the current command line.
* **[count]l**\0\0\0(ell)  


* **[count]**&lt;space&gt;    
  Move the current cursor position to the next character position. If
  the cursor was positioned on the last character of the line, the
  terminal shall be alerted and the cursor shall not be advanced. If the
  _count_
  is larger than the number of characters after the cursor, this shall
  not be considered an error; the cursor shall advance to the last
  character on the line.
* **[count]h**  
  Move the current cursor position to the
  _count_th
  (default 1) previous character position. If the cursor was positioned
  on the first character of the line, the terminal shall be alerted and
  the cursor shall not be moved. If the count is larger than the number
  of characters before the cursor, this shall not be considered an error;
  the cursor shall move to the first character on the line.
* **[count]w**  
  Move to the start of the next word. If the cursor was positioned on
  the last character of the line, the terminal shall be alerted and the
  cursor shall not be advanced. If the
  _count_
  is larger than the number of words after the cursor, this shall not be
  considered an error; the cursor shall advance to the last character on
  the line.
* **[count]W**  
  Move to the start of the next bigword. If the cursor was positioned on
  the last character of the line, the terminal shall be alerted and the
  cursor shall not be advanced. If the
  _count_
  is larger than the number of bigwords after the cursor, this shall not
  be considered an error; the cursor shall advance to the last character
  on the line.
* **[count]e**  
  Move to the end of the current word. If at the end of a word, move to
  the end of the next word. If the cursor was positioned on the last
  character of the line, the terminal shall be alerted and the cursor
  shall not be advanced. If the
  _count_
  is larger than the number of words after the cursor, this shall not be
  considered an error; the cursor shall advance to the last character on
  the line.
* **[count]E**  
  Move to the end of the current bigword. If at the end of a bigword,
  move to the end of the next bigword. If the cursor was positioned on
  the last character of the line, the terminal shall be alerted and the
  cursor shall not be advanced. If the
  _count_
  is larger than the number of bigwords after the cursor, this shall not
  be considered an error; the cursor shall advance to the last character
  on the line.
* **[count]b**  
  Move to the beginning of the current word. If at the beginning of a
  word, move to the beginning of the previous word. If the cursor was
  positioned on the first character of the line, the terminal shall be
  alerted and the cursor shall not be moved. If the
  _count_
  is larger than the number of words preceding the cursor, this shall not
  be considered an error; the cursor shall return to the first character
  on the line.
* **[count]B**  
  Move to the beginning of the current bigword. If at the beginning of a
  bigword, move to the beginning of the previous bigword. If the cursor
  was positioned on the first character of the line, the terminal shall
  be alerted and the cursor shall not be moved. If the
  _count_
  is larger than the number of bigwords preceding the cursor, this shall
  not be considered an error; the cursor shall return to the first
  character on the line.
* **^**  
  Move the current cursor position to the first character on the input
  line that is not a
  &lt;blank&gt;.
* **$**  
  Move to the last character position on the current command line.
* **0**  
  (Zero.) Move to the first character position on the current command
  line.
* **[count]\||**  
  Move to the
  _count_th
  character position on the current command line. If no number is
  specified, move to the first position. The first character position
  shall be numbered 1. If the count is larger than the number of
  characters on the line, this shall not be considered an error; the
  cursor shall be placed on the last character on the line.
* **[count]fc**  
  Move to the first occurrence of the character
  **'c'**
  that occurs after the current cursor position. If the cursor was
  positioned on the last character of the line, the terminal shall be
  alerted and the cursor shall not be advanced. If the character
  **'c'**
  does not occur in the line after the current cursor position, the
  terminal shall be alerted and the cursor shall not be moved.
* **[count]Fc**  
  Move to the first occurrence of the character
  **'c'**
  that occurs before the current cursor position. If the cursor was
  positioned on the first character of the line, the terminal shall be
  alerted and the cursor shall not be moved. If the character
  **'c'**
  does not occur in the line before the current cursor position, the
  terminal shall be alerted and the cursor shall not be moved.
* **[count]tc**  
  Move to the character before the first occurrence of the character
  **'c'**
  that occurs after the current cursor position. If the cursor was
  positioned on the last character of the line, the terminal shall be
  alerted and the cursor shall not be advanced. If the character
  **'c'**
  does not occur in the line after the current cursor position, the
  terminal shall be alerted and the cursor shall not be moved.
* **[count]Tc**  
  Move to the character after the first occurrence of the character
  **'c'**
  that occurs before the current cursor position. If the cursor was
  positioned on the first character of the line, the terminal shall be
  alerted and the cursor shall not be moved. If the character
  **'c'**
  does not occur in the line before the current cursor position, the
  terminal shall be alerted and the cursor shall not be moved.
* **[count];**  
  Repeat the most recent
  **f**,
  **F**,
  **t**,
  or
  **T**
  command. Any number argument on that previous command shall be
  ignored. Errors are those described for the repeated command.
* **[count],**  
  Repeat the most recent
  **f**,
  **F**,
  **t**,
  or
  **T**
  command. Any number argument on that previous command shall be
  ignored. However, reverse the direction of that command.
* **a**  
  Enter insert mode after the current cursor position. Characters that
  are entered shall be inserted before the next character.
* **A**  
  Enter insert mode after the end of the current command line.
* **i**  
  Enter insert mode at the current cursor position. Characters that are
  entered shall be inserted before the current character.
* **I**  
  Enter insert mode at the beginning of the current command line.
* **R**  
  Enter insert mode, replacing characters from the command line beginning
  at the current cursor position.
* **[count]cmotion**    
  Delete the characters between the current cursor position and the
  cursor position that would result from the specified motion
  command. Then enter insert mode before the first character following
  any deleted characters. If
  _count_
  is specified, it shall be applied to the motion command. A
  _count_
  shall be ignored for the following motion commands:

    
    0    ^    $    c


If the motion command is the character
**'c'**,
the current command line shall be cleared and insert mode shall be
entered. If the motion command would move the current cursor position
toward the beginning of the command line, the character under the
current cursor position shall not be deleted. If the motion command
would move the current cursor position toward the end of the command
line, the character under the current cursor position shall be deleted.
If the
_count_
is larger than the number of characters between the current cursor
position and the end of the command line toward which the motion
command would move the cursor, this shall not be considered an error;
all of the remaining characters in the aforementioned range shall be
deleted and insert mode shall be entered. If the motion command is
invalid, the terminal shall be alerted, the cursor shall not be moved,
and no text shall be deleted.

* **C**  
  Delete from the current character to the end of the line and enter
  insert mode at the new end-of-line.
* **S**  
  Clear the entire edit line and enter insert mode.
* **[count]rc**  
  Replace the current character with the character
  **'c'**.
  With a number
  _count_,
  replace the current and the following
  _count_\(mi1
  characters. After this command, the current cursor position shall be
  on the last character that was changed. If the
  _count_
  is larger than the number of characters after the cursor, this shall
  not be considered an error; all of the remaining characters shall be
  changed.
* **[count]\_**  
  Append a
  &lt;space&gt;
  after the current character position and then append the last bigword
  in the previous input line after the
  &lt;space&gt;.
  Then enter insert mode after the last character just appended. With a
  number
  _count_,
  append the
  _count_th
  bigword in the previous line.
* **[count]x**  
  Delete the character at the current cursor position and place the
  deleted characters in the save buffer. If the cursor was positioned on
  the last character of the line, the character shall be deleted and the
  cursor position shall be moved to the previous character (the new last
  character). If the
  _count_
  is larger than the number of characters after the cursor, this shall
  not be considered an error; all the characters from the cursor to the
  end of the line shall be deleted.
* **[count]X**  
  Delete the character before the current cursor position and place the
  deleted characters in the save buffer. The character under the current
  cursor position shall not change. If the cursor was positioned on the
  first character of the line, the terminal shall be alerted, and the
  **X**
  command shall have no effect. If the line contained a single
  character, the
  **X**
  command shall have no effect. If the line contained no characters, the
  terminal shall be alerted and the cursor shall not be moved. If the
  _count_
  is larger than the number of characters before the cursor, this shall
  not be considered an error; all the characters from before the cursor
  to the beginning of the line shall be deleted.
* **[count]dmotion**    
  Delete the characters between the current cursor position and the
  character position that would result from the motion command. A number
  _count_
  repeats the motion command
  _count_
  times. If the motion command would move toward the beginning of the
  command line, the character under the current cursor position shall not
  be deleted. If the motion command is
  **d**,
  the entire current command line shall be cleared. If the
  _count_
  is larger than the number of characters between the current cursor
  position and the end of the command line toward which the motion
  command would move the cursor, this shall not be considered an error;
  all of the remaining characters in the aforementioned range shall be
  deleted. The deleted characters shall be placed in the save buffer.
* **D**  
  Delete all characters from the current cursor position to the end of
  the line. The deleted characters shall be placed in the save buffer.
* **[count]ymotion**    
  Yank (that is, copy) the characters from the current cursor position to
  the position resulting from the motion command into the save buffer. A
  number
  _count_
  shall be applied to the motion command. If the motion command would
  move toward the beginning of the command line, the character under the
  current cursor position shall not be included in the set of yanked
  characters. If the motion command is
  **y**,
  the entire current command line shall be yanked into the save buffer.
  The current cursor position shall be unchanged. If the
  _count_
  is larger than the number of characters between the current cursor
  position and the end of the command line toward which the motion
  command would move the cursor, this shall not be considered an error;
  all of the remaining characters in the aforementioned range shall be
  yanked.
* **Y**  
  Yank the characters from the current cursor position to the end of the
  line into the save buffer. The current character position shall be
  unchanged.
* **[count]p**  
  Put a copy of the current contents of the save buffer after the current
  cursor position. The current cursor position shall be advanced to the
  last character put from the save buffer. A
  _count_
  shall indicate how many copies of the save buffer shall be put.
* **[count]P**  
  Put a copy of the current contents of the save buffer before the
  current cursor position. The current cursor position shall be moved to
  the last character put from the save buffer. A
  _count_
  shall indicate how many copies of the save buffer shall be put.
* **u**  
  Undo the last command that changed the edit line. This operation shall
  not undo the copy of any command line to the edit line.
* **U**  
  Undo all changes made to the edit line. This operation shall not undo
  the copy of any command line to the edit line.
* **[count]k**  


* **[count]\(mi**  
  Set the current command line to be the
  _count_th
  previous command line in the shell command history. If
  _count_
  is not specified, it shall default to 1. The cursor shall be positioned
  on the first character of the new command. If a
  **k**
  or
  **\(mi**
  command would retreat past the maximum number of commands in effect for
  this shell (affected by the
  _HISTSIZE_
  environment variable), the terminal shall be alerted, and the command
  shall have no effect.
* **[count]j**  


* **[count]+**  
  Set the current command line to be the
  _count_th
  next command line in the shell command history. If
  _count_
  is not specified, it shall default to 1. The cursor shall be positioned
  on the first character of the new command. If a
  **j**
  or
  **+**
  command advances past the edit line, the current command line shall be
  restored to the edit line and the terminal shall be alerted.
* **[number]G**  
  Set the current command line to be the oldest command line stored in
  the shell command history. With a number
  _number_,
  set the current command line to be the command line
  _number_
  in the history. If command line
  _number_
  does not exist, the terminal shall be alerted and the command line
  shall not be changed.
* **/pattern**&lt;newline&gt;    
  Move backwards through the command history, searching for the specified
  pattern, beginning with the previous command line. Patterns use the
  pattern matching notation described in
  _Section 2.13_, _Pattern Matching Notation_,
  except that the
  **'^'**
  character shall have special meaning when it appears as the first
  character of
  _pattern_.
  In this case, the
  **'^'**
  is discarded and the characters after the
  **'^'**
  shall be matched only at the beginning of a line. Commands in the
  command history shall be treated as strings, not as filenames. If the
  pattern is not found, the current command line shall be unchanged and
  the terminal is alerted. If it is found in a previous line, the current
  command line shall be set to that line and the cursor shall be set to
  the first character of the new command line.

If
_pattern_
is empty, the last non-empty pattern provided to
**/**
or
**?**
shall be used. If there is no previous non-empty pattern, the terminal
shall be alerted and the current command line shall remain unchanged.

* **?pattern**&lt;newline&gt;    
  Move forwards through the command history, searching for the specified
  pattern, beginning with the next command line. Patterns use the pattern
  matching notation described in
  _Section 2.13_, _Pattern Matching Notation_,
  except that the
  **'^'**
  character shall have special meaning when it appears as the first
  character of
  _pattern_.
  In this case, the
  **'^'**
  is discarded and the characters after the
  **'^'**
  shall be matched only at the beginning of a line. Commands in the
  command history shall be treated as strings, not as filenames. If the
  pattern is not found, the current command line shall be unchanged and
  the terminal alerted. If it is found in a following line, the current
  command line shall be set to that line and the cursor shall be set to
  the fist character of the new command line.

If
_pattern_
is empty, the last non-empty pattern provided to
**/**
or
**?**
shall be used. If there is no previous non-empty pattern, the terminal
shall be alerted and the current command line shall remain unchanged.

* **n**  
  Repeat the most recent
  **/**
  or
  **?**
  command. If there is no previous
  **/**
  or
  **?**,
  the terminal shall be alerted and the current command line shall remain
  unchanged.
* **N**  
  Repeat the most recent
  **/**
  or
  **?**
  command, reversing the direction of the search. If there is no previous
  **/**
  or
  **?**,
  the terminal shall be alerted and the current command line shall remain
  unchanged.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \0\0\0\00  
  The script to be executed consisted solely of zero or more blank lines
  or comments, or both.
* 1-125  
  A non-interactive shell detected an error other than
  _command_file_
  not found, including but not limited to syntax, redirection, or variable
  assignment errors.
* \0\0127  
  A specified
  _command_file_
  could not be found by a non-interactive shell.

Otherwise, the shell shall return the exit status of the last command
it invoked or attempted to invoke (see also the
_exit_
utility in
_Section 2.14_, _Special Built-In Utilities_).

<a name="consequences-of-errors"></a>

# Consequences of Errors

See
_Section 2.8.1_, _Consequences of Shell Errors_.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Standard input and standard error are the files that
determine whether a shell is interactive when
**\(mii**
is not specified. For example:

    
    sh > file


and:

    
    sh 2> file


create interactive and non-interactive shells, respectively. Although
both accept terminal input, the results of error conditions are
different, as described in
_Section 2.8.1_, _Consequences of Shell Errors_;
in the second example a redirection error encountered by a special
built-in utility aborts the shell.

A conforming application must protect its first operand, if it starts
with a
&lt;plus-sign&gt;,
by preceding it with the
**"\(mi\|\(mi"**
argument that denotes the end of the options.

Applications should note that the standard
_PATH_
to the shell cannot be assumed to be either
**/bin/sh**
or
**/usr/bin/sh**,
and should be determined by interrogation of the
_PATH_
returned by
_getconf_
_PATH_,
ensuring that the returned pathname is an absolute pathname and not a
shell built-in.

For example, to determine the location of the standard
_sh_
utility:

    
    command (miv sh


On some implementations this might return:

    
    /usr/xpg4/bin/sh


Furthermore, on systems that support executable scripts (the
**"#!"**
construct), it is recommended that applications using executable
scripts install them using
_getconf_
_PATH_
to determine the shell pathname and update the
**"#!"**
script appropriately as it is being installed (for example, with
_sed_).
For example:

    
    #
    # Installation time script to install correct POSIX shell pathname
    #
    # Get list of paths to check
    #
    Sifs=$IFS
    Sifs_set=${IFS+y}
    IFS=:
    set (mi|(mi $(getconf PATH)
    if [ "$Sifs_set" = y ]
    then
        IFS=$Sifs
    else
        unset IFS
    fi
    #
    # Check each path for 'sh'
    #
    for i
    do
        if [ (mix "${i}"/sh ]
        then
            Pshell=${i}/sh
        fi
    done
    #
    # This is the list of scripts to update. They should be of the
    # form '${name}.source' and will be transformed to '${name}'.
    # Each script should begin:
    #
    # #!INSTALLSHELLPATH
    #
    scripts="a b c"
    #
    # Transform each script
    #
    for i in ${scripts}
    do
        sed (mie "s|INSTALLSHELLPATH|${Pshell}|" < ${i}.source > ${i}
    done


<a name="examples"></a>

# Examples


*  1.  
  Execute a shell command from a string:

    
    sh (mic "cat myfile"


*  2.  
  Execute a shell script from a file in the current directory:

    
    sh my_shell_cmds


<a name="rationale"></a>

# Rationale

The
_sh_
utility and the
_set_
special built-in utility share a common set of options.

The name
_IFS_
was originally an abbreviation of \`\`Input Field Separators''; however,
this name is misleading as the
_IFS_
characters are actually used as field terminators. The KornShell
ignores the contents of
_IFS_
upon entry to the script. A conforming application cannot rely on
importing
_IFS_.
One justification for this, beyond security considerations, is to
assist possible future shell compilers. Allowing
_IFS_
to be imported from the environment prevents many optimizations that
might otherwise be performed via dataflow analysis of the script
itself.

The text in the STDIN section about non-blocking reads concerns an
instance of
_sh_
that has been invoked, probably by a C-language program, with standard
input that has been opened using the O_NONBLOCK flag; see
_open_()
in the System Interfaces volume of POSIX.1-2008. If the shell did not reset this flag, it would
immediately terminate because no input data would be available yet and
that would be considered the same as end-of-file.

The options associated with a
_restricted shell_
(command name
_rsh_
and the
**\(mir**
option) were excluded because the standard developers considered that
the implied level of security could not be achieved and they did not
want to raise false expectations.

On systems that support set-user-ID scripts,
a historical trapdoor has been to link a script to the name
**\(mii**.
When it is called by a sequence such as:

    
    sh (mi


or by:

    
    #!&nbsp;usr/bin/sh&nbsp;(mi


the historical systems have assumed that no option letters follow.
Thus, this volume of POSIX.1-2008 allows the single
&lt;hyphen&gt;
to mark the end of the options, in addition to the use of the regular
**"\(mi\|\(mi"**
argument, because it was considered that the older practice was so
pervasive. An alternative approach is taken by the KornShell, where
real and effective user/group IDs must match for an interactive shell;
this behavior is specifically allowed by this volume of POSIX.1-2008.

* **Note:**  
  There are other problems with set-user-ID scripts that the two
  approaches described here do not resolve.


The initialization process for the history file can be dependent on the
system start-up files, in that they may contain commands that
effectively preempt the user's settings of
_HISTFILE_
and
_HISTSIZE_.
For example, function definition commands are recorded in the history
file, unless the
_set_
**\(mio**
_nolog_
option is set. If the system administrator includes function
definitions in some system start-up file called before the
_ENV_
file, the history file is initialized before the user gets a chance to
influence its characteristics. In some historical shells, the history
file is initialized just after the
_ENV_
file has been processed. Therefore, it is implementation-defined
whether changes made to
_HISTFILE_
after the history file has been initialized are effective.

The default messages for the various
_MAIL_-related
messages are unspecified because they vary across implementations.
Typical messages are:

    
    "you have mailen"


or:

    
    "you have new mailen"


It is important that the descriptions of command line editing refer to
the same shell as that in POSIX.1-2008 so that interactive users can also be
application programmers without having to deal with programmatic
differences in their two environments. It is also essential that the
utility name
_sh_
be specified because this explicit utility name is too firmly rooted in
historical practice of application programs for it to change.

Consideration was given to mandating a diagnostic message when
attempting to set
_vi_-mode
on terminals that do not support command line editing. However, it is
not historical practice for the shell to be cognizant of all terminal
types and thus be able to detect inappropriate terminals in all cases.
Implementations are encouraged to supply diagnostics in this case
whenever possible, rather than leaving the user in a state where
editing commands work incorrectly.

In early proposals, the KornShell-derived
_emacs_
mode of command line editing was included, even though the
_emacs_
editor itself was not. The community of
_emacs_
proponents was adamant that the full
_emacs_
editor not be standardized because they were concerned that an attempt
to standardize this very powerful environment would encourage vendors
to ship strictly conforming versions lacking the extensibility required
by the community. The author of the original
_emacs_
program also expressed his desire to omit the program. Furthermore,
there were a number of historical systems that did not include
_emacs_,
or included it without supporting it, but there were very few that did
not include and support
_vi_.
The shell
_emacs_
command line editing mode was finally omitted because it became
apparent that the KornShell version and the editor being distributed
with the GNU system had diverged in some respects. The author of
_emacs_
requested that the POSIX
_emacs_
mode either be deleted or have a significant number of unspecified
conditions. Although the KornShell author agreed to consider changes to
bring the shell into alignment, the standard developers decided to
defer specification at that time. At the time, it was assumed that
convergence on an acceptable definition would occur for a subsequent
draft, but that has not happened, and there appears to be no impetus to
do so. In any case, implementations are free to offer additional
command line editing modes based on the exact models of editors their
users are most comfortable with.

Early proposals had the following list entry in
_vi Line Editing Insert Mode_:

* \e  
  If followed by the
  _erase_
  or
  _kill_
  character, that character shall be inserted into the input line.
  Otherwise, the
  &lt;backslash&gt;
  itself shall be inserted into the input line.

However, this is not actually a feature of
_sh_
command line editing insert mode, but one of some historical terminal
line drivers. Some conforming implementations continue to do this when
the
_stty_
**iexten**
flag is set.

In interactive shells, SIGTERM is ignored so that
_kill 0_
does not kill the shell, and SIGINT is caught so that
_wait_
is interruptible. If the shell does not ignore SIGTTIN, SIGTTOU, and
SIGTSTP signals when it is interactive and the
**\(mim**
option is not in effect, these signals suspend the shell if it is not
a session leader. If it is a session leader, the signals are discarded
if they would stop the process, as required by the System Interfaces volume of POSIX.1-2008,
_Section 2.4.3_, _Signal Actions_
for orphaned process groups.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__cd_\^_,
__echo_\^_,
__exit_\^_,
__fc_\^_,
__pwd_\^_,
_invalid_,
__set_\^_,
__stty_\^_,
__test_\^_,
__trap_\^_,
__umask_\^_,
__vi_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__dup_\^(\|)_,
__exec_\^_,
__exit_\^(\|)_,
__fork_\^(\|)_,
__open_\^(\|)_,
__pipe_\^(\|)_,
__signal_\^(\|)_,
__system_\^(\|)_,
__ulimit_\^(\|)_,
__umask_\^(\|)_,
__wait_\^(\|)_

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
