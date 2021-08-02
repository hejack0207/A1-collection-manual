# gdb(1)

gdb-Fedora 8.2.91.20190401-23.fc30, 2019-04-01

.if n .ad l
.nh

<a name="name"></a>

# Name

gdb - The GNU Debugger

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gdb [-help] [-nh] [-nx] [-q] [-batch] [-cd=dir] [-f] [-b&nbsp;bps]     [-tty=dev] [-s symfile] [-e&nbsp;prog] [-se&nbsp;prog] [-c&nbsp;core] [-p&nbsp;procID]     [-x&nbsp;cmds] [-d&nbsp;dir] [prog|prog procID|prog core]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The purpose of a debugger such as \s-1GDB\s0 is to allow you to see what is
going on inside\*(R" another program while it executes \*(-- or what another
program was doing at the moment it crashed.

\s-1GDB\s0 can do four main kinds of things (plus other things in support of
these) to help you catch bugs in the act:

* ·  
  Start your program, specifying anything that might affect its behavior.
* ·  
  Make your program stop on specified conditions.
* ·  
  Examine what has happened, when your program has stopped.
* ·  
  Change things in your program, so you can experiment with correcting the
  effects of one bug and go on to learn about another.

You can use \s-1GDB\s0 to debug programs written in C, C@t{++}, Fortran and
Modula-2.

\s-1GDB\s0 is invoked with the shell command \f(CW`gdb\*(C'.  Once started, it reads
commands from the terminal until you tell it to exit with the \s-1GDB\s0
command \f(CW`quit\*(C'.  You can get online help from \s-1GDB\s0 itself
by using the command \f(CW`help\*(C'.

You can run \f(CW`gdb\*(C' with no arguments or options; but the most
usual way to start \s-1GDB\s0 is with one argument or two, specifying an
executable program as the argument:

.Vb 1
        gdb program
.Ve

You can also start with both an executable program and a core file specified:

.Vb 1
        gdb program core
.Ve

You can, instead, specify a process \s-1ID\s0 as a second argument, if you want
to debug a running process:

.Vb 2
        gdb program 1234
        gdb -p 1234
.Ve

would attach \s-1GDB\s0 to process \f(CW1234 (unless you also have a file
named _1234_; \s-1GDB\s0 does check for a core file first).
With option **-p** you can omit the _program_ filename.

Here are some of the most frequently needed \s-1GDB\s0 commands:

* **break [**_file_**:]**_function_  
  .IX Item "break [file:]function"
  Set a breakpoint at _function_ (in _file_).
* **run [**_arglist_**]**  
  .IX Item "run [arglist]"
  Start your program (with _arglist_, if specified).
* **bt**  
  .IX Item "bt"
  Backtrace: display the program stack.
* **print** _expr_  
  .IX Item "print expr"
  Display the value of an expression.
* **c**  
  .IX Item "c"
  Continue running your program (after stopping, e.g. at a breakpoint).
* **next**  
  .IX Item "next"
  Execute next program line (after stopping); step _over_ any
  function calls in the line.
* **edit [**_file_**:]**_function_  
  .IX Item "edit [file:]function"
  look at the program line where it is presently stopped.
* **list [**_file_**:]**_function_  
  .IX Item "list [file:]function"
  type the text of the program in the vicinity of where it is presently stopped.
* **step**  
  .IX Item "step"
  Execute next program line (after stopping); step _into_ any
  function calls in the line.
* **help [**_name_**]**  
  .IX Item "help [name]"
  Show information about \s-1GDB\s0 command _name_, or general information
  about using \s-1GDB.\s0
* **quit**  
  .IX Item "quit"
  Exit from \s-1GDB.\s0

For full details on \s-1GDB,\s0
see _Using \s-1GDB: A\s0 Guide to the \s-1GNU\s0 Source-Level Debugger_,
by Richard M. Stallman and Roland H. Pesch.  The same text is available online
as the \f(CW`gdb\*(C' entry in the \f(CW\*(C\`info\*(C' program.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
Any arguments other than options specify an executable
file and core file (or process \s-1ID\s0); that is, the first argument
encountered with no
associated option flag is equivalent to a **-se** option, and the second,
if any, is equivalent to a **-c** option if it's the name of a file.
Many options have
both long and short forms; both are shown here.  The long forms are also
recognized if you truncate them, so long as enough of the option is
present to be unambiguous.  (If you prefer, you can flag option
arguments with **+** rather than **-**, though we illustrate the
more usual convention.)

All the options and command line arguments you give are processed
in sequential order.  The order makes a difference when the **-x**
option is used.

* **-help**  
  .IX Item "-help"
* **-h**  
  .IX Item "-h"
  List all options, with brief explanations.
* **-symbols=**_file_  
  .IX Item "-symbols=file"
* **-s** _file_  
  .IX Item "-s file"
  Read symbol table from file _file_.
* **-write**  
  .IX Item "-write"
  Enable writing into executable and core files.
* **-exec=**_file_  
  .IX Item "-exec=file"
* **-e** _file_  
  .IX Item "-e file"
  Use file _file_ as the executable file to execute when
  appropriate, and for examining pure data in conjunction with a core
  dump.
* **-se=**_file_  
  .IX Item "-se=file"
  Read symbol table from file _file_ and use it as the executable
  file.
* **-core=**_file_  
  .IX Item "-core=file"
* **-c** _file_  
  .IX Item "-c file"
  Use file _file_ as a core dump to examine.
* **-command=**_file_  
  .IX Item "-command=file"
* **-x** _file_  
  .IX Item "-x file"
  Execute \s-1GDB\s0 commands from file _file_.
* **-ex** _command_  
  .IX Item "-ex command"
  Execute given \s-1GDB\s0 _command_.
* **-directory=**_directory_  
  .IX Item "-directory=directory"
* **-d** _directory_  
  .IX Item "-d directory"
  Add _directory_ to the path to search for source files.
* **-nh**  
  .IX Item "-nh"
  Do not execute commands from _~/.gdbinit_.
* **-nx**  
  .IX Item "-nx"
* **-n**  
  .IX Item "-n"
  Do not execute commands from any _.gdbinit_ initialization files.
* **-quiet**  
  .IX Item "-quiet"
* **-q**  
  .IX Item "-q"
  Quiet\*(R".  Do not print the introductory and copyright messages.  These
  messages are also suppressed in batch mode.
* **-batch**  
  .IX Item "-batch"
  Run in batch mode.  Exit with status \f(CW0 after processing all the command
  files specified with **-x** (and _.gdbinit_, if not inhibited).
  Exit with nonzero status if an error occurs in executing the \s-1GDB\s0
  commands in the command files.
  .Sp
  Batch mode may be useful for running \s-1GDB\s0 as a filter, for example to
  download and run a program on another computer; in order to make this
  more useful, the message
  .Sp
  .Vb 1
          Program exited normally.
  .Ve
  .Sp
  (which is ordinarily issued whenever a program running under \s-1GDB\s0 control
  terminates) is not issued when running in batch mode.
* **-cd=**_directory_  
  .IX Item "-cd=directory"
  Run \s-1GDB\s0 using _directory_ as its working directory,
  instead of the current directory.
* **-fullname**  
  .IX Item "-fullname"
* **-f**  
  .IX Item "-f"
  Emacs sets this option when it runs \s-1GDB\s0 as a subprocess.  It tells
  \s-1GDB\s0 to output the full file name and line number in a standard,
  recognizable fashion each time a stack frame is displayed (which
  includes each time the program stops).  This recognizable format looks
  like two **\e032** characters, followed by the file name, line number
  and character position separated by colons, and a newline.  The
  Emacs-to-GDB interface program uses the two **\e032**
  characters as a signal to display the source code for the frame.
* **-b** _bps_  
  .IX Item "-b bps"
  Set the line speed (baud rate or bits per second) of any serial
  interface used by \s-1GDB\s0 for remote debugging.
* **-tty=**_device_  
  .IX Item "-tty=device"
  Run using _device_ for your program's standard input and output.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
The full documentation for \s-1GDB\s0 is maintained as a Texinfo manual.
If the \f(CW`info\*(C' and \f(CW\*(C\`gdb\*(C' programs and \s-1GDB\s0's Texinfo
documentation are properly installed at your site, the command

.Vb 1
        info gdb
.Ve

should give you access to the complete manual.

_Using \s-1GDB: A\s0 Guide to the \s-1GNU\s0 Source-Level Debugger_,
Richard M. Stallman and Roland H. Pesch, July 1991.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1988-2019 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with the
Invariant Sections being Free Software\*(R" and \*(L"Free Software Needs
Free Documentation, with the Front-Cover Texts being \*(L"A \s-1GNU\s0 Manual,\*(R"
and with the Back-Cover Texts as in (a) below.

(a) The \s-1FSF\s0's Back-Cover Text is: You are free to copy and modify
this \s-1GNU\s0 Manual.  Buying copies from \s-1GNU\s0 Press supports the \s-1FSF\s0 in
developing \s-1GNU\s0 and promoting software freedom.
