# set(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

set
— set or unset options and positional parameters

<a name="synopsis"></a>

# Synopsis

```


```
    set [(miabCefhmnuvx] [(mio option] [argument...]
    
    set [+abCefhmnuvx] [+o option] [argument...]
    
    set (mi|(mi [argument...]
    
    set (mio
    
    set +o

<a name="description"></a>

# Description

If no
_option_s
or
_argument_s
are specified,
_set_
shall write the names and values of all shell variables in the collation
sequence of the current locale. Each
_name_
shall start on a separate line, using the format:

    
    "%s=%sen", <name>, <value>


The
_value_
string shall be written with appropriate quoting; see the description
of shell quoting in
_Section 2.2_, _Quoting_.
The output shall be suitable for reinput to the shell, setting or
resetting, as far as possible, the variables that are currently set;
read-only variables cannot be reset.

When options are specified, they shall set or unset attributes of the
shell, as described below. When
_argument_s
are specified, they cause positional parameters to be set or unset, as
described below. Setting or unsetting attributes and positional
parameters are not necessarily related actions, but they can be
combined in a single invocation of
_set_.

The
_set_
special built-in shall support the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_
except that options can be specified with either a leading
&lt;hyphen&gt;
(meaning enable the option) or
&lt;plus-sign&gt;
(meaning disable it) unless otherwise specified.

Implementations shall support the options in the following list in both
their
&lt;hyphen&gt;
and
&lt;plus-sign&gt;
forms. These options can also be specified as options to
_sh_.

* **\(mia**  
  When this option is on, the
  _export_
  attribute shall be set for each variable to which an assignment is
  performed; see the Base Definitions volume of POSIX.1-2008,
  _Section 4.22_, _Variable Assignment_.
  If the assignment precedes a utility name in a command, the
  _export_
  attribute shall not persist in the current execution environment after
  the utility completes, with the exception that preceding one of the
  special built-in utilities causes the
  _export_
  attribute to persist after the built-in has completed. If the
  assignment does not precede a utility name in the command, or if the
  assignment is a result of the operation of the
  _getopts_
  or
  _read_
  utilities, the
  _export_
  attribute shall persist until the variable is unset.
* **\(mib**  
  This option shall be supported if the implementation supports the User
  Portability Utilities option. It shall cause the shell to notify the
  user asynchronously of background job completions. The following
  message is written to standard error:

    
    "[%d]%c %s%sen", <job-number>, <current>, <status>, <job-name>


where the fields shall be as follows:

* &lt;_current_&gt;  
  The character
  **'+'**
  identifies the job that would be used as a default for the
  _fg_
  or
  _bg_
  utilities; this job can also be specified using the
  _job_id_
  **"%+"**
  or
  **"%%"**.
  The character
  **'\(mi'**
  identifies the job that would become the
  default if the current default job were to exit; this job can also be
  specified using the
  _job_id_
  **"%\(mi"**.
  For other jobs, this field is a
  &lt;space&gt;.
  At most one job can be identified with
  **'+'**
  and at most one job can be identified with
  **'\(mi'**.
  If there is any suspended job, then the current job shall be a
  suspended job. If there are at least two suspended jobs, then the
  previous job also shall be a suspended job.
* &lt;_job-number_&gt;  
  A number that can be used to identify the process group to the
  _wait_,
  _fg_,
  _bg_,
  and
  _kill_
  utilities. Using these utilities, the job can be identified by
  prefixing the job number with
  **'%'**.
* &lt;_status_&gt;  
  Unspecified.
* &lt;_job-name_&gt;  
  Unspecified.

When the shell notifies the user a job has been completed, it may
remove the job's process ID from the list of those known in the current
shell execution environment; see
_Section 2.9.3.1_, _Examples_.
Asynchronous notification shall not be enabled by default.

* **\(miC**  
  (Uppercase C.) Prevent existing files from being overwritten by the
  shell's
  **'&gt;'**
  redirection operator (see
  _Section 2.7.2_, _Redirecting Output_);
  the
  **"&gt;|"**
  redirection operator shall override this
  _noclobber_
  option for an individual file.
* **\(mie**  
  When this option is on, when any command fails (for any of the reasons
  listed in
  _Section 2.8.1_, _Consequences of Shell Errors_
  or by returning an exit status greater than zero), the shell immediately
  shall exit with the following exceptions:
    *  1.  
      The failure of any individual command in a multi-command pipeline shall
      not cause the shell to exit. Only the failure of the pipeline itself
      shall be considered.
    *  2.  
      The
      **\(mie**
      setting shall be ignored when executing the compound list following the
      **while**,
      **until**,
      **if**,
      or
      **elif**
      reserved word, a pipeline beginning with the
      **!**
      reserved word, or any command of an AND-OR list other than the last.
    *  3.  
      If the exit status of a compound command other than a subshell command
      was the result of a failure while
      **\(mie**
      was being ignored, then
      **\(mie**
      shall not apply to this command.

This requirement applies to the shell environment and each subshell
environment separately. For example, in:

    
    set -e; (false; echo one) | cat; echo two


the
_false_
command causes the subshell to exit without executing
_echo one_;
however,
_echo two_
is executed because the exit status of the pipeline
_(false; echo one) | cat_
is zero.

* **\(mif**  
  The shell shall disable pathname expansion.
* **\(mih**  
  Locate and remember utilities invoked by functions as those functions
  are defined (the utilities are normally located when the function is
  executed).
* **\(mim**  
  This option shall be supported if the implementation supports the User
  Portability Utilities option. All jobs shall be run in their own
  process groups. Immediately before the shell issues a prompt after
  completion of the background job, a message reporting the exit status
  of the background job shall be written to standard error. If a
  foreground job stops, the shell shall write a message to standard error
  to that effect, formatted as described by the
  _jobs_
  utility. In addition, if a job changes status other than exiting (for
  example, if it stops for input or output or is stopped by a SIGSTOP
  signal), the shell shall write a similar message immediately prior to
  writing the next prompt. This option is enabled by default for
  interactive shells.
* **\(min**  
  The shell shall read commands but does not execute them; this can be
  used to check for shell script syntax errors. An interactive shell may
  ignore this option.
* **\(mio**  
  Write the current settings of the options to standard output in an
  unspecified format.
* **+o**  
  Write the current option settings to standard output in a format that
  is suitable for reinput to the shell as commands that achieve the same
  options settings.
* **\(mio&nbsp;option**    
  This option is supported if the system supports the User Portability
  Utilities option. It shall set various options, many of which shall be
  equivalent to the single option letters. The following values of
  _option_
  shall be supported:
    * _allexport_  
      Equivalent to
      **\(mia**.
    * _errexit_  
      Equivalent to
      **\(mie**.
    * _ignoreeof_  
      Prevent an interactive shell from exiting on end-of-file. This setting
      prevents accidental logouts when
      &lt;control&gt;-D
      is entered. A user shall explicitly
      _exit_
      to leave the interactive shell.
    * _monitor_  
      Equivalent to
      **\(mim**.
      This option is supported if the system supports the User Portability
      Utilities option.
    * _noclobber_  
      Equivalent to
      **\(miC**
      (uppercase C).
    * _noglob_  
      Equivalent to
      **\(mif**.
    * _noexec_  
      Equivalent to
      **\(min**.
    * _nolog_  
      Prevent the entry of function definitions into the command history; see
      _Command History List_.
    * _notify_  
      Equivalent to
      **\(mib**.
    * _nounset_  
      Equivalent to
      **\(miu**.
    * _verbose_  
      Equivalent to
      **\(miv**.
    * _vi_  
      Allow shell command line editing using the built-in
      _vi_
      editor. Enabling
      _vi_
      mode shall disable any other command line editing mode provided as an
      implementation extension.

It need not be possible to set
_vi_
mode on for certain block-mode terminals.

* _xtrace_  
  Equivalent to
  **\(mix**.

* **\(miu**  
  When the shell tries to expand an unset parameter other than the
  **'@'**
  and
  **'*'**
  special parameters, it shall write a message to standard error and shall
  not execute the command containing the expansion, but for the purposes
  of setting the
  **'?'**
  special parameter and the exit status of the shell the command shall be
  treated as having been executed and returned an exit status of between
  1 and 125 inclusive. A non-interactive shell shall immediately exit. An
  interactive shell shall not exit.
* **\(miv**  
  The shell shall write its input to standard error as it is read.
* **\(mix**  
  The shell shall write to standard error a trace for each command after
  it expands the command and before it executes it. It is unspecified
  whether the command that turns tracing off is traced.

The default for all these options shall be off (unset) unless stated
otherwise in the description of the option or unless the shell was
invoked with them on; see
_sh_.

The remaining arguments shall be assigned in order to the positional
parameters. The special parameter
**'#'**
shall be set to reflect the number of positional parameters. All
positional parameters shall be unset before any new values are
assigned.

If the first argument is
**'\(mi'**,
the results are unspecified.

The special argument
**"\(mi\|\(mi"**
immediately following the
_set_
command name can be used to delimit the arguments if the first argument
begins with
**'+'**
or
**'\(mi'**,
or to prevent inadvertent listing of all shell variables when there are
no arguments. The command
_set_
**\(mi\|\(mi**
without
_argument_
shall unset all positional parameters and set the special parameter
**'#'**
to zero.

<a name="options"></a>

# Options

See the DESCRIPTION.

<a name="operands"></a>

# Operands

See the DESCRIPTION.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

None.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

See the DESCRIPTION.

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

Zero.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Application writers should avoid relying on
_set_
**\(mie**
within functions. For example, in the following script:

    
    set -e
    start() {
        some_server
        echo some_server started successfully
    }
    start || echo >&2 some_server failed


the
**\(mie**
setting is ignored within the function body (because the function is a
command in an AND-OR list other than the last). Therefore, if
_some_server_
fails, the function carries on to echo
**"some_server**started**successfully"**,
and the exit status of the function is zero (which means
**"some_server**failed"
is not output).

<a name="examples"></a>

# Examples

Write out all variables and their values:

    
    set


Set $1, $2, and $3 and set
**"$#"**
to 3:

    
    set c a b


Turn on the
**\(mix**
and
**\(miv**
options:

    
    set (mixv


Unset all positional parameters:

    
    set (mi|(mi


Set $1 to the value of
_x_,
even if it begins with
**'\(mi'**
or
**'+'**:

    
    set (mi|(mi "$x"


Set the positional parameters to the expansion of
_x_,
even if
_x_
expands with a leading
**'\(mi'**
or
**'+'**:

    
    set (mi|(mi $x


<a name="rationale"></a>

# Rationale

The
_set_
\(mi\|\(mi form is listed specifically in the SYNOPSIS even though this
usage is implied by the Utility Syntax Guidelines. The explanation of
this feature removes any ambiguity about whether the
_set_
\(mi\|\(mi form might be misinterpreted as being equivalent to
_set_
without any options or arguments. The functionality of this form has
been adopted from the KornShell. In System V,
_set_
\(mi\|\(mi only unsets parameters if there is at least one argument;
the only way to unset all parameters is to use
_shift_.
Using the KornShell version should not affect System V scripts because
there should be no reason to issue it without arguments deliberately;
if it were issued as, for example:

    
    set (mi|(mi "$@"


and there were in fact no arguments resulting from
**"$@"**,
unsetting the parameters would have no result.

The
_set_
+ form in early proposals was omitted as being an unnecessary
duplication of
_set_
alone and not widespread historical practice.

The
_noclobber_
option was changed to allow
_set_
**\(miC**
as well as the
_set_
**\(mio**
_noclobber_
option. The single-letter version was added so that the historical
**"$\(mi"**
paradigm would not be broken; see
_Section 2.5.2_, _Special Parameters_.

The description of the
**\(mie**
option is intended to match the behavior of the 1988 version of the
KornShell.

The
**\(mih**
flag is related to command name hashing. See
__hash_\^_.

The following
_set_
flags were omitted intentionally with the following rationale:

* **\(mik**  
  The
  **\(mik**
  flag was originally added by the author of the Bourne shell to make it
  easier for users of pre-release versions of the shell. In early
  versions of the Bourne shell the construct
  _set_
  _name_=\c
  _value_
  had to be used to assign values to shell variables. The problem with
  **\(mik**
  is that the behavior affects parsing, virtually precluding writing any
  compilers. To explain the behavior of
  **\(mik**,
  it is necessary to describe the parsing algorithm, which is
  implementation-defined. For example:

    
    set (mik; echo name=value


and:

    
    set (mik
    echo name=value


behave differently. The interaction with functions is even more
complex. What is more, the
**\(mik**
flag is never needed, since the command line could have been
reordered.

* **\(mit**  
  The
  **\(mit**
  flag is hard to specify and almost never used. The only known use could
  be done with here-documents. Moreover, the behavior with
  _ksh_
  and
  _sh_
  differs. The reference page says that it exits after reading and
  executing one command. What is one command? If the input is
  _date_;\c
  _date_,
  _sh_
  executes both
  _date_
  commands while
  _ksh_
  does only the first.

Consideration was given to rewriting
_set_
to simplify its confusing syntax. A specific suggestion was that the
_unset_
utility should be used to unset options instead of using the non-\c
_getopt_()\c
-able +\c
_option_
syntax. However, the conclusion was reached that the historical
practice of using +\c
_option_
was satisfactory and that there was no compelling reason to modify such
widespread historical practice.

The
**\(mio**
option was adopted from the KornShell to address user needs. In
addition to its generally friendly interface,
**\(mio**
is needed to provide the
_vi_
command line editing mode, for which historical practice yields no
single-letter option name. (Although it might have been possible to
invent such a letter, it was recognized that other editing modes would
be developed and
**\(mio**
provides ample name space for describing such extensions.)

Historical implementations are inconsistent in the format used for
**\(mio**
option status reporting. The
**+o**
format without an option-argument was added to allow portable access to
the options that can be saved and then later restored using, for
instance, a dot script.

Historically,
_sh_
did trace the command
_set_
**+x**,
but
_ksh_
did not.

The
_ignoreeof_
setting prevents accidental logouts when the end-of-file character
(typically
&lt;control&gt;-D)
is entered. A user shall explicitly
_exit_
to leave the interactive shell.

The
_set_
**\(mim**
option was added to apply only to the UPE because it applies primarily
to interactive use, not shell script applications.

The ability to do asynchronous notification became available in the
1988 version of the KornShell. To have it occur, the user had to issue
the command:

    
    trap "jobs (min" CLD


The C shell provides two different levels of an asynchronous
notification capability. The environment variable
_notify_
is analogous to what is done in
_set_
**\(mib**
or
_set_
**\(mio**
_notify_.
When set, it notifies the user immediately of background job
completions. When unset, this capability is turned off.

The other notification ability comes through the built-in utility
_notify_.
The syntax is:

    
    notify [%job ... ]


By issuing
_notify_
with no operands, it causes the C shell to notify the user
asynchronously when the state of the current job changes. If given
operands,
_notify_
asynchronously informs the user of changes in the states of the
specified jobs.

To add asynchronous notification to the POSIX shell, neither the
KornShell extensions to
_trap_,
nor the C shell
_notify_
environment variable seemed appropriate (\c
_notify_
is not a proper POSIX environment variable name).

The
_set_
**\(mib**
option was selected as a compromise.

The
_notify_
built-in was considered to have more functionality than was required
for simple asynchronous notification.

Historically, some shells applied the
**\(miu**
option to all parameters including
_$@_
and
_$*_.
The standard developers felt that this was a misfeature since it is
normal and common for
_$@_
and
_$*_
to be used in shell scripts regardless of whether they were passed any
arguments. Treating these uses as an error when no arguments are passed
reduces the value of
**\(miu**
for its intended purpose of finding spelling mistakes in variable names
and uses of unset positional parameters.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_,
__hash_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 4.22_, _Variable Assignment_,
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
