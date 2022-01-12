# mailx(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

mailx
— process messages

<a name="synopsis"></a>

# Synopsis


<a name="send-mode"></a>

### Send Mode

```

 .RS 4
</synopsis>
    
    mailx [(mis subject] address...
<synopsis>

 .RE
</synopsis>

<a name="receive-mode"></a>

### Receive Mode

<synopsis>

 .RS 4
</synopsis>
    
    mailx (mie
    
    mailx [(miHiNn] [(miF] [(miu user]
    
    mailx (mif [(miHiNn] [(miF] [file]
<synopsis>

 .RE
```

<a name="description"></a>

# Description

The
_mailx_
utility provides a message sending and receiving facility. It has two
major modes, selected by the options used: Send Mode and Receive
Mode.

On systems that do not support the User Portability Utilities option,
an application using
_mailx_
shall have the ability to send messages in an unspecified manner (Send
Mode). Unless the first character of one or more lines is
&lt;tilde&gt;
(\c
**'~'**),
all characters in the input message shall appear in the delivered
message, but additional characters may be inserted in the message
before it is retrieved.

On systems supporting the User Portability Utilities option,
mail-receiving capabilities and other interactive features, Receive
Mode, described below, also shall be enabled.

<a name="send-mode"></a>

### Send Mode


Send Mode can be used by applications or users to send messages from
the text in standard input.

<a name="receive-mode"></a>

### \*!Receive Mode


Receive Mode is more oriented towards interactive users. Mail can be read
and sent in this interactive mode.

When reading mail,
_mailx_
provides commands to facilitate saving, deleting, and responding to
messages. When sending mail,
_mailx_
allows editing, reviewing, and other modification of the message as it
is entered.

Incoming mail shall be stored in one or more unspecified locations for
each user, collectively called the system
_mailbox_
for that user. When
_mailx_
is invoked in Receive Mode, the system mailbox shall be the default
place to find new mail. As messages are read, they shall be marked to
be moved to a secondary file for storage, unless specific action is
taken. This secondary file is called the
**mbox**
and is normally located in the directory referred to by the
_HOME_
environment variable (see
_MBOX_
in the ENVIRONMENT VARIABLES section for a description of this file).
Messages shall remain in this file until explicitly removed. When the
**\(mif**
option is used to read mail messages from secondary files, messages
shall be retained in those files unless specifically removed. All
three of these locations—system mailbox,
**mbox**,
and secondary file—are referred to in this section as simply
\`\`mailboxes'', unless more specific identification is required.

<a name="options"></a>

# Options

The
_mailx_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported. (Only the
**\(mis**
_subject_
option shall be required on all systems. The other options are required
only on systems supporting the User Portability Utilities option.)

* **\(mie**  
  Test for the presence of mail in the system mailbox. The
  _mailx_
  utility shall write nothing and exit with a successful return code if
  there is mail to read.
* **\(mif**  
  Read messages from the file named by the
  _file_
  operand instead of the system mailbox. (See also
  **folder**.)
  If no
  _file_
  operand is specified, read messages from
  **mbox**
  instead of the system mailbox.
* **\(miF**  
  Record the message in a file named after the first recipient. The name
  is the login-name portion of the address found first on the
  **To:**
  line in the mail header. Overrides the
  **record**
  variable, if set (see
  _Internal Variables in mailx_).
* **\(miH**  
  Write a header summary only.
* **\(mii**  
  Ignore interrupts. (See also
  **ignore**.)
* **\(min**  
  Do not initialize from the system default start-up file. See the
  EXTENDED DESCRIPTION section.
* **\(miN**  
  Do not write an initial header summary.
* **\(mis\0subject**  
  Set the
  **Subject**
  header field to
  _subject_.
  All characters in the
  _subject_
  string shall appear in the delivered message. The results are
  unspecified if
  _subject_
  is longer than
  {LINE_MAX}
  \(mi 10 bytes or contains a
  &lt;newline&gt;.
* **\(miu\0user**  
  Read the system mailbox of the login name
  _user_.
  This shall only be successful if the invoking user has appropriate
  privileges to read the system mailbox of that user.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _address_  
  Addressee of message. When
  **\(min**
  is specified and no user start-up files are accessed (see the EXTENDED
  DESCRIPTION section), the user or application shall ensure this is an
  address to pass to the mail delivery system. Any system or user
  start-up files may enable aliases (see
  **alias**
  under
  _Commands in mailx_)
  that may modify the form of
  _address_
  before it is passed to the mail delivery system.
* _file_  
  A pathname of a file to be read instead of the system mailbox when
  **\(mif**
  is specified. The meaning of the
  _file_
  option-argument shall be affected by the contents of the
  **folder**
  internal variable; see
  _Internal Variables in mailx_.

<a name="stdin"></a>

# Stdin

When
_mailx_
is invoked in Send Mode (the first synopsis line), standard input shall
be the message to be delivered to the specified addresses.
When in Receive Mode, user commands shall be accepted from
_stdin_.
If the User Portability Utilities option is not supported, standard
input lines beginning with a
&lt;tilde&gt;
(\c
**'~'**)
character produce unspecified results.

If the User Portability Utilities option is supported, then in both
Send and Receive Modes, standard input lines beginning with the escape
character (usually
&lt;tilde&gt;
(\c
**'~'**))
shall affect processing as described in
_Command Escapes in mailx_.

<a name="input-files"></a>

# Input Files

When
_mailx_
is used as described by this volume of POSIX.1-2008, the
_file_
option-argument (see the
**\(mif**
option) and the
**mbox**
shall be text files containing mail messages, formatted as described in
the OUTPUT FILES section. The nature of the system mailbox is
unspecified; it need not be a file.

<a name="environment-variables"></a>

# Environment Variables

Some of the functionality described in this section shall be provided on
implementations that support the User Portability Utilities option
as described in the text, and is not further shaded for this option.

The following environment variables shall affect the execution of
_mailx_:

* _DEAD_  
  Determine the pathname of the file in which to save partial messages in
  case of interrupts or delivery errors. The default shall be
  **dead.letter**
  in the directory named by the
  _HOME_
  variable. The behavior of
  _mailx_
  in saving partial messages is unspecified if the User Portability
  Utilities option is not supported and
  _DEAD_
  is not defined with the value
  **/dev/null**.
* _EDITOR_  
  Determine the name of a utility to invoke when the
  **edit**
  (see
  _Commands in mailx_)
  or
  **~e**
  (see
  _Command Escapes in mailx_)
  command is used. The default editor is unspecified.
  On XSI-conformant systems it is
  _ed_.
  The effects of this variable are unspecified if the User Portability
  Utilities option is not supported.
* _HOME_  
  Determine the pathname of the user's home directory.
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
  multi-byte characters in arguments and input files) and the handling of
  case-insensitive address and header-field comparisons.
* _LC\_TIME_  
  This variable may determine the format and contents of the date and
  time strings written by
  _mailx_.
  This volume of POSIX.1-2008 specifies the effects of this variable only for systems
  supporting the User Portability Utilities option.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _LISTER_  
  Determine a string representing the command for writing the contents of
  the
  **folder**
  directory to standard output when the
  **folders**
  command is given (see
  **folders**
  in
  _Commands in mailx_).
  Any string acceptable as a
  _command_string_
  operand to the
  _sh_
  **\(mic**
  command shall be valid. If this variable is null or not set, the output
  command shall be
  _ls_.
  The effects of this variable are unspecified if the User Portability
  Utilities option is not supported.
* _MAILRC_  
  Determine the pathname of the start-up file. The default shall be
  **.mailrc**
  in the directory referred to by the
  _HOME_
  environment variable. The behavior of
  _mailx_
  is unspecified if the User Portability Utilities option is not
  supported and
  _MAILRC_
  is not defined with the value
  **/dev/null**.
* _MBOX_  
  Determine a pathname of the file to save messages from the system
  mailbox that have been read. The
  **exit**
  command shall override this function, as shall saving the message
  explicitly in another file. The default shall be
  **mbox**
  in the directory named by the
  _HOME_
  variable. The effects of this variable are unspecified if the User
  Portability Utilities option is not supported.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PAGER_  
  Determine a string representing an output filtering or pagination
  command for writing the output to the terminal. Any string acceptable
  as a
  _command_string_
  operand to the
  _sh_
  **\(mic**
  command shall be valid. When standard output is a terminal device, the
  message output shall be piped through the command if the
  _mailx_
  internal variable
  **crt**
  is set to a value less the number of lines in the message; see
  _Internal Variables in mailx_.
  If the
  _PAGER_
  variable is null or not set, the paginator shall be either
  _more_
  or another paginator utility documented in the system documentation.
  The effects of this variable are unspecified if the User Portability
  Utilities option is not supported.
* _SHELL_  
  Determine the name of a preferred command interpreter. The default
  shall be
  _sh_.
  The effects of this variable are unspecified if the User Portability
  Utilities option is not supported.
* _TERM_  
  If the internal variable
  **screen**
  is not specified, determine the name of the terminal type to indicate
  in an unspecified manner the number of lines in a screenful of headers.
  If
  _TERM_
  is not set or is set to null, an unspecified default terminal type
  shall be used and the value of a screenful is unspecified. The effects
  of this variable are unspecified if the User Portability Utilities
  option is not supported.
* _TZ_  
  This variable may determine the timezone used to calculate date and
  time strings written by
  _mailx_.
  If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.
* _VISUAL_  
  Determine a pathname of a utility to invoke when the
  **visual**
  command (see
  _Commands in mailx_)
  or
  **~v**
  command-escape (see
  _Command Escapes in mailx_)
  is used. If this variable is null or not set, the full-screen editor
  shall be
  _vi_.
  The effects of this variable are unspecified if the User Portability
  Utilities option is not supported.

<a name="asynchronous-events"></a>

# Asynchronous Events

When
_mailx_
is in Send Mode and standard input is not a terminal, it shall take the
standard action for all signals.

In
Receive Mode, or in
Send Mode when standard input is a terminal, if a SIGINT signal
is received:

*  1.  
  If in command mode, the current command, if there is one, shall be
  aborted, and a command-mode prompt shall be written.
*  2.  
  If in input mode:
    *  a.  
      If
      **ignore**
      is set,
      _mailx_
      shall write
      **"@\en"**,
      discard the current input line, and continue processing, bypassing the
      message-abort mechanism described in item 2b.
    *  b.  
      If the interrupt was received while sending mail, either when in
      Receive Mode or in
      Send Mode, a message shall be written, and another
      subsequent interrupt, with no other intervening characters typed, shall
      be required to abort the mail message.
      If in Receive Mode and another
      interrupt is received, a command-mode prompt shall be written.
      If in Send Mode and another interrupt is received,
      _mailx_
      shall terminate with a non-zero status.

In both cases listed in item b, if the message is not empty:

*  i.  
  If
  **save**
  is enabled and the file named by
  _DEAD_
  can be created, the message shall be written to the file named by
  _DEAD_.
  If the file exists, the message shall be written to replace the
  contents of the file.
* ii.  
  If
  **save**
  is not enabled, or
  the file named by
  _DEAD_
  cannot be created, the message shall not be saved.

The
_mailx_
utility shall take the standard action for all other signals.

<a name="stdout"></a>

# Stdout

In command and input modes, all output, including prompts and messages,
shall be written to standard output.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

Various
_mailx_
commands and command escapes can create or add to files, including the
**mbox**,
the dead-letter file, and secondary mailboxes. When
_mailx_
is used as described in this volume of POSIX.1-2008, these files shall be text files,
formatted as follows:

line beginning with From&lt;space&gt;  
[one or more _header-lines_; see
_Commands in mailx_]  
empty line  
**[**zero or more body lines  
empty line]  
**[**line beginning with **From&lt;space&gt;...]**

where each message begins with the
**From\0&lt;space&gt;**
line shown, preceded by the beginning of the file or an empty line.
(The
**From &lt;space&gt;**
line is considered to be part of the message header, but not one of the
header-lines referred to in
_Commands in mailx_;
thus, it shall not be affected by the
**discard**,
**ignore**,
or
**retain**
commands.) The formats of the remainder of the
**From &lt;space&gt;**
line and any additional header lines are unspecified, except that none
shall be empty. The format of a message body line is also unspecified,
except that no line following an empty line shall start with
**From &lt;space&gt;**;
_mailx_
shall modify any such user-entered message body lines (following an
empty line and beginning with
**From &lt;space&gt;**)
by adding one or more characters to precede the
**'F'**;
it may add these characters to
**From &lt;space&gt;**
lines that are not preceded by an empty line.

When a message from the system mailbox or entered by the user is not a
text file, it is implementation-defined how such a message is stored
in files written by
_mailx_.

<a name="extended-description"></a>

# Extended Description

The functionality in the entire EXTENDED DESCRIPTION section shall
be provided on implementations supporting the User Portability
Utilities option.
The functionality described in this section shall be provided on
implementations that support the User Portability Utilities option
(and the rest of this section is not further shaded for this option).

The
_mailx_
utility need not support for all character encodings in all
circumstances. For example, inter-system mail may be restricted to
7-bit data by the underlying network, 8-bit data need not be portable
to non-internationalized systems, and so on. Under these
circumstances, it is recommended that only characters defined in the
ISO/IEC&nbsp;646:\|1991 standard International Reference Version (equivalent to ASCII) 7-bit range
of characters be used.

When
_mailx_
is invoked using one of the Receive Mode synopsis forms, it shall write
a page of header-summary lines (if
**\(miN**
was not specified and there are messages, see below), followed by a
prompt indicating that
_mailx_
can accept regular commands (see
_Commands in mailx_);
this is termed
_command mode_.
The page of header-summary lines shall contain the first new message if
there are new messages, or the first unread message if there are unread
messages, or the first message. When
_mailx_
is invoked using the Send Mode synopsis and standard input is a
terminal, if no subject is specified on the command line and the
**asksub**
variable is set, a prompt for the subject shall be written. At this
point,
_mailx_
shall be in input mode. This input mode shall also be entered when using
one of the Receive Mode synopsis forms and a reply or new message is
composed using the
**reply**,
**Reply**,
**followup**,
**Followup**,
or
**mail**
commands and standard input is a terminal. When the message is typed
and the end of the message is encountered, the message shall be passed to
the mail delivery software. Commands can be entered by beginning a line
with the escape character (by default,
&lt;tilde&gt;
(\c
**'~'**))
followed by a single command letter and optional arguments. See
_Commands in mailx_
for a summary of these commands. It is unspecified what effect these
commands will have if standard input is not a terminal when a message
is entered using either the Send Mode synopsis, or the Read Mode
commands
**reply**,
**Reply**,
**followup**,
**Followup**,
or
**mail**.

* **Note:**  
  For notational convenience, this section uses the default escape
  character,
  &lt;tilde&gt;,
  in all references and examples.


At any time, the behavior of
_mailx_
shall be governed by a set of environmental and internal variables.
These are flags and valued parameters that can be set and cleared via
the
_mailx_
**set**
and
**unset**
commands.

Regular commands are of the form:

    
    [command] [msglist] [argument ...]


If no
_command_
is specified in command mode,
**next**
shall be assumed. In input mode, commands shall be recognized by the
escape character, and lines not treated as commands shall be taken as
input for the message.

In command mode, each message shall be assigned a sequential number,
starting with 1.

All messages have a state that shall affect how they are displayed in
the header summary and how they are retained or deleted upon
termination of
_mailx_.
There is at any time the notion of a
_current_
message, which shall be marked by a
**'&gt;'**
at the beginning of a line in the header summary. When
_mailx_
is invoked using one of the Receive Mode synopsis forms, the current
message shall be the first new message, if there is a new message, or
the first unread message if there is an unread message, or the first
message if there are any messages, or unspecified if there are no
messages in the mailbox. Each command that takes an optional list of
messages (_msglist_) or an optional single message (_message_)
on which to operate shall leave the current message set to the
highest-numbered message of the messages specified, unless the command
deletes messages, in which case the current message shall be set to the
first undeleted message (that is, a message not in the deleted state)
after the highest-numbered message deleted by the command, if one
exists, or the first undeleted message before the highest-numbered
message deleted by the command, if one exists, or to an unspecified
value if there are no remaining undeleted messages. All messages
shall be in one of the following states:

* _new_  
  The message is present in the system mailbox and has not been viewed by
  the user or moved to any other state. Messages in state
  _new_
  when
  _mailx_
  quits shall be retained in the system mailbox.
* _unread_  
  The message has been present in the system mailbox for more than one
  invocation of
  _mailx_
  and has not been viewed by the user or moved to any other state.
  Messages in state
  _unread_
  when
  _mailx_
  quits shall be retained in the system mailbox.
* _read_  
  The message has been processed by one of the following commands:
  **~f**,
  **~m**,
  **~F**,
  **~M**,
  **copy**,
  **mbox**,
  **next**,
  **pipe**,
  **print**,
  **Print**,
  **top**,
  **type**,
  **Type**,
  **undelete**.
  The
  **delete**,
  **dp**,
  and
  **dt**
  commands may also cause the next message to be marked as
  _read_,
  depending on the value of the
  **autoprint**
  variable. Messages that are in the system mailbox and in state
  _read_
  when
  _mailx_
  quits shall be saved in the
  **mbox**,
  unless the internal variable
  **hold**
  was set. Messages that are in the
  **mbox**
  or in a secondary mailbox and in state
  _read_
  when
  _mailx_
  quits shall be retained in their current location.
* _deleted_  
  The message has been processed by one of the following commands:
  **delete**,
  **dp**,
  **dt**.
  Messages in state
  _deleted_
  when
  _mailx_
  quits shall be deleted. Deleted messages shall be ignored until
  _mailx_
  quits or changes mailboxes or they are specified to the undelete
  command; for example, the message specification /\c
  _string_
  shall only search the subject lines of messages that have not yet been
  deleted, unless the command operating on the list of messages is
  **undelete**.
  No deleted message or deleted message header shall be displayed by any
  _mailx_
  command other than
  **undelete**.
* _preserved_  
  The message has been processed by a
  **preserve**
  command. When
  _mailx_
  quits, the message shall be retained in its current location.
* _saved_  
  The message has been processed by one of the following commands:
  **save**
  or
  **write**.
  If the current mailbox is the system mailbox, and the internal variable
  **keepsave**
  is set, messages in the state saved shall be saved to the file
  designated by the
  _MBOX_
  variable (see the ENVIRONMENT VARIABLES section). If the current
  mailbox is the system mailbox, messages in the state
  _saved_
  shall be deleted from the current mailbox, when the
  **quit**
  or
  **file**
  command is used to exit the current mailbox.

The header-summary line for each message shall indicate the state of
the message.

Many commands take an optional list of messages (\c
_msglist_)
on which to operate, which defaults to the current message. A
_msglist_
is a list of message specifications separated by
&lt;blank&gt;
characters, which can include:

* n  
  Message number
  _n_.
* +  
  The next undeleted message, or the next deleted message for the
  **undelete**
  command.
* \(mi  
  The next previous undeleted message, or the next previous deleted
  message for the
  **undelete**
  command.
* .  
  The current message.
* ^  
  The first undeleted message, or the first deleted message for the
  **undelete**
  command.
* $  
  The last message.
* *  
  All messages.
* n-m  
  An inclusive range of message numbers.
* _address_  
  All messages from
  _address_;
  any address as shown in a header summary shall be matchable in this
  form.
* /_string_  
  All messages with
  _string_
  in the subject line (case ignored).
* :c  
  All messages of type
  _c_,
  where
  _c_
  shall be one of:
    * d  
      Deleted messages.
    * n  
      New messages.
    * Old messages (any not in state
      _read_
      or
      _new_).
    * r  
      Read messages.
    * u  
      Unread messages.

Other commands take an optional message (\c
_message_)
on which to operate, which defaults to the current message. All of the
forms allowed for
_msglist_
are also allowed for
_message_,
but if more than one message is specified, only the first shall be
operated on.

Other arguments are usually arbitrary strings whose usage depends on
the command involved.

<a name="start-up-in-mailx"></a>

### Start-Up in mailx


At start-up time,
_mailx_
shall take the following steps in sequence:

*  1.  
  Establish all variables at their stated default values.
*  2.  
  Process command line options, overriding corresponding default values.
*  3.  
  Import any of the
  _DEAD_,
  _EDITOR_,
  _MBOX_,
  _LISTER_,
  _PAGER_,
  _SHELL_,
  or
  _VISUAL_
  variables that are present in the environment, overriding the
  corresponding default values.
*  4.  
  Read
  _mailx_
  commands from an unspecified system start-up file, unless the
  **\(min**
  option is given, to initialize any internal
  _mailx_
  variables and aliases.
*  5.  
  Process the start-up file of
  _mailx_
  commands named in the user
  _MAILRC_
  variable.

Most regular
_mailx_
commands are valid inside start-up files, the most common use being to
set up initial display options and alias lists. The following commands
shall be invalid in the start-up file:
**!**,
**edit**,
**hold**,
**mail**,
**preserve**,
**reply**,
**Reply**,
**shell**,
**visual**,
**Copy**,
**followup**,
and
**Followup**.
Any errors in the start-up file shall either cause
_mailx_
to terminate with a diagnostic message and a non-zero status or to
continue after writing a diagnostic message, ignoring the remainder of
the lines in the start-up file.

A blank line in a start-up file shall be ignored.

<a name="internal-variables-in-mailx"></a>

### Internal Variables in mailx


The following variables are internal
_mailx_
variables. Each internal variable can be set via the
_mailx_
**set**
command at any time. The
**unset**
and
**set\0no**
_name_
commands can be used to erase variables.

In the following list, variables shown as:

    
    variable


represent Boolean values. Variables shown as:

    
    variable=value


shall be assigned string or numeric values. For string values, the
rules in
_Commands in mailx_
concerning filenames and quoting shall also apply.

The defaults specified here may be changed by the unspecified system
start-up file unless the user specifies the
**\(min**
option.

* **allnet**  
  All network names whose login name components match shall be treated as
  identical. This shall cause the
  _msglist_
  message specifications to behave similarly. The default shall be
  **noallnet**.
  See also the
  **alternates**
  command and the
  **metoo**
  variable.
* **append**  
  Append messages to the end of the
  **mbox**
  file upon termination instead of placing them at the beginning. The
  default shall be
  **noappend**.
  This variable shall not affect the
  **save**
  command when saving to
  **mbox**.
* **ask**,\0**asksub**  
  Prompt for a subject line on outgoing mail if one is not specified on
  the command line with the
  **\(mis**
  option. The
  **ask**
  and
  **asksub**
  forms are synonyms; the system shall refer to
  **asksub**
  and
  **noasksub**
  in its messages, but shall accept
  **ask**
  and
  **noask**
  as user input to mean
  **asksub**
  and
  **noasksub**.
  It shall not be possible to set both
  **ask**
  and
  **noasksub**,
  or
  **noask**
  and
  **asksub**.
  The default shall be
  **asksub**,
  but no prompting shall be done if standard input is not a terminal.
* **askbcc**  
  Prompt for the blind copy list. The default shall be
  **noaskbcc**.
* **askcc**  
  Prompt for the copy list. The default shall be
  **noaskcc**.
* **autoprint**  
  Enable automatic writing of messages after
  **delete**
  and
  **undelete**
  commands. The default shall be
  **noautoprint**.
* **bang**  
  Enable the special-case treatment of
  &lt;exclamation-mark&gt;
  characters (\c
  **'!'**)
  in escape command lines; see the
  **escape**
  command and
  _Command Escapes in mailx_.
  The default shall be
  **nobang**,
  disabling the expansion of
  **'!'**
  in the
  _command_
  argument to the
  **~!**
  command and the
  **~&lt;!**\c
  _command_
  escape.
* **cmd**=_command_    
  Set the default command to be invoked by the
  **pipe**
  command. The default shall be
  **nocmd**.
* **crt**=_number_  
  Pipe messages having more than
  _number_
  lines through the command specified by the value of the
  _PAGER_
  variable. The default shall be
  **nocrt**.
  If it is set to null, the value used is implementation-defined.
* **debug**  
  Enable verbose diagnostics for debugging. Messages are not delivered.
  The default shall be
  **nodebug**.
* **dot**  
  When
  **dot**
  is set, a
  &lt;period&gt;
  on a line by itself during message input from a terminal shall also
  signify end-of-file (in addition to normal end-of-file). The default
  shall be
  **nodot**.
  If
  **ignoreeof**
  is set (see below), a setting of
  **nodot**
  shall be ignored and the
  &lt;period&gt;
  is the only method to terminate input mode.
* **escape**=_c_  
  Set the command escape character to be the character
  **'c'**.
  By default, the command escape character shall be
  &lt;tilde&gt;.
  If
  **escape**
  is unset,
  &lt;tilde&gt;
  shall be used; if it is set to null, command escaping shall be disabled.
* **flipr**  
  Reverse the meanings of the
  **R**
  and
  **r**
  commands. The default shall be
  **noflipr**.
* **folder**=_directory_    
  The default directory for saving mail files. User-specified filenames
  beginning with a
  &lt;plus-sign&gt;
  (\c
  **'\(pl'**)
  shall be expanded by preceding the filename with this directory name
  to obtain the real pathname. If
  _directory_
  does not start with a
  &lt;slash&gt;
  (\c
  **'/'**),
  the contents of
  _HOME_
  shall be prefixed to it. The default shall be
  **nofolder**.
  If
  **folder**
  is unset or set to null, user-specified filenames beginning with
  **'\(pl'**
  shall refer to files in the current directory that begin with the
  literal
  **'\(pl'**
  character. See also
  **outfolder**
  below. The
  **folder**
  value need not affect the processing of the files named in
  _MBOX_
  and
  _DEAD_.
* **header**  
  Enable writing of the header summary when entering
  _mailx_
  in Receive Mode. The default shall be
  **header**.
* **hold**  
  Preserve all messages that are read in the system mailbox instead of
  putting them in the
  **mbox**
  save file. The default shall be
  **nohold**.
* **ignore**  
  Ignore interrupts while entering messages. The default shall be
  **noignore**.
* **ignoreeof**  
  Ignore normal end-of-file during message input. Input can be
  terminated only by entering a
  &lt;period&gt;
  (\c
  **'.'**)
  on a line by itself or by the
  **~.**
  command escape. The default shall be
  **noignoreeof**.
  See also
  **dot**
  above.
* **indentprefix**=_string_    
  A string that shall be added as a prefix to each line that is inserted
  into the message by the
  **~m**
  command escape. This variable shall default to one
  &lt;tab&gt;.
* **keep**  
  When a system mailbox, secondary mailbox, or
  **mbox**
  is empty, truncate it to zero length instead of removing it. The
  default shall be
  **nokeep**.
* **keepsave**  
  Keep the messages that have been saved from the system mailbox into
  other files in the file designated by the variable
  _MBOX_,
  instead of deleting them. The default shall be
  **nokeepsave**.
* **metoo**  
  Suppress the deletion of the login name of the user from the recipient
  list when replying to a message or sending to a group. The default
  shall be
  **nometoo**.
* **onehop**  
  When responding to a message that was originally sent to several
  recipients, the other recipient addresses are normally forced to be
  relative to the originating author's machine for the response. This
  flag disables alteration of the recipients' addresses, improving
  efficiency in a network where all machines can send directly to all
  other machines (that is, one hop away). The default shall be
  **noonehop**.
* **outfolder**  
  Cause the files used to record outgoing messages to be located in the
  directory specified by the
  **folder**
  variable unless the pathname is absolute. The default shall be
  **nooutfolder**.
  See the
  **record**
  variable.
* **page**  
  Insert a
  &lt;form-feed&gt;
  after each message sent through the pipe created by the
  **pipe**
  command. The default shall be
  **nopage**.
* **prompt**=_string_    
  Set the command-mode prompt to
  _string_.
  If
  _string_
  is null or if
  **noprompt**
  is set, no prompting shall occur. The default shall be to prompt with
  the string
  **"?\0"**.
* **quiet**  
  Refrain from writing the opening message and version when entering
  _mailx_.
  The default shall be
  **noquiet**.
* **record**=_file_  
  Record all outgoing mail in the file with the pathname
  _file_.
  The default shall be
  **norecord**.
  See also
  **outfolder**
  above.
* **save**  
  Enable saving of messages in the dead-letter file on interrupt or
  delivery error. See the variable
  _DEAD_
  for the location of the dead-letter file. The default shall be
  **save**.
* **screen**=_number_    
  Set the number of lines in a screenful of headers for the
  **headers**
  and
  **z**
  commands. If
  **screen**
  is not specified, a value based on the terminal type identified by the
  _TERM_
  environment variable, the window size, the baud rate, or some
  combination of these shall be used.
* **sendwait**  
  Wait for the background mailer to finish before returning. The default
  shall be
  **nosendwait**.
* **showto**  
  When the sender of the message was the user who is invoking
  _mailx_,
  write the information from the
  **To:**
  line instead of the
  **From:**
  line in the header summary. The default shall be
  **noshowto**.
* **sign**=_string_  
  Set the variable inserted into the text of a message when the
  **~a**
  command escape is given. The default shall be
  **nosign**.
  The character sequences
  **'\et'**
  and
  **'\en'**
  shall be recognized in the variable as
  &lt;tab&gt;
  and
  &lt;newline&gt;
  characters, respectively. (See also
  **~i**
  in
  _Command Escapes in mailx_.)
* **Sign**=_string_  
  Set the variable inserted into the text of a message when the
  **~A**
  command escape is given. The default shall be
  **noSign**.
  The character sequences
  **'\et'**
  and
  **'\en'**
  shall be recognized in the variable as
  &lt;tab&gt;
  and
  &lt;newline&gt;
  characters, respectively.
* **toplines**=_number_    
  Set the number of lines of the message to write with the
  **top**
  command. The default shall be 5.

<a name="commands-in-mailx"></a>

### Commands in mailx


The following
_mailx_
commands shall be provided. In the following list, header refers to
lines from the message header, as shown in the OUTPUT FILES section.
Header-line refers to lines within the header that begin with one or
more non-white-space characters, immediately followed by a
&lt;colon&gt;
and white space and continuing until the next line beginning with a
non-white-space character or an empty line. Header-field refers to the
portion of a header line prior to the first
&lt;colon&gt;
in that line.

For each of the commands listed below, the command can be entered as
the abbreviation (those characters in the Synopsis command word
preceding the
**'['**),
the full command (all characters shown for the command word, omitting
the
**'['**
and
**']'**),
or any truncation of the full command down to the abbreviation. For
example, the
**exit**
command (shown as **ex[it]** in the Synopsis) can be entered as
**ex**,
**exi**,
or
**exit**.

The arguments to commands can be quoted, using the following methods:

*  *  
  An argument can be enclosed between paired double-quotes (\c
  **"\^"**)
  or single-quotes (\c
  **'\^'**);
  any white space, shell word expansion, or
  &lt;backslash&gt;
  characters within the quotes shall be treated literally as part of the
  argument. A double-quote shall be treated literally within single-quotes
  and _vice versa_. These special properties of the
  &lt;quotation-mark&gt;
  characters shall occur only when they are paired at the beginning and
  end of the argument.
*  *  
  A
  &lt;backslash&gt;
  outside of the enclosing quotes shall be discarded and the following
  character treated literally as part of the argument.
*  *  
  An unquoted
  &lt;backslash&gt;
  at the end of a command line shall be discarded and the next line shall
  continue the command.  

Filenames, where expected, shall be subjected to the following
transformations, in sequence:

*  *  
  If the filename begins with an unquoted
  &lt;plus-sign&gt;,
  and the
  **folder**
  variable is defined (see the
  **folder**
  variable), the
  &lt;plus-sign&gt;
  shall be replaced by the value of the
  **folder**
  variable followed by a
  &lt;slash&gt;.
  If the
  **folder**
  variable is unset or is set to null, the filename shall be unchanged.
*  *  
  Shell word expansions shall be applied to the filename (see
  _Section 2.6_, _Word Expansions_).
  If more than a single pathname results from this expansion and the
  command is expecting one file, the effects are unspecified.

<a name="declare-aliases"></a>

### Declare Aliases


* _Synopsis_:  


    
    a[lias] [alias [address...]]
    g[roup] [alias [address...]]


Add the given addresses to the alias specified by
_alias_.
The names shall be substituted when
_alias_
is used as a recipient address specified by the user in an outgoing
message (that is, other recipients addressed indirectly through the
**reply**
command shall not be substituted in this manner). Mail address alias
substitution shall apply only when the alias string is used as a full
address; for example, when
**hlj**
is an alias,
_hlj@posix.com_
does not trigger the alias substitution. If no arguments are given,
write a listing of the current aliases to standard output. If only an
_alias_
argument is given, write a listing of the specified alias to standard
output. These listings need not reflect the same order of addresses
that were entered.

<a name="declare-alternatives"></a>

### Declare Alternatives


* _Synopsis_:  


    
    alt[ernates] name...


(See also the
**metoo**
variable.) Declare a list of alternative names for the user's login.
When responding to a message, these names shall be removed from the
list of recipients for the response. The comparison of names shall be
in a case-insensitive manner. With no arguments,
**alternates**
shall write the current list of alternative names.

<a name="change-current-directory"></a>

### Change Current Directory


* _Synopsis_:  


    
    cd [directory]
    ch[dir] [directory]


Change directory. If
_directory_
is not specified, the contents of
_HOME_
shall be used.

<a name="copy-messages"></a>

### Copy Messages


* _Synopsis_:  


    
    c[opy] [file]
    c[opy] [msglist] file
    C[opy] [msglist]


Copy messages to the file named by the pathname
_file_
without marking the messages as saved. Otherwise, it shall be
equivalent to the
**save**
command.

In the capitalized form, save the specified messages in a file whose
name is derived from the author of the message to be saved, without
marking the messages as saved. Otherwise, it shall be equivalent to
the
**Save**
command.

<a name="delete-messages"></a>

### Delete Messages


* _Synopsis_:  


    
    d[elete] [msglist]


Mark messages for deletion from the mailbox. The deletions shall not
occur until
_mailx_
quits (see the
**quit**
command) or changes mailboxes (see the
**folder**
command). If
**autoprint**
is set and there are messages remaining after the
**delete**
command, the current message shall be written as described for the
**print**
command (see the
**print**
command); otherwise, the
_mailx_
prompt shall be written.

<a name="discard-header-fields"></a>

### Discard Header Fields


* _Synopsis_:  


    
    di[scard] [header-field...]
    ig[nore] [header-field...]


Suppress the specified header fields when writing messages. Specified
_header-fields_
shall be added to the list of suppressed header fields. Examples of
header fields to ignore are
**status**
and
**cc**.
The fields shall be included when the message is saved. The
**Print**
and
**Type**
commands shall override this command. The comparison of header fields
shall be in a case-insensitive manner. If no arguments are specified,
write a list of the currently suppressed header fields to standard
output; the listing need not reflect the same order of header fields
that were entered.

If both
**retain**
and
**discard**
commands are given,
**discard**
commands shall be ignored.

<a name="delete-messages-and-display"></a>

### Delete Messages and Display


* _Synopsis_:  


    
    dp [msglist]
    dt [msglist]


Delete the specified messages as described for the
**delete**
command, except that the
**autoprint**
variable shall have no effect, and the current message shall be written
only if it was set to a message after the last message deleted by the
command. Otherwise, an informational message to the effect that there
are no further messages in the mailbox shall be written, followed by
the
_mailx_
prompt.

<a name="echo-a-string"></a>

### Echo a String


* _Synopsis_:  


    
    ec[ho] string ...


Echo the given strings, equivalent to the shell
_echo_
utility.

<a name="edit-messages"></a>

### Edit Messages


* _Synopsis_:  


    
    e[dit] [msglist]


Edit the given messages. The messages shall be placed in a temporary
file and the utility named by the
_EDITOR_
variable is invoked to edit each file in sequence. The default
_EDITOR_
is unspecified.

The
**edit**
command does not modify the contents of those messages in the mailbox.

<a name="exit"></a>

### Exit


* _Synopsis_:  


    
    ex[it]
    x[it]


Exit from
_mailx_
without changing the mailbox. No messages shall be saved in the
**mbox**
(see also
**quit**).

<a name="change-folder"></a>

### Change Folder


* _Synopsis_:  


    
    fi[le] [file]
    fold[er] [file]


Quit (see the
**quit**
command) from the current file of messages and read in the file named
by the pathname
_file_.
If no argument is given, the name and status of the current mailbox
shall be written.

Several unquoted special characters shall be recognized when used as
_file_
names, with the following substitutions:

* %  
  The system mailbox for the invoking user.
* %_user_  
  The system mailbox for
  _user_.
* #  
  The previous file.
* &  
  The current
  **mbox**.
* +_file_  
  The named file in the
  **folder**
  directory. (See the
  **folder**
  variable.)

The default file shall be the current mailbox.

<a name="display-list-of-folders"></a>

### Display List of Folders


* _Synopsis_:  


    
    folders


Write the names of the files in the directory set by the
**folder**
variable. The command specified by the
_LISTER_
environment variable shall be used (see the ENVIRONMENT VARIABLES
section).

<a name="follow-up-specified-messages"></a>

### Follow Up Specified Messages


* _Synopsis_:  


    
    fo[llowup] [message]
    F[ollowup] [msglist]


In the lowercase form, respond to a message, recording the response in
a file whose name is derived from the author of the message. See also
the
**save**
and
**copy**
commands and
**outfolder**.

In the capitalized form, respond to the first message in the
_msglist_,
sending the message to the author of each message in the
_msglist_.
The subject line shall be taken from the first message and the response
shall be recorded in a file whose name is derived from the author of
the first message. See also the
**Save**
and
**Copy**
commands and
**outfolder**.

Both forms shall override the
**record**
variable, if set.

<a name="display-header-summary-for-specified-messages"></a>

### Display Header Summary for Specified Messages


* _Synopsis_:  


    
    f[rom] [msglist]


Write the header summary for the specified messages.

<a name="display-header-summary"></a>

### Display Header Summary


* _Synopsis_:  


    
    h[eaders] [message]


Write the page of headers that includes the message specified. If the
_message_
argument is not specified, the current message shall not change.
However, if the
_message_
argument is specified, the current message shall become the message
that appears at the top of the page of headers that includes the
message specified. The
**screen**
variable sets the number of headers per page. See also the
**z**
command.

<a name="help"></a>

### Help


* _Synopsis_:  


    
    hel[p]
    ?


Write a summary of commands.

<a name="hold-messages"></a>

### Hold Messages


* _Synopsis_:  


    
    ho[ld] [msglist]
    pre[serve] [msglist]


Mark the messages in
_msglist_
to be retained in the mailbox when
_mailx_
terminates. This shall override any commands that might previously
have marked the messages to be deleted. During the current invocation
of
_mailx_,
only the
**delete**,
**dp**,
or
**dt**
commands shall remove the
_preserve_
marking of a message.

<a name="execute-commands-conditionally"></a>

### Execute Commands Conditionally


* _Synopsis_:  


    
    i[f] s|r
    mail-commands
    el[se]
    mail-commands
    en[dif]


Execute commands conditionally, where
**if\0s**
executes the following
_mail-command_s,
up to an
**else**
or
**endif**,
if the program is in Send Mode, and
**if\0r**
shall cause the
_mail-command_s
to be executed only in Receive Mode.

<a name="list-available-commands"></a>

### List Available Commands


* _Synopsis_:  


    
    l[ist]


Write a list of all commands available. No explanation shall be
given.

<a name="mail-a-message"></a>

### Mail a Message


* _Synopsis_:  


    
    m[ail] address...


Mail a message to the specified addresses or aliases.

<a name="direct-messages-to-mbox"></a>

### Direct Messages to mbox


* _Synopsis_:  


    
    mb[ox] [msglist]


Arrange for the given messages to end up in the
**mbox**
save file when
_mailx_
terminates normally. See
_MBOX_.
See also the
**exit**
and
**quit**
commands.

<a name="process-next-specified-message"></a>

### Process Next Specified Message


* _Synopsis_:  


    
    n[ext] [message]


If the current message has not been written (for example, by the
**print**
command) since
_mailx_
started or since any other message was the current message, behave as
if the
**print**
command was entered. Otherwise, if there is an undeleted message after
the current message, make it the current message and behave as if the
**print**
command was entered. Otherwise, an informational message to the effect
that there are no further messages in the mailbox shall be written,
followed by the
_mailx_
prompt. Should the current message location be the result of an
immediately preceding
**hold**,
**mbox**,
**preserve**,
or
**touch**
command,
**next**
will act as if the current message has already been written.

<a name="pipe-message"></a>

### Pipe Message


* _Synopsis_:  


    
    pi[pe] [[msglist] command]
    | [[msglist] command]


Pipe the messages through the given
_command_
by invoking the command interpreter specified by
_SHELL_
with two arguments:
**\(mic**
and
_command_.
(See also
_sh_
**\(mic**.)
The application shall ensure that the command is given as a single
argument. Quoting, described previously, can be used to accomplish
this. If no arguments are given, the current message shall be piped
through the command specified by the value of the
**cmd**
variable. If the
**page**
variable is set, a
&lt;form-feed&gt;
shall be inserted after each message.

<a name="display-message-with-headers"></a>

### Display Message with Headers


* _Synopsis_:  


    
    P[rint] [msglist]
    T[ype] [msglist]


Write the specified messages, including all header lines, to standard
output. Override suppression of lines by the
**discard**,
**ignore**,
and
**retain**
commands. If
**crt**
is set, the messages longer than the number of lines specified by the
**crt**
variable shall be paged through the command specified by the
_PAGER_
environment variable.

<a name="display-message"></a>

### Display Message


* _Synopsis_:  


    
    p[rint] [msglist]
    t[ype] [msglist]


Write the specified messages to standard output. If
**crt**
is set, the messages longer than the number of lines specified by the
**crt**
variable shall be paged through the command specified by the
_PAGER_
environment variable.

<a name="quit"></a>

### Quit


* _Synopsis_:  


    
    q[uit]
    end-of-file


Terminate
_mailx_,
storing messages that were read in
**mbox**
(if the current mailbox is the system mailbox and unless
**hold**
is set), deleting messages that have been explicitly saved (unless
**keepsave**
is set), discarding messages that have been deleted, and saving all
remaining messages in the mailbox.

<a name="reply-to-a-message-list"></a>

### Reply to a Message List


* _Synopsis_:  


    
    R[eply] [msglist]
    R[espond] [msglist]


Mail a reply message to the sender of each message in the
_msglist_.
The subject line shall be formed by concatenating
**Re:**\c
&lt;space&gt;
(unless it already begins with that string) and the subject from the
first message. If
**record**
is set to a filename, the response shall be saved at the end of that
file.

See also the
**flipr**
variable.

<a name="reply-to-a-message"></a>

### Reply to a Message


* _Synopsis_:  


    
    r[eply] [message]
    r[espond] [message]


Mail a reply message to all recipients included in the header of the
message. The subject line shall be formed by concatenating
**Re:**\c
&lt;space&gt;
(unless it already begins with that string) and the subject from the
message. If
**record**
is set to a filename, the response shall be saved at the end of that
file.

See also the
**flipr**
variable.

<a name="retain-header-fields"></a>

### Retain Header Fields


* _Synopsis_:  


    
    ret[ain] [header-field...]


Retain the specified header fields when writing messages. This command
shall override all
**discard**
and
**ignore**
commands. The comparison of header fields shall be in a
case-insensitive manner. If no arguments are specified, write a list
of the currently retained header fields to standard output; the listing
need not reflect the same order of header fields that were entered.

<a name="save-messages"></a>

### Save Messages


* _Synopsis_:  


    
    s[ave] [file]
    s[ave] [msglist] file
    S[ave] [msglist]


Save the specified messages in the file named by the pathname
_file_,
or the
**mbox**
if the
_file_
argument is omitted. The file shall be created if it does not exist;
otherwise, the messages shall be appended to the file. The message
shall be put in the state
_saved_,
and shall behave as specified in the description of the
_saved_
state when the current mailbox is exited by the
**quit**
or
**file**
command.

In the capitalized form, save the specified messages in a file whose
name is derived from the author of the first message. The name of the
file shall be taken to be the author's name with all network addressing
stripped off. See also the
**Copy**,
**followup**,
and
**Followup**
commands and
**outfolder**
variable.

<a name="set-variables"></a>

### Set Variables


* _Synopsis_:  


    
    se[t] [name[=[string]] ...] [name=number ...] [noname ...]


Define one or more variables called
_name_.
The variable can be given a null, string, or numeric value. Quoting and
&lt;backslash&gt;-escapes
can occur anywhere in
_string_,
as described previously, as if the
_string_
portion of the argument were the entire argument. The forms
_name_
and
_name_=
shall be equivalent to
_name_=""
for variables that take string values. The
**set**
command without arguments shall write a list of all defined variables
and their values. The
**no**
_name_
form shall be equivalent to
**unset**
_name_.

<a name="invoke-a-shell"></a>

### Invoke a Shell


* _Synopsis_:  


    
    sh[ell]


Invoke an interactive command interpreter (see also
_SHELL_).

<a name="display-message-size"></a>

### Display Message Size


* _Synopsis_:  


    
    si[ze] [msglist]


Write the size in bytes of each of the specified messages.

<a name="read-mailx-commands-from-a-file"></a>

### Read mailx Commands From a File


* _Synopsis_:  


    
    so[urce] file


Read and execute commands from the file named by the pathname
_file_
and return to command mode.

<a name="display-beginning-of-messages"></a>

### Display Beginning of Messages


* _Synopsis_:  


    
    to[p] [msglist]


Write the top few lines of each of the specified messages. If the
**toplines**
variable is set, it is taken as the number of lines to write. The
default shall be 5.

<a name="touch-messages"></a>

### Touch Messages


* _Synopsis_:  


    
    tou[ch] [msglist]


Touch the specified messages. If any message in
_msglist_
is not specifically deleted nor saved in a file, it shall be placed in
the
**mbox**
upon normal termination. See
**exit**
and
**quit**.

<a name="delete-aliases"></a>

### Delete Aliases


* _Synopsis_:  


    
    una[lias] [alias]...


Delete the specified alias names. If a specified alias does not exist,
the results are unspecified.

<a name="undelete-messages"></a>

### Undelete Messages


* _Synopsis_:  


    
    u[ndelete] [msglist]


Change the state of the specified messages from deleted to read. If
**autoprint**
is set, the last message of those restored shall be written. If
_msglist_
is not specified, the message shall be selected as follows:

*  *  
  If there are any deleted messages that follow the current message, the
  first of these shall be chosen.
*  *  
  Otherwise, the last deleted message that also precedes the current
  message shall be chosen.

<a name="unset-variables"></a>

### Unset Variables


* _Synopsis_:  


    
    uns[et] name...


Cause the specified variables to be erased.

<a name="edit-message-with-full-screen-editor"></a>

### Edit Message with Full-Screen Editor


* _Synopsis_:  


    
    v[isual] [msglist]


Edit the given messages with a screen editor. Each message shall be
placed in a temporary file, and the utility named by the
_VISUAL_
variable shall be invoked to edit each file in sequence. The default
editor shall be
_vi_.

The
**visual**
command does not modify the contents of those messages in the mailbox.

<a name="write-messages-to-a-file"></a>

### Write Messages to a File


* _Synopsis_:  


    
    w[rite] [msglist] file


Write the given messages to the file specified by the pathname
_file_,
minus the message header. Otherwise, it shall be equivalent to the
**save**
command.

<a name="scroll-header-display"></a>

### Scroll Header Display


* _Synopsis_:  


    
    z[+|(mi]


Scroll the header display forward (if
**'\(pl'**
is specified or if no option is specified) or backward (if
**'\(mi'**
is specified) one screenful. The number of headers written shall be
set by the
**screen**
variable.

<a name="invoke-shell-command"></a>

### Invoke Shell Command


* _Synopsis_:  


    
    !command


Invoke the command interpreter specified by
_SHELL_
with two arguments:
**\(mic**
and
_command_.
(See also
_sh_
**\(mic**.)
If the
**bang**
variable is set, each unescaped occurrence of
**'!'**
in
_command_
shall be replaced with the command executed by the previous
**!**
command or
**~!**
command escape.

<a name="null-command"></a>

### Null Command


* _Synopsis_:  


    
    # comment


This null command (comment) shall be ignored by
_mailx_.

<a name="display-current-message-number"></a>

### Display Current Message Number


* _Synopsis_:  


    
    =


Write the current message number.

<a name="command-escapes-in-mailx"></a>

### Command Escapes in mailx


The following commands can be entered only from input mode, by
beginning a line with the escape character (by default,
&lt;tilde&gt;
(\c
**'~'**)).
See the
**escape**
variable description for changing this special character. The format
for the commands shall be:

    
    <escape-character><command-char><separator>[<arguments>]


where the &lt;_separator_&gt; can be zero or more
&lt;blank&gt;
characters.

In the following descriptions, the application shall ensure that the
argument
_command_
(but not
_mailx-command)_
is a shell command string. Any string acceptable to the command
interpreter specified by the
_SHELL_
variable when it is invoked as
_SHELL_
**\(mic**
_command_string_
shall be valid. The command can be presented as multiple arguments
(that is, quoting is not required).

Command escapes that are listed with
_msglist_
or
_mailx-command_
arguments are invalid in Send Mode and produce unspecified results.

* **~!\0command**  
  Invoke the command interpreter specified by
  _SHELL_
  with two arguments:
  **\(mic**
  and
  _command_;
  and then return to input mode. If the
  **bang**
  variable is set, each unescaped occurrence of
  **'!'**
  in
  _command_
  shall be replaced with the command executed by the previous
  **!**
  command or
  **~!**
  command escape.
* **~.**  
  Simulate end-of-file (terminate message input).
* **~:\0mailx-command**,\0**~\_\0mailx-command**    
  Perform the command-level request.
* **~?**  
  Write a summary of command escapes.
* **~A**  
  This shall be equivalent to
  **~i\0Sign**.
* **~a**  
  This shall be equivalent to
  **~i\0sign**.
* **~b\0name**.\|.\|.  
  Add the
  _name_s
  to the blind carbon copy (\c
  **Bcc**)
  list.
* **~c\0name**.\|.\|.  
  Add the
  _name_s
  to the carbon copy (\c
  **Cc**)
  list.
* **~d**  
  Read in the dead-letter file. See
  _DEAD_
  for a description of this file.
* **~e**  
  Invoke the editor, as specified by the
  _EDITOR_
  environment variable, on the partial message.
* **~\|f\0[msglist]**  
  Forward the specified messages. The specified messages shall be
  inserted into the current message without alteration. This command
  escape also shall insert message headers into the message with field
  selection affected by the
  **discard**,
  **ignore**,
  and
  **retain**
  commands.
* **~\|F\0[msglist]**  
  This shall be the equivalent of the
  **~f**
  command escape, except that all headers shall be included in the
  message, regardless of previous
  **discard**,
  **ignore**,
  and
  **retain**
  commands.
* **~h**  
  If standard input is a terminal, prompt for a
  **Subject**
  line and the
  **To**,
  **Cc**,
  and
  **Bcc**
  lists. Other implementation-defined headers may also be presented
  for editing. If the field is written with an initial value, it can be
  edited as if it had just been typed.
* **~i\0string**  
  Insert the value of the named variable, followed by a
  &lt;newline&gt;,
  into the text of the message. If the string is unset or null, the
  message shall not be changed.
* **~\|m\0[msglist]**  
  Insert the specified messages into the message, prefixing non-empty
  lines with the string in the
  **indentprefix**
  variable. This command escape also shall insert message headers into
  the message, with field selection affected by the
  **discard**,
  **ignore**,
  and
  **retain**
  commands.
* **~\|M\0[msglist]**  
  This shall be the equivalent of the
  **~m**
  command escape, except that all headers shall be included in the
  message, regardless of previous
  **discard**,
  **ignore**,
  and
  **retain**
  commands.
* **~p**  
  Write the message being entered. If the message is longer than
  **crt**
  lines (see
  _Internal Variables in mailx_),
  the output shall be paginated as described for the
  _PAGER_
  variable.
* **~q**  
  Quit (see the
  **quit**
  command) from input mode by simulating an interrupt. If the body of
  the message is not empty, the partial message shall be saved in the
  dead-letter file. See
  _DEAD_
  for a description of this file.
* **~r\0file**,\0**~&lt;\0file**,\0**~r\0!command**,\0**~&lt;\0!command**    
  Read in the file specified by the pathname
  _file_.
  If the argument begins with an
  &lt;exclamation-mark&gt;
  (\c
  **'!'**),
  the rest of the string shall be taken as an arbitrary system command;
  the command interpreter specified by
  _SHELL_
  shall be invoked with two arguments:
  **\(mic**
  and
  _command_.
  The standard output of
  _command_
  shall be inserted into the message.
* **~s\0string**  
  Set the subject line to
  _string_.
* **~t\0name**.\|.\|.  
  Add the given
  _name_s
  to the
  **To**
  list.
* **~v**  
  Invoke the full-screen editor, as specified by the
  _VISUAL_
  environment variable, on the partial message.
* **~w\0file**  
  Write the partial message, without the header, onto the file named by
  the pathname
  _file_.
  The file shall be created or the message shall be appended to it if the
  file exists.
* **~x**  
  Exit as with
  **~q**,
  except the message shall not be saved in the dead-letter file.
* **~|\0command**  
  Pipe the body of the message through the given
  _command_
  by invoking the command interpreter specified by
  _SHELL_
  with two arguments:
  **\(mic**
  and
  _command_.
  If the
  _command_
  returns a successful exit status, the standard output of the command
  shall replace the message. Otherwise, the message shall remain
  unchanged. If the
  _command_
  fails, an error message giving the exit status shall be written.  

<a name="exit-status"></a>

# Exit Status

When the
**\(mie**
option is specified, the following exit values are returned:

* \00  
  Mail was found.
* &gt;0  
  Mail was not found or an error occurred.

Otherwise, the following exit values are returned:

* \00  
  Successful completion; note that this status implies that all messages
  were
  _sent_,
  but it gives no assurances that any of them were actually
  _delivered_.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

When in
input mode (Receive Mode)
or Send Mode:

*  *  
  If an error is encountered processing an input line beginning
  with a
  &lt;tilde&gt;
  (\c
  **'~'**)
  character,
  (see
  _Command Escapes in mailx_),
  a diagnostic message shall be written to standard error, and the
  message being composed may be modified, but this condition shall not
  prevent the message from being sent.
*  *  
  Other errors shall prevent the sending of the message.

When in command mode:

*  *  
  Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Delivery of messages to remote systems requires the existence of
communication paths to such systems. These need not exist.

Input lines are limited to
{LINE_MAX}
bytes, but mailers between systems may impose more severe line-length
restrictions. This volume of POSIX.1-2008 does not place any restrictions on the length of
messages handled by
_mailx_,
and for delivery of local messages the only limitations should be the
normal problems of available disk space for the target mail file. When
sending messages to external machines, applications are advised to
limit messages to less than 100\|000 bytes because some mail gateways
impose message-length restrictions.

The format of the system mailbox is intentionally unspecified. Not all
systems implement system mailboxes as flat files, particularly with the
advent of multimedia mail messages. Some system mailboxes may be
multiple files, others records in a database. The internal format of
the messages themselves is specified with the historical format from
Version&nbsp;7, but only after the messages have been saved in some file
other than the system mailbox. This was done so that many historical
applications expecting text-file mailboxes are not broken.

Some new formats for messages can be expected in the future, probably
including binary data, bit maps, and various multimedia objects. As
described here,
_mailx_
is not prohibited from handling such messages, but it must store them
as text files in secondary mailboxes (unless some extension, such as a
variable or command line option, is used to change the stored format).
Its method of doing so is implementation-defined and might include
translating the data into text file-compatible or readable form or
omitting certain portions of the message from the stored output.

The
**discard**
and
**ignore**
commands are not inverses of the
**retain**
command. The
**retain**
command discards all header-fields except those explicitly retained.
The
**discard**
command keeps all header-fields except those explicitly discarded. If
headers exist on the retained header list,
**discard**
and
**ignore**
commands are ignored.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The standard developers felt strongly that a method for applications to
send messages to specific users was necessary. The obvious example is a
batch utility, running non-interactively, that wishes to communicate
errors or results to a user. However, the actual format, delivery
mechanism, and method of reading the message are clearly beyond the
scope of this volume of POSIX.1-2008.

The intent of this command is to provide a simple, portable interface
for sending messages non-interactively. It merely defines a
\`\`front-end'' to the historical mail system. It is suggested that
implementations explicitly denote the sender and recipient in the body
of the delivered message. Further specification of formats for either
the message envelope or the message itself were deliberately not made,
as the industry is in the midst of changing from the current standards
to a more internationalized standard and it is probably incorrect, at
this time, to require either one.

Implementations are encouraged to conform to the various delivery
mechanisms described in the CCITT X.400 standards or to the equivalent
Internet standards, described in Internet Request for Comment (RFC)
documents RFC&nbsp;819, RFC&nbsp;822, RFC&nbsp;920, RFC&nbsp;921, and RFC&nbsp;1123.

Many historical systems modified each body line that started with
**From\0**
by prefixing the
**'F'**
with
**'&gt;'**.
It is unnecessary, but allowed, to do that when the string does not
follow a blank line because it cannot be confused with the next
header.

The
**edit**
and
**visual**
commands merely edit the specified messages in a temporary file. They
do not modify the contents of those messages in the mailbox; such a
capability could be added as an extension, such as by using different
command names.

The restriction on a subject line being
{LINE_MAX}\(mi10
bytes is based on the historical format that consumes 10 bytes for
**Subject:\0**
and the trailing
&lt;newline&gt;.
Many historical mailers that a message may encounter on other systems
are not able to handle lines that long, however.

Like the utilities
_logger_
and
_lp_,
_mailx_
admittedly is difficult to test. This was not deemed sufficient
justification to exclude this utility from this volume of POSIX.1-2008. It is also arguable
that it is, in fact, testable, but that the tests themselves are not
portable.

When
_mailx_
is being used by an application that wishes to receive the results as
if none of the User Portability Utilities option features were
supported, the
_DEAD_
environment variable must be set to
**/dev/null**.
Otherwise, it may be subject to the file creations described in
_mailx_
ASYNCHRONOUS EVENTS. Similarly, if the
_MAILRC_
environment variable is not set to
**/dev/null**,
historical versions of
_mailx_
and
_Mail_
read initialization commands from a file before processing begins.
Since the initialization that a user specifies could alter the contents
of messages an application is trying to send, such applications must
set
_MAILRC_
to
**/dev/null**.

The description of
_LC_TIME_
uses \`\`may affect'' because many historical implementations do not or
cannot manipulate the date and time strings in the incoming mail
headers. Some headers found in incoming mail do not have enough
information to determine the timezone in which the mail originated,
and, therefore,
_mailx_
cannot convert the date and time strings into the internal form that
then is parsed by routines like
_strftime_()
that can take
_LC_TIME_
settings into account. Changing all these times to a user-specified
format is allowed, but not required.

The paginator selected when
_PAGER_
is null or unset is partially unspecified to allow the System V
historical practice of using
_pg_
as the default. Bypassing the pagination function, such as by declaring
that
_cat_
is the paginator, would not meet with the intended meaning of this
description. However, any \`\`portable user'' would have to set
_PAGER_
explicitly to get his or her preferred paginator on all systems. The
paginator choice was made partially unspecified, unlike the
_VISUAL_
editor choice (mandated to be
_vi_)
because most historical pagers follow a common theme of user input,
whereas editors differ dramatically.

Options to specify addresses as
**cc**
(carbon copy) or
**bcc**
(blind carbon copy) were considered to be format details and were
omitted.

A zero exit status implies that all messages were
_sent_,
but it gives no assurances that any of them were actually
_delivered_.
The reliability of the delivery mechanism is unspecified and is an
appropriate marketing distinction between systems.

In order to conform to the Utility Syntax Guidelines, a solution was
required to the optional
_file_
option-argument to
**\(mif**.
By making
_file_
an operand, the guidelines are satisfied and users remain portable.
However, it does force implementations to support usage such as:

    
    mailx (mifin mymail.box


The
**no**
_name_
method of unsetting variables is not present in all historical systems,
but it is in System V and provides a logical set of commands
corresponding to the format of the display of options from the
_mailx_
_set_
command without arguments.

The
**ask**
and
**asksub**
variables are the names selected by BSD and System V, respectively, for
the same feature. They are synonyms in this volume of POSIX.1-2008.

The
_mailx_
_echo_
command was not documented in the BSD version and has been omitted here
because it is not obviously useful for interactive users.

The default prompt on the System V
_mailx_
is a
&lt;question-mark&gt;,
on BSD
_Mail_
an
&lt;ampersand&gt;.
Since this volume of POSIX.1-2008 chose the
_mailx_
name, it kept the System V default, assuming that BSD users would not
have difficulty with this minor incompatibility (that they can
override).

The meanings of
**r**
and
**R**
are reversed between System V
_mailx_
and SunOS
_Mail_.
Once again, since this volume of POSIX.1-2008 chose the
_mailx_
name, it kept the System V default, but allows the SunOS user to
achieve the desired results using
**flipr**,
an internal variable in System V
_mailx_,
although it has not been documented in the SVID.

The
**indentprefix**
variable, the
**retain**
and
**unalias**
commands, and the
**~F**
and
**~M**
command escapes were adopted from 4.3 BSD
_Mail_.

The
**version**
command was not included because no sufficiently general specification
of the version information could be devised that would still be useful
to a portable user. This command name should be used by suppliers who
wish to provide version information about the
_mailx_
command.

The \`\`implementation-specific (unspecified) system start-up file''
historically has been named
**/etc/mailx.rc**,
but this specific name and location are not required.

The intent of the wording for the
**next**
command is that if any command has already displayed the current
message it should display a following message, but, otherwise, it
should display the current message. Consider the command sequence:

    
    next 3
    delete 3
    next


where the
**autoprint**
option was not set. The normative text specifies that the second
**next**
command should display a message following the third message, because
even though the current message has not been displayed since it was set
by the
**delete**
command, it has been displayed since the current message was anything
other than message number 3. This does not always match historical
practice in some implementations, where the command file address
followed by
**next**
(or the default command) would skip the message for which the user had
searched.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__ed_\^_,
__ls_\^_,
__more_\^_,
__vi_\^_

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
