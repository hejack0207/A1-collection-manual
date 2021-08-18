# fc(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

fc
— process the command history list

<a name="synopsis"></a>

# Synopsis

```


```
    fc [(mir] [(mie editor] [first [last]]
    
    fc (mil [(minr] [first [last]]
    
    fc (mis [old=new] [first]

<a name="description"></a>

# Description

The
_fc_
utility shall list, or shall edit and re-execute, commands previously
entered to an interactive
_sh_.

The command history list shall reference commands by number. The first
number in the list is selected arbitrarily. The relationship of a
number to its command shall not change except when the user logs in and
no other process is accessing the list, at which time the system may
reset the numbering to start the oldest retained command at another
number (usually 1). When the number reaches an
implementation-defined upper limit, which shall be no smaller than
the value in
_HISTSIZE_
or 32\|767 (whichever is greater), the shell may wrap the numbers,
starting the next command with a lower number (usually 1). However,
despite this optional wrapping of numbers,
_fc_
shall maintain the time-ordering sequence of the commands. For
example, if four commands in sequence are given the numbers 32\|766,
32\|767, 1 (wrapped), and 2 as they are executed, command 32\|767 is
considered the command previous to 1, even though its number is
higher.

When commands are edited (when the
**\(mil**
option is not specified), the resulting lines shall be entered at the
end of the history list and then re-executed by
_sh_.
The
_fc_
command that caused the editing shall not be entered into the history
list. If the editor returns a non-zero exit status, this shall
suppress the entry into the history list and the command re-execution.
Any command line variable assignments or redirection operators used
with
_fc_
shall affect both the
_fc_
command itself as well as the command that results; for example:

    
    fc (mis (mi|(mi (mi1 2>/dev/null


reinvokes the previous command, suppressing standard error for both
_fc_
and the previous command.

<a name="options"></a>

# Options

The
_fc_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mie&nbsp;editor**  
  Use the editor named by
  _editor_
  to edit the commands. The
  _editor_
  string is a utility name, subject to search via the
  _PATH_
  variable (see the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_).
  The value in the
  _FCEDIT_
  variable shall be used as a default when
  **\(mie**
  is not specified. If
  _FCEDIT_
  is null or unset,
  _ed_
  shall be used as the editor.
* **\(mil**  
  (The letter ell.) List the commands rather than invoking an editor on
  them. The commands shall be written in the sequence indicated by the
  _first_
  and
  _last_
  operands, as affected by
  **\(mir**,
  with each command preceded by the command number.
* **\(min**  
  Suppress command numbers when listing with
  **\(mil**.
* **\(mir**  
  Reverse the order of the commands listed (with
  **\(mil**)
  or edited (with neither
  **\(mil**
  nor
  **\(mis**).
* **\(mis**  
  Re-execute the command without invoking an editor.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _first_,&nbsp;_last_  
  Select the commands to list or edit. The number of previous commands
  that can be accessed shall be determined by the value of the
  _HISTSIZE_
  variable. The value of
  _first_
  or
  _last_
  or both shall be one of the following:
    * **[+]number**  
      A positive number representing a command number; command numbers can be
      displayed with the
      **\(mil**
      option.
    * **\(minumber**  
      A negative decimal number representing the command that was executed
      _number_
      of commands previously. For example, \(mi1 is the immediately previous
      command.
    * _string_  
      A string indicating the most recently entered command that begins with
      that string. If the
      _old_=\c
      _new_
      operand is not also specified with
      **\(mis**,
      the string form of the
      _first_
      operand cannot contain an embedded
      &lt;equals-sign&gt;.

When the synopsis form with
**\(mis**
is used:

*  *  
  If
  _first_
  is omitted, the previous command shall be used.

For the synopsis forms without
**\(mis**:

*  *  
  If
  _last_
  is omitted,
  _last_
  shall default to the previous command when
  **\(mil**
  is specified; otherwise, it shall default to
  _first_.
*  *  
  If
  _first_
  and
  _last_
  are both omitted, the previous 16 commands shall be listed or the
  previous single command shall be edited (based on the
  **\(mil**
  option).
*  *  
  If
  _first_
  and
  _last_
  are both present, all of the commands from
  _first_
  to
  _last_
  shall be edited (without
  **\(mil**)
  or listed (with
  **\(mil**).
  Editing multiple commands shall be accomplished by presenting to the
  editor all of the commands at one time, each command starting on a new
  line. If
  _first_
  represents a newer command than
  _last_,
  the commands shall be listed or edited in reverse sequence, equivalent
  to using
  **\(mir**.
  For example, the following commands on the first line are equivalent to
  the corresponding commands on the second:

    
    fc (mir 10 20    fc    30 40
    fc    20 10    fc (mir 40 30


*  *  
  When a range of commands is used, it shall not be an error to specify
  _first_
  or
  _last_
  values that are not in the history list;
  _fc_
  shall substitute the value representing the oldest or newest command in
  the list, as appropriate. For example, if there are only ten commands
  in the history list, numbered 1 to 10:

    
    fc (mil
    fc 1 99


shall list and edit, respectively, all ten commands.

* _old_=_new_  
  Replace the first occurrence of string
  _old_
  in the commands to be re-executed by the string
  _new_.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_fc_:

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
  environment variable. If the shell cannot obtain both read and write
  access to, or create, the history file, it shall use an unspecified
  mechanism that allows the history to operate properly. (References to
  history \`\`file'' in this section shall be understood to mean this
  unspecified mechanism in such cases.) An implementation may choose to
  access this variable only when initializing the history file; this
  initialization shall occur when
  _fc_
  or
  _sh_
  first attempt to retrieve entries from, or add entries to, the file, as
  the result of commands issued by the user, the file named by the
  _ENV_
  variable, or implementation-defined system start-up files. In some
  historical shells, the history file is initialized just after the
  _ENV_
  file has been processed. Therefore, it is implementation-defined
  whether changes made to
  _HISTFILE_
  after the history file has been initialized are effective.
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
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

When the
**\(mil**
option is used to list commands, the format of each command in the list
shall be as follows:

    
    "%det%sen", <line number>, <command>


If both the
**\(mil**
and
**\(min**
options are specified, the format of each command shall be:

    
    "et%sen", <command>


If the &lt;_command_&gt; consists of more than one line, the lines after
the first shall be displayed as:

    
    "et%sen", <continued-command>


<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion of the listing.
* &gt;0  
  An error occurred.

Otherwise, the exit status shall be that of the commands executed by
_fc_.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since editors sometimes use file descriptors as integral parts of their
editing, redirecting their file descriptors as part of the
_fc_
command can produce unexpected results. For example, if
_vi_
is the
_FCEDIT_
editor, the command:

    
    fc (mis | more


does not work correctly on many systems.

Users on windowing systems may want to have separate history files for
each window by setting
_HISTFILE_
as follows:

    
    HISTFILE=$HOME/.sh_hist$$


<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

This utility is based on the
_fc_
built-in of the KornShell.

An early proposal specified the
**\(mie**
option as
**[\(mie**
_editor_
**[**\c
_old_\c
=
_new_
**]\|]**,
which is not historical practice. Historical practice in
_fc_
of either
**[\(mie**
_editor_\c
**]**
or
**[\(mie \(mi [**
_old_\c
=
_new_
**]\|]**
is acceptable, but not both together. To clarify this, a new option
**\(mis**
was introduced replacing the
**[\(mie \(mi]**.
This resolves the conflict and makes
_fc_
conform to the Utility Syntax Guidelines.

* _HISTFILE_  
  Some implementations of the KornShell check for the superuser
  and do not create a history file unless
  _HISTFILE_
  is set. This is done primarily to avoid creating unlinked files in the
  root file system when logging in during single-user mode.
  _HISTFILE_
  must be set for the superuser to have history.
* _HISTSIZE_  
  Needed to limit the size of history files. It is the intent of the
  standard developers that when two shells share the same history file,
  commands that are entered in one shell shall be accessible by the other
  shell. Because of the difficulties of synchronization over a network,
  the exact nature of the interaction is unspecified.

The initialization process for the history file can be dependent on the
system start-up files, in that they may contain commands that
effectively preempt the settings the user has for
_HISTFILE_
and
_HISTSIZE_.
For example, function definition commands are recorded in the history
file. If the system administrator includes function definitions in some
system start-up file called before the
_ENV_
file, the history file is initialized before the user can influence its
characteristics. In some historical shells, the history file is
initialized just after the
_ENV_
file has been processed. Because of these situations, the text requires
the initialization process to be implementation-defined.

Consideration was given to omitting the
_fc_
utility in favor of the command line editing feature in
_sh_.
For example, in
_vi_
editing mode, typing
**"&lt;ESC&gt;**v"
is equivalent to:

    
    EDITOR=vi fc


However, the
_fc_
utility allows the user the flexibility to edit multiple commands
simultaneously (such as
_fc_
10 20) and to use editors other than those supported by
_sh_
for command line editing.

In the KornShell, the alias
**r**
(\`\`re-do'') is preset to
_fc_
**\(mie \(mi**
(equivalent to the POSIX
_fc_
**\(mis**).
This is probably an easier command name to remember than
_fc_
(\`\`fix command''), but it does not meet the Utility Syntax Guidelines.
Renaming
_fc_
to
_hist_
or
_redo_
was considered, but since this description closely matches historical
KornShell practice already, such a renaming was seen as gratuitous.
Users are free to create aliases whenever odd historical names such as
_fc_,
_awk_,
_cat_,
_grep_,
or
_yacc_
are standardized by POSIX.

Command numbers have no ordering effects; they are like serial numbers.
The
**\(mir**
option and \(mi_number_ operand address the sequence of command
execution, regardless of serial numbers. So, for example, if the
command number wrapped back to 1 at some arbitrary point, there would
be no ambiguity associated with traversing the wrap point. For example,
if the command history were:

    
    32766: echo 1
    32767: echo 2
    1: echo 3


the number \(mi2 refers to command 32\|767 because it is the second
previous command, regardless of serial number.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__sh_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
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
